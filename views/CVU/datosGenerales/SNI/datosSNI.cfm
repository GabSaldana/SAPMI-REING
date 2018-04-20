<cfprocessingdirective pageEncoding="utf-8">
<div id="divTipoInvestigador"></div>
<div id="divTablaSNI"></div>

<script type="text/javascript">
	$(document).ready(function(){
		getSNI();
		getTipoInvestigador();
	});

	function getSNI(){
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getSNI")#</cfoutput>',{
			pkPersona:$("#pkPersona").val()
		},function(data){
			$('#divTablaSNI').html(data);
		});
	}

	function getTipoInvestigador(){
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getTipoInvestigador")#</cfoutput>',{
			pkPersona:$("#pkPersona").val()
		},function(data){
			$('#divTipoInvestigador').html(data);
		});
	}
</script>
