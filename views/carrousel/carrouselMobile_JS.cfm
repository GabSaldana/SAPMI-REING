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
	      if(data.DATA.NUM[0] > 0 ){
					$('#accordion').show();
	      }else {
	      	 swal({
				  title: "Lo sentimos, el eje seleccionado no est\u00E1 disponible para el perfil ingresado.",
				  icon: "warning",
				  button: "Regresar",
				  dangerMode: true,
				})
	      	 	.then((willDelete) => {
				  if (willDelete) {
				    location.assign('<cfoutput>#event.buildLink("ejes/ejes")#</cfoutput>');
				  }
				});
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
					var numeroProyecto = 'Proyecto Especial ' + data.DATA.ACCION[i];
					var nombreProyecto = data.DATA.NOMBRE[i];
					var imagen = data.DATA.IMAGEN[i];
					creaMenuMobile(i, imagen, frase, data.DATA.NUMERO[i], noSub, numeroProyecto, nombreProyecto);
		  	}
	    }).fail(function(xhr, errorType, exception) {
	        console.log('problemas al obtener Datos Acciones');
	    });
	}

	function colocarNombreEje(Nombre){
		$('#th_acciones').text(Nombre);
	}

	function gotoQuiz() {
    	location.assign('<cfoutput>#event.buildLink("quiz/quiz")#</cfoutput>');
  	}

  	function creaMenuMobile(i, imagen, frase,numero,total, numProy, nomProy){
		/*Insertar estructura para las imagenes*/
		var grosorBorde = .5;
		var plantilla = '<div class="row celdaMenuMobile accli" id="'+ numero +'" name="'+ arrF[numero-1] +'" style = "border-bottom: '+grosorBorde+'px solid grey;  ">' +
			'<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">'+
			'	<div class="imgwrap imgCeldaSubMenuMobile" ><img id="img'+i+'" src="'+ imagen +'.jpg" alt=""  class="img-responsive"></div>'+
			'</div>'+
			'<div class="col-xs-9 col-md-9 col-sm-9">'+
				'<p class="txtCeldaMenuMobile "><strong>'+numProy+'</strong><br/><span>'+ nomProy +'</span></p>'+
			'</div>'+
		'</div>';

		$("#tr_acciones").append(plantilla);
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