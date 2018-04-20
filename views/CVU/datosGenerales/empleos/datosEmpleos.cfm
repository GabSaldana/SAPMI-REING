<cfprocessingdirective pageEncoding="utf-8">

<div id="divTablaEmpleos"></div>

<script type="text/javascript">
	$(document).ready(function(){
		getEmpleos();
	});

	function getEmpleos(){
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getEmpleos")#</cfoutput>',{
			pkPersona:$("#pkPersona").val()
		},function(data){
			$('#divTablaEmpleos').html(data);
		});
	}
</script>
