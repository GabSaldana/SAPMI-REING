
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
<cfinclude template="principal_JS.cfm">
<div class="container" >	
	<input type="hidden" id="in-formatos" name="formatos">
	<input type="hidden" id="in-readOnly">
	<input type="hidden" id="pkperiodo" name="formatos">												
	<input type="hidden" id="pkReporte" name="formatos">													
<div class="container" >												
	<div class="row" id="cont-Allreportes">
		<div class="col-md-12">		
			<cfinclude template="/views/adminCSII/historial/historial.cfm">										
			<div class="ibox">
			    <div class="ibox-title">
					<h1>M&oacute;dulo de Indicadores </h1>
					<cfif arrayFind(session.cbstorage.grant,'Indicadores.capturar')>
						<div class="col-md-4">
							<button class="btn btn-primary btn-outline pull-left dim "><i class="fa fa-magic"></i> Capturar Indicador</button>
						</div>
					</cfif>
				</div>
				<div class="ibox-content">
					<div class="row" >
				    <table id="tablaFormatos" function ="getIndex " class="table table-striped table-responsive" data-page-size="8"  data-pagination="true" data-search="true" data-search-accent-neutralise="true">
						<thead>
				            <tr>
								<th  class="text-center" data-field="Formato" 	data-sortable="true" width="30%">Indicador</th>
								<th  class="text-center" data-field="Clave" 	data-sortable="true"  width="20%">Clave</th>
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
				                	<a title="Consultar historial" onclick="">			
				                    <span class="fa-stack text-info" style="font-size:15px">
											<i class="fa fa-circle-o fa-stack-2x"></i>
									  		<strong class="fa-stack-1x guiaHistorial">#NUMEDO#</strong>
										</span>
										<span class="badge badge-warning">#NOMEDO#</span>	
									</a>    
								</td>	
								<!---PERMISOS PARA EL AUXILIAR, RESPONSABLECGET--->                		                            		        
			                	<td class="text-center">									
									<button class="btn btn-sm btn-primary btn-outline dim guiaVer" onclick="verFormato(282);" title="Ver Formato" >
		                            	<i class="fa fa-search fa-fw"></i>
		                            </button>
				                </td>
			                	<td>
				                   <!---ACCIONES PARA EL AUXILIAR--->
				                   <cfif listFind(ACCIONESCVE,'Indicadores.editar','$')>
										<button id="edicion" class="btn btn-sm btn-primary dim guiaEditar" onclick="" title=" Editar Indicador"><i class="fa fa-pencil  fa-fw"></i>
										</button>
									</cfif>
				                    <!---ACCIONES PARA EL RESPONSABLE CGET--->
				                    <cfif listFind(ACCIONESCVE,'Indicadores.validar','$')>							
										<button class="btn btn-sm btn-success dim guiaValidar"  title="Validar indicador" onclick="cambiarEstadoFT(#pk#,'Indicadores.validar','Validar Indicador');"><i class="fa fa-thumbs-o-up  fa-fw"></i> 
			                    		</button>
			                    	</cfif>
			                    	<cfif listFind(ACCIONESCVE,'Indicadores.eliminar','$')>
				                    	<button class="btn btn-sm btn-danger dim guiaEliminar"  title="Eliminar Indicador" onclick="cambiarEstadoFT(#pk#,'Indicadores.eliminar','Eliminar Indicador);">
			                    			<i class="fa fa-trash fa-fw"></i>  
			                    		</button>
				                    </cfif>
				                    <!---ACCIONES PARA EL ANALISTA--->
				                    <cfif listFind(ACCIONESCVE,'Indicadores.rechazar','$')>								
										<button class="btn btn-sm btn-success dim guiaRechazar"  title="Rechazar indicador" onclick="cambiarEstadoFT(#pk#,'Indicadores.rechazar','Rechazar Indicador');"><i class="fa fa-thumbs-o-down  fa-fw"></i> 
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

<!---<cfoutput>
	<cfdump var="#Session#">
	<cfdump var="#prc#">
	<cfdump var="#application#">
</cfoutput>--->
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
	function cambiarEstadoFT(pkTindicador,accion, textoAccion){
		//alert('ojh');
		if(confirm( textoAccion+'\n¿Desea realizar esta operacion?')){
			console.log('pk: ' + pkTindicador);
			$.post('indicadores/cambiarEstadoFT', {
					accion: accion,
					pkTindicador: pkTindicador
				}, 
				function(data){
					console.log(data);
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
