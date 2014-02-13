import bb.cascades 1.2
import bb.system 1.0

NavigationPane {
    id: navigation
    property string placa
    property variant jsonJalado

    Page {
        id: pageThis

        Container {
            Container {
                maxHeight: 300

                background: Color.create("#13BA32")
                layout: AbsoluteLayout {

                }

                Label {
                    text: "Mis Autos"
                    textStyle.color: Color.White
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 260
                        positionY: 15
                    }

                }

                Label {
                    text: "Listo"
                    textStyle.color: Color.White
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 600
                        positionY: 15
                    }
                    onTouch: {
                        if (event.isUp()) {
                            obtenerPlaca();
                        }
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
                layout: AbsoluteLayout {
                }
                Label {
                    text: qsTr("Para empezar agrega un auto ingresando tu placa")
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                    textStyle.fontSize: FontSize.XLarge
                    textStyle.textAlign: TextAlign.Center
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 20
                        positionY: 150
                    }
                }

                TextField {
                    id: placaTA
                    accessibility.name: "txtAplaca"
                    maxWidth: 400
                    maximumLength: 6
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 200
                        positionY: 560
                    }
                }

            }
        }

        attachedObjects: [
            SystemToast {
                id: placaToast
                body: "Ingresa una placa para continuar"
            },
            SystemToast {
                id: placaCaracteresMenos
                body: "La placa debe tener 6 caracteres"
            },
            ComponentDefinition {
                id: paginaPrincipal
                source: "main.qml"
            }
        ]

    }
    
    function obtenerPlaca() {
        var plataString = placaTA.text;
        if (plataString < 6) {
            console.log("la placa tiene menos de 6 caracteres")
            placaCaracteresMenos.show();
        } else if (plataString==6){
            console.log("la placa tiene 6 caracteres: " + plataString);
            placa = plataString;
            sendRequest(placa);
        }
    }
    
    function sendRequest(placaRecib) {
        
        //console.log("Latitudee--<<<<<<< " + latitude + " - " + longitude)
        var url = "http://datos.labplc.mx/movilidad/vehiculos/" + placaRecib + ".json";
        var ajax = new XMLHttpRequest();
        ajax.open("GET", url, true);
        ajax.send(null);
        ajax.onreadystatechange = function() {
            console.log("entrando al onready ajax")
            if (ajax.readyState === XMLHttpRequest.DONE) {
                console.log("ajax.status: " + ajax.status);
                try {
                    var json = JSON.parse(ajax.responseText);
                    console.log(ajax.responseText);
                    jsonJalado = json;
                    var pagemain = paginaPrincipal.createObject();
                    navigation.push(pagemain);
                } catch (e) {
                
                }
            }
        
        }
    }
    onPopTransitionEnded: {
        page.destroy();
    }

}
