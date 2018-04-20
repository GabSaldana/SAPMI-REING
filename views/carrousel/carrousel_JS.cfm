<cfprocessingdirective pageEncoding="utf-8"/>
<script type="text/javascript">
	var Frase = localStorage.getItem('Frase');
	var arrF = Frase.split("|");
	$(document).ready(function(){

		obtenEje();
		obtenNumeroAcciones();
		/*imagenes del acordeon click*/
		$('body').on('click','.accli',function(){
			var id = $(this).attr('id');
			var name = $(this).attr('name');
			localStorage.setItem('accion',id);
			localStorage.setItem('NombreAccion',name);
			setTimeout(gotoQuiz, 1000);
		});
	});

	function obtenEje(){
	    $.ajax({
	        url: "<cfoutput>#event.buildLink("carrousel.carrousel.getEje")#</cfoutput>",
	        method: 'POST',
	        cache: false,
	        data: { eje: localStorage.getItem('eje')}
	    }).done(function(data){
	      colocarNombreEje(data.DATA.CEJ_DESCRIPCION[0]);
	    }).fail(function(xhr, errorType, exception) {
	        console.log('problemas');
	    });
	}

	function obtenNumeroAcciones(){
	    $.ajax({
	        url: "<cfoutput>#event.buildLink("carrousel.carrousel.getNumeroAcciones")#</cfoutput>",
	        method: 'POST',
	        cache: false,
	        data: { eje: localStorage.getItem('eje')}
	    }).done(function(data){
	      obtenDatosAcciones(data.DATA.NUM[0]);
	      if(data.DATA.NUM[0] == 5){
	      	$('#accordion').show();
	      	 $('#dcss').append('<link href="/includes/accordion/css/style-5.css" rel="stylesheet">');
	      }else if(data.DATA.NUM[0] == 4){
	      	 $('#dcss').append('<link href="/includes/accordion/css/style-4.css" rel="stylesheet">');
	      	 $('#accordion').show();
	      }else if(data.DATA.NUM[0] == 3){
	      	 $('#dcss').append('<link href="/includes/accordion/css/style-3.css" rel="stylesheet">');
	      	 $('#accordion').show();
	      }else if(data.DATA.NUM[0] == 2){
	      	 $('#dcss').append('<link href="/includes/accordion/css/style-2.css" rel="stylesheet">');
	      	 $('#accordion').show();
	      }else if(data.DATA.NUM[0] == 1){
	      	 $('#dcss').append('<link href="/includes/accordion/css/style-1.css" rel="stylesheet">');
	      	 $('#accordion').show();
	      }else if(data.DATA.NUM[0] == 0){
			$('#divAvisoSinAcciones').show();
	      }
	    }).fail(function(xhr, errorType, exception) {
	        console.log('problemas');
	    });
	}

	function obtenDatosAcciones(noSub){
	    $.ajax({
	        url: "<cfoutput>#event.buildLink("carrousel.carrousel.getDatosAcciones")#</cfoutput>",
	        method: 'POST',
	        cache: false,
	        data: { eje: localStorage.getItem('eje')}
	    }).done(function(data){
	      for(var i=0 ; i < noSub ; i++){
			var indice = data.DATA.EJE[i] + '.' + data.DATA.ACCION[i];
			var frase = indice + ' ' + data.DATA.NOMBRE[i];
			var imagen = data.DATA.IMAGEN[i];
			creaAcordeon(i, imagen, frase, data.DATA.NUMERO[i]);
		  }
	    }).fail(function(xhr, errorType, exception) {
	        console.log('problemas al obtener Datos Acciones');
	    });
	}

	function colocarNombreEje(Nombre){
		$('#tituloAcordeon').text(Nombre);
	}

	function gotoQuiz() {
    	location.assign('<cfoutput>#event.buildLink("quiz/quiz")#</cfoutput>');
  	}

  	function creaAcordeon(i, imagen, frase,numero){
		/*Insertar estructura para las imagenes*/
		var transparencia = 'background:rgba(24, 25, 28, 0.5)';
		var plantilla = '<li class="accli" id="'+ numero +'" name="'+ arrF[numero-1] +'">' + '<cfoutput>' + '<a target="_self">' +
		'</cfoutput>' +
				'<div class="imgdiv"><div class="imgwrap"><img id="img'+i+'" src="'+ imagen +'.jpg" alt=""></div></div>' +
				'<div class="text top-right">' +
					'<p><span style="'+ transparencia +'">'+ frase +'</span></p>' +
				'</div>' +
			 '</a>' +
		'</li>' ;

		$("#accul").append(plantilla);
		corregirIMGPath();
	}

	function corregirIMGPath(){
		/*Obtener imagenes*/
		var images = $('#accdiv').find('img').map(function() { 
			var source = this.src;
			var as = source.replace("/index.cfm/carrousel","");
			$(this).attr("src",as);
		}).get();
	}
</script>