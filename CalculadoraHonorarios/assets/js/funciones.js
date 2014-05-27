function calcular(){
	
var deseado;// = ingresNum.text;

if (ingresNum.text == '') {
	deseado = 0;
}else{
    deseado = ingresNum.text;
}
    var iv = .16;
    var importe = 0;
    if (iv > .14) {
    importe = deseado / .9533333333333333334;
    } else {
    importe = deseado / .9;
    }
    
    var iva = importe * iv;
    var subtotal = importe + iva;
    var retencionISR = importe * .1;
    var retencionIVA = (iva / 3) * 2;
    var total = subtotal - retencionISR - retencionIVA;
    
    console.log("iva "+iva+" subtotal "+subtotal+" retencion ISR "+retencionISR+" retencion IVA "+retencionIVA +" total "+total );
    
    lblImporte.text="$ "+importe.toFixed(2);
    lblIvaDieciseis.text="$ "+iva.toFixed(2);
    lblSubtotal.text="$ "+subtotal.toFixed(2);
    lblRetencionIVA.text="$ "+retencionIVA.toFixed(2);
    lblRetencionISR.text="$ "+retencionISR.toFixed(2);
    lblTotal.text="$ "+total.toFixed(2);
	
}