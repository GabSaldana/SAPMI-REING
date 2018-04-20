<cfprocessingdirective pageEncoding="utf-8">

<div id="divTablaEscolaridad"></div>

<script type="text/javascript">
	$(document).ready(function(){
		getEscolaridad();
	});

	function getEscolaridad(){
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getEscolaridad")#</cfoutput>',{
			pkPersona:$("#pkPersona").val()
		},function(data){
			$('#divTablaEscolaridad').html(data);
		});
	}
</script>
