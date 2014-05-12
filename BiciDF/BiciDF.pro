APP_NAME = BiciDF

CONFIG += qt warn_on cascades10
LIBS += -lbbplatformbbm
LIBS += -lbbsystem
LIBS += -lbb
LIBS += -lQtLocationSubset -lbbcascadesmaps -lGLESv1_CM -lbbsystem -lbbdata

include(config.pri)
