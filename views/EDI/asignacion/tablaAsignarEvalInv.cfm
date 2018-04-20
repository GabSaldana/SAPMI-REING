<cfprocessingdirective pageEncoding="utf-8">
<table id="listaEval" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true"  data-search-accent-neutralise="true" data-show-export="true">
	<thead>
		<tr>
			<th data-sortable='true' data-field="numEmpl" class="text-center">No. Empleado</th>
			<th data-sortable='true' data-field="nombre">Investigador</th>
			<th data-sortable='true' data-field="dep">Dependencia</th>
			<th data-sortable='true' data-field="evalSIP">Evaluador SIP</th>
			<th data-sortable='true' data-field="evalCE">Evaluador CE</th>
			<th data-sortable='true' data-field="evalCA">Evaluador CA</th>
			<th data-sortable='true' data-field="evalRI">Evaluador RI</th>
		</tr>
	</thead>
</table>

<script>

	$(function () {
		$('#listaEval').bootstrapTable({
			exportDataType: 'all',
			exportOptions: {
				excelstyles: ['background-color', 'color', 'border-bottom-color', 'border-bottom-style', 'border-bottom-width', 'border-top-color', 'border-top-style', 'border-top-width', 'border-left-color', 'border-left-style', 'border-left-width', 'border-right-color', 'border-right-style', 'border-right-width', 'font-family', 'font-size', 'font-weight', 'text-align', 'height', 'width'],
				fileName: 'Asignacion_Evaluadores',
				worksheetName: 'Asignacion_Evaluadores'
			},
			exportTypes: {
				default: 'excel'
			}
		});
	});

	var data = [];
	<cfif isDefined('prc.personas.recordCount')>
		<cfloop index='i' from='1' to='#prc.personas.recordCount#'>
			<cfoutput>
				data.push({
					numEmpl:	'#prc.personas.NUMEMPLEADO[i]#',
					nombre:		'#prc.personas.NOMBRE[i]# #prc.personas.PATERNO[i]# #prc.personas.MATERNO[i]#',
					dep:		'#prc.personas.DEPENDENCIA[i]#',
					evalSIP:	'<label id="labelAsigEvalSIP#prc.personas.PKPERSONA[i]#">#prc.personas.EVALSIP[i]#</label><button type="button" class="asigEval btn #prc.personas.CLASEEVALSIP[i]# btn-outline" pkPersona="#prc.personas.PKPERSONA[i]#" tipoEval="1" tipoEvalChar="SIP" pkEvaluador="#prc.personas.PKEVALSIP[i]#" id="asigEvalSIP#prc.personas.PKPERSONA[i]#"><span id="spanAsigEvalSIP#prc.personas.PKPERSONA[i]#" class="fa #prc.personas.BOTONEVALSIP[I]#"></span></button>#prc.personas.COMPLETAEVALSIP[i]#',
					evalCE:		'<label id="labelAsigEvalCE#prc.personas.PKPERSONA[i]#">#prc.personas.EVALCE[i]#</label><button type="button" class="asigEval btn #prc.personas.CLASEEVALCE[i]# btn-outline" pkPersona="#prc.personas.PKPERSONA[i]#" tipoEval="2" tipoEvalChar="CE" pkEvaluador="#prc.personas.PKEVALCE[i]#" id="asigEvalCE#prc.personas.PKPERSONA[i]#"><span id="spanAsigEvalCE#prc.personas.PKPERSONA[i]#" class="fa #prc.personas.BOTONEVALCE[I]#"></span></button>#prc.personas.COMPLETAEVALCE[i]#',
					evalCA:		'<label id="labelAsigEvalCA#prc.personas.PKPERSONA[i]#">#prc.personas.EVALCA[i]#</label><button type="button" class="asigEval btn #prc.personas.CLASEEVALCA[i]# btn-outline" pkPersona="#prc.personas.PKPERSONA[i]#" tipoEval="3" tipoEvalChar="CA" pkEvaluador="#prc.personas.PKEVALCA[i]#" id="asigEvalCA#prc.personas.PKPERSONA[i]#"><span id="spanAsigEvalCA#prc.personas.PKPERSONA[i]#" class="fa #prc.personas.BOTONEVALCA[I]#"></span></button>#prc.personas.COMPLETAEVALCA[i]#',
					evalRI:		'<label id="labelAsigEvalRI#prc.personas.PKPERSONA[i]#">#prc.personas.EVALRI[i]#</label><button type="button" class="asigEval btn #prc.personas.CLASEEVALRI[i]# btn-outline" pkPersona="#prc.personas.PKPERSONA[i]#" tipoEval="4" tipoEvalChar="RI" pkEvaluador="#prc.personas.PKEVALRI[i]#" id="asigEvalRI#prc.personas.PKPERSONA[i]#"><span id="spanAsigEvalRI#prc.personas.PKPERSONA[i]#" class="fa #prc.personas.BOTONEVALRI[I]#"></span></button>#prc.personas.COMPLETAEVALRI[i]#'
				});
			</cfoutput>
		</cfloop>
	</cfif>

	$(document).ready(function() {
		$("#listaEval").bootstrapTable();
		$('#listaEval').bootstrapTable('load', data);
	});

	$('body').undelegate('.asigEval', 'click');
	$('body').on('click', '.asigEval', function(){
		pkPersona	= $(this).attr('pkPersona');
		pkEvaluador	= $(this).attr('pkEvaluador');
		pkTipoEval	= $(this).attr('tipoEval');
		tipoEval	= $(this).attr('tipoEvalChar');
		estado		= $(this).hasClass("btn-primary") == true ? 0 : 2;
		if(estado == 2){
			swal({
				title:				"Eliminar Evaluador",
				text:				"¿Desea eliminar al evaluador?",
				type:				"warning",
				confirmButtonColor:	"#ED5565",
				confirmButtonText:	"Eliminar",
				cancelButtonText:	"Cancelar",
				showCancelButton:	true,
				closeOnConfirm:		true
			}, function(){
				$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.eliminarEvaluador")#</cfoutput>',{
					pkPersona:		pkPersona,
					pkEvaluador:	pkEvaluador,
					pkTipoEval:		pkTipoEval
				}, function(data){
					if(data != 0){
						toastr.success('Registro actualizado correctamente.');
						$('#asigEval'+tipoEval+pkPersona).removeClass("btn-danger").addClass("btn-primary");
						$('#spanAsigEval'+tipoEval+pkPersona).removeClass("fa-user-times").addClass("fa-user-plus");
						$('#labelAsigEval'+tipoEval+pkPersona).html('');
						consultarListaInvestigadores();
					} else{
						toastr.error('Problemas al actualizar el registro.');
					}
				});
			});
		} else{
			$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getEvaluadoresTipo")#</cfoutput>',{
				pkPersona:		pkPersona,
				pkTipoEval:		pkTipoEval
			}, function(data){
				if(data == 1){
					toastr.warning('El investigador no aplico ningun producto al recurso de inconformidad');
				}else if(data != 0){
					$('#modal-asigEvaluadores').modal();
					$('#modal-asigEvaluadoresContent').html(data);
				}else{
					toastr.error('Problemas al mostrar los evaluadores.');
				}
			});
		}
	});

</script>
