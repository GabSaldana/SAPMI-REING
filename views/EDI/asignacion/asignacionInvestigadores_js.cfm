<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$('.selectpicker').selectpicker();

$(document).ready(function() { 
	consultarListaInvestigadores();
});

function consultarListaInvestigadores(){
	var tipoInvestArray		= [];
	var pkTipoInvestArray	= [];
	if($('#selecEvaluador :selected').data('sip') != 0 && $('#selecEvaluador :selected').data('sip') != '' && $('#selecEvaluador :selected').data('sip') != NaN && $('#selecEvaluador :selected').data('sip') != null && $('#selecEvaluador :selected').data('sip') != undefined){
		tipoInvestArray.push('EVALSIP');
		pkTipoInvestArray.push(1);
	}
	if($('#selecEvaluador :selected').data('ce') != 0 && $('#selecEvaluador :selected').data('ce') != '' && $('#selecEvaluador :selected').data('ce') != NaN && $('#selecEvaluador :selected').data('ce') != null && $('#selecEvaluador :selected').data('ce') != undefined){
		tipoInvestArray.push('EVALCE');
		pkTipoInvestArray.push(2);
	}
	if($('#selecEvaluador :selected').data('ca') != 0 && $('#selecEvaluador :selected').data('ca') != '' && $('#selecEvaluador :selected').data('ca') != NaN && $('#selecEvaluador :selected').data('ca') != null && $('#selecEvaluador :selected').data('ca') != undefined){
		tipoInvestArray.push('EVALCA', 'EVALRI');
		pkTipoInvestArray.push(3,4);
	}
	var tipoInvest = JSON.stringify(tipoInvestArray);
	var pkTipoInvest = JSON.stringify(pkTipoInvestArray);
	if($('#selecEvaluador').val() != 0 && $('#selecEvaluador').val() != '' && $('#selecEvaluador').val() != NaN && $('#selecEvaluador').val() != null && $('#selecEvaluador').val() != undefined)
	    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getAsignarInvEval")#</cfoutput>', {
	    	pkEvaluador:	$('#selecEvaluador :selected').val(),
	    	tipoInvest:		tipoInvest,
	    	pkTipoInvest:	pkTipoInvest
	    }, function(data){
	        $('#listaInvestigadores').html(data);
	    });
}

$('body').off('#selecEvaluador', 'change');
$('body').on('change', '#selecEvaluador', function(){
	var tipoInvestArray		= [];
	var pkTipoInvestArray	= [];
	if($('#selecEvaluador :selected').data('sip') != 0 && $('#selecEvaluador :selected').data('sip') != '' && $('#selecEvaluador :selected').data('sip') != NaN && $('#selecEvaluador :selected').data('sip') != null && $('#selecEvaluador :selected').data('sip') != undefined){
		tipoInvestArray.push('EVALSIP');
		pkTipoInvestArray.push(1);
	}
	if($('#selecEvaluador :selected').data('ce') != 0 && $('#selecEvaluador :selected').data('ce') != '' && $('#selecEvaluador :selected').data('ce') != NaN && $('#selecEvaluador :selected').data('ce') != null && $('#selecEvaluador :selected').data('ce') != undefined){
		tipoInvestArray.push('EVALCE');
		pkTipoInvestArray.push(2);
	}
	if($('#selecEvaluador :selected').data('ca') != 0 && $('#selecEvaluador :selected').data('ca') != '' && $('#selecEvaluador :selected').data('ca') != NaN && $('#selecEvaluador :selected').data('ca') != null && $('#selecEvaluador :selected').data('ca') != undefined){
		tipoInvestArray.push('EVALCA', 'EVALRI');
		pkTipoInvestArray.push(3,4);
	}
	var tipoInvest = JSON.stringify(tipoInvestArray);
	var pkTipoInvest = JSON.stringify(pkTipoInvestArray);
	if($('#selecEvaluador').val() != 0 && $('#selecEvaluador').val() != '' && $('#selecEvaluador').val() != NaN && $('#selecEvaluador').val() != null && $('#selecEvaluador').val() != undefined)
	    $.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getAsignarInvEval")#</cfoutput>', {
	    	pkEvaluador:	$('#selecEvaluador :selected').val(),
	    	tipoInvest:		tipoInvest,
	    	pkTipoInvest:	pkTipoInvest
	    }, function(data){
	        $('#listaInvestigadores').html(data);
	    });
});

</script>