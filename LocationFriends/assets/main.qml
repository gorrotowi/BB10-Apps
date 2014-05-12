/* Copyright (c) 2012, 2013  BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.0
import QtMobility.sensors 1.2
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import bb.system 1.0

        Page {
            titleBar: TitleBar {
                title: qsTr("Location Friends")
            }

			Menu.definition: MenuDefinition{
			    helpAction: HelpActionItem {
           			onTriggered: {
                  		var help = Help.c
                  	}
           		}
			}
            
            actions: [
                //! [0]
                /* ActionItem {
                 title: qsTr("Share")
                 imageSource: "asset:///images/invoke.png"//"asset:///images/pin.png"
                 ActionBar.placement: ActionBarPlacement.OnBar
                 onTriggered: {
                 _mapViewTest.addPinAtCurrentMapCenter();
                 }
                 }*/
                InvokeActionItem {
                    title: "Share Location"
                    ActionBar.placement: ActionBarPlacement.OnBar
                    query{
                        mimeType: "text/plain"
                        invokeActionId: "bb.action.SHARE"
                    }
                    onTriggered: {
                        if ((positionSource.position.coordinate.latitude!='NaN')&&(positionSource.position.coordinate.longitude!='NaN')){
                            data = '{"lat":'+'"'+positionSource.position.coordinate.latitude+'"'+', "lon": '+'"'+positionSource.position.coordinate.longitude+'"'+' }'
                        }
                        else {
                            toastLocation.show();
                        }
                    }
                    attachedObjects: [
                        SystemToast{
                            id: toastLocation
                            body: "I'm sorry, try again, your location is unavailable"
                        }
                    ]
                },
                ActionItem {
                    title: qsTr("Remove Pin")
                    imageSource: "asset:///images/clearpin.png"
                    ActionBar.placement: ActionBarPlacement.InOverflow
                    onTriggered: {
                        _mapViewTest.clearPins();
                    }
                },
                ActionItem {
                    title: qsTr("Return")
                    imageSource: "asset:///images/return.png"
                    ActionBar.placement: ActionBarPlacement.OnBar
                    onTriggered: {
                        mapview.latitude = positionSource.position.coordinate.latitude
                        mapview.longitude = positionSource.position.coordinate.longitude
                    }
                },
                ActionItem {
                    title: qsTr("Manually enter location")
                    ActionBar.placement: ActionBarPlacement.OnBar
                    imageSource: "asset:///images/url.png"
                    attachedObjects: [
                        SystemPrompt {
                            id: manualData
                            title: "Enter Data"
                            onFinished: {
                                if(result == SystemUiResult.ConfirmButtonSelection){
                                    console.log(inputFieldTextEntry())
                                //_mapViewTest.obtainManualData(manualData.toString())
                                _mapViewTest.obtainManualData(qsTr(inputFieldTextEntry()));
                                	//_mapViewTest.obtainManualData(inputFieldTextEntry())
                                }
                            }
                        }
                    ]
                    onTriggered: {
                        manualData.show();
                    }
                }
            ]
            Container {
                id: root
                layout: DockLayout {
                }
                background: Color.White
                //! [1]
                MapView {
                    id: mapview
                    objectName: "mapViewObj"
                    altitude: 3000
                    latitude: positionSource.position.coordinate.latitude
                    longitude: positionSource.position.coordinate.longitude
                    preferredWidth: 768
                    preferredHeight: 1280
                }
                
                Container {
                    leftPadding: 20
                    rightPadding: 20
                    bottomPadding: 20
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Bottom
                    overlapTouchPolicy: OverlapTouchPolicy.Allow
                    
                    ImageView {
                        id: compassImage
                        imageSource: "asset:///images/compass.png"
                        horizontalAlignment: HorizontalAlignment.Center
                        attachedObjects: [
                            ImplicitAnimationController {
                                // Disable animations to avoid jumps between 0 and 360 degree
                                enabled: false
                            }
                        ]
                        
                         property bool flag: flase 
                         onTouch: {
                         if(flag==false){
                         rotation.active=true;
                         flag=true
                         }else if(flag == true){
                         rotation.active=false;
                         flag=false;
                         }
                         }
                         
                    }
                }
                //! [3]
            }
            attachedObjects: [
                //! [5]
                RotationSensor {
                    id: rotation
                    property real x: 0
                    property real y: 0
                    active: false //sensorToggle.checked
                    alwaysOn: false
                    skipDuplicates: true
                    onReadingChanged: {
                        x = reading.x //- 30
                        y = reading.y
                        console.log("leido en x"+x);
                        console.log("leido en y"+y);
                        if (x <= 50 && x > 0) {
                            mapview.setTilt(x);
                            
                             mapview.visible = true
                             mapview.altitude = 3000
                             }
                             if (x<=90 && x > 70){
                             mapview.setTilt(90);
                             mapview.altitude = 1500
                             //mapview.visible = false
                             }
                    }
                },
                //! [5]
                //! [4]
                Compass {
                    property double azimuth: 0
                    active: true
                    axesOrientationMode: Compass.UserOrientation
                    alwaysOn: false
                    onReadingChanged: { // Called when a new compass reading is available
                        mapview.setHeading(reading.azimuth);
                        compassImage.rotationZ = 360 - reading.azimuth;
                    }
                },
                //! [4]
                //! [6]
                PositionSource {
                    id: positionSource
                    updateInterval:180000
                    active: true //sensorToggle.checked
                    onPositionChanged: {
                        _mapViewTest.updateDeviceLocation(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude);
                    }
                },
            //! [6]
            ComponentDefinition {
                id: abourPage
                source: "About.qml"
            }
            ]
        }
        