import bb.cascades 1.2
import bb.system 1.0

NavigationPane {
    property string placaAuto
    //property string jsonGuardado
    id: navigationAuto

    onCreationCompleted: {

            requestplaca();
        
    }

    Page {
        id: pagina
        attachedObjects: [
            ComponentDefinition {
                id: agregarAutos
                source: "AutoNuevo.qml"
            },
            GroupDataModel {
                id: gdmAuto
                sortingKeys: [ "item" ]
            }
        ]

        Container {

            Container {
                maxHeight: 300

                background: Color.create("#13BA32")
                layout: AbsoluteLayout {

                }

                Label {
                    text: "Autos"
                    textStyle.color: Color.White
                    textStyle.fontSize: FontSize.XLarge
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 310
                        positionY: 15
                    }
                }

                ImageButton {
                    id: plusCar
                    preferredHeight: 60
                    preferredWidth: 60
                    defaultImageSource: "asset:///images/agregarIcon.png"
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 660
                        positionY: 25
                    }
                    onClicked: {
                        console.log("presionando agregar");
                        var page = agregarAutos.createObject();
                        navigationAuto.push(page);
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
                id: textoSinCar
                preferredWidth: 700
                Label {
                    text: "No tienes ningun auto, agrega uno para poder empezar"
                    multiline: true
                    textStyle.fontSize: FontSize.XLarge
                    textStyle.textAlign: TextAlign.Center
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 100
                        positionY: 400
                    }
                }
            }
            Container {
                ListView {
                    dataModel: gdmAuto
                    accessibility.name: "listaAuto"
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            Container {
                                layout: AbsoluteLayout {
                                }
                                preferredHeight: 150
                                Label {
                                    id: marcaAut
                                    text: ListItemData.marca
                                    textStyle.fontSize: FontSize.Default
                                    textStyle.color: Color.create("#13BA32")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 25
                                        positionY: 15
                                    }
                                }
                                Label {
                                    id: modeloAut
                                    text: ListItemData.modelo
                                    //textStyle.fontSize: FontSize.XLarge
                                    textStyle.color: Color.create("#13BA32")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 455
                                        positionY: 15
                                    }
                                }
                                Label {
                                    id: placaAut
                                    text: ListItemData.placa
                                    textStyle.fontSize: FontSize.Medium
                                    textStyle.color: Color.create("#929292")
                                    layoutProperties: AbsoluteLayoutProperties {
                                        positionX: 25
                                        positionY: 100
                                    }
                                }
                            }
                        }
                    ]
                }
            }
        }

    }

    onPopTransitionEnded: {
        page.destroy();
    }
    
    function parseoJsonLocal(){
        
        var consultaLocal,placaRequestLocal,marcalocal,verificacioneslocal,modelolocal
        
        var jsonlocal = JSON.parse(jsonGuardado);
        consultaLocal = jsonlocal.consulta;
        placaRequestLocal = consultaLocal.placa;
        verificacioneslocal = consultaLocal.verificaciones;
        marcalocal = verificacioneslocal[0].marca;
        modelolocal = verificacioneslocal[0].modelo;
        console.log("dime la marca: " + marcalocal + " y el modelo: " + modelolocal + " placa: " + placaRequestLocal);
        gdmAuto.insert({
                "marca": marcalocal,
                "modelo": modelolocal,
                "placa": placaRequestLocal
        });
    }

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
                    //jsonGuardado = json;
                    console.log("json " + ajax.responseText);
                    //console.log("clima " + json.consulta.clima);
                    consulta = json.consulta;
                    placaRequest = consulta.placa;
                    verificaciones = consulta.verificaciones;
                    marca = verificaciones[0].marca;
                    modelo = verificaciones[0].modelo;
                    console.log("dime la marca: " + marca + " y el modelo: " + modelo + " placa: " + placaRequest);
                    gdmAuto.insert({
                            "marca": marca,
                            "modelo": modelo,
                            "placa": placaRequest
                        });
                } catch (e) {
                    console.log("error " + e);
                    //temperaLb.layoutProperties.positionX = 30
                    //toastErrorCargando.show();
                }
                if (marca != "") {
                    textoSinCar.visible = false;
                }else {
                    textoSinCar.visible = true;
                }
            }

        }
    }

}