function llenarLista() {
	for ( var i = 0; i < 20; i++) {
		gdm.insert({
			"name" : "estacion",
			"distancia" : "500" + " metros",
			"disp" : "50",
			"free" : "15"
		});
	}
}

var red, estaciones, free_places, name, bicis, latitud, longitud, id;

function requestplaca() {

    var direccion = "http://api.citybik.es/v2/networks/ecobici"

    var ajax = new XMLHttpRequest();
    ajax.open("GET", direccion, true);
    ajax.send(null);
    ajax.onreadystatechange = function() {
        if (ajax.readyState === XMLHttpRequest.DONE) {
            try {
                var json = JSON.parse(ajax.responseText);
                console.log("json " + ajax.responseText);
                consulta = json.consulta;

            } catch (e) {
                console.log("error " + e);
            }

        }

    }
}