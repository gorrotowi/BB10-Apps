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

        ScrollView {
            accessibility.name: "scrollView"
            Container {

                Container {
                    layout: AbsoluteLayout {
                    }

                    Container {
                        layout: StackLayout {
                        }
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 35
                            positionY: 50
                        }
                        background: Color.create('#cccccc')
                        preferredHeight: 500
                        preferredWidth: 700
                    }

                    Container {
                        layout: AbsoluteLayout {
                        }
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 35
                            positionY: 50
                        }
                        background: Color.create('#FFFFFF')
                        preferredHeight: 490
                        preferredWidth: 700
                        Label {
                            accessibility.name: "Importe"
                            text: qsTr('Importe')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 20
                            }
                        }
                        Label {
                            id: lblImporte
                            accessibility.name: "lblImporte"
                            text: qsTr('$0')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 420
                                positionY: 20
                            }
                        }
                        Label {
                            accessibility.name: "iva"
                            text: qsTr('IVA (16%)')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 100
                            }
                        }
                        Label {
                            id: lblIvaDieciseis
                            accessibility.name: "lblImporte"
                            text: qsTr('$0')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 420
                                positionY: 100
                            }
                        }
                        Label {
                            accessibility.name: "subtotal"
                            text: qsTr('Subtotal')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 180
                            }
                        }
                        Label {
                            id: lblSubtotal
                            accessibility.name: "lblSubtotal"
                            text: qsTr('$0')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 420
                                positionY: 180
                            }
                        }
                        Label {
                            accessibility.name: "retencionIVA"
                            text: qsTr('Retencion IVA')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 260
                            }
                        }
                        Label {
                            id: lblRetencionIVA
                            accessibility.name: "lblRetencion"
                            text: qsTr('$0')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 420
                                positionY: 260
                            }
                        }
                        Label {
                            accessibility.name: "retencionISR"
                            text: qsTr('Retencion ISR (10%)')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 340
                            }
                        }
                        Label {
                            id: lblRetencionISR
                            accessibility.name: "lblSubtotal"
                            text: qsTr('$0')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 420
                                positionY: 340
                            }
                        }
                        Label {
                            accessibility.name: "total"
                            text: qsTr('Total')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 420
                            }
                        }
                        Label {
                            id: lblTotal
                            accessibility.name: "lblTotal"
                            text: qsTr('$0')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 420
                                positionY: 420
                            }
                        }
                    }

                }

                Container {
                    layout: AbsoluteLayout {
                    }

                    focusPolicy: FocusPolicy.None
                    Container {
                        layout: StackLayout {
                        }
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 35
                            positionY: 50
                        }
                        background: Color.create('#cccccc')
                        preferredHeight: 110
                        preferredWidth: 700
                    }

                    Container {
                        layout: AbsoluteLayout {
                        }
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 35
                            positionY: 50
                        }
                        background: Color.create('#FFFFFF')
                        preferredHeight: 100
                        preferredWidth: 700
                        Label {
                            accessibility.name: "Signo"
                            text: qsTr('$')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 20
                            }
                        }
                        TextField {
                            id: ingresNum
                            accessibility.name: "ingresNum"
                            preferredWidth: 550
                            inputMode: TextFieldInputMode.NumericPassword
                            input.masking: TextInputMasking.NotMaskedNotTogglable
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 90
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
                            positionX: 35
                            positionY: 50
                        }
                        background: Color.create('#cccccc')
                        preferredHeight: 225
                        preferredWidth: 700
                    }

                    Container {
                        layout: AbsoluteLayout {
                        }
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 35
                            positionY: 50
                        }
                        background: Color.create('#FFFFFF')
                        preferredHeight: 215
                        preferredWidth: 700
                        Label {
                            accessibility.name: "note"
                            text: qsTr('NOTA:')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 35
                                positionY: 20
                            }
                        }
                        Label {
                            accessibility.name: "note"
                            multiline: true
                            text: qsTr('Recuerda que esta calculadora solo sirve para personas fisicas que hacen recibos a personas morales.')
                            layoutProperties: AbsoluteLayoutProperties {
                                positionX: 150
                                positionY: 20
                            }
                            preferredWidth: 550
                        }
                    }
                }
            }

        }
    }
}
