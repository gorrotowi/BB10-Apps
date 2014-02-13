import bb.cascades 1.2
import QtMobility.sensors 1.2
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import bb.system 1.0

Page {
    
    attachedObjects: [
        PositionSource {
            id: positionSource
            updateInterval: 120000
            active: true
            onPositionChanged: {
                mapView.setLatitude(positionSource.position.coordinate.latitude);
                mapView.setLongitude(positionSource.position.coordinate.longitude);
            }
        }
    ]
    
    Container {

        Container {
            maxHeight: 300

            background: Color.create("#13BA32")
            layout: AbsoluteLayout {
            }

            Label {
                text: "Verificentros"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 230
                    positionY: 15
                }
            }

            Label {
                text: " "
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 900
                    positionY: 60
                }
            }

        }

        Container {
        	id: root
        	layout: AbsoluteLayout {}
        	background: Color.White
        	MapView {
        	    layoutProperties: AbsoluteLayoutProperties {
                 positionY: 1
             }
             id: mapView
             objectName: "mapViewObj"
             altitude: 7000
             latitude: positionSource.position.coordinate.latitude
             longitude: positionSource.position.coordinate.longitude
             preferredWidth: 768
             preferredHeight: 1080
         }
        }

    }

    function servicioVerif() {
        console.log("lolaaaaaaaassss!!!!")
    
    }

}
