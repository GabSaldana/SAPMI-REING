<script type="text/javascript">
<!--
//	var monitoreoTbl;
	$('#cargador-modal').modal('show');
	$(document).ready(function(e) {
		$('#cargador-modal').modal('hide');
		getTablaAccesos();
		$('[data-toggle="tooltip"]').tooltip();
		/*
		monitoreoTbl = $('#monitoreo-registrados-id').DataTable({
			"sScrollY": "365px",
			"sScrollX": "100%",
			"sScrollXInner": "100%",
			"bScrollCollapse": true,
			"bSort": false,
			"bJQueryUI": false,
			"iDisplayLength" : 10,
			"oLanguage": {
				"sZeroRecords":  "No existen registros",
				"sLengthMenu": "&nbsp;&nbsp;Mostrar&nbsp;_MENU_\u0020\u0020 registros por p\u00E1gina",
				"sInfo": 	    "Mostrando del _START_ al _END_ de _TOTAL_ registros",
				"sInfoEmpty":    "0 registros",
				"sInfoFiltered": "(filtrando con un total de _MAX_  registros)",
				"sSearch":"Buscar:  _INPUT_ &nbsp;&nbsp;",
				"oPaginate":{
					"sFirst":    "Primero",
					"sLast":     "\u00DAltimo",
					"sNext":     "Siguiente",
					"sPrevious": "Previo"
				}
			},
			"sPaginationType": "full_numbers",
			"deferRender": true
		});
		*/
		$('.input-group.date').datepicker({
			language: "es",
			autoclose: true,
			todayHighlight: true,
			toggleActive: true
		});
		
		$('.modal').on('show.bs.modal', function (event) {
			var idx = $('.modal:visible').length;
			$(this).css('z-index', 1040 + (10 * idx));
		});
		$('.modal').on('shown.bs.modal', function (event) {
			var idx = ($('.modal:visible').length) - 1; // raise backdrop after animation.
			$('.modal-backdrop').not('.stacked').css('z-index', 1039 + (10 * idx));
			$('.modal-backdrop').not('.stacked').addClass('stacked');
		});
	});
	
	function verAccesoDetalle(obj){
		if(confirm("¿Está seguro de ver el detalle del acceso?")){
			$("#pkAcceso").val($(obj).attr("data-pkAcceso"));
			$('#formAcceso').attr('action','/index.cfm/adminCSII/administrador/monitoreo/monitoreo/verSeguimiento');
			$('#formAcceso').submit();
		}
	}
	
	function muestraMensaje(tipo, titulo, mensaje){
		switch(tipo){
			case "error": 
				$("#modal-header").removeClass();
				$("#modal-header").addClass("modal-header alert-danger bg-danger");
				$("#mensaje-footer button").removeClass();
				$("#mensaje-footer button").addClass("btn btn-danger");
			break;
			
			case "information": 
				$("#modal-header").removeClass();
				$("#modal-header").addClass("modal-header alert-info bg-info");
				$("#mensaje-footer button").removeClass();
				$("#mensaje-footer button").addClass("btn btn-info");
			break;
			
			case "success": 
				$("#modal-header").removeClass();
				$("#modal-header").addClass("modal-header alert-success bg-success");
				$("#mensaje-footer button").removeClass();
				$("#mensaje-footer button").addClass("btn btn-success");
			break;
			
			case "warning": 
				$("#modal-header").removeClass();
				$("#modal-header").addClass("modal-header alert-warning bg-warning");
				$("#mensaje-footer button").removeClass();
				$("#mensaje-footer button").addClass("btn btn-warning");
			break;
			
		}
		$("#mensaje-titulo").html(titulo);
		$("#mensaje-texto").html(mensaje);
		$('#winMensaje').modal('show');
	}
	
	function quitarElemento(pkAcceso){
		$("#monitoreo-registrados-id tr").each(function(index, value) {
			if( parseInt($(this).attr('data-pkRegistro')) == pkAcceso ){
				$(this).remove();
			}
		});
	}
	
	function consultaInformacionAccesos(){
		$("#tituloAccesos").html("Lista de accesos registrados (Monitoreo)");
		getTablaAccesos();
	}
	
	function getTablaAccesos(){
		$('#cargador-modal').modal('show');
		
		$.post('<cfoutput>#event.buildLink("adminCSII.administrador.monitoreo.monitoreo.verTablaRegistros")#</cfoutput>', {numeroPagina:$('#cmbPagina').find("option:selected").val(), ur:$('#cmbUR').find("option:selected").val(), fechaIni:$("#fechaIni").val(), fechaFin:$("#fechaFin").val() }, function(data){
			$('#accesosRegistradosID').html( data );
			$('#cargador-modal').modal('hide');
		});
	}
	
	function limpiarInformacion(){
		$("input:text").val("");
		$("select").each(function(index, element) {
			$(this).prop("selectedIndex", 0);
		});
		getTablaAccesos();
	}
	
-->
</script>
<cfoutput>
	<form name="formAcceso" id="formAcceso" enctype="application/x-www-form-urlencoded" method="post" target="_top">
		<input type="hidden" name="pkAcceso" id="pkAcceso" />
	</form>
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title" id="tituloAccesos">Lista de accesos registrados (Monitoreo)</h3>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-5">
									<label>Unidad Responsable:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<select id="cmbUR" name="cmbUR" class="form-control">
										<option value="">Seleccione...</option>
										<cfloop index="o" from="1" to="#prc.nomUR.UR_DATA.recordCount#">
											<option value="#prc.nomUR.UR_DATA.UR[o]#">#prc.nomUR.UR_DATA.UR[o]# - #prc.nomUR.UR_DATA.NOMBRE_DEPENDENCIA[o]#</option>
										</cfloop>
									</select>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-4">
									<label>N&uacute;mero de registros:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<cfset maximoPagina = 100>
									<input type="hidden" name="maxPagina" id="maxPagina" value="#maximoPagina#" />
									<select id="cmbPagina" name="cmbPagina" class="form-control">
										<cfset noPaginas = Ceiling(prc.nomUR.TOTAL / maximoPagina)>
										<cfloop index="o" from="1" to="#(noPaginas+1)#">
											<cfset selected = ''>
											<cfif o EQ 1>
												<cfset selected = 'selected="selected"'>
											</cfif>
											<option value="#(o * maximoPagina)#" #selected#>#(o * maximoPagina)#</option>
										</cfloop>
									</select>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
					<div class="clearfix"><br /></div>
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-5">
									<label>Fecha inicial:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<div class="input-group date">
										<input type="text" name="fechaIni" id="fechaIni" class="form-control" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										<input type="hidden" name="tituloReporte" id="tituloReporte" value="" />
										<input type="hidden" name="nombreProceso" id="nombreProceso" value="Seguimiento de accesos" />
									</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-4">
									<label>Fecha final:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<div class="input-group date">
										<input type="text" name="fechaFin" id="fechaFin" class="form-control" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
									</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
					<div class="clearfix"><br /></div>
					<div class="row">
						<div class="col-sm-3">
							&nbsp;
						</div>
						<div class="col-sm-3 text-center">
							<button type="button" class="btn btn-primary" onClick="consultaInformacionAccesos();">
								<span class="glyphicon glyphicon-search">&nbsp;Consultar informaci&oacute;n</span>
							</button>
						</div>
						<div class="clearfix visible-xs-block"></div>
						<div class="col-sm-3 text-center">
							<button type="button" class="btn btn-primary" onClick="limpiarInformacion();">
								<span class="glyphicon glyphicon-erase">&nbsp;Limpiar filtros</span>
							</button>
						</div>
						<div class="col-sm-3">
							&nbsp;
						</div>
					</div>
					<div id="accesosRegistradosID" style="height:730px;">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="winMensaje" class="modal fade">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header alert-danger bg-danger" id="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h5 id="mensaje-titulo">&nbsp;</h5>
				</div>
				<div class="modal-body" id="mensaje-texto">
					&nbsp;
				</div>
				<div class="modal-footer" id="mensaje-footer">
					<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Cerrar
					</button>
				</div>
			</div>
		</div>
	</div>
</cfoutput>