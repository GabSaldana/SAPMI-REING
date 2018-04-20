<cfprocessingdirective pageEncoding="utf-8">
<div class="container" style="width:100%;">
	<div class="row">
		<div class="col-md-12" id="CuentaProyectos" style="display: none">
			<div class="alert alert-success">
				<span class="fa fa-check"></span> Usted ha seleccionado al menos un proyecto para la solicitud.<br>
			</div>
		</div>
		<div class="col-md-12 noProcede" id="NoCuentaProyectos" style="display: none">
			<div class="alert alert-danger">
				<span class="fa fa-times"></span> Usted <strong>No</strong> ha seleccionado ningun proyecto para la solicitud.<br>
				Seleccione un proyecto, de lo contrario <strong>No</strong> podrá participar en el programa.
			</div>
		</div>
	</div>
	<div class="row">
		<div class="input-group pull-right mail-search col-md-12">
			<input id="buscar_proy" class="form-control input-sm" name="search" placeholder="Buscar" type="text" onkeyup="busquedaProy()">
		</div>
	</div>
	<div class="row">
		<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
			<cfset producto = prc.productos[numReporte].reporte>
			<cfset ruta =  prc.productos[numReporte].ruta>
			<cfset filas = producto.getFilas()>
			<cfset encabezado = producto.getEncabezado()>
			<cfset columnas = encabezado.getColumnas()>
			<cfset pkformato = producto.getPkTFormato()>
			<cfif arraylen(filas) GT 0>
				<cfloop array="#filas#" index="fila">
					<div class="col-lg-6 proyBusqueda">
						<div class="widget-head-color-box lazur-bg p-sm text-center datos">
								<cfloop  from="1" to="#arraylen(ruta)#" index="rprod">
									<b><cfif rprod neq 1>/</cfif><cfoutput>#ruta[rprod]# </cfoutput></b>
								</cfloop>
						</div>
						<div class="widget-text-box">
							<cfloop  array="#columnas#" index="columna">
								<cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
									<div class="row">
										<div class="col-sm-6">
											<label class="control-label"><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</label>
										</div>
										<div class="col-sm-6">
											<cftry>
												<cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput>
												<cfcatch>
													No se encontro la celda
												</cfcatch>
											</cftry>
										</div>
									</div>
								</cfif>
							</cfloop>
							<cfoutput>
								<div class="row">
									<cfloop  array="#columnas#" index="columna">
										<cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
											<div class="col-sm-6">
												<label class="control-label"><cfoutput>#columna.getNOM_COLUMNA()# </cfoutput>:</label>
											</div>
											<div class="col-sm-6">
												<button class="btn btn-white btn-rounded btnFile " onclick="descargaComprobante(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);">
													Descargar 
													<span class="fa fa-download"></span>
												</button>
											</div>
										</cfif>
									</cfloop>
								</div>
							</cfoutput>
							<div class="text-right checkbox checkbox-primary">
								<input id="check<cfoutput>#fila.getPK_FILA()#</cfoutput>" fila="<cfoutput>#fila.getPK_FILA()#</cfoutput>" cproducto="<cfoutput>#fila.getPK_CPRODUCTO()#</cfoutput>" class="fa-3x selectProyectos" type="checkbox" <cfif fila.getSELECCIONADO() EQ 1> checked</cfif>>
								<label for="check<cfoutput>#fila.getPK_FILA()#</cfoutput>">
									Seleccionar
								</label>
							</div>
						</div>
					</div>
				</cfloop>
			<cfelse>
				<div class="alert alert-danger NoExistenProyectos">
					<span class="fa fa-times"></span> Usted <strong>No</strong> cuenta con proyectos de investigación.<br>
					Debe dar de alta proyectos en CVU, de lo contrario <strong>No</strong> podrá participar en el programa.
				</div>
			</cfif>
		</cfloop>
	</div>
</div>
<form id="downloadComprobante" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="get" target="_blank">
	<input type="hidden" id="pkCatFmt"		name="pkCatFmt">
	<input type="hidden" id="pkColDown"		name="pkColDown">
	<input type="hidden" id="pkFilaDown"	name="pkFilaDown">
</form>

<script type="text/javascript">

	$(document).ready(function() {
		CuentaProyectosInvestigacion();
	});

	function CuentaProyectosInvestigacion(){
		valoresSelecionados = $('.selectProyectos:checked').length == 0 ? 0 : 2; 
		if(valoresSelecionados == 0){
			$('#NoCuentaProyectos').show();
			$('#CuentaProyectos').hide();
		} else{
			$('#NoCuentaProyectos').hide();
			$('#CuentaProyectos').show();
		}
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionProyectoInvestigacion")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado:	valoresSelecionados
		}, function(data){
		});
	}

	$('body').undelegate('.selectProyectos', 'click');
	$('body').on('click', '.selectProyectos', function(){
		pkFila = $(this).attr('fila');
		pkEstado = $(this).is(":checked")? 2:0;
		pkProducto = $(this).attr('cproducto');
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.addEvaluacionProducto")#</cfoutput>', {
			pkFila: pkFila,
			pkProducto: pkProducto,
			pkEstado:pkEstado
		}, function(data){
			if(data > 0)
				toastr.success('Se ha actualizado la información');
			else
				toastr.error('Error en el servidor, intente más tarde');
		});
		CuentaProyectosInvestigacion();
	});

	function descargaComprobante(pkformato, pkfila, pkcol){
		$("#pkColDown").val(pkcol);
		$("#pkFilaDown").val(pkfila);
		$("#pkCatFmt").val(pkformato);
		$('#downloadComprobante').submit();
	}

	function busquedaProy(){
		var tex = $('#buscar_proy').val();
		$('.proyBusqueda').hide();
		$('.proyBusqueda').each(function(){
			if(tex == '')
				$('.proyBusqueda').show();
			else if($(this).text().toUpperCase().indexOf(tex.toUpperCase()) != -1){
		    	$(this).show();
		   	}
		});
  	}

</script>