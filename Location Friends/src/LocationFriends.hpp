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
#ifndef LOCATIONFRIENDS_HPP
#define LOCATIONFRIENDS_HPP

#include <QObject>
#include <bb/system/InvokeRequest>
#include <bb/cascades/AbstractPane>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class Application;
		namespace maps {
			class MapView;
		}
	}
	namespace platform {
		namespace geo {
			class GeoLocation;
			}
		}
	}

class MapViewDemo: public QObject {
    Q_OBJECT

    //en public se nombran las funciones que se van a usar tanto del lado de c++ como en QML
public:
    MapViewDemo(bb::cascades::Application *app);

    Q_INVOKABLE void addPinAtCurrentMapCenter();
    Q_INVOKABLE void clearPins();
    Q_INVOKABLE void updateDeviceLocation(double lat, double lon);
    Q_INVOKABLE void obtainManualData(const QString &localizacion);
    //AbstractPane *root;

private slots:
	//con esta funcion vamos a lograr que nuestra applicacion sea invokable desde cualquier otra app
	void onInvoke(const bb::system::InvokeRequest& invoke);

	//creamos nuestros objetos mapView y Geolocation
private:
    bb::cascades::maps::MapView* mapView;
    bb::platform::geo::GeoLocation* deviceLocation;

    AbstractPane *root;
};

#endif
