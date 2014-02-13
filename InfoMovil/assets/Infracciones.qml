import bb.cascades 1.2

NavigationPane {
	id: nav
    Page {
        onCreationCompleted: {
            sendRequest();
        }
        attachedObjects: [
            ComponentDefinition {
                id: itemPageDefinition
                source: "itemInfraccion.qml"
            },
            GroupDataModel {
                id: gdm
                sortingKeys: [ "item" ]
            }
        ]
        //property string jsonInfracciones
        Container {
            Container {
                maxHeight: 300

                background: Color.create("#13BA32")
                layout: AbsoluteLayout {

                }

                Label {
                    text: "Infracciones"
                    textStyle.color: Color.White
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 240
                        positionY: 15
                    }
                }

                ImageView {
                    id: verificentros
                    //imageSource: "asset:///images/"
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
                    dataModel: gdm
                    onTriggered: {

                        if (indexPath.length > 1) {
                            var chosenItem = dataModel.data(indexPath);

                            var contentpage = itemPageDefinition.createObject();

                            contentpage.folio = chosenItem.folio;
                            contentpage.fecha = chosenItem.fecha;
                            contentpage.motivo = chosenItem.motivo;
                            //contentpage.fundamentos = chosenItem.fundamentos
                            contentpage.sancion = chosenItem.sancion;
                            nav.push(contentpage);
                        }
                    }
                    accessibility.name: "listv"
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            Container {
                                layout: AbsoluteLayout {
                                }
                                preferredHeight: 200
                                Label {
                                    id: fecha
                                    text: ListItemData.fecha
                                    textStyle.fontSize: FontSize.Default
                                    textStyle.color: Color.create("#13BA32")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 50
                                    }
                                }
                                Label {
                                    text: ListItemData.situacion
                                    textStyle.color: Color.create("#13BA32")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 350
                                    }
                                }
                                Label {
                                    text: ListItemData.motivo //ListItemData.motivo
                                    multiline: true
                                    //textStyle.textAlign: TextAlign.Center
                                    textStyle.fontSize: FontSize.XXSmall
                                    maxWidth: 700
                                    //textStyle.color:  //"#616263"
                                    textStyle.color: Color.create("#616263")
                                    textStyle {
                                        textAlign: TextAlign.Justify
                                        //fontFamily: fontSize.XXSmall
                                        //color: Color.create("#13BA32")
                                    }
                                    rightPadding: 10
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 30
                                        positionY: 60
                                    }
                                }
                            }
                        }
                    ]
                }

            }

        }

        function sendRequest() {

            //console.log("Latitudee--<<<<<<< " + latitude + " - " + longitude)
            var url = "http://datos.labplc.mx/movilidad/vehiculos/A43051.json";
            var ajax = new XMLHttpRequest();
            ajax.open("GET", url, true);
            ajax.send(null);
            ajax.onreadystatechange = function() {
                console.log("entrando al onready ajax")
                if (ajax.readyState === XMLHttpRequest.DONE) {
                    console.log("ajax.status: " + ajax.status);
                    var json = JSON.parse(ajax.responseText);
                    console.log("json " + ajax.responseText);
                    console.log("json consulta " + json["consulta"].placa);
                    console.log("json consulta.placa " + json.consulta.placa);
                    console.log("json consulta tenencia " + json.consulta.tenencias.tieneadeudos)
                    var infracciones = json.consulta.infracciones;
                    console.log("infracciones " + infracciones);
                    infracciones.forEach(function(entrada) {
                            console.log("marca " + entrada.fecha);
                            gdm.insert({
                                    "fecha": entrada.fecha,
                                    "situacion": entrada.situacion,
                                    "motivo": entrada.motivo,
                                    "folio": entrada.folio,
                                    "fundamentos": entrada.fundamentos,
                                    "sancion":entrada.sancion
                                });
                        });

                }

            }

        }

    }
}
