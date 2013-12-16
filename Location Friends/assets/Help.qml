import bb.cascades 1.2

    Page {
            titleBar: TitleBar {
                title: "Help!"
            }
            Container {
                background: Color.White
                layout: StackLayout {}
                Label {
                    text: "<html><b>How to use this application</b></html>" //qsTr("How to use this application")
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                    text: qsTr("to use this application there are two options")
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                    text:"<html><b>Send Location</b></html>" //qsTr("Send location")
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                    text: qsTr("to send your location to a friend so you just press the icon 'share location' and choose how you want to share (We recommend BBM ;) )")
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                    text: "<html><b>receiving location</b></html>"
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                text: "When someone sends his location the only thing to do is press the colored text (something like:'{lat: 19.4310525, lon: -99.1590726}) and the application will show you the exact point where your friend is on the map"
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Label {
                    text: '<html><a href="https://www.dropbox.com/s/g00tpj7vwp1sijr/avisoDePrivacidad.pdf">Privacy policy</a></html>'
                    textStyle{
                        base: SystemDefaults.TextStyles.BigText
                        color: Color.Black
                        fontFamily: FontStyle.Normal
                    }
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }
        }
    