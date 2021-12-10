import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5

StackView {
    width: parent.width
    height: parent.height
    initialItem: grids
    Component{
        id: grids
        Grids{
            id: rows
        }
    }

    Component{
        id: waiting
        Rectangle{
            color: "transparent"
            Component.onCompleted:{
                if (adMethod == 0) {
                    ftsconn.applyPCA(parCh, tol, maxIter, valueMin, savedfilename)
                } else if(adMethod == 1) {
                    ftsconn.applyULCL(parCh, tol, maxIter, valueMin, savedfilename)
                } else if(adMethod == 2) {
                    ftsconn.applyFull(parS, parCh, tol, maxIter, valueMin, savedfilename)
                } 
            }
            Text{
                id: counter
                property double sizes: 40
                text: "Waiting the process..."
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: sizes
                font.family: "Sans-Serif"
                SequentialAnimation on sizes{
                    id: animator
                    loops: Animator.Infinite
                    NumberAnimation{
                        id: scrollAnim1
                        from: counter.width / 4
                        to: counter.width / 5
                        duration: counter.width * 3                   
                    }
                    NumberAnimation{
                        id: scrollAnim2
                        from: counter.width / 5
                        to: counter.width / 4
                        duration: counter.width * 3
                    }
                    running: true
                }
            }
            Connections {
                target: ftsconn
                function onFinishedWorker(_applyULCL){ 
                    carrousel.push(endPage)
                }
            } 
        } 
    }
    Component{
        id:endPage
        EndPage{}
    } 
}
