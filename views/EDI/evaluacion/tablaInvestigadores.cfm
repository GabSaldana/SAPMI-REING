<cfprocessingdirective pageEncoding="utf-8">

<cfinclude template="/views/adminCSII/historial/historial.cfm">
<input type="hidden" id="hNombreInvest"    value="">
<input type="hidden" id="dependenciaInvest" value="">
<input type="hidden" id="pkAspProcListInv" 	value="0">
<div class="col-md-12">
	<table id="tablaInvestigadores" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-search-accent-neutralise="true" data-show-export="true" data-show-columns="true" data-minimum-count-columns="4">
	<thead>
		<tr>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="nombre">Nombre</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="rfc">RFC</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="num_empleado">Número de Empleado</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="ur">Dependencia</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="correo">Correo</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="movimiento">Movimiento</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="edo_solicitud">Estado de la Solicitud</th>
			<cfif arraycontains(session.cbstorage.grant,'evalEDI.verEvalCA')>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="nivelSIP">Nivel SIP</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="nivelCE">Nivel CE</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="nivelCA">Nivel CA</th>
			</cfif>
			<th class="text-center" data-sortable="true" data-valign="middle" data-tableexport-display="none" data-field="consultar">Consultar</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-tableexport-display="none" data-field="acciones">Acciones</th>
		</tr>
	</thead>
	<tbody>		
		<cfoutput>		
			<cfloop query="#prc.inv#">
				<tr>
					<td>#NOMBRE#</td>
					<td>#RFC#</td>
					<td>#NUM_EMPLEADO#</td>
					<td>#UR#</td>
					<td>#CORREO#</td>
					<td>#MOVIMIENTO#</td>
					<td><span style="font-size: 11px;" class="badge #COLOR#">#ESTADO#</span></td>
					<cfif arraycontains(session.cbstorage.grant,'evalEDI.verEvalCA')>
						<td> #NIVEL_ASIGNADO_SIP#</td>
						<td> #NIVEL_ASIGNADO_CE#</td>
						<td> <CFIF ESTADO EQ 'Solicitud Atendida'>#NIVEL_ASIGNADO_CA#</CFIF></td>
					</cfif>
					<td class="text-center">
						<button data-toggle="tooltip" class="btn btn-primary fa fa-search consultarEvaluacion" pkUsuario="#FK_USUARIO#" pkPersona="#PK_PERSONA#" pkMovimiento="#PK_MOVIMIENTO#" nombre="#NOMBRE#" pkVertiente="#VERTIENTE#" pkAspiranteProceso="#PK_ASPIRANTEPROCESO#" ur="#UR#" title="Consultar"></button>
					</td>
					<td class="text-center">
						
						<cfif PK_MOVIMIENTO neq 21>
							<cfif listFind(ACCIONESCVE,'solicEDI.regreSIP','$')>
								<button class=" btn btn-sm btn-default guiaValidar"  data-toggle="tooltip" title="Regresar para evaluación de SIP" onclick="cambiarEstadoSol('solicEDI.regreSIP',#PK_ASPIRANTEPROCESO#);">
	                    			<i class="fa fa-reply"></i>
	                    		</button>
							</cfif>
							<cfif listFind(ACCIONESCVE,'solicEDI.regreCE','$')>
								<button class=" btn btn-sm btn-info guiaValidar"  data-toggle="tooltip" title="Regresar para evaluación de CE" onclick="cambiarEstadoSol('solicEDI.regreCE',#PK_ASPIRANTEPROCESO#);">
	                    			<i class="fa fa-reply"></i>
	                    		</button>
							</cfif>
							<cfif listFind(ACCIONESCVE,'solicEDI.regreCA','$')>
								<button class=" btn btn-sm btn-warning guiaValidar"  data-toggle="tooltip" title="Regresar para evaluación de CA" onclick="cambiarEstadoSol('solicEDI.regreCA',#PK_ASPIRANTEPROCESO#);">
	                    			<i class="fa fa-reply"></i>
	                    		</button>
							</cfif>
							<cfif listFind(ACCIONESCVE,'solicEDI.regreRI','$')>
								<button class=" btn btn-sm btn-danger guiaValidar"  data-toggle="tooltip" title="Regresar para evaluación de RI" onclick="cambiarEstadoSol('solicEDI.regreRI',#PK_ASPIRANTEPROCESO#);">
	                    			<i class="fa fa-reply"></i>
	                    		</button>
							</cfif>
						</cfif>
						
						<cfif arraycontains(session.cbstorage.grant,'evalEDI.verTodos')>
						<button class="btn btn-sm btn-default fa fa-address-card detallesEvaluacion" data-toggle="tooltip" title="Resumen de la evaluacion SIP" onclick="resumenEval(#FK_USUARIO#,1);"></button>
						<button class="btn btn-sm btn-info fa fa-address-card detallesEvaluacion" data-toggle="tooltip" title="Resumen de la evaluacion CE" onclick="resumenEval(#FK_USUARIO#,2);"></button>
						<button class="btn btn-sm btn-success fa fa-address-card detallesEvaluacion" data-toggle="tooltip" title="Resumen de la evaluacion CA" onclick="resumenEval(#FK_USUARIO#,3);"></button>
						
						<button class="btn btn-sm btn-danger getReporteResultados" data-persona="<cfoutput>#PK_PERSONA#</cfoutput>" data-movimiento="<cfoutput>#PK_MOVIMIENTO#</cfoutput>" data-nombre="<cfoutput>#NOMBRE#"</cfoutput>" data-ur="<cfoutput>#PK_UR#</cfoutput>" data-usuario="<cfoutput>#FK_USUARIO#</cfoutput>"><span class="fa fa-file"></span></button>
						</cfif>
						
						<!--- <button data-toggle="tooltip" class="btn btn-success fa fa-file-pdf-o generarDictamen"		pkInvestigador="#FK_USUARIO#" title="Generar Dictamen"></button>
						<button data-toggle="tooltip" class="btn btn-warning fa fa-lock"						pkInvestigador="#FK_USUARIO#" title="Registro Evaluado"></button> --->
					</td>
				</tr>
			</cfloop>			
		</cfoutput>	
	</tbody>
</table>
</div>

<div class="modal fade resEval">
	<div class="modal-dialog modal-lg" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" onclick="cerrarResumen();"><i class="fa fa-times fa-lg"></i></button>
				<h4 class="modal-title">Resumen de la Evaluación</h4>
			</div>
			<div class="modal-body">   
				<div class="row">
				  <div id="resumenEvalBody" class="divScroll" style="width:100%"> </div>
				</div>
			</div>
		</div>
	</div>
</div>

<form id="form_reporteResultados" action="<cfoutput>#event.buildLink("EDI.solicitud.getReporteResultados")#</cfoutput>" method="POST" target="_blank">
	<input type="hidden" id="rr_pkPersona" name="pkPersona">
	<input type="hidden" id="rr_pkMovimiento" name="pkMovimiento">
	<input type="hidden" id="rr_nombrePersona" name="nombrePersona">
	<input type="hidden" id="rr_pkUR" name="pkUR">	
	<input type="hidden" id="rr_pkUsuario" name="pkUsuario">
</form>

<script type="text/javascript">
	
	$(document).ready(function(){
		$(".divScroll").slimScroll({
			height:        "700px",
			width:         "none",
			railVisible:   true,
			alwaysVisible: true
		});
		$('body').undelegate('.getReporteResultados', 'click');
		$('body').on('click', '.getReporteResultados', function(){
				
				var pkPersona = $(this).data("persona");
				var pkMovimiento = $(this).data("movimiento");
				var nombrePersona = $(this).data("nombre");
				var pkUR = $(this).data("ur");
				var pkUsuario = $(this).data("usuario");		

				$("#rr_pkPersona").val(pkPersona);
				$("#rr_pkMovimiento").val(pkMovimiento);
				$("#rr_nombrePersona").val(nombrePersona);
				$("#rr_pkUR").val(pkUR);
				$("#rr_pkUsuario").val(pkUsuario);			

				$('#form_reporteResultados').submit();
		});
	});

	$(function () {
		$('#tablaInvestigadores').bootstrapTable({
			exportDataType: 'all',
			exportOptions: {
				excelstyles: ['background-color', 'color', 'border-bottom-color', 'border-bottom-style', 'border-bottom-width', 'border-top-color', 'border-top-style', 'border-top-width', 'border-left-color', 'border-left-style', 'border-left-width', 'border-right-color', 'border-right-style', 'border-right-width', 'font-family', 'font-size', 'font-weight', 'text-align', 'height', 'width'],
				fileName: 'Listado_Investigadores',
				worksheetName: 'Listado_Investigadores',
				ignoreColumn: ["acciones", "consultar"]
			},
			exportTypes: {
				default: 'excel'
			}
		});
	});

	$('#tablaInvestigadores').bootstrapTable();
	$('#tablaInvestigadores').bootstrapTable('hideColumn', 'rfc');
	$('#tablaInvestigadores').bootstrapTable('hideColumn', 'correo');
	<cfif not arraycontains(session.cbstorage.grant,'evalEDI.verEvalCA')>
		$('.detallesEvaluacion').hide();
	</cfif>

	$('body').undelegate('.consultarEvaluacion', 'click');
	$('body').on('click', '.consultarEvaluacion', function(){
		$("#hNombreInvest").val($(this).attr('nombre'));
		$("#dependenciaInvest").val($(this).attr('ur'));
		$('#pkAspProcListInv').val($(this).attr('pkAspiranteProceso'));

		$.post('<cfoutput>#event.buildLink("EDI.evaluacion.consultarEvaluacion")#</cfoutput>',{
			pkUsuario:    $(this).attr('pkUsuario'),
			pkPersona:    $(this).attr('pkPersona'),
			pkMovimiento: $(this).attr('pkMovimiento'),
			pkVertiente:  $(this).attr('pkVertiente'),
			clasifSel:    0,
			subClasifSel: 0
		}, function(data){
			$('#divEvaluacionEDI').html(data);
			abrirCerrarEvaluacion();
		});
	});
	
	function cambiarEstadoSol(accion, pkAspProc) {
  		swal({
            title:             "&iquest;Desea aperturar el expediente?",
            type:              "warning",
            confirmButtonText: "Aceptar",
            cancelButtonText:  "Cerrar",
            showCancelButton:  true,
            closeOnConfirm:    true,
            html:              true
        }, function () {
            $.post('<cfoutput>#event.buildLink("EDI.evaluacion.cambiarEstadoSolicitudSimple")#</cfoutput>', {
	           accion:    accion,
	           pkAspProc: pkAspProc
	        }, function(data) {
	            if (data.EXITO){
                    toastr.success('Acci&oacute;n ejecutada correctamente');
                    getTablaInvestigadores();
                }else{
                    toastr.error('Error al aperturar el expediente');
                }
	        });
        });
    }

	function resumenEval(pkUsuario,pkTipoEval){
		$.ajax({
			type: "POST",
			url: "<cfoutput>#event.buildLink('EDI.evaluacion.getResumenEvaluacion')#</cfoutput>",
			data: {
				pkUsuario: pkUsuario,
				pkTipoEvaluacion: pkTipoEval
			}
		}).done(function(data) {
			$("#resumenEvalBody").html(data);
			$(".resEval").modal('show');
			$("#tabResSol").addClass('hide');
			$("#tabActAlt").addClass('hide');
		});
	}

	function cerrarResumen(){
		$("#resumenEvalBody").empty();
		$(".resEval").modal('hide');
	}
	
</script>
