import bb.cascades 1.2

NavigationPane {
    id: navigationCircula
    property string jsonCircula
    
    onCreationCompleted: {
        requestplaca();
    }

    attachedObjects: [
        ComponentDefinition {
            id: infoCircula
            source: "HoyNoCirculaInfo.qml"
        },
        GroupDataModel {
            id: gdmCircula
            sortingKeys: [ "item" ]
        }
    ]
    Page {
        Container {

            Container {
                maxHeight: 300

                background: Color.create("#13BA32")
                layout: AbsoluteLayout {

                }

                Label {
                    text: "Hoy no circula"
                    textStyle.color: Color.White
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 220
                        positionY: 15
                    }
                }

                /*ImageView {
                 * id: infoicon
                 * preferredHeight: 50
                 * preferredWidth: 50
                 * imageSource: "asset:///images/infoIcon.png"
                 * layoutProperties: AbsoluteLayoutProperties {
                 * positionX: 690
                 * positionY: 30
                 * }
                 * onTouch: {
                 * var page = infoCircula.createObject();
                 * navigationCircula.push(page);
                 * }
                 * }*/

                ImageButton {
                    id: info
                    preferredHeight: 50
                    preferredWidth: 50
                    defaultImageSource: "asset:///images/infoIcon.png"
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 680
                        positionY: 30
                    }
                    onClicked: {
                        var page = infoCircula.createObject();
                        navigationCircula.push(page);
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
                maxHeight: 300
                id: engomadoColor
                background: Color.create("#F0F0F0")
                layout: AbsoluteLayout {

                }

                Label {
                    id: engomadoLb
                    text: "-"
                    textStyle.color: Color.Black
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 290
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
                layout: AbsoluteLayout {}
                
                Label {
                    id: lbCircula
                    text: "Hoy si circula tu auto"
                    textStyle.fontSize: FontSize.XXLarge
                    textStyle.color: Color.create("#929292");
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 50
                        positionY: 200
                    }
                }
                
                ImageView {
                    id: carCircula
                    preferredWidth: 358
                    preferredHeight: 291
                    imageSource: "asset:///images/siCirculaCar.png"
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 650
                    }
                }
                
            }

        }
    }

    onPopTransitionEnded: {
        page.destroy();
    }
    function requestplaca() {

        var direccion = "http://datos.labplc.mx/movilidad/vehiculos/299rpu.json"
        var consulta, verificaciones, marca, modelo, placaRequest;

        var ajax = new XMLHttpRequest();
        ajax.open("GET", direccion, true);
        ajax.send(null);
        ajax.onreadystatechange = function() {
            //console.log("entrando al onready ajax")
            if (ajax.readyState === XMLHttpRequest.DONE) {
                //console.log("ajax.status: " + ajax.status);
                try {
                    var json = JSON.parse(ajax.responseText);
                    //jsonGlobalAuto = json;
                    console.log("json " + ajax.responseText);
                    consulta = json.consulta;
                    placaRequest = consulta.placa;
                    console.log("dime la placa " + placaRequest)
                    //var arreglo = new Array();
                    for (var i = placaRequest.length; i >= 0; i --) {
                        console.log("dime la letra " + placaRequest[i])
                        console.log(placaRequest.charCodeAt(i));
                        var number = placaRequest.charCodeAt(i) - 48;
                        var diaNoC;
                        switch (number) {
                            case 5:
                            case 6:
                                diaNoC = "Lunes"
                                engomadoColor.background = Color.create("#FAF327");
                                engomadoLb.text = placaRequest;
                                break;
                            case 7:
                            case 8:
                                diaNoC = "Martes"
                                engomadoColor.background = Color.create("#EDA7CB");
                                engomadoLb.text = placaRequest;
                                break;
                            case 3:
                            case 4:
                                diaNoC = "Miercoles"
                                engomadoColor.background = Color.create("#E0202F");
                                engomadoLb.text = placaRequest;
                                break;
                            case 1:
                            case 2:
                                diaNoC = "Jueves"
                                engomadoColor.background = Color.create("#25A163");
                                engomadoLb.text = placaRequest;
                                break;
                            case 9:
                            case 0:
                                diaNoC = "Viernes"
                                engomadoColor.background = Color.create("#99D6E9");
                                engomadoLb.text = placaRequest;
                                break;
                            default:
                                break;
                        }
                        if (engomadoLb.text != "-") {
                            var fecha = new Date();
                            var dia = fecha.getDay();
                            var diaLocal = getDia(dia);
                            if (diaLocal == diaNoC) {
                                //noCirculaDiaLb.visible = false
                                lbCircula.text = "Hoy no circula tu auto"
                                lbCircula.layoutProperties.positionX=35
                                carCircula.imageSource = "asset:///images/noCirculaCar.png"
                            }
                            break;
                        }
                    }

                } catch (e) {
                    console.log("error " + e);
                    //temperaLb.layoutProperties.positionX = 30
                    //toastErrorCargando.show();
                }

            }

        }
    }

    function getDia(dia) {
        var diaF;
        switch (dia) {
            case 0:
                diaF = "Domingo"
                break;
            case 1:
                diaF = "Lunes"
                break;
            case 2:
                diaF = "Martes"
                break;
            case 3:
                diaF = "Miercoles"
                break;
            case 4:
                diaF = "Jueves"
                break;
            case 5:
                diaF = "Viernes"
                break;
            case 6:
                diaF = "Sabado"
                break;
            default:
                diaF = "-"
                break;
        }
        return diaF;
    }
}
