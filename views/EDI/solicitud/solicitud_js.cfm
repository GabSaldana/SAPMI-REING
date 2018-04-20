<cfprocessingdirective pageEncoding="utf-8">
<script>
	$(document).ready(function() {
		 $('#ayudaInvt').hide();
         $("#steps-solicitud").steps({
		    headerTag: "h3",
		    bodyTag: "section",
		    transitionEffect: "slideLeft",
		    stepsOrientation: "vertical",
		    labels:{
		        finish: "Finalizar",
		        next: "Siguiente",
		        previous: "Anterior"
		    },
		    onStepChanging: function(e, currentIndex, newIndex) {
		    	if($('.stepT'+newIndex).attr('clave') == 'Invest' || $('.stepT'+newIndex).attr('clave') == 'ActDocente'){
		    		$('#ayudaInvt').show();

		    	}else{
		    		$('#ayudaInvt').hide();
		    	}
		    	if(newIndex == $('#numPestanias').val())
		    		getResumen();
		    	return true;
		   },
		   onFinishing: function (event, currentIndex) { 
		   		swal({
					title:              "¿Desea enviar su solicitud para revisión de la SIP?",
					type:               "warning",
					confirmButtonText:  "Aceptar",
					cancelButtonText:   "Cerrar",
					showCancelButton:   true,
					closeOnConfirm:     true,
				}, function () {
					cambiarEstado('solicEDI.valida',<cfoutput>#prc.solicitud#</cfoutput>);
				});
		   		return true; 
		   }
		});
		<cfloop array="#prc.pestanias#" index='pestania'>
			<cfoutput>
			cargar#pestania.getClave()#();</cfoutput>
		</cfloop>
	});
	<cfloop array="#prc.pestanias#" index='pestania'>
			<cfoutput>
			function cargar#pestania.getClave()#(){
				$.post('<cfoutput>#event.buildLink("EDI.solicitud.cargaValidacion" & pestania.getClave())#</cfoutput>', {
					pkAspirante: $('##pkAspirante').val(),
					pkPestania:#pestania.getPK_PESTANIA()#,
					pkMovimiento:#pestania.getPK_MOVIMIENTO()#
					}, 
					function(data){
						$('##div#pestania.getClave()#').html( data );
					}
			    );	
			}
		</cfoutput>
	</cfloop>
	
	<!---
    * Fecha : Noviembre de 2017
    * Autor : Marco Torres
    * Comentario: Funcin que actualiza la vista de resumen
    --->
	function getResumen(){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.getResumen")#</cfoutput>', {
			pkPersona: <cfoutput>#Session.cbstorage.persona.PK[1]#</cfoutput>,
			pkMovimiento:<cfoutput>#pestania.getPK_MOVIMIENTO()#</cfoutput>
			}, 
			function(data){
				$('#divResumen').html( data );
			}
	    );	
	}

</script>