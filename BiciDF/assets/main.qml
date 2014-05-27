import QtMobilitySubset.location 1.1
import bb.platform 1.0
import bb.system 1.0
import QtMobility.sensors 1.2
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1

import bb.cascades 1.2
import "js/datos.js" as DatosJS

Page {
    
    onCreationCompleted: {
        DatosJS.llenarLista();
    }

    Container {
        
        Container {
            preferredWidth: 768
            preferredHeight: 100
            background: Color.create("#380b61")
            layout: AbsoluteLayout {
            }
            Label {
                text: qsTr('BiciDF')
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 310
                    positionY: 15
                }
            }
        }

        Container {

            MapView {
                id: mapQml
                objectName: "mapViewObj"
                altitude: 3000
                latitude: positionSource.position.coordinate.latitude
                longitude: positionSource.position.coordinate.longitude
                preferredHeight: 450
                preferredWidth: 768
            }

        }
        
        Container {
            preferredWidth: 768
            preferredHeight: 5
            background: Color.create("#380b61")
            topMargin: 15
        }
        
        Container {
            layout: AbsoluteLayout {
                
            }
            preferredWidth: 768
            preferredHeight: 50
            background: Color.White
            topMargin: 15
            
            Label {
                textStyle.color: Color.Black
                textStyle.fontSize: FontSize.Medium
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                }
                text: "Condicion del clima"
            }
            
            Label {
                id: condicionLb
                textStyle.color: Color.create('#FF8000')
                textStyle.fontSize: FontSize.Medium
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 450
                }
                text: "No disponible"
            }
            
        }
        
        Container {
            preferredWidth: 768
            preferredHeight: 5
            background: Color.create("#380b61")
            topMargin: 15
        }
        
        Container {
            preferredWidth: 768
            topMargin: 15
            background: Color.White
            
            ListView {
                dataModel: gdm
                accessibility.name: listBicis
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            layout: AbsoluteLayout {
                            }
                            preferredHeight: 150
                            Label {
                                id: nameStation
                                text: ListItemData.name
                                textStyle.fontSize: FontSize.Large
                                textStyle.color: Color.create("#380B61")
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 25
                                    positionY: 15
                                }
                            }
                            Label {
                                id: distanciametros
                                text: ListItemData.distancia
                                textStyle.fontSize: FontSize.Medium
                                textStyle.color: Color.create("#380BDF")
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 25
                                    positionY: 60
                                }
                            }
                            Label {
                                id: lblDisp
                                text: qsTr("Disponibles:")
                                textStyle.fontSize: FontSize.Medium
                                textStyle.color: Color.create("#424242")
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 25
                                    positionY: 100
                                }
                            }
                            Label {
                                id: dispBik
                                text: ListItemData.disp
                                textStyle.fontSize: FontSize.Default
                                textStyle.color: Color.create("#13BA32")
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 235
                                    positionY: 102
                                }
                            }
                            
                            Label {
                                id: lblfree
                                text: qsTr("Libres:")
                                textStyle.fontSize: FontSize.Medium
                                textStyle.color: Color.create("#424242")
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 400
                                    positionY: 100
                                }
                            }
                            Label {
                                id: dispLugar
                                text: ListItemData.free
                                textStyle.fontSize: FontSize.Default
                                textStyle.color: Color.create("#13BA32")
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 515
                                    positionY: 102
                                }
                            }
                            
                            ImageView {
                                id: imageArrow
                                accessibility.name: imageRow
                                preferredHeight: 50
                                preferredWidth: 50
                                imageSource: "asset:///images/item_arrow.png"
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 680
                                    positionY: 50
                                }
                            }
                        }
                    }
                ]
            }
            
        }

    }
    attachedObjects: [
        GroupDataModel {
            id: gdm
            sortingKeys: [ "item" ]
        },
        Compass {
            property double azimuth: 0
            active: true
            axesOrientationMode: Compass.UserOrientation
            alwaysOn: true
            onReadingChanged: {
                mapQml.setHeading(reading.azimuth)
            }
        },
        PositionSource {
            id: positionSource
            updateInterval: 60000
            active: true
            onPositionChanged: {
                _appMap.updateDeviceLocation(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude)
            }
        }
    ]
    
    function llenarLista(){
        for(var i=0;i<20;i++){
        gdm.insert({
        "name":"estacion",
        "distancia":"500"+" metros",
        "disp":"50",
        "free":"15"
        });
    }
    }
}
