import bb.cascades 1.2
import bb.system 1.0
NavigationPane {
    id: nav

    Page {

        property string jsonVerificacion
        onCreationCompleted: {
            requestplaca();
        }
        Container {
            Container {
                maxHeight: 300

                background: Color.create("#13BA32")
                layout: AbsoluteLayout {

                }

                Label {
                    text: "Verificación"
                    textStyle.color: Color.White
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 250
                        positionY: 15
                    }
                }
                
                ImageButton {
                    defaultImageSource: "asset:///images/verificacion.png"
                    preferredHeight: 90
                    preferredWidth: 110
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 630
                        positionY: 10
                    }
                    accessibility.name: "imgButton"
                    onClicked: {
                        var pageMap = mapViewVerif.createObject();
                        pageMap.servicioVerif();
                        nav.push(pageMap);
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
                ListView {
                    dataModel: gdmVerif
                    accessibility.name: "listVerif"
                    onTriggered: {
                        if (indexPath.length > 0) {
                            detalle.body = ListItemData.causa;
                            detalle.show();
                        }
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            Container {
                                layout: AbsoluteLayout {
                                }
                                preferredHeight: 150
                                Label {
                                    id: marcaLb
                                    text: ListItemData.marca
                                    textStyle.fontSize: FontSize.XLarge
                                    textStyle.color: Color.create("#13BA32")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 25
                                        positionY: 15
                                    }
                                }
                                Label {
                                    id: modeloLb
                                    text: ListItemData.modelo
                                    textStyle.fontSize: FontSize.XLarge
                                    textStyle.color: Color.create("#13BA32")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 455
                                        positionY: 15
                                    }
                                }
                                Label {
                                    text: ListItemData.vigencia
                                    textStyle.fontSize: FontSize.Medium
                                    textStyle.color: Color.create("#929292")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 25
                                        positionY: 100
                                    }
                                }
                                ImageView {
                                    id: imageLOL
                                    preferredHeight: 50
                                    preferredWidth: 50
                                    imageSource: "asset:///images/" + ListItemData.img
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
                id: gdmVerif
                sortingKeys: [ "item" ]
            },
            SystemDialog {
                id: detalle
                title: "Causa de rechazo"
            },
            ComponentDefinition {
                id: mapViewVerif
                source: "MapaVerif.qml"
            }
        ]

        function requestplaca() {

            //var direccion = "http://cosa.mobi/hackdf/clima2.html";
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
                        console.log("json " + ajax.responseText);
                        consulta = json.consulta;
                        verificaciones = consulta.verificaciones;
                        verificaciones.forEach(function(entrada) {
                                console.log(entrada.vigencia);
                                var cancel = entrada.cancelado;
                                var img;
                                if (cancel == "NO") {
                                    img = "si";
                                } else {
                                    img = "no";
                                }
                                gdmVerif.insert({
                                        "marca": entrada.marca,
                                        "vigencia": entrada.vigencia,
                                        "modelo": entrada.modelo,
                                        "img": img + ".png",
                                        "causa": entrada.casua_rechazo
                                    });
                            });
                    } catch (e) {
                        console.log("error " + e);
                        //temperaLb.layoutProperties.positionX = 30
                        //toastErrorCargando.show();
                    }

                }

            }
        }

    }
    onPopTransitionEnded: {
        page.destroy();
    }
}