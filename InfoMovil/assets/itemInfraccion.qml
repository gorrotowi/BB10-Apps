import bb.cascades 1.2

Page {
    property string folio
    property string fecha
    property string motivo
    property string fundamentos
    property string sancion
    
    Container {
    
        Container {
            maxHeight: 300
            
            background: Color.create("#13BA32")
            layout: AbsoluteLayout {
            
            }
            
            Label {
                text: "Detalle"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 290
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
                text: "Folio:"
                textStyle.fontSize: FontSize.Large
                textStyle.color: Color.create("#13BA32")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 50
                    positionY: 50
                }
            }
            
            Label {
                text: folio
                textStyle.fontSize: FontSize.Medium
                textStyle.color: Color.create("#929292")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 200
                    positionY: 50
                }
            }
            
            Label {
                text: fecha
                textStyle.fontSize: FontSize.Small
                textStyle.color: Color.create("#929292")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 520
                    positionY: 55
                }
            }
            Label {
                text: "Motivo:"
                textStyle.fontSize: FontSize.Large
                textStyle.color: Color.create("#13BA32")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 50
                    positionY: 150
                }
            }
            Label {
                text: motivo
                multiline: true
                maxWidth: 600
                textStyle.fontSize: FontSize.XSmall
                textStyle.color: Color.create("#929292")
                layoutProperties: AbsoluteLayoutProperties {
                	positionX: 50
                	positionY: 230                    
                }
            }
            Label {
                text: "Sancion:"
                textStyle.fontSize: FontSize.Large
                textStyle.color: Color.create("#13BA32")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 50
                    positionY: 550
                }
            }
            Label {
                text: sancion
                multiline: true
                maxWidth: 600
                textStyle.fontSize: FontSize.XSmall
                textStyle.color: Color.create("#929292")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 50
                    positionY: 625                    
                }
            }            
        }
        
    }
}
