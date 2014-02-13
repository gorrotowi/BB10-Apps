
import bb.cascades 1.2

TabbedPane {
    showTabsOnActionBar: false
    //activeTab: autosTab
    Tab {
        title: "Inicio"
        imageSource:"asset:///images/inicio.png"
        id: inicioTab
        delegate: Delegate {
            id: iniDelegate
            source: "Inicio.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.Default
    }
    Tab {
        title: "Autos"
        imageSource: "asset:///images/autos.png"
        id: autosTab
        delegate: Delegate {
            id: autosDelegate
            source: "Autos.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.Default
    }
    Tab {
        title: "Tenencia"
        imageSource: "asset:///images/tenencia.png"
        id: tenenciaTab
        delegate: Delegate {
            id: tenenciaDelegate
            source: "Tenencia.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.Default
    }
    Tab {
        title: "Verificación"
        imageSource: "asset:///images/verificacion.png"
        id: verificacionTab
        delegate: Delegate {
            id: verifiDelegate
            source: "Verificacion.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.Default
    }
    Tab {
        title:"Hoy no circula"
        imageSource: "asset:///images/nocircula.png"
        id: hoycirculaTab
        delegate: Delegate {
            id: hoycirculaDelegate
            source: "HoyCircula.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.Default
    }
    Tab {
        title: "Infracciones"
        imageSource: "asset:///images/infracciones.png"
        id: infracionesTab
        delegate: Delegate {
            id: infracDelegate
            source: "Infracciones.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.Default
    }
    
}
