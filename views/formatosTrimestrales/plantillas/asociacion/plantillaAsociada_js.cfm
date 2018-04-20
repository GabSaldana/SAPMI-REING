<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">
	$(document).ready(function() {
		$('.bt-cerrar-captura').click(function(){
			$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');
			$(this).parent().parent().slideToggle( 1000,'easeInExpo');
		});
		$('#tablaFormatos').bootstrapTable();
	})
	
    function cargarPlantillas(pkAsociacion){
    	$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
		$('#contAsociacion').slideToggle( 1000,'easeOutExpo');	
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.cargarPlantillas")#</cfoutput>',{
			pkAsociacion:pkAsociacion
			},
		   function(data){
				$('#divAsociacion').html( data );
		   });
	}
	function eliminarAsociacion(pkAsociacion){
		if (confirm('La siguente asociación se eliminará permanetemente \n¿Desea eliminar esta asociación?')) { 
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.eliminarAsociacion")#</cfoutput>',{
				pkAsociacion:pkAsociacion
			},
		   function(data){location.reload();});
		}
	}
</script>