<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$(document).ready(function() { 
	consultarListaEvaluadores();

});

function consultarListaEvaluadores(){
    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getAsignarEvalInv")#</cfoutput>', function(data){
        $('#listaEvaluadores').html( data );
    });
}
</script>