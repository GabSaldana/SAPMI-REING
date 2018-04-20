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

<cfinclude template="configuracion_js.cfm">
<cfset total_records = prc.Formatos.recordcount>

<div class="container" >	
	<input type="hidden" id="in-formatos" name="formatos">
	<input type="hidden" id="in-readOnly">
	<input type="hidden" id="pkperiodo" name="formatos">													<!-- A.B.J.M. Para cargar el historial se necesita pk -->
	<input type="hidden" id="pkReporte" name="formatos">													<!-- A.B.J.M. Para cargar el historial se necesita pkReporte  -->	
<div class="container" >												
	<div class="row" id="cont-Allreportes">
		<div class="col-md-12">		
			<cfinclude template="/views/adminCSII/historial/historial.cfm">										<!-- A.B.J.M. Incluir el historial en  Configuración de Formatos -->	
			<div class="ibox">
			    <div class="ibox-title">
					<h4>Reportes Trimestrales</h4>
				</div>
				<div class="ibox-content">
					<div class="row">
						<div class="col-md-4">
							<button class="btn btn-primary btn-outline pull-left dim bt-nuevoRep"><i class="fa fa-magic"></i> Asistente</button>
						</div>
					</div>
			
					<div class="row" >
				    <table id="tablaFormatos" function ="getIndex " class="table table-striped table-responsive" data-page-size="8"  data-pagination="true" data-search="true" data-search-accent-neutralise="true">
						<thead>
				            <tr>
								<th  class="text-center" data-field="Formato" 	data-sortable="true" width="30%">Formato</th>
								<th  class="text-center" data-field="Clave" 	data-sortable="true"  width="20%">Clave</th>
								<th  class="text-center" data-field="Versión" 	data-sortable="true"  width="10%">Versión</th>
								<th  class="text-center" data-field="Estado" 	data-sortable="true" width="10%">Estado</th>
								<th  class="text-center" data-field="consulta" 	data-sortable="true" width="10%">Ver</th>
								<th  class="text-center" data-field="Acciones" 	data-sortable="true" width="20%">Acciones</th>
							</tr>
			            </thead>
			            			            
			            <cfoutput query="prc.Formatos">
							<tr>
						    	<td class="text-left" >
			                    	#nombre#
								</td>
			                	<td>
									#CLAVE#
								</td>
								<td>
									<span class="badge badge-primary">#version#</span>
								</td>
			                	<td>			             	
				                	<a title="Consultar historial" onclick="consultaHistorial(#pk#,1);">				 <!-- A.B.J.M. Llama a la funcón que inicia el historial -->
				                    <span class="fa-stack text-info" style="font-size:15px">
											<i class="fa fa-circle-o fa-stack-2x"></i>
									  		<strong class="fa-stack-1x guiaHistorial">#NUMEDO#</strong> 					 <!-- A.B.J.M. guiaEstado -->
										</span>
									</a>    
								</td>
											                		                            		                                          
			                	<td class="text-center">
									
									<cfif listFind(ACCIONESCVE,'configFT.captura','$')>
										<button class="btn btn-sm btn-primary btn-outline dim guiaEditar" onclick="capturarFormato(#pk#);" title="Capturar o Editar Formato" >
			                            	<i class="fa fa-list-alt  fa-fw"></i>
										</button>										
									<cfelse>
										<button class="btn btn-sm btn-primary btn-outline dim guiaVer" onclick="verFormato(#pk#);" title="Ver Formato" >
			                            	<i class="fa fa-search fa-fw"></i>
			                            </button>
									</cfif>		                            
				                </td>
			                	<td>
				                	
				                	<cfif arrayFind(session.cbstorage.grant,'configFT.Copiar')>
			                    	<button class=" btn btn-sm btn-primary guiaCopiar" title="Copiar Formato" onclick="copiarFormato(#pk#);"><!--,configFT.copiar');">-->
			                    		<i class="fa fa-copy fa-fw"></i> 
			                    	</button> 
			                    	</cfif>
				                    
				                    <cfif listFind(ACCIONESCVE,'configFT.Validacion','$')>
			                    		<button class=" btn btn-sm btn-success guiaValidar"  title="Validar Formato" onclick="cambiarEstadoFT(#pk#,'configFT.Validacion','Validar Formato');">
			                    			<i class="fa fa-thumbs-o-up  fa-fw"></i> 
			                    		</button> 
				                    </cfif>
				                    
				                    <cfif listFind(ACCIONESCVE,'configFT.Rechazo','$')>
			                    		<button class=" btn btn-sm btn-warning guiaRechazar"  title="Rechazar Formato" onclick="cambiarEstadoFT(#pk#,'configFT.Rechazo','Rechazar Formato');">
			                    			<i class="fa fa-thumbs-o-down  fa-fw"></i> 
			                    		</button> 
				                    </cfif>
				                    
				                    <cfif listFind(ACCIONESCVE,'configFT.Eliminar','$')>
				                    	<button class="btn btn-sm btn-danger guiaEliminar"  title="Eliminar Formato" onclick="cambiarEstadoFT(#pk#,'configFT.Eliminar','Eliminar Formato');">
			                    			<i class="fa fa-trash fa-fw"></i> 
			                    		</button>
				                    </cfif>

				                    <cfif arrayFind(session.cbstorage.grant,'configFT.crearVersion')>								
										<button class="btn btn-sm btn-success guiaNuevaVersion"  title="Crear nueva versión" onclick="formatoVersion(#pk#);">
			                    			<i class="fa  fa-external-link fa-fw"></i> 
			                    		</button>
			                    	</cfif>
					    		</td>
			        		</tr>    
						</cfoutput>
			        </table>   
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div id="divConfiguracion">
		</div>
	</div>
</div>

<!--- ********************************************************* Guia ********************************************************* --->
<ul id="tlyPageGuide" data-tourtitle="Configuración de formatos">
	<li class="tlypageguide_top" data-tourtarget=".bt-nuevoRep">
		<div>Generar nuevo formato<br>
		Asistente para crear un nuevo formato de reporte.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".search">
		<div>Buscar formatos<br>
		En la tabla puede realizar una búsqueda de formatos de reporte,utilizando datos específicos.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaHistorial">
		<div>Estado<br>
		Número que representa el estado en que se encuentra el reporte, al dar click en el "Estado" de un reporte se mostrará el historial de estado el cual ofrece una explicación detallada de los estados por los que ha pasado el reporte.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaEditar">
		<div>Capturar o Editar formato<br>
		Puede editar cualquier configuración del formato en el panel editor de formatos.</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget=".guiaVer">
		<div>Ver formato<br>
		Al seleccionar este botón se desplegará la información del formato de reporte.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaCopiar">
		<div>Copiar formato<br>
		Al seleccionar el botón <i class="fa fa-copy fa-fw"></i> se creará una copia del formato.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaValidar">
		<div>Validar formato<br>
		Al seleccionar el botón <i class="fa fa-thumbs-o-up  fa-fw"></i> el formato de reporte se validará y una notificación le será enviada al responsable.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaRechazar">
		<div>Rechazar reporte<br>
		Al seleccionar el botón <i class="fa fa-thumbs-o-down fa-2x"></i> el formato será rechazado y una notificación será enviada al usuario que realizó la petición de validar el formato, de manera opcional se desplegará la ventana de comentarios para agregar un comentario con el motivo del rechazo.</div>
	</li>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaEliminar">
		<div>Eliminar formato<br>
		Al seleccionar el botón <i class="fa fa-trash fa-fw"></i> se eliminará el formato de reporte.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaNuevaVersion">
		<div>Crear nueva versión<br>
		Al seleccionar el botón <i class="fa  fa-external-link fa-fw"></i> se creará un nuevo formato de reporte con las mismas características del formato seleccionado.</div>
	</li>

	<!--- -------------(Panel de edición de datos generales del reporte)------------------------- --->
	<li class="tlypageguide_left" data-tourtarget=".nombreFormato">
			<div>Formato<br>
			Escriba el nombre que llevará el reporte.</div>
		</li>
	<li class="tlypageguide_left" data-tourtarget="#claveFormato#">
			<div>Clave<br>
			La clave que cada formato posee.Los identificadores "SGE-EV-" serán incluidos de forma automática</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#vigenciaFormato#">
			<div>Vigencia<br>
			Para asignar la fecha de vigencia del formato utilice el botón <i class="glyphicon glyphicon-calendar"></i></div>
		</li>
		<li class="tlypageguide_left" data-tourtarget=".clasificacionFormato">
			<div>Clasificación<br>
			Seleccione la clasificación de la UR a la que pertenece el reporte.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget=".areaFormato">
			<div>Información general - Area<br>
			Seleccione el área que coordinará la captura de información del formato.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget=".instruccionFormato">
			<div>Información general - Instrucciones<br>
			En este recuadro se deben incluir las instrucciones de llenado del formato, estas instrucciones estarán a disposición de los usuarios que consulten el reporte, durante las captura de información.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaInsercionFilas#">
			<div>Configuraciones generales - Inserción de filas<br>
			Permite configurar la inserción de filas al final del formato al momento de la captura.</div>
		</li>
		<li class="tlypageguide_right" data-tourtarget="#guiaTotalFinal#">
			<div>Configuraciones generales - Inserción total final<br>
			Permite configurar la inserción de la última fila con el total final.</div>
		</li>

	<!--- ---------------(Panel Captura o edición de formato de reporte)------------------- --->
	<li class="tlypageguide_left" data-tourtarget="#guiaColumna#">
			<div>Configuración de la columna - Nombre<br>
			Título de la celda inferior del encabezado.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaTipo#">
			<div>Configuración de la columna - Tipo de dato<br>
			Seleccione un tipo de dato para la columna, durante el proceso de captura, las celdas de la columna aceptarán el tipo de datos seleccionado.</div>
		</li>
		<li class="tlypageguide_top" data-tourtarget="#verSumandos#">
			<div>Guardar información<br>
			Al seleccionar el botón <i class=" fa fa-plus"></i> se desplegará una ventana para seleccionar las columnas de las que procede la suma para obtener el “Total”.</div>
		</li>
		<li class="tlypageguide_top" data-tourtarget="#catalogo#">
			<div>Guardar información<br>
			Al seleccionar el botón <i class="fa fa-search"></i>se desplegará una ventana para seleccionar el catálogo de datos que se desea integrar en la columna.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaAyuda#">
			<div>Configuración de la columna - Ayuda<br>
			En este recuadro es posible incluir instrucciones de llenado de la columna, así como cualquier descripción que facilite su llenado, este texto de ayuda será incluido en los datos del formato de reporte de forma que los usuarios que intervengan en él puedan visualizarlo.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaBloquearCaptura#">
			<div>Configuración de la columna - Bloquear para captura<br>
			Al activar esta opción, la columna seleccionada no permitirá ingresar ningún dato.Esta función es especialmente útil para crear formatos con un tamaño de datos definido y no permitir que se modifique el número de registros de un reporte.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaReferencia#">
			<div>Configuración de la columna - Columna referencia<br>
			Al activar esta opción se estará señalando que la columna será sustituida en el reporte acumulado.</div>
		</li>		
		<li class="tlypageguide_left" data-tourtarget="#guiaCalcularTotales#">
			<div>Configuración de la columna - Calcular Subtotales<br>
			Al activar esta opción la columna seleccionada será asignada como una columna subtotal que de acuerdo a la agrupación de sus valores presentará una sumatoria de subtotales en el reporte, esta característica es única por lo que sólo puede asignarse una columna de tipo subtotal en el reporte.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaTotal#">
			<div>Configuración de la columna -Asignar columna Total final<br>
			Al activar esta opción la columna seleccionada contendrá la sumatoria de todas las columnas de tipo total dentro del reporte, de forma que en cada celda de la columna se encuentre un total de totales del reporte. </div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaMostrarSuma#">
			<div>Configuración de la columna - Suma por secciones<br>
			Al seleccionar esta opción se abrirá una ventana para seleccionar la dupla de plantillas asociadas a la columna.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaCopiarColumna#">
			<div>Configuración de la columna - Copiar columna<br>
			Al activar esta opción la información que contiene la columna se mantendrá para cada formato de cada trimestre.</div>
		</li>
		<li class="tlypageguide_left" data-tourtarget="#guiaPreviosTrimestres#">
			<div>Configuración de la columna - Seleccionar columna Origen<br>
			Al seleccionar esta opción se abrirá una ventana para seleccionar la columna copiable del trimestre previo del cual se transferirá la información a la columna.</div>
		</li>
</ul>

<div id="modal-Copiar" class="modal large inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times"></span></button>
            	<h4 class="modal-title">Copiar Formato</h4>
            </div>
            <div class="modal-body">
            	<input type="text" id="pkFormato" hidden>
            	<form id="registroForm" class="form-horizontal" role="form">	
            		<fieldset>

            			<div class="form-group">
            				<label for="nombreFormato"  class="col-md-2 control-label"><span style="color:#F00">*</span> Formato:</label>
            				<div class="col-md-10" id="nombreFormato">  
            					<input type="text" id="in-nombreFormato" name="nombreFormato" class="required form-control required" value=""/>							
            				</div>
            			</div>

            			<div class="form-group">
            				<label for="claveFormato" class="col-md-2 control-label"><span style="color:#F00">*</span> Clave:</label>
            				<div class="col-md-10">	 
            					<div class="input-group" id="claveFormato">
            						<span class="input-group-addon">SGE-EV-</span>
            						<input type="text" id="in-claveFormato" name="claveFormato" class="required form-control" value="" />															
            					</div>							
            				</div>	
            				<label id="claveWarn" class="col-md-12 control-label">Los campos marcados con <span style="color:#F00">*</span> son obligatorios.</label>
            			</div>

            		</fieldset>        
            	</form>
            </div>
            <div class="modal-footer">
            	<button id="guardarCopia" type="button" class="btn btn-success"><span class="fa fa-save"></span> Guardar</button>
                <button type="button" data-dismiss="modal" class="btn btn-danger"><span class="fa fa-times"></span> Cancelar</button>
            </div>
        </div>
    </div>
</div>

<script>	
	
	$(document).ready(function() {
		
		$('#tablaFormatos').bootstrapTable();	

		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga la vista para generar reportes nuevos
		* --->
		$('.bt-nuevoRep').click(function(){
			window.location.assign('configuracion/cargaVistaNuevoReporte');
		});

		$(document).on('click', '#guardarCopia', function() {

			var longNombre = $.trim($('#in-nombreFormato').val()).length;
			var longClave = $.trim($('#in-claveFormato').val()).length;

			if(longNombre == 0 || longClave == 0){				
				toastr.error('Los campos no deben estar vacios','Error al copiar');		
			}
			else{
				$.when(
					$.ajax({
						type:"POST",		
						url:"configuracion/copiarFormato",
						data:{
							pkFormato: $('#pkFormato').val(),
							clave: 'SGE-EV-'+$('#in-claveFormato').val(),
							nombre: $('#in-nombreFormato').val()
						},
						success:function(data){
							$('#modal-Copiar').modal('hide');
						}
					})
				).then(function(data){
						if(data > 0){
							toastr.success('Recargando Pagina','Copia Creada')
							location.reload();
						}else{
							toastr.error('Al copiar','Error');
						}												
					}			
				);				
			}			
		});
	});

	function formatoVersion(pkFormato){	
		$.when(
			$.ajax({
				type:"POST",		
				url:"configuracion/formatoVersion",
				data:{
					pkTformato:pkFormato					
				},
				success:function(data){
					
				}
			})
		).then(function(data){
				if(data>0){
					toastr.success('Recargando Pagina','Nueva Version Creada')
					location.reload();
				}else{
					toastr.error('Al crear nueva versión','Error');
				}
			}			
		);		
	}

	function copiarFormato(pkFormato){

		$.when(
			$.ajax({
				type:"POST",		
				url:"configuracion/getInfoCopiar",
				data:{
					pkTformato:pkFormato					
				},
				success:function(data){					
					$('#pkFormato').val(pkFormato);
					$('#in-claveFormato').val(data.DATA.CVE[0].substring(7,100));
					$('#in-nombreFormato').val(data.DATA.NOMBRE[0] + ' - copia');					
				}
			})
		).then(function(data){	
				$('#modal-Copiar').modal('show');
			}			
		);				
	}
		
	<!---
	* Fecha      : Enero 2017
	* Autor      : Marco Torres
	* Descripcion: cambia el estado del reporte
	* --->
	function cambiarEstadoFT(pkTformato,accion, textoAccion){
		if(confirm( textoAccion+'\n¿Desea realizar esta operacion?')){
			$.post('configuracion/cambiarEstadoFT', {
					accion: accion,
					pkTformato: pkTformato
				}, 
				function(data){
					location.reload();		
		    	}
		    );
		}
	}
	
	<!---
	* Fecha      : Enero 2017
	* Autor      : Marco Torres
	* Descripcion: cambia el estado del reporte
	* --->	
	function verFormato(pkTformato){		
		$('#divConfiguracion').show();
		$('#in-formatos').val(pkTformato);
		$('#in-readOnly').val(1);
		$('#cont-Allreportes').slideToggle( 1500,'easeOutExpo');		
		cargarVista();		
	}

	function capturarFormato(pkTformato){
		$('#divConfiguracion').show();
		$('#in-formatos').val(pkTformato);
		$('#in-readOnly').val(0);
		$('#cont-Allreportes').slideToggle( 1500,'easeOutExpo');
		cargarInicio();
	}
	
</script>