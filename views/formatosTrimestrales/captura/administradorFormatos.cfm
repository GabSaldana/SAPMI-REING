<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:
* Descripcion:
* Autor:
* =========================================================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<link rel="stylesheet" type="text/css" href="/views/formatosTrimestrales/formatosTrimestrales.css"/>
<cfinclude template="captura_js.cfm">


<cfset total_records = prc.formatosPeriodo.recordcount>
	<input type="hidden" id="pkformato" name="formatos">
	<input type="hidden" id="pkperiodo" name="formatos">
	<input type="hidden" id="pkReporte" name="formatos">
	<div class="row" id="cont-Allreportes" >
		<div class="col-md-12">
			<!--- <cfinclude template="/views/adminCSII/comentarios/tablaComentarios.cfm"> --->
			<!--- <cfinclude template="/views/adminCSII/historial/historial.cfm"> --->
			<div class="ibox ">
			    <div class="ibox-title">
					 <h4>Reportes Trimestrales</h4>
				</div>
				<div class="ibox-content" >
					<div class="row">
					<table id="tablaFormatos" function ="getIndex " class="table table-striped table-responsive" data-page-size="8"  data-pagination="true" data-search="true" data-search-accent-neutralise="true">
						<thead>
				            <tr>
								<th  class="text-center" data-field="Formato" 	data-sortable="true" width="40%">Formato</th>
								<th  class="text-center" data-field="Periodo" 	data-sortable="true"  width="20%">Periodo</th>
								<th  class="text-center" data-field="Clave" 	data-sortable="true"  width="20%">Clave</th>
								<th  class="text-center" data-field="Estado" 	data-sortable="true" width="10%">Estado</th>
								<th  class="text-center" data-field="consulta" 	data-sortable="true" width="10%">Capturar</th>
								<th  class="text-center" data-field="Acciones" 	data-sortable="true" width="20%">Acciones</th>
							</tr>
			            </thead>
					<cfoutput query="prc.formatosPeriodo">
						<tr>
					    	<td class="text-left" >
		                    	#nombre#
							</td>
		                	<td>
								#PERIODO#
							</td>
		                	<td>
								#CLAVE#
							</td>
		                	<td>
		                		<a title="Consultar historial" onclick="consultaHistorial(#pkreporte#,2);">
				                    <span class="fa-stack text-success" style="font-size:15px">
										<i class="fa fa-circle-o fa-stack-2x"></i>
									  	<strong class="fa-stack-1x guiaHistorial">#NUMEDO#</strong>
									</span>
								</a>
							</td>
		                	<td class="text-center">

		                		<cfif listFind(ACCIONESCVE,'CapturaFT.captura','$')>
		                            <button class="btn btn-sm btn-primary btn-outline dim guiaCapturar" onclick="verFormato(#pk#,#pkreporte#, #PKPERIODO#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#');" title="Capturar o Editar Formato" >
			                            <i class="fa fa-edit "></i> 
									</button> 
									<button class="btn btn-sm btn-success btn-outline dim guiaLlenado" onclick="llenarFormato(#pk#,#PKPERIODO#,#pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#');" title="Llenar Formato">
										<i class="fa fa-pencil-square"></i> 
									</button>
								<cfelse>
							       	<button class="btn btn-sm btn-primary btn-outline dim guiaConsultar" onclick="capturarFormato(#pk#,#PKPERIODO#,#pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#');" title="Consultar Formato" >
										<i class="fa fa-search "></i>
									</button>
			                    </cfif>

			                </td>
		                	<td>
		                    	<cfif listFind(ACCIONESCVE,'CapturaFT.Validacion','$')>
		                    		<button class=" btn btn-sm btn-success guiaValidar"  title="Validar Formato" onclick="cambiarEstadoRT('CapturaFT.Validacion','Validar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');">
		                    			<i class="fa fa-thumbs-o-up "></i>
		                    		</button>
			                    </cfif>

			                    <cfif listFind(ACCIONESCVE,'CapturaFT.Rechazo','$')>
		                    		<button class=" btn btn-sm btn-warning guiaRechazar"  title="Rechazar Formato" onclick="cambiarEstadoRT('CapturaFT.Rechazo','Rechazar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');">
		                    			<i class="fa fa-thumbs-o-down "></i>
		                    		</button>
			                    </cfif>

			                    <cfif listFind(ACCIONESCVE,'CapturaFT.Eliminar','$')>
			                    	<button class="btn btn-sm btn-danger guiaEliminar"  title="Eliminar Formato" onclick="cambiarEstadoRT('CapturaFT.Eliminar','Eliminar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');">
		                    			<i class="fa fa-trash"></i>
		                    		</button>
			                    </cfif>

			                    <button class="btn btn-info ml5 fa fa-server guiaComentarios" title="Comentarios" onclick="consultarComenReg(#pkreporte#);"></button>

				    		</td>
		        		</tr>
					</cfoutput>
			        </table>
					</div>

				</div>
			</div>
		</div>
	</div>

	<div class="row" id="divConfiguracion" style="display:none;"> 
		<div class="panel panel-primary">
	    	<div class="panel-heading">
				<span class="btn btn-primary  btn-xs pull-right " id="bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;"><i class="fa fa-times"></i></span>
				<cfif listFind(prc.formatosPeriodo.ACCIONESCVE,'CapturaFT.captura','$')>
					<span class="btn btn-primary btn-xs pull-right panelToggleHorizontal" title="Cambiar de panel" style="font-size:22px;" onclick="llenarFormatoToogle();"><i class="fa fa-arrow-right"></i></span>
				</cfif>
				FORMATO&nbsp;&nbsp;&nbsp;:
				<strong><span id="displayNombre"></span></strong><br>
				TRIMESTRE&nbsp;:
				<strong><span id="displayTrimestre"></span></strong>
        	</div>
			<div class="panel-body" >  
				<div id="divInfoGral"></div> 
				<div id="tabla"></div>
			</div>
		</div>
	</div>

	<div class="row" id="divVistaLlenado" style="display:none; width:100%; position:absolute;">
		<div class="panel panel-success">
		    <div class="panel-heading">
				<span class="btn btn-success btn-xs pull-right" id="bt-cerrar-vista" title="Cerrar Encabezado" style="font-size: 22px;"><i class="fa fa-times"></i></span>
				<span class="btn btn-success btn-xs pull-right panelToggleHorizontal" title="Cambiar de panel" style="font-size:22px;" onclick="verFormatoToogle();"><i class="fa fa-arrow-left"></i></span>
				FORMATO&nbsp;&nbsp;&nbsp;:
				<strong><span id="displayNombreVistaLlenado"></span></strong><br>
				TRIMESTRE&nbsp;:
				<strong><span id="displayTrimestreVistaLlenado"></span></strong>
			</div>
			<div class="panel-body">
				<div id="tablaVista"></div>
			</div>
		</div>
	</div>

	<div class="row" id="divLlenado" style="display:none">
		<div class="col-md-12"><br>
			<div class="panel panel-success">
			    <div class="panel-heading">
					<span class="btn btn-success btn-xs pull-right" id="btn-cerrar-llenado" onclick="cerrarLlenado();" title="Cerrar" style="font-size: 22px;"><i class="fa fa-times"></i></span>
					FORMATO&nbsp;&nbsp;&nbsp;:
					<strong><span id="displayNombreLlenado"></span></strong><br>
					TRIMESTRE&nbsp;:
					<strong><span id="displayTrimestreLlenado"></span></strong>
				</div>
				<div class="panel-body">
					<div id="formularioLlenado"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">					<!-- ABJM -->
	  <div class="row">							<!-- ABJM -->
		<div id="cont-columna" class="col-md-4" style="display:none" >					<!-- ABJM  Información de columna -->
			<div id="columnaPanel" class="panel panel-warning">
	            <div class="panel-heading">
	                Información de columna
	            	<i class="btn btn-default btn-outline btn-xs pull-right" onclick="cerrarColumna()" title="Captura"><i class="fa fa-times"></i> </i>
			    </div>
	            <div class="panel-body" id="bodyCol">
	           		<div id="confColumna"></div>
				</div>
	        </div>
	    </div>																			<!-- ABJM  -->

		<div id="mdl-coments" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true">
	    	<div class="modal-dialog modal-lg contnido"> </div>
		</div>
	  </div>										<!-- ABJM row -->
    </div>											<!-- ABJM -->

<script>
	$(document).ready(function() {

		$('#tablaFormatos').bootstrapTable();
		<!---*
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga el reporte seleccionado
		* --->
		$('#bt-cerrar-captura').click(function(){		
			$('#in-formato').val(0);
			$('#in-periodo').val(0);
			$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');
			$('#divConfiguracion').slideToggle( 1000,'easeInExpo');
			$('#divSeleccion').slideToggle( 1000,'easeInExpo');
			$('#cont-columna').hide();
		});

		$('#bt-cerrar-vista').click(function(){	
			$('#in-formato').val(0);
			$('#in-periodo').val(0);
			$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');
			$('#divVistaLlenado').slideToggle( 1000,'easeInExpo');
			$('#divSeleccion').slideToggle( 1000,'easeInExpo');
		});

		$('.panelToggleHorizontal').click(function(){
			if(confirm('Los cambios no guardados se perderan ¿Desea continuar?')){
				$('#divConfiguracion').toggle('slide', {direction:'left'}, 500);
				$('#divVistaLlenado').toggle('slide', {direction:'right'}, 500);
			}
		});		
		$('.modal-backdrop').remove();	
	});

	<!---
	* Fecha      : Enero 2017
	* Autor      : Marco Torres
	* Descripcion: cambia el estado del reporte
	* --->
	function cambiarEstadoRT(accion, textoAccion, pkRegistro, nombreFormato, periodoFormato, claveFormato, nombReportes){
		if(confirm( textoAccion+'\n¿Desea realizar esta operacion?')){
			$.post('capturaFT/cambiarEstadoRT', {
					accion: accion,
					pkRegistro: pkRegistro,
					nombreFormato: nombreFormato,
					periodoFormato: periodoFormato,
					claveFormato: claveFormato
				},
				function(data){
					if (data.RETROCESO){
		                escribirComentario(pkRegistro, data.EDODEST, nombReportes);
		            }

		            if (!data.RETROCESO){
		                if (data.EXITO){
		            		location.reload();
			            }else if (data.FALLO){
			                alert("El registro ya había sido modificado.");
			                alert(data.MENSAJE);
			            }
		            }
		    	}
		    );
		}
	}


	<!---
	* Fecha      : Enero 2017
	* Autor      : Marco Torres
	* Descripcion: cambia el estado del reporte
	* --->
	function verFormato(pkTformato, pkReporte, pkPeriodo,textoFormato, textoTrimestre){		
		$('#displayNombre').text(textoFormato);
		$('#displayTrimestre').text(textoTrimestre);
$('.panelToggleHorizontal').show();
		$('#divConfiguracion').show();
		$('#pkformato').val(pkTformato);
		$('#pkperiodo').val(pkPeriodo);
		$('#pkReporte').val(pkReporte);

		$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
		$('#divSeleccion').slideToggle( 1000,'easeOutExpo');
		cargarInicio();
	}

	function verFormatoToogle(){
		$('#displayNombre').text($('#displayNombreVistaLlenado').text());
		$('#displayTrimestre').text($('#displayTrimestreVistaLlenado').text());
		$('#divConfiguracion').addClass('col-md-12').removeClass('col-md-8');
		cargarInicio();
	}

	<!---
	* Fecha      : Enero 2017
	* Autor      : Marco Torres
	* Descripcion: cambia el estado del reporte
	* --->
	function capturarFormato(pkTformato, pkPeriodo, pkReporte, textoFormato, textoTrimestre){
		$('#displayNombre').text(textoFormato);
		$('#displayTrimestre').text(textoTrimestre);

		$('.panelToggleHorizontal').hide();
		$('#divConfiguracion').show();
		$('#pkformato').val(pkTformato);
		$('#pkperiodo').val(pkPeriodo);
		$('#pkReporte').val(pkReporte);

		$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
		$('#divSeleccion').slideToggle( 1000,'easeOutExpo');
		cargarCaptura();
	}

	<!---
	* Fecha      : Febrero 2017
	* Autor      : Ana Juarez Mendez
	* Descripcion: elementos visuales de la carga de la vista de de la tabla (vista previa de la captura)
	* --->
	function cerrarColumna(){
		//cargarTablap3();
		$('#cont-columna').hide();
		$('#divConfiguracion').addClass('col-md-12').removeClass('col-md-8');
		//$('#cont-formato').addClass( 'col-md-12').removeClass( 'col-md-8');

		//$('#divConfiguracion').show();
		//$('#divConfiguracion').hide();
		//$('#cont-infoGral').show();

		//$('#cont-vistaPrevia').show();
		//$('#cont-config').hide();
		//$('#cont-infoGral').show();
	}
	
	<!---
	* Fecha      : Marzo 2017
	* Autor      : SGS
	* Descripcion: 
	* --->
	function llenarFormato(pkTformato, pkPeriodo, pkReporte, textoFormato, textoTrimestre){
		$('#displayNombreVistaLlenado').text(textoFormato);
		$('#displayTrimestreVistaLlenado').text(textoTrimestre);
		
		$('#divVistaLlenado').show();
		$('#pkformato').val(pkTformato);
		$('#pkperiodo').val(pkPeriodo);
		$('#pkReporte').val(pkReporte);
		
		$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
		$('#divSeleccion').slideToggle( 1000,'easeOutExpo');
		cargarLlenado();
	}

	function llenarFormatoToogle(){
		$('#cont-columna').hide();
		$('#displayNombreVistaLlenado').text($('#displayNombre').text());
		$('#displayTrimestreVistaLlenado').text($('#displayTrimestre').text());
		cargarLlenado();
	}

</script>