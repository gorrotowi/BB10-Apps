import bb.cascades 1.2

Page {
    Container {
        
        Container {
            maxHeight: 300
            
            background: Color.create("#13BA32")
            layout: AbsoluteLayout {
            
            }
            
            Label {
                text: "Hoy no circula"
                textStyle.color: Color.White
                textStyle.fontSize: FontSize.XLarge
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 220
                    positionY: 15
                }
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
           ImageView {
               preferredHeight: 1040
               preferredWidth: 768
               imageSource: "asset:///images/nocirculaInfo.png"
           }
        }
        
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: backgroundFull
            imageSource: "asset:///images/nocirculaInfo.png"
        }
    ]
}
