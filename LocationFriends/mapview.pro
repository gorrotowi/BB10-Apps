TEMPLATE = app
TARGET = mapview

CONFIG += qt warn_on debug_and_release cascades

INCLUDEPATH += ../src
SOURCES += ../src/*.cpp
HEADERS += ../src/*.hpp ../src/*.h
LIBS += -lQtLocationSubset -lbbcascadesmaps -lGLESv1_CM -lbbsystem -lbbdata

lupdate_inclusion {
    SOURCES += ../assets/*.qml
}

device {
    CONFIG(release, debug|release) {
        DESTDIR = o.le-v7
        TEMPLATE = lib
        QMAKE_CXXFLAGS_RELEASE += -fvisibility=hidden -mthumb
    }
    CONFIG(debug, debug|release) {
        DESTDIR = o.le-v7-g
    }
}

simulator {
    CONFIG(release, debug|release) {
        DESTDIR = o
    }
    CONFIG(debug, debug|release) {
        DESTDIR = o-g
    }
}

OBJECTS_DIR = $${DESTDIR}/.obj
MOC_DIR = $${DESTDIR}/.moc
RCC_DIR = $${DESTDIR}/.rcc
UI_DIR = $${DESTDIR}/.ui

suredelete.target = sureclean
suredelete.commands = $(DEL_FILE) $${MOC_DIR}/*; $(DEL_FILE) $${RCC_DIR}/*; $(DEL_FILE) $${UI_DIR}/*
suredelete.depends = distclean

QMAKE_EXTRA_TARGETS += suredelete

TRANSLATIONS = \
    $${TARGET}_en_GB.ts \
    $${TARGET}_fr.ts \
    $${TARGET}_it.ts \
    $${TARGET}_de.ts \
    $${TARGET}_es.ts \
    $${TARGET}.ts
    
    QMAKE_CFLAGS_RELEASE += -fstack-protector-strong
QMAKE_CXXFLAGS_RELEASE += -fstack-protector-strong
QMAKE_LFLAGS_RELEASE += -Wl,-z,relro

QMAKE_POST_LINK = ntoarm-objcopy --only-keep-debug ${DESTDIR}/${QMAKE_TARGET} ${DESTDIR}/${QMAKE_TARGET}.sym && ntoarm-objcopy --strip-all -R.ident --add-gnu-debuglink "${DESTDIR}/${QMAKE_TARGET}.sym" "$@" "${DESTDIR}/${QMAKE_TARGET}"
