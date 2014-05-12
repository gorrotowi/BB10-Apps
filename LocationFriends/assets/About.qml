import bb.cascades 1.2

Page {
    Container {
        layout: DockLayout {
            
        }
        Label {
            text: 'This application was made by @gorrotowi'
            textStyle{
                base: SystemDefaults.TextStyles.BigText
                color: Color.Black
                fontFamily: FontStyle.Normal
            }
            multiline: true
            horizontalAlignment: HorizontalAlignment.Center
            //verticalAlignment: VerticalAlignment.Center
        }
       Button {
           id: vendor
           text: "More Applications"
           horizontalAlignment: HorizontalAlignment.Center
           verticalAlignment: VerticalAlignment.Center
           onTouch: {
            
           }
       }
    }
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: "Back"
            //imageSource: "asset:///back.png"
            onTriggered: { navigationPane.pop(); }
        }
    }
    attachedObjects: [
        Invocation {
            id: appworld
            query{
                invokeTargetId: "appworld://vendor/"
            }
        }
    ]
}
