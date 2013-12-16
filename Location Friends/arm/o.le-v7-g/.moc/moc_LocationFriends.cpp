/****************************************************************************
** Meta object code from reading C++ file 'LocationFriends.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/LocationFriends.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'LocationFriends.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MapViewDemo[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      20,   13,   12,   12, 0x08,

 // methods: signature, parameters, type, tag, flags
      56,   12,   12,   12, 0x02,
      83,   12,   12,   12, 0x02,
     103,   95,   12,   12, 0x02,
     152,  139,   12,   12, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_MapViewDemo[] = {
    "MapViewDemo\0\0invoke\0"
    "onInvoke(bb::system::InvokeRequest)\0"
    "addPinAtCurrentMapCenter()\0clearPins()\0"
    "lat,lon\0updateDeviceLocation(double,double)\0"
    "localizacion\0obtainManualData(QString)\0"
};

void MapViewDemo::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MapViewDemo *_t = static_cast<MapViewDemo *>(_o);
        switch (_id) {
        case 0: _t->onInvoke((*reinterpret_cast< const bb::system::InvokeRequest(*)>(_a[1]))); break;
        case 1: _t->addPinAtCurrentMapCenter(); break;
        case 2: _t->clearPins(); break;
        case 3: _t->updateDeviceLocation((*reinterpret_cast< double(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2]))); break;
        case 4: _t->obtainManualData((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MapViewDemo::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MapViewDemo::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MapViewDemo,
      qt_meta_data_MapViewDemo, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MapViewDemo::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MapViewDemo::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MapViewDemo::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MapViewDemo))
        return static_cast<void*>(const_cast< MapViewDemo*>(this));
    return QObject::qt_metacast(_clname);
}

int MapViewDemo::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
