/*
  Q Light Controller Plus
  ActionsMenu.qml

  Copyright (c) Massimo Callegari

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0.txt

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import QtQuick 2.0
import QtQuick.Dialogs 1.2

Rectangle
{
    id: menuRoot
    visible: false
    x: 1
    y: 40
    z: 99
    radius: 2
    border.width: 1
    border.color: "#1D1D1D"
    color: "#202020"
    width: actionsMenuEntries.width
    height: actionsMenuEntries.height

    function closeMenu()
    {
        contextMenuArea.enabled = false
        contextMenuArea.z = 0
        menuRoot.visible = false
    }

    FileDialog
    {
        id: fileDialog
        visible: false

        onAccepted:
        {
            console.log("You chose: " + fileDialog.fileUrl)
            qlcplus.loadWorkspace(fileDialog.fileUrl)
        }
        onRejected:
        {
            console.log("Canceled")
        }
    }

    Column
    {
        id: actionsMenuEntries
        ContextMenuEntry
        {
            id: fileNew
            imgSource: "qrc:///filenew.svg"
            entryText: qsTr("New project")
            onClicked:
            {
                qlcplus.newWorkspace()
                closeMenu()
            }
            onEntered: recentMenu.visible = false
        }
        ContextMenuEntry
        {
            id: fileOpen
            imgSource: "qrc:///fileopen.svg"
            entryText: qsTr("Open project")
            onClicked:
            {
                fileDialog.title = qsTr("Open a workspace")
                fileDialog.nameFilters = [ "Workspace files (*.qxw)", "All files (*)" ]
                fileDialog.visible = true
                closeMenu()
                fileDialog.open();
            }
            onEntered: recentMenu.visible = true
            //onExited: recentMenu.visible = false


            Rectangle
            {
                id: recentMenu
                x: menuRoot.width
                width: recentColumn.width
                height: recentColumn.height
                color: "#202020"
                visible: false

                Column
                {
                    id: recentColumn
                    Repeater
                    {
                        model: qlcplus.recentFiles
                        delegate:
                            ContextMenuEntry
                            {
                                entryText: modelData
                                onClicked:
                                {
                                    recentMenu.visible = false
                                    menuRoot.visible = false
                                    contextMenuArea.enabled = false
                                    contextMenuArea.z = 0
                                    qlcplus.loadWorkspace(entryText)
                                }
                            }
                        }
                }
            }
        }
        ContextMenuEntry
        {
            id: fileSave
            imgSource: "qrc:///filesave.svg"
            entryText: qsTr("Save project")
            onClicked: { }
            onEntered: recentMenu.visible = false
        }
        ContextMenuEntry
        {
            id: fileSaveAs
            imgSource: "qrc:///filesaveas.svg"
            entryText: qsTr("Save project as...")
            onClicked: { }
            onEntered: recentMenu.visible = false
        }
    }
}


