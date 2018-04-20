
	<!--- Javascript Charts --->
	<script type="text/javascript" src="/includes/js/jquery/amcharts/amcharts.js"></script>
	<script type="text/javascript" src="/includes/js/jquery/amcharts/export.js"></script>
	<script type="text/javascript" src="/includes/js/jquery/amcharts/fonts.js"></script>
	<script type="text/javascript" src="/includes/js/jquery/amcharts/pie.js"></script>
	<script type="text/javascript" src="/includes/js/jquery/amcharts/serial.js"></script>
	<script type="text/javascript" src="/includes/js/jquery/amcharts/themes/light.js"></script>
	<script type="text/javascript" src="/includes/js/jquery/amcharts/themes/none.js"></script>
	

<script type="text/javascript">
<!--
	var erroresTbl;
	$('#cargador-modal').modal('show');
	$(document).ready(function(e) {
		$('#cargador-modal').modal('hide');
		getTablaErrores();
		$('[data-toggle="tooltip"]').tooltip();
		$('.input-group.date').datepicker({
			language: "es",
			autoclose: true,
			todayHighlight: true,
			toggleActive: true,
			format: 'dd/mm/yyyy'
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
	
	function quitarElemento(pkError){
		$("#errores-registrados-id tr").each(function(index, value) {
			if( parseInt($(this).attr('data-pkRegistro')) == pkError ){
				$(this).remove();
			}
		});
	}
	
	function verErrorDetalle(obj){
		if(confirm("¿Desea ver el detalle del error generado?")){
			$("#pkError").val($(obj).attr("data-pkError"));
			$('#formErrores').attr('action','/index.cfm/adminCSII/administrador/error/error/verDetalleError');
			$('#formErrores').submit();
		}
	}
	
	function eliminarError(obj){
		if(confirm("\u00BFDesea eliminar la informaci\u00F3n?")){
			var pkRemove = $(obj).attr("data-remove");
			
			$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.eliminarError")#</cfoutput>', {pkError:pkRemove}, function(data){
				if(data > 0){
					quitarElemento(pkRemove);
					muestraMensaje("success","Informaci&oacute;n","La informaci&oacute;n se ha eliminado correctamente");
				}else{
					muestraMensaje("warning","Informaci&oacute;n","La informaci&oacute;n no se pudo eliminar, intente m&aacute;s tarde");
				}
			});
		}
	}
	
	function getTablaErrores(){
		$('#cargador-modal').modal('show');
		var valTipoError = '';
		if($("#cmbErrores").find("option:selected").val() > 0){
			valTipoError = $("#cmbErrores").find("option:selected").text();
		}
		
		$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.verTablaRegistros")#</cfoutput>', {numeroPagina: $('#cmbPagina').find("option:selected").val(),tipoError: valTipoError, ur:$('#cmbUR').find("option:selected").val(), fechaIni:$("#fechaIni").val(), fechaFin:$("#fechaFin").val() }, function(data){
			$('#erroresRegistradosID').html( data );
			$('#cargador-modal').modal('hide');
		});
	}
	
	function consultaInformacion(){
		$("#tituloErrores").html("Lista de errores registrados");
		getTablaErrores();
	}
	
	function limpiarInformacion(){
		$("input:text").val("");
		$("select").each(function(index, element) {
			$(this).prop("selectedIndex", 0);
		});
		getTablaErrores();
	}
	
	function analizarInformacion(){
		if(pkAnalisis.length > 0){
			$('#cargador-modal').modal('show');
			if(confirm("¿Desea ver el an\u00E1lisis sobre los errores encontrados?")){
				$("#tituloErrores").html("An&aacute;lisis de los errores registrados");
				var valTipoError = '';
				if($("#cmbErrores").find("option:selected").val() > 0){
					valTipoError = $("#cmbErrores").find("option:selected").text();
				}
				
				$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.analisisInformacion")#</cfoutput>', {numeroPagina: $('#cmbPagina').find("option:selected").val(),tipoError: valTipoError, ur:$('#cmbUR').find("option:selected").val(), fechaIni:$("#fechaIni").val(), fechaFin:$("#fechaFin").val(), pkRegistrosAz:pkAnalisis.join(",")}, function(data){
					$('#erroresRegistradosID').html( data );
					$('#cargador-modal').modal('hide');
				});
			}else{
				$('#cargador-modal').modal('hide');
			}
		}
	}
-->
</script>
<cfoutput>
	<form name="formErrores" id="formErrores" enctype="application/x-www-form-urlencoded" method="post" target="_top">
		<input type="hidden" name="pkError" id="pkError" />
	</form>
	<form name="formAnalisis" id="formAnalisis" enctype="application/x-www-form-urlencoded" method="post" target="_top">
		<textarea id="pkRegistrosAz" name="pkRegistrosAz" style="display:none;"></textarea>
	</form>
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title" id="tituloErrores">Lista de errores registrados</h3>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="row">
								<div class="col-xs-6 col-md-2">
									<label>Unidad Responsable:</label>
								</div>
								<div class="col-xs-12 col-sm-12 col-md-10">
									<select id="cmbUR" name="cmbUR" class="form-control">
										<option value="">Seleccione...</option>
										<cfloop index="o" from="1" to="#prc.nomUR.recordCount#">
											<option value="#prc.nomUR.UR[o]#">#prc.nomUR.UR[o]# - #prc.nomUR.NOMBRE_DEPENDENCIA[o]#</option>
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
									<label>Tipos de errores:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<select id="cmbErrores" name="cmbErrores" class="form-control">
										<option value="-1">Seleccione...</option>
										<cfloop index="o" from="1" to="#prc.tiposError.TERRORES.recordCount#">
											<option value="#o#">#prc.tiposError.TERRORES.CLAVE_ERROR[o]#</option>
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
										<cfset noPaginas = Ceiling(prc.tiposError.TOTAL / maximoPagina)>
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
										<input type="hidden" name="nombreProceso" id="nombreProceso" value="Manejo de errores" />
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
							<button type="button" class="btn btn-primary" onClick="consultaInformacion();">
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
					<div id="erroresRegistradosID">
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
	
	<div id="consultarDetalleError" class="modal fade">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header alert-success bg-success">
					<button type="button" class="btn btn-primary btn-lg close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="modal-detalle-title">Detalle</h4>
				</div>
				<div class="modal-body" id="modal-detalle-body">
					<div id="consultaDetalleError">
						&nbsp;
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="verInformacion" class="modal fade">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header alert-success bg-success">
					<button type="button" class="btn btn-primary btn-lg close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="modal-title">Detalle</h4>
				</div>
				<div class="modal-body" id="modal-body">
					<div id="consultaRegistrosError">
						&nbsp;
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>
</cfoutput>