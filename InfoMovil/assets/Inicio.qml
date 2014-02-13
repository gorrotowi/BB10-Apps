import bb.cascades 1.2
import bb.system 1.0

//http://dev.datos.labplc.mx/aire.json

Page {
    
    property string jsonGlobalAuto

    //property string

    onCreationCompleted: {
        requestClima();
        obtenerFecha();
        getTwitter();
        requestplaca();
    }
    Container {

        Container {
            maxHeight: 300
            id: climaContainer
            background: Color.create("#f0f0f0")
            layout: AbsoluteLayout {

            }

            Label {
                text: "Inicio"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 320
                    positionY: 15
                }
            }

            Label {
                id: condicionLb
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.Medium
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 100
                }
                text: "Condicion del aire"
            }

            Label {
                id: temperaLb
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XXLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 100
                    positionY: 200
                }
                text: "-'C"
            }

            Label {
                id: fechaLb
                text: "fecha"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.Large
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 500
                    positionY: 100
                }
            }

            ImageView {
                id: imageEstado
                imageSource: "asset:///images/nublado.png"
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 530
                    positionY: 200
                }
            }

            Label {
                text: " "
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 900
                }
            }

            ImageView {
                id: reload
                imageSource: "asset:///images/actualizar.png"
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 700
                    positionY: 30
                }
                onTouch: {
                    requestClima();
                    requestplaca();
                    getTwitter();
                    obtenerFecha();
                }
            }

        }

        Container {
            layout: AbsoluteLayout {
            }

            Container {
                id: engomadoColor
                background: Color.create("#f0f0f0");
                layout: AbsoluteLayout {

                }
                preferredHeight: 100
                preferredWidth: 285
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 40
                    positionY: 70
                }

                Label {
                    id: engomadoLb
                    text: "-"
                    textStyle.textAlign: TextAlign.Center
                    textStyle.fontSize: FontSize.Large
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 130
                        positionY: 20
                    }
                }
            }

            Label {
                id: circulaLb
                text: "Hoy no circula"
                textStyle.fontSize: FontSize.Large
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 50
                    positionY: 190
                }
            }

            Label {
                id: noCirculaDiaLb
                text: "Lunes"
                textStyle.fontSize: FontSize.Large
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 50
                    positionY: 250
                }
            }

            ImageView {
                id: autoCircula
                imageSource: "asset:///images/autoNormal.png"
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 450
                    positionY: 100
                }
            }

        }

        Container {
            background: Color.create("#13BA32")
            layout: AbsoluteLayout {
            }
            Label {
                text: " "
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 770
                    positionY: 100
                }
            }

            Label {
                id: calidadLb
                text: "Calidad del aire: -"
                textStyle.color: Color.White
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 15
                    positionY: 15
                }
            }

            Label {
                id: recomendacionLb
                text: "Hoy puedes hacer un dia ecologico"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.Small
                multiline: true
                maxWidth: 500
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 15
                    positionY: 80
                }
            }

            ImageView {
                id: arrowMap
                imageSource: "asset:///images/arrowFront.png"
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 700
                    positionY: 50
                }
            }

        }

        Container {
            ListView {
                dataModel: gdm
                accessibility.name: "listTwitter"
                listItemComponents: [

                    ListItemComponent {

                        type: "item"
                        Container {
                            layout: AbsoluteLayout {
                            }
                            preferredHeight: 150
                            Label {
                                id: user
                                text: "@"+ ListItemData.username
                                textStyle.fontSize: FontSize.Medium
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 10
                                }
                            }
                            Label {
                                id: tw
                                text: ListItemData.tweet
                                multiline: true
                                preferredWidth: 750
                                textStyle.fontSize: FontSize.XXSmall
                                layoutProperties: AbsoluteLayoutProperties {
                                    positionX: 10
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
        SystemToast {
            id: toastErrorCargando
            body: "Ops! Algo esta mal, vuelve a actualizar"
        },
        ComponentDefinition {
            id: autosView
            source: "Autos.qml"
        },
        ComponentDefinition {
            id:tenenciaView
            source: "Tenencia.qml"
        },
        ComponentDefinition {
            id: verificacionView
            source: "Verificacion.qml"
        },
        ComponentDefinition {
            id: noCirculaView
            source: "HoyCircula.qml"
        },
        ComponentDefinition {
            id: infraccionesView
            source: "Infracciones.qml"
        }
    ]
    
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
                    console.log("dime la placa "+placaRequest)
                    //var arreglo = new Array();
                    for (var i=placaRequest.length ; i>=0; i--){
                        console.log("dime la letra "+placaRequest[i])
                        console.log(placaRequest.charCodeAt(i));
                        var number = placaRequest.charCodeAt(i) - 48;
                        switch (number){
                            case 5:
                            case 6:
                                noCirculaDiaLb.text = "Lunes"
                                engomadoColor.background = Color.create("#FAF327");
                                engomadoLb.text = number;
                                break;
                            case 7:
                            case 8:
                                noCirculaDiaLb.text = "Martes"
                                engomadoColor.background = Color.create("#EDA7CB");
                                engomadoLb.text = number;
                                break;
                            case 3:
                            case 4:
                                noCirculaDiaLb.text = "Miercoles"
                                engomadoColor.background = Color.create("#E0202F");
                                engomadoLb.text = number;
                                break;
                            case 1:
                            case 2:
                                noCirculaDiaLb.text = "Jueves"
                                engomadoColor.background = Color.create("#25A163");
                                engomadoLb.text = number;
                                break;
                            case 9:
                            case 0:
                                noCirculaDiaLb.text = "Viernes"
                                engomadoColor.background = Color.create("#99D6E9");
                                engomadoLb.text = number;
                                break;
                            default :
                                break;
                        }
                        if(engomadoLb.text!="-"){
                            var fecha = new Date();
                            var dia = fecha.getDay();
                            var diaLocal = getDia(dia);
                            if (diaLocal != noCirculaDiaLb){
                            	noCirculaDiaLb.visible = false
                            	circulaLb.text = "Hoy si circula"
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
    
    function getDia(dia){
        var diaF;
        switch (dia){
            case 0:
                diaF="Domingo"
                break;
            case 1:
                diaF="Lunes"
                break;
            case 2:
                diaF="Martes"
                break;
            case 3:
                diaF="Miercoles"
                break;
            case 4:
                diaF="Jueves"
                break;
            case 5:
                diaF="Viernes"
                break;
            case 6:
                diaF="Sabado"
                break;
            default :
                diaF = "-"
                break;
        }
        return diaF;
    }

    function requestClima() {
        var direccion = "http://datos.labplc.mx/aire.json";
        //var direccion = "http://cosa.mobi/hackdf/clima2.html";	
        var categoria, condi, temper, recomendacion;

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
                    //console.log("clima " + json.consulta.clima);
                    var clima = json.consulta.clima;

                    var calidadV = json.consulta.calidad
                    categoria = calidadV.categoria;
                    recomendacion = calidadV.recomendaciones;

                    condi = clima.condicion;
                    temper = clima.temperatura;
                    
                    colorTemp(temper);
                    //console.log("dime la condicion " + condi);
                    //console.log("dime la temperatura " + temper);
                    condicionLb.text = condi;
                    temperaLb.text = temper + " 'C";
                    calidadLb.text = "Calidad del aire: " + categoria;
                    //recomendacionLb.text = recomendacion;

                } catch (e) {
                    console.log("error "+e);
                    //temperaLb.layoutProperties.positionX = 30
                    toastErrorCargando.show();
                }

            }

        }
    }
    
    function colorTemp(grados){
        if(grados<=8){
            climaContainer.background=Color.create("#4452FF");
        }else if(grados>8&&grados<=16){
            climaContainer.background=Color.create("#5DC9F9");
        }else if(grados>16&&grados<=24){
            climaContainer.background=Color.create("#E5D948");
        }else if(grados>24&&grados<=32){
            climaContainer.background=Color.create("#FC8F2D");
        }else if(grados>32){
            climaContainer.background=Color.create("#F93030");
        }
        
    }

    function obtenerFecha() {
        var fecha = new Date();
        var mes = fecha.getUTCMonth();
        var dia = fecha.getUTCDate();
        var anio = fecha.getUTCFullYear();
        var fechaFormateada = dia + "/" + (mes + 1) + "/" + anio;
        fechaLb.text = fechaFormateada;
    }

    function getTwitter() {
        //console.log("Latitudee--<<<<<<< " + latitude + " - " + longitude)
        var url = "http://cosa.mobi/hackdf/?user=072Avial";
        var ajax = new XMLHttpRequest();
        ajax.open("GET", url, true);
        ajax.send(null);

        ajax.onreadystatechange = function() {
            console.log("entrando al onready ajax")
            if (ajax.readyState === XMLHttpRequest.DONE) {
                //console.log("ajax.status: " + ajax.status);
                var json = JSON.parse(ajax.responseText);
                //console.log("json " + ajax.responseText);
                json.forEach(function(entrada) {
                        // console.log("dime el tweet " + entrada.text);
                        //console.log("dime el username " + entrada.user.screen_name);
                        gdm.insert({
                                "username": entrada.user.screen_name,
                                "tweet": entrada.text,
                                "title": "Twitter Setravi"
                            });
                    });
            }
        }

    }

}
