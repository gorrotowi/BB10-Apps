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
#include "LocationFriends.hpp"

#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/Container>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/MapData>
#include <bb/cascades/maps/DataProvider>
#include <bb/cascades/QmlDocument>
#include <bb/platform/geo/Point>
#include <bb/platform/geo/GeoLocation>
#include <bb/platform/geo/Marker>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeManager>
#include <bb/UIToolkitSupport>
#include <bb/cascades/TextArea>
#include <bb/data/JsonDataAccess>
#include <bb/system/SystemPrompt>

//definimos los namespace que vamos a utilizar
using namespace bb;
using namespace bb::cascades;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;
using namespace bb::system;
using namespace bb::data;



//! [0]
MapViewDemo::MapViewDemo(bb::cascades::Application *app)
    : QObject(app)
{

	InvokeManager *invokeManager = new InvokeManager(this); //creamos un objeto invokeManager para poder manejar mas adelante tu signal y slot

	//declaramos el signal y slot del invoke
	connect(invokeManager, SIGNAL(invoked(const bb::system::InvokeRequest&)),
				this, SLOT(onInvoke(const bb::system::InvokeRequest&)));

	//creamos una referencia a nuestro main.qml y un contexto
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_mapViewTest", this);

    // creamos un objeto principal para nuestra interfaz
    root = qml->createRootObject<AbstractPane>();

    //creamos nuestro objeto mapa
    QObject* mapViewAsQObject = root->findChild<QObject*>(QString("mapViewObj"));
    if (mapViewAsQObject) {
        mapView = qobject_cast<bb::cascades::maps::MapView*>(mapViewAsQObject);
        mapView->setCaptionGoButtonVisible(true);
        if (mapView) {

        	//como nuestro mapa es una vista que recive datos necesitamos un proveedor y a la vez asignarselo a nuestro mapa
        	DataProvider* deviceLocDataProv = new DataProvider("device-location-data-provider");
            mapView->mapData()->addProvider(deviceLocDataProv);

            // create a geolocation just for the device's location
            deviceLocation = new GeoLocation("device-location-id");
            deviceLocation->setName("This is you");
            //deviceLocation->setDescription("<html><a href=\"http://www.blackberry.com\">Hyperlinks</a> are super useful in bubbles.</html>");

            // for that location, replace the standard default pin with the provided bulls eye asset
            Marker bullseye = Marker(UIToolkitSupport::absolutePathFromUrl(
                                QUrl("asset:///images/me.png")), QSize(60, 60),
                                QPoint(29, 29), QPoint(29, 1));
            deviceLocation->setMarker(bullseye);

            deviceLocDataProv->add(deviceLocation);
        }
    }

    // set created root object as a scene
    app->setScene(root);
}
//! [0]
//! [1]
void MapViewDemo::addPinAtCurrentMapCenter() {
    if (mapView) {
        GeoLocation* newDrop = new GeoLocation();
        newDrop->setLatitude(mapView->latitude());
        newDrop->setLongitude(mapView->longitude());
        QString desc = QString("Coordinates: %1, %2").arg(mapView->latitude(),
                                0, 'f', 3).arg(mapView->longitude(), 0, 'f', 3);
        newDrop->setName("Dropped Pin");
        newDrop->setDescription(desc);

        // use the marker in the assets, as opposed to the default marker
        Marker flag;
        flag.setIconUri(UIToolkitSupport::absolutePathFromUrl(
                        QUrl("asset:///images/on_map_pin.png")));
        flag.setIconSize(QSize(60, 60));
        flag.setLocationCoordinate(QPoint(20, 59));
        flag.setCaptionTailCoordinate(QPoint(20, 1));
        newDrop->setMarker(flag);

        mapView->mapData()->add(newDrop);
    }
}
//! [1]
//! [2]
void MapViewDemo::clearPins() {
    if (mapView) {
        // this will remove all pins, except the "device location" pin, as it's in a different data provider
        mapView->mapData()->defaultProvider()->clear();
    }
}
//! [2]
void MapViewDemo::updateDeviceLocation(double lat, double lon) {
    qDebug() << "MapViewDemo::updateDeviceLocation( " << lat << ", " << lon
            << " )";
    if (deviceLocation) {
        deviceLocation->setLatitude(lat);
        deviceLocation->setLongitude(lon);
    }
    mapView->setLatitude(lat);
    mapView->setLongitude(lon);
}

void MapViewDemo::obtainManualData(const QString &localizacion){
		bool flag;
		QString latiS, longtS;
		QString jsonString = localizacion;
		qDebug() <<"aca el valor de la cadena mi rey "<<jsonString;
		JsonDataAccess jda;
		QVariantMap qmap = jda.loadFromBuffer(jsonString).value<QVariantMap>();
		qDebug() <<"que segun el json "<< qmap;
		qDebug() <<"pos la latitud" << qmap["lat"].toString();
		qDebug() <<"pos la longitud" << qmap["lon"].toString();
		latiS = qmap["lat"].toString();
		longtS = qmap["lon"].toString();

		double latitud = latiS.toDouble(&flag);
		double longitud = longtS.toDouble(&flag);
		qDebug() << "latitud en entero " << latitud;
		qDebug() << "longitud en entero " << longitud;

		Marker amigo;
		amigo.setIconUri(UIToolkitSupport::absolutePathFromUrl(
	            QUrl("asset:///images/pinFriend.png")));
		amigo.setIconSize(QSize(60, 60));
		amigo.setLocationCoordinate(QPoint(20, 59));
		amigo.setCaptionTailCoordinate(QPoint(20, 1));
		GeoLocation *location = new GeoLocation;
		location->setLatitude(latitud);
		location->setLongitude(longitud);
		location->setMarker(amigo);
		mapView->mapData()->add(location);
		//}
}

void MapViewDemo::onInvoke(const bb::system::InvokeRequest& invoke){

	bool flag;
	QString latiS, longtS;
	QString jsonString = invoke.data();
	qDebug() <<"aca el valor de la cadena mi rey "<<jsonString;
	JsonDataAccess jda;
	QVariantMap qmap = jda.loadFromBuffer(jsonString).value<QVariantMap>();
	qDebug() <<"que segun el json "<< qmap;
	qDebug() <<"pos la latitud" << qmap["lat"].toString();
	qDebug() <<"pos la longitud" << qmap["lon"].toString();
	latiS = qmap["lat"].toString();
	longtS = qmap["lon"].toString();
	//int lati = latiS.toInt(&flag,10);
	//int longt = longtS.toInt(&flag, 10);
	double latitud = latiS.toDouble(&flag);
	double longitud = longtS.toDouble(&flag);
	qDebug() << "latitud en entero " << latitud;
	qDebug() << "longitud en entero " << longitud;
	Marker amigo;
	amigo.setIconUri(UIToolkitSupport::absolutePathFromUrl(
            QUrl("asset:///images/pinFriend.png")));
	amigo.setIconSize(QSize(60, 60));
	amigo.setLocationCoordinate(QPoint(20, 59));
	amigo.setCaptionTailCoordinate(QPoint(20, 1));
	GeoLocation *location = new GeoLocation;
	location->setLatitude(latitud);
	location->setLongitude(longitud);
	location->setMarker(amigo);
	location -> setName("I'm here!");
	mapView->mapData()->add(location);
 }
