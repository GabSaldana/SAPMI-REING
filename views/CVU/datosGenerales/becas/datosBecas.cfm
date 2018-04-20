<cfprocessingdirective pageEncoding="utf-8">

<div id="divTablaBecas"></div>

<script type="text/javascript">
	$(document).ready(function(){
		getBecas();
	});

	function getBecas(){
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getBecas")#</cfoutput>',{
			pkPersona:$("#pkPersona").val()
		},function(data){
			$('#divTablaBecas').html(data);
		});
	}
</script>

