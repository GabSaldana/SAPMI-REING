<cfprocessingdirective pageEncoding="utf-8">
<div class="tabs-container">
	<ul class="nav nav-tabs">
		<li class="active">
			<a class="guiaEstados" data-toggle="tab" data-popover="popover" data-container="body" data-placement="top" data-content="Flujo por estados del convenio" href="#tab-1" aria-expanded="false">
				<i class="fa fa-list-ol"></i>
				Estado
			</a>
		</li>
		<li class="">
			<a class="guiaValidaciones" data-toggle="tab" data-popover="popover" data-container="body" data-placement="top" data-content="Flujo por validaciones del convenio"  href="#tab-2" aria-expanded="false">
				<i class="fa fa-sort-amount-asc"></i>
				Validación
			</a>
		</li>
	</ul>
	<div class="tab-content">
	<div id="tab-1" class="tab-pane active">
		<div class="panel-body">
<!--- 			<table id="table" class="table table-hover">
				<tbody>
					<cfoutput>
						<cfloop array="#prc.historial.getEstados()#" index="estado">
							<cfset nombreEstado = REReplace(REReplace(REReplace(REReplace("#estado.GETNOMB_EDO()#"," ","_","ALL"), 'é', "e"),'á', 'a'), 'ó','o')>
							<tr>
								<td class="col-md-1">
									<span class="btn btn-circle estiloDefecto#estado.getESTILO_ESTADO()# guiaEstadoHistorial">#estado.GETNUM_EDO()#</span>
								</td>
								<td  class="col-md-8 guiaNombreEstadoHistorial">
									#estado.GETNOMB_EDO()#
								</td>
								<td class="col-md-3">
									<cfloop array="#estado.getCambios()#" index="cambio">
										<cfset fecha  = REReplace(REReplace("#cambio.getFECHA()#", " ","_","ALL"), ":", "_", "ALL")>
										<cfset accion = REReplace(REReplace(REReplace(REReplace("#cambio.getACCION_NOMBRE()#"," ","_","ALL"), 'é', "e"),'á', 'a'), 'ó','o')>
										<button class="btn boton_#fecha#_#accion# botonEstado#nombreEstado# btn-xs btn-success  pull-right #cambio.getACCION_ICONO()# ml5 guiaBotonHistorial" onclick="resaltaLink('#fecha#','#accion#');"> </button>
									</cfloop>									
									<script type="text/javascript">
										$(".botonEstado#nombreEstado#:last").removeClass('btn-xs').addClass('btn-sm');
									</script>
								</td>
							</tr>
							<cfloop array="#estado.getlinks()#" index="cambio">
								<cfset fecha  = REReplace(REReplace("#cambio.getFECHA()#", " ","_","ALL"), ":", "_", "ALL")>
								<cfset accion = REReplace(REReplace(REReplace(REReplace("#cambio.getACCION_NOMBRE()#"," ","_","ALL"), 'é', "e"),'á', 'a'), 'ó','o')>
								<tr class="bloquePadre_#fecha#_#accion# estado-#nombreEstado# " abierto="0">
									<td>
									 </td>
									<td>
										<label fecha="#fecha#" accion="#accion#" class="resaltarBoton guiaPersonaHistorial">#cambio.getusuario()#</label>
									</td>
									<td>
										<label fecha="#fecha#" accion="#accion#" class="resaltarBoton pull-right guiaFechaHistorial">#cambio.getFECHA()#</label>
									</td>
								</tr>
								<script type="text/javascript">
									$(".estado-#nombreEstado#").hide();
									$(".estado-#nombreEstado#:last").show();
									$(".estado-#nombreEstado#:last").attr('abierto', '1');
								</script>
							</cfloop>
						</cfloop>
					</cfoutput>
				</tbody>
			</table> --->
			<div id="vertical-timeline" class="vertical-container dark-timeline">
				<cfoutput>
					<cfloop  array="#prc.historial.getEstados()#" index="estado">
						<cfset nombreEstado = REReplace(REReplace(REReplace(REReplace("#estado.GETNOMB_EDO()#"," ","_","ALL"), 'é', "e"),'á', 'a'), 'ó','o')>
						<div class="vertical-timeline-block">
							<div class="vertical-timeline-icon estiloDefectoS#estado.getESTILO_ESTADO()# guiaEstadoHistorial">
								<p style="margin-top: 5px;">#estado.GETNUM_EDO()#</p>
							</div>
							<div class="vertical-timeline-content">
								<div class="col-md-8">
									<h5 class="guiaNombreEstadoHistorial">#estado.GETNOMB_EDO()#</h5>
								</div>
								<div class="col-md-4">
									<cfloop array="#estado.getCambios()#" index="cambio">
										<cfset fecha  = REReplace(REReplace("#cambio.getFECHA()#", " ","_","ALL"), ":", "_", "ALL")>
										<cfset accion = REReplace(REReplace(REReplace(REReplace("#cambio.getACCION_NOMBRE()#"," ","_","ALL"), 'é', "e"),'á', 'a'), 'ó','o')>
										<button class="btn boton_#fecha#_#accion# botonEstado#nombreEstado# btn-xs btn-success  pull-right #cambio.getACCION_ICONO()# ml5 guiaBotonHistorial" onclick="resaltaLink('#fecha#','#accion#');"> </button>
									</cfloop>
									<script type="text/javascript">
										$(".botonEstado#nombreEstado#:last").removeClass('btn-xs').addClass('btn-sm');
									</script>
								</div>
								<cfloop array="#estado.getlinks()#" index="cambio">
									<cfset fecha  = REReplace(REReplace("#cambio.getFECHA()#", " ","_","ALL"), ":", "_", "ALL")>
									<cfset accion = REReplace(REReplace(REReplace(REReplace("#cambio.getACCION_NOMBRE()#"," ","_","ALL"), 'é', "e"),'á', 'a'), 'ó','o')>
									<div class=". bloquePadre_#fecha#_#accion# estado-#nombreEstado#" abierto="0">
										<small>
										<label fecha="#fecha#" accion="#accion#" class="badge badge-info resaltarBoton guiaPersonaHistorial">#cambio.getusuario()# <br>#cambio.getFECHA()#</label>
										</small>
									</div>
								</cfloop>
								<script type="text/javascript">
									$(".estado-#nombreEstado#").hide();
									$(".estado-#nombreEstado#:last").show();
									$(".estado-#nombreEstado#:last").attr('abierto', '1');
								</script>
							</div>
						</div>
					</cfloop>
				</cfoutput>
			</div>
		</div>
	</div>
	<div id="tab-2" class="tab-pane">
		<div class="panel-body">
			<div id="vertical-timeline" class="vertical-container dark-timeline">
				<cfoutput>
					<cfloop  array="#prc.cambios#" index="estado">
						<div class="vertical-timeline-block">
							<div class="vertical-timeline-icon estiloDefectoS#estado.getESTILO_ESTADO()# guiaEstadoHistorial">
								<i class="#estado.getACCION_ICONO()# "></i>
							</div>
							<div class="vertical-timeline-content">
								<span class="fa-stack color-number#estado.getNOM_EDO_ACTUAL()# fa-1x pull-right" style="padding-right: 0px">								
							    <i class="fa fa-circle-o fa-stack-2x"></i>
							    <strong class="fa-stack-1x">#estado.getNOM_EDO_ACTUAL()#</strong>
								</span>
								<h5 class="guiaNombreEstadoHistorial">#estado.getNOMBRE_EDO_ACTUAL()#</h5>
								<p>
									Usuario: #estado.getUSUARIO()#<br>
									Acción: #estado.getACCION_NOMBRE()#
								</p>
								<span class="vertical-date">
									<small>#estado.getFECHA()#</small>
								</span>
							</div>
						</div>
					</cfloop>
				</cfoutput>
			</div>
		</div>
	</div>
</div>
</div>
<div class="leyendas text-center">
	<span class="label badge-success">Estado Actual</span>
	<span class="label badge-default">Estados antiguos</span>
	<span class="label badge-warning">Estado de rechazo</span>
	<span class="label badge-white" style=" border: .01em solid;">Estado no registrado</span>
</div>
<style type="text/css">
	.gris-bg{
		background-color: #c2c2c2;
		color: #ffffff;
	}
</style>
<script type="text/javascript">
	
	$('[data-popover="popover"]').popover({
		trigger: 'focus'
	});

	$(document).ready(function(){

		$('[data-tooltip="tooltip"]').tooltip();
		definirEstilos();
	});

	function definirEstilos(){

		$(".estiloDefectoSestadoActual").addClass('blue-bg');
		$(".estiloDefectoSestadoAntiguo").addClass('gris-bg');
		$(".estiloDefectoSestadoRetroceso").addClass('yellow-bg');
		$(".estiloDefectoS").addClass('white-bg');

		$(".estiloDefectoestadoActual").addClass('btn-success');
		$(".estiloDefectoestadoAntiguo").addClass('btn-default');
		$(".estiloDefectoestadoRetroceso").addClass('btn-warning');
		$(".estiloDefecto").addClass('btn-white').css('border', '.01em solid');
	}

	function resaltaLink(fecha, accion){
		if($('.bloquePadre_'+fecha+'_'+accion).attr('abierto') == '0'){
			$('.bloquePadre_'+fecha+'_'+accion).show();
			$('.bloquePadre_'+fecha+'_'+accion).attr('abierto', '1');
		}
		else{
			$('.bloquePadre_'+fecha+'_'+accion).hide();
			$('.bloquePadre_'+fecha+'_'+accion).attr('abierto', '0');
		}
	}

	$('body').undelegate('.resaltarBoton', 'click');
	$('body').on('click', '.resaltarBoton', function() {
		fecha = $(this).attr('fecha');
		accion = $(this).attr('accion');
		$('.boton_'+fecha+'_'+accion).css({'background':'#23c6c8', 'border-color': '#23c6c8'});

		setTimeout(function() {
			$('.boton_'+fecha+'_'+accion).css({'background':'#1c84c6', 'border-color': '#1c84c6'});
		}, 500);
	});
</script>
