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

import bb.cascades 1.2
import "js/funciones.js" as Funciones

Page {

    titleBar: TitleBar {
        title: qsTr('Calculadora de honorarios')
        kind: TitleBarKind.FreeForm
        kindProperties: FreeFormTitleBarKindProperties {
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                background: Color.create('#FF8000')
                leftPadding: 10
                rightPadding: 10
                Label {
                    text: qsTr('Calculadora de honorarios')
                    textStyle {
                        color: Color.White
                    }
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                }
            }
        }
    }

    Container {
        layout: StackLayout {
        }
        background: Color.create('#E6E6E6')
        Container {
            layout: AbsoluteLayout {
            }

            Container {
                layout: StackLayout {
                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 25
                }
                background: Color.create('#cccccc')
                preferredHeight: 280
                preferredWidth: 660
            }

            Container {
                layout: AbsoluteLayout {
                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 15
                }
                background: Color.create('#FFFFFF')
                preferredHeight: 280
                preferredWidth: 660
                Label {
                    accessibility.name: "Importe"
                    text: qsTr('Importe')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 35
                        positionY: 5
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    id: lblImporte
                    accessibility.name: "lblImporte"
                    text: qsTr('$0')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 5
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    accessibility.name: "iva"
                    text: qsTr('IVA (16%)')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 35
                        positionY: 50
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    id: lblIvaDieciseis
                    accessibility.name: "lblImporte"
                    text: qsTr('$0')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 50
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    accessibility.name: "subtotal"
                    text: qsTr('Subtotal')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 35
                        positionY: 95
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    id: lblSubtotal
                    accessibility.name: "lblSubtotal"
                    text: qsTr('$0')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 95
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    accessibility.name: "retencionIVA"
                    text: qsTr('Retencion IVA')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 35
                        positionY: 140
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    id: lblRetencionIVA
                    accessibility.name: "lblRetencion"
                    text: qsTr('$0')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 140
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    accessibility.name: "retencionISR"
                    text: qsTr('Retencion ISR (10%)')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 35
                        positionY: 185
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    id: lblRetencionISR
                    accessibility.name: "lblSubtotal"
                    text: qsTr('$0')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 185
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    accessibility.name: "total"
                    text: qsTr('Total')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 35
                        positionY: 230
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    id: lblTotal
                    accessibility.name: "lblTotal"
                    text: qsTr('$0')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 350
                        positionY: 230
                    }
                    textStyle.color: Color.create("#000000")
                }
            }

        }

        Container {
            layout: AbsoluteLayout {
            }

            Container {
                layout: StackLayout {
                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 25
                }
                background: Color.create('#cccccc')
                preferredHeight: 95
                preferredWidth: 660
            }

            Container {
                layout: AbsoluteLayout {
                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 20
                }
                background: Color.create('#FFFFFF')
                preferredHeight: 90
                preferredWidth: 660
                Label {
                    accessibility.name: "Signo"
                    text: qsTr('$')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 30
                        positionY: 20
                    }
                    textStyle.color: Color.create("#000000")
                }
                TextField {
                    id: ingresNum
                    accessibility.name: "ingresNum"
                    preferredWidth: 555
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 70
                        positionY: 10
                    }
                    maximumLength: 7
                    hintText: qsTr('5000')
                    onTextChanging: {
                        Funciones.calcular();
                    }
                }
            }
        }

        Container {
            layout: AbsoluteLayout {
            }

            Container {
                layout: StackLayout {
                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 20
                }
                background: Color.create('#cccccc')
                preferredHeight: 155
                preferredWidth: 660
            }

            Container {
                layout: AbsoluteLayout {
                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 30
                    positionY: 20
                }
                background: Color.create('#FFFFFF')
                preferredHeight: 145
                preferredWidth: 660
                Label {
                    accessibility.name: "note"
                    text: qsTr('NOTA:')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 20
                        positionY: 10
                    }
                    textStyle.color: Color.create("#000000")
                }
                Label {
                    accessibility.name: "note"
                    multiline: true
                    text: qsTr('Recuerda que esta calculadora solo sirve para personas fisicas que hacen recibos a personas morales.')
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 125
                        positionY: 10
                    }
                    textStyle.color: Color.create("#000000")
                    preferredWidth: 550
                }
            }
        }
    }
}
