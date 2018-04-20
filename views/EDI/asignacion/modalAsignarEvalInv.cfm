<!---
* =========================================================================
* IPN - CSII
* Sistema:      SIIP
* Modulo:       Asignación investigador - evaluador
* Fecha:        Enero de 2018
* Descripcion:  Modal de la asignación investigador - evaluador
* Autor:        Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h3 class="modal-title">Seleccionar Evaluador</h3>
</div>
<div class="modal-body">
	<div class="form-group">
		<table id="listaEvalEvaluadores" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true"  data-search-accent-neutralise="true">
			<thead>
				<tr>
					<th data-sortable='true' class="text-center" data-field="nombre">Nombre</th>
					<th data-sortable='true' class="text-center" data-field="dependencia">Dependencia</th>
					<th data-sortable='true' class="text-center" data-field="selec">Seleccionar</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
</div>

<script type="text/javascript">
	
	var data = [];
	<cfif isDefined('prc.evaluadores.recordCount')>
		<cfloop index='i' from='1' to='#prc.evaluadores.recordCount#'>
			<cfoutput>
				data.push({
					nombre:		'#prc.evaluadores.NOMBRE[i]# #prc.evaluadores.PATERNO[i]# #prc.evaluadores.MATERNO[i]#',
					dependencia:'#prc.evaluadores.DEPENDENCIA[i]#',
					selec:		'<div class="radio radio-info radio-inline"><input type="radio" name="radioAsigEval" class="radioAsigEval" id="radioAsigEval#prc.evaluadores.PKEVALUADOR[i]#" pkEvaluador="#prc.evaluadores.PKEVALUADOR[i]#" pkPersona="#prc.pkPersona#" tipoEval="#prc.pkTipoEval#" nombreEval="#prc.evaluadores.NOMBRE[i]# #prc.evaluadores.PATERNO[i]# #prc.evaluadores.MATERNO[i]#"><label for="radioAsigEval#prc.evaluadores.PKEVALUADOR[i]#"></label></div>'
				});
			</cfoutput>
		</cfloop>
	</cfif>

	$(document).ready(function() {
		$("#listaEvalEvaluadores").bootstrapTable();
		$('#listaEvalEvaluadores').bootstrapTable('load', data);
	});

	$('body').undelegate('.radioAsigEval', 'click');
	$('body').on('click', '.radioAsigEval', function(){
		pkPersona	= $(this).attr('pkPersona');
		pkEvaluador	= $(this).attr('pkEvaluador');
		pkTipoEval	= $(this).attr('tipoEval');
		nombreEval	= $(this).attr('nombreEval');
		$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.setEvaluadorInvestigador")#</cfoutput>',{
			pkPersona:		pkPersona,
			pkEvaluador:	pkEvaluador,
			pkTipoEval:		pkTipoEval
		}, function(data){
			if(data != 0){
				toastr.success('Registro actualizado correctamente.');
				$('#asigEval'+tipoEval+pkPersona).removeClass("btn-primary").addClass("btn-danger");
				$('#spanAsigEval'+tipoEval+pkPersona).removeClass("fa-user-plus").addClass("fa-user-times");
				$('#labelAsigEval'+tipoEval+pkPersona).html(nombreEval);
				$('#asigEval'+tipoEval+pkPersona).attr('pkEvaluador', pkEvaluador);
			}else{
				toastr.error('Problemas al actualizar el registro.');
			}
		});
		
	});
</script>

