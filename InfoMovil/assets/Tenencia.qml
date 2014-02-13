import bb.cascades 1.2

Page {
    onCreationCompleted: {
        consultaTenencias();
    }
    Container {
        Container {
            maxHeight: 300

            background: Color.create("#13BA32")
            layout: AbsoluteLayout {

            }

            Label {
                text: "Tenencia"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 270
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

            layout: AbsoluteLayout {
            }
            Label {
                id: tenenciaLb
                text: "¡Felicidades! No cuentas con ningun adeudo."
                preferredWidth: 600
                textStyle.fontSize: FontSize.XLarge
                multiline: true
                textStyle.textAlign: TextAlign.Justify
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 90
                    positionY: 400
                }
            }
        }
    }
    function consultaTenencias() {
        var direccion = "http://datos.labplc.mx/movilidad/vehiculos/436prr/tenencias.json"
        var consulta, tenencias, adeu, tAdeudos, placaRequest;

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
                    tenencias = consulta.tenencias;
                    tAdeudos = tenencias.tieneadeudos;
                    if(tAdeudos!="0"){
                        adeu = tenencias.adeudos;
                        tenenciaLb.text = "Tienes "+tAdeudos+ " adeudo(s). En el ejercicio:\n "+adeu+".";
                    }

                } catch (e) {
                    console.log("error " + e);
                }
            }
        }
    }
}
