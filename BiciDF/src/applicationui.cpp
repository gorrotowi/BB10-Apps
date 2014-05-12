/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
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

#include "applicationui.hpp"

#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/Container>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/MapData>
#include <bb/cascades/maps/DataProvider>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/LocaleHandler>
#include <bb/platform/geo/Point>
#include <bb/platform/geo/GeoLocation>
#include <bb/platform/geo/Marker>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeManager>
#include <bb/UIToolkitSupport>
#include <bb/cascades/TextArea>
#include <bb/data/JsonDataAccess>
#include <bb/system/SystemPrompt>

using namespace bb;
using namespace bb::cascades;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;
using namespace bb::system;
using namespace bb::data;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
		QObject(app) {
	// prepare the localization
	m_pTranslator = new QTranslator(this);
	m_pLocaleHandler = new LocaleHandler(this);

	bool res = QObject::connect(m_pLocaleHandler,
			SIGNAL(systemLanguageChanged()), this,
			SLOT(onSystemLanguageChanged()));
	// This is only available in Debug builds
	Q_ASSERT(res);
	// Since the variable is not used in the app, this is added to avoid a
	// compiler warning
	Q_UNUSED(res);

	// initial load
	onSystemLanguageChanged();

	// Create scene document from main.qml asset, the parent is set
	// to ensure the document gets destroyed properly at shut down.
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

	qml->setContextProperty("_appMap", this);

	// Create root object for the UI
	AbstractPane *root = qml->createRootObject<AbstractPane>();

	QObject* mapViewObject = root->findChild<QObject*>(QString("mapViewObj"));
	if(mapViewObject){
		mapView = qobject_cast<bb::cascades::maps::MapView*>(mapViewObject);
		mapView->setCaptionGoButtonVisible(true);
		if (mapView) {
			DataProvider* deviceLocDataProvider = new DataProvider("device-location-data-provider");
			mapView->mapData()->addProvider(deviceLocDataProvider);
			deviceLocation = new GeoLocation("device-location-id");
			deviceLocation->setName("Aqui estas");
			Marker marcador = Marker(UIToolkitSupport::absolutePathFromUrl(
					QUrl("asset:///images/me.png")), QSize(60,60),
					QPoint(29,29),QPoint(29,1));
			deviceLocation->setMarker(marcador);
			deviceLocDataProvider->add(deviceLocation);
		}
	}

	// Set created root object as the application scene
	app->setScene(root);
}

void ApplicationUI::addPinAtCurrentMapCenter() {
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

void ApplicationUI::clearPins() {
    if (mapView) {
        // this will remove all pins, except the "device location" pin, as it's in a different data provider
        mapView->mapData()->defaultProvider()->clear();
    }
}
//! [2]
void ApplicationUI::updateDeviceLocation(double lat, double lon) {
    qDebug() << "MapViewDemo::updateDeviceLocation( " << lat << ", " << lon
            << " )";
    if (deviceLocation) {
        deviceLocation->setLatitude(lat);
        deviceLocation->setLongitude(lon);
    }
    mapView->setLatitude(lat);
    mapView->setLongitude(lon);
}

void ApplicationUI::onSystemLanguageChanged() {
	QCoreApplication::instance()->removeTranslator(m_pTranslator);
	// Initiate, load and install the application translation files.
	QString locale_string = QLocale().name();
	QString file_name = QString("BiciDF_%1").arg(locale_string);
	if (m_pTranslator->load(file_name, "app/native/qm")) {
		QCoreApplication::instance()->installTranslator(m_pTranslator);
	}
}
