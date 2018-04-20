<!---
* =========================================================================
* IPN - CSII
* Sistema:      SIIP
* Modulo:       Asignación investigador - evaluador
* Fecha:        Enero de 2018
* Descripcion:  Js del Index de la asignación investigador - evaluador
* Autor:        Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$(document).ready(function(){
	comiteEvaluador();
});

function comiteEvaluador(){
    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.gestionEvaluadores")#</cfoutput>', function(data){
        $('#comiteEvaluador').html( data );
    });
}

function asigInvestigadores(){
    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.asignacionInvestigadores")#</cfoutput>', function(data){
        $('#asigInvestigadores').html( data );
    });
}

function asigEvaluadores(){
    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.asignacionEvaluadores")#</cfoutput>', function(data){
        $('#asigEvaluadores').html( data );
    });
}
</script>