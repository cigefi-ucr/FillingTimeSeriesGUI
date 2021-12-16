"""
Note: v1.0.0 Originally, filling data methods was developed by Eric Alfaro and Javier Soley in SCILAB
      Python version was developed by Rolando Duarte and Erick Rivera
      Centro de Investigaciones Geofísicas (CIGEFI)
      Universidad de Costa Rica (UCR)
"""

"""
MIT License
Copyright 2021 Rolando Jesus Duarte Mejias and Erick Rivera Fernandez
Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

from pandas import read_csv
from PyQt5.QtCore import QObject, QRunnable, QThreadPool, pyqtSignal, pyqtSlot

from FillingTimeSeries.FillingMethods import Autoregression, PrincipalComponentAnalysis, ComponentsAutoregression


class FTSConnected(QObject):
    """
    Connection between interface and filling methods
    
    Parameters
    ----------
    QObject: QObject
        PyQt5 object to connect python functions and qml
    """
    def __init__(self):
        QObject.__init__(self)
        self.threadpool = QThreadPool()

    finishedWorker = pyqtSignal(arguments = ["_applyULCL"])

    @pyqtSlot(str)
    def getFilename(self, filename):
        """
        Get filename to search the file
        
        Parameters
        ----------
        filename: str
            File path
        """
        self.filename = filename.replace("file://", "")

    @pyqtSlot(result = int)
    def continuePCA(self):
        """
        Display principal component graph from FillingMethods

        Returns
        -------
        upperRange: int
           Maximum number to choose principal components
        """
        self.df = read_csv(self.filename, delimiter = "\s+", header = None, na_values = "Nan")
        self.pca = PrincipalComponentAnalysis(self.df)
        self.upperRange = self.pca.checkPrincipalComponents()
        return self.upperRange

    @pyqtSlot(result = int)
    def continueULCL(self):
        """
        Returns maximum number to choose lag for ULCL method

        Returns
        -------
        upperRange: int
            Maximum lag to choose for ULCL method
        """
        self.df = read_csv(self.filename, delimiter = "\s+", header = None, na_values = "Nan")
        self.AR = Autoregression(self.df)
        self.upperRange = int(self.AR.dfRows / 5)
        return self.upperRange
    
    @pyqtSlot(result = list)
    def continueFull(self):
        """
        Display principal component graph from FillingMethods

        Returns
        -------
        upperRangeAR: int
            Maximum lag to choose for ULCL method
        upperRange: int
           Maximum number to choose principal components
        """
        self.df = read_csv(self.filename, delimiter = "\s+", header = None, na_values = "Nan")
        self.full = ComponentsAutoregression(self.df)
        self.upperRange = self.full.checkPrincipalComponents()
        self.upperRangeAR = int(self.df.shape[0] / 5)
        return [self.upperRangeAR, self.upperRange]

    @pyqtSlot(int, float, int, float, str)
    def applyULCL(self, param, tol, maxIter, valueMin,savedFilename):
        """
        Applies ULCL method from FillingMethods and saves filled dataframe at original filepath
        
        Parameters
        ----------
        param: int
            Lags number
        tol: float
            Tolerance value
        maxIter: int
            Maximum  iterations
        valueMin: float
            Allowed minimum value
        savedFilename: str
            File path to save the dataframe
        """
        savedFilename = savedFilename.replace("file://", "")
        self.wULCL = WorkerULCL(self.AR, savedFilename, param, tol, maxIter, valueMin)
        self.threadpool.start(self.wULCL)
        self.wULCL.signal.finished.connect(self._applyULCL)

    def _applyULCL(self):
        self.finishedWorker.emit()

    @pyqtSlot(int, float, int, float, str)
    def applyPCA(self, param, tol, maxIter, valueMin, savedFilename):
        """
        Applies principal components method from FillingMethods and saves filled dataframe at original filepath
        
        Parameters
        ----------
        param: int
            principal component number
        tol: float
            Tolerance value
        maxIter: int
            Maximum  iterations
        valueMin: float
            Allowed minimum value
        savedFilename: str
            File path to save the dataframe
        """
        savedFilename = savedFilename .replace("file://", "")
        self.wPCA = WorkerPCA(self.pca, savedFilename, param, tol, maxIter, valueMin)
        self.threadpool.start(self.wPCA)
        self.wPCA.signal.finished.connect(self._applyPCA)

    def _applyPCA(self):
        self.finishedWorker.emit()

    @pyqtSlot(int, int, float, int, float, str)
    def applyFull(self, param1, param2, tol, maxIter, valueMin, savedFilename):
        """
        Applies full method from FillingMethods and saves filled dataframe at original filepath
        
        Parameters
        ----------
        param1: int
            Lags number
        param2: int
            principal component number
        tol: float
            Tolerance value
        maxIter: int
            Maximum  iterations
        valueMin: float
            Allowed minimum value
        savedFilename: str
            File path to save the dataframe
        """
        savedFilename = savedFilename .replace("file://", "")
        self.wFull = WorkerFull(self.full, savedFilename, param1, param2, tol, maxIter, valueMin)
        self.threadpool.start(self.wFull)
        self.wFull.signal.finished.connect(self._applyFull)

    def _applyFull(self):
        self.finishedWorker.emit()

class WorkerULCL(QRunnable):
    """ Threading ULCL method """
    def __init__(self, method, savedFilename, param, tol, maxIter, valueMin):
        super(WorkerULCL, self).__init__()
        self.AR = method
        self.param = param
        self.tol = tol
        self.valueMin = valueMin
        self.maxIter = maxIter
        self.savedFilename = savedFilename
        self.signal = Signals()

    @pyqtSlot()
    def run(self):
        try:
            self.df = self.AR.ULCLMethod(lags = self.param, tol=self.tol, itermax=self.maxIter, valueMin=self.valueMin)
            self.df.to_csv(self.savedFilename, sep=r" ",  header=False, index=False)  
        finally:
            self.signal.finished.emit() 

class WorkerPCA(QRunnable):
    """ Threading PCA method """
    def __init__(self, method, savedFilename, param, tol, maxIter, valueMin):
        super(WorkerPCA, self).__init__()
        self.pca = method
        self.param = param
        self.tol = tol
        self.valueMin = valueMin
        self.maxIter = maxIter
        self.savedFilename = savedFilename
        self.signal = Signals()

    @pyqtSlot()
    def run(self):
        try:
            self.df = self.pca.PCAMethod(components=self.param, tol=self.tol, itermax=self.maxIter, valueMin=self.valueMin)
            self.df.to_csv(self.savedFilename, sep=r" ",  header=False, index=False)  
        finally:
            self.signal.finished.emit() 

class WorkerFull(QRunnable):
    """ Threading Full method """
    def __init__(self, method, savedFilename, param1, param2, tol, maxIter, valueMin):
        super(WorkerFull, self).__init__()
        self.full = method
        self.param1 = param1
        self.param2 = param2
        self.tol = tol
        self.valueMin = valueMin
        self.maxIter = maxIter
        self.savedFilename = savedFilename
        self.signal = Signals()

    @pyqtSlot()
    def run(self):
        try:
            self.df = self.full.FullMethod(lags=self.param1, components=self.param2, tol=self.tol, itermax=self.maxIter, valueMin=self.valueMin)
            self.df.to_csv(self.savedFilename, sep=r" ",  header=False, index=False)  
        finally:
            self.signal.finished.emit() 


class Signals(QObject):
    finished = pyqtSignal()