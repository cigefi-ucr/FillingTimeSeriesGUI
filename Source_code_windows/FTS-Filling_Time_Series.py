"""
Note: v0.9.2 Originally, filling data methods was developed by Eric Alfaro and Javier Soley in SCILAB
      Python version was developed by Rolando Duarte and Erick Rivera
      Centro de Investigaciones Geofísicas (CIGEFI)
      Universidad de Costa Rica (UCR)
"""
import sys

from PyQt5.QtGui import QIcon
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication

from FTSUI import FTSConnected

app = QApplication(sys.argv)
app.setWindowIcon(QIcon("./resources/images/Icon.ico"))
app.setOrganizationName("cigefi")
app.setOrganizationDomain("ucr")
engine = QQmlApplicationEngine()

ftsconn = FTSConnected()

engine.load("./resources/qml/Main.qml")
engine.rootObjects()[0].setProperty("ftsconn", ftsconn)
engine.quit.connect(app.quit)
sys.exit(app.exec_())