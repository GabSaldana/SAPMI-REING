<script type="text/javascript">
/*obtenemos el centro de la pantalla*/
$(document).ready(function(){
	calculaP();
	$( window ).resize(function(){
		calculaP();
	});	
});

function calculaP(){
	
	var Ww = $(window).width();
	console.log( 'ww: ' + Ww);
	var Wh = $(window).height();
	console.log( 'wh: ' + Wh);
	var Cx = Ww /2;
	console.log('cx: ' + Cx);
	var Cy =Wh/2;
	console.log('cy: ' + Cy);

	var cr = Wh/7;
	$('.circle').css({'width' : cr+20 , 'height' : cr+20 });
	$('.circle-center').css({'width' : cr+50 , 'height' : cr+50 });
	
	/*calculamos el centro de la pantalla y colocamos la imagen */
	var tamini = $('.circle-center').height();
	var tamnav = $('.logo-contenedor').height();
	var tamtext = $('.text-center').height();
	$('#center').css({
        left: (Cx-(tamini/2)) + 'px',
        top: (Cy+((tamnav+tamtext)/2)-(tamini/2)) + 'px'
    });

	var r=0;
	var d = Wh-(((tamnav+tamtext)/2)-(tamini/2)); //desplazamiento en altura
	if(Ww > Wh){
		console.log('rectangulo acostado');
		r = d/4;
		console.log('r: ' + r);
	}else if(Wh > Ww){
		console.log('rectangulo parado');
		r = (Ww/3.5);
		console.log('r: ' + r);
	}else{
		console.log('cuadrado');
		r = (Ww/3.5);
		console.log('r: ' + r);
	}

	var elements = $('.field');
	console.log( elements);
	var angle = 0, step = (2*Math.PI) / elements.length;
	console.log('s: ' + step);
	elements.each(function() {
		console.log('angle: ' + angle);
		 var x = Math.round(Ww/2 + r * Math.cos(angle) - $(this).width()/2);
		 var y = Math.round(d/2 + r * Math.sin(angle) - $(this).height()/2);
		if(window.console) {
        	console.log($(this).text(), x, y);
	    }
	    $(this).css({
	        left: x + 'px',
	        top: y + 'px'
	    });
	    angle += step;
	});
}
</script>