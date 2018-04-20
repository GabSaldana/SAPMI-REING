<cfprocessingdirective pageEncoding="utf-8">

<div clas="row">
<div id="tabs-producto">
	
	<a class="boton">Investigador</a>
</div>
</div>

<script>
	$(document).ready(function() {
		cargaTabs(<cfoutput>#prc.pkproducto#</cfoutput>);        	
	});

	function cargaTabs(pkPadrep){
		$.post('<cfoutput>#event.buildLink("CVU.productos.cargaTabs")#</cfoutput>', {
			pkproducto: pkPadrep
			}, 
			function(data){
				$('#tabs-producto').html( data );
			}
		    );	
	}

</script>
