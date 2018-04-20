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
	<cfset plantillas = prc.plantillas>
	<cfset tiposDato = prc.tiposDato>
	<cfset columna = prc.columna>
	<cfset sumandos = prc.sumandos>	
	<div class="row">
		<div class="col-md-12">
			<div id="registroForm" class="form-vertical" role="form">
				<br>
				<div class="form-group "  id="guiaColumna">
					<label for="nombre">Nombre:</label>
					<input type="text" id="nombre" name="inNombreColumna" class="form-control" placeholder="<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>" value="<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>"/>
				</div>

				<div class="form-group"  id="guiaTipo">
					<label for="inTipoColumna">Tipo de Dato:</label>

					<div class="input-group" style="width: 100%"  id="contenedor">

						<select class="form-control" name="inTipoColumna" id="inTipoColumna">
							<option value="0">Seleccione una opción</option>
							<cfset total_records = tiposDato.recordcount/>
							<cfloop index="x" from="1" to="#total_records#">
								<cfoutput>
									<cfif tiposDato.cve[x] eq columna.getTIPO_DATO()>
										<option selected value="#tiposDato.cve[x]#">#tiposDato.cve[x]# - #tiposDato.nombre[x]#</option>
									<cfelse>
										<option value="#tiposDato.cve[x]#">#tiposDato.cve[x]# - #tiposDato.nombre[x]#</option>
									</cfif>
									</cfoutput>
								</cfloop>
							</select>

							<cfif columna.getType() eq 'dropdown'>
								<span class="input-group-btn" id="catalogo">
									<span class="btn btn-info fa fa-search" title="Seleccionar Plantillas"></span>
								</span>

								<cfelseif columna.getTIPO_DATO() eq 5>
									<span class="input-group-btn"  id="verSumandos">
										<span class="btn btn-info fa fa-plus" title="Configurar Sumatorias" ></span>
									</span>

								</cfif>
							</div>
					<!---
	                <cfif columna.getType() eq 'dropdown'>
		                <div class="input-group">
		                   	<input type="text" id="tipo" name="inTipoColumna" class="form-control" placeholder="<cfoutput>#columna.getTIPO_DATONOMBRE()#</cfoutput>" value="<cfoutput>#columna.getTIPO_DATONOMBRE()#</cfoutput>"/>
		                	<span class="input-group-addon">
	                        	<span class="btn btn-info fa fa-search catalogo" id="catalogo"></span>
	                       	</span>
						</div>
					<cfelseif columna.getTIPO_DATO() eq 5>
					     <div class="input-group">
		                   	<input type="text" id="tipo" name="inTipoColumna" class="form-control" placeholder="<cfoutput>#columna.getTIPO_DATONOMBRE()#</cfoutput>" value="<cfoutput>#columna.getTIPO_DATONOMBRE()#</cfoutput>"/>
		                	<span class="input-group-addon"  id="verSumandos">
	                        	<span title="Configurar Sumatorias" class="fa fa-plus"></span>
	                       	</span>
						</div>
					<cfelse>
						<input type="text" id="tipo" name="inTipoColumna" class="form-control" placeholder="<cfoutput>#columna.getTIPO_DATONOMBRE()#</cfoutput>" value="<cfoutput>#columna.getTIPO_DATONOMBRE()#</cfoutput>"/>
					</cfif>   --->
				</div>
				<br>
				<div class="form-group "  id="guiaAyuda">
					<label for="descripcionColumna">Texto de Ayuda:</label>
					<textarea type="text" id="descripcionColumna" name="inText" class="form-control" placeholder="Instrucciones de Llenado"><cfoutput>#columna.getdescripcion()#</cfoutput></textarea>
				</div>
				
				<div class="form-group " id="guiaBloquearCaptura">
					<div class="checkbox">
						<cfoutput>
							<cfif columna.getBLOQUEADA_EDO() gt 0>
								<label><input type="checkbox" id="bloqueada" name="bloqueada" checked>Bloquear para Captura</label>
							<cfelse>
								<label><input type="checkbox" id="bloqueada" name="bloqueada">Bloquear para Captura</label>
							</cfif>
						</cfoutput>											
					</div>
				</div>

				<div class="form-group" id="guiaReferencia">
					<div class="checkbox">
						<cfoutput>
							<cfif columna.getREFERENCIA() eq 1>
								<label><input type="checkbox" id="referencia" name="referencia" checked>Columna referencia</label>
							<cfelse>
								<label><input type="checkbox" id="referencia" name="referencia" unchecked>Columna referencia</label>
							</cfif>
						</cfoutput>
					</div>
				</div>
				
				<br>
				<hr class="hr-line-solid">
				<br>
				<label>Configuración de Subtotales</label>
				<div class="form-group " id="guiaCalcularTotales">
					<div class="checkbox">
						<cfoutput>
							<cfif columna.getCOLUMNATOTAL_EDO() eq columna.getpk_Columna()>
								<label><input type="checkbox" id="calcularTotales" name="calcularTotales" checked>Calcular SubTotales para cada grupo de valores en esta columna</label>
							<cfelse>
								<label><input type="checkbox" id="calcularTotales" name="calcularTotales">Calcular SubTotales para cada grupo de valores en esta columna</label>
							</cfif>
						</cfoutput>						
					</div>
				</div>


				<div class="form-group " id="guiaTotal">
					<div class="checkbox">
						<cfoutput>
							<cfif columna.getCOLUMNATOTALFINAL_EDO() eq columna.getpk_Columna()>
								<label><input type="checkbox" id="istotal" name="istotal" checked />Es la columna de Total Final</label>
							<cfelse>
								<label><input type="checkbox" id="istotal" name="istotal" />Es la columna de Total Final</label>
							</cfif>
						</cfoutput>						
					</div>
				</div>
				
				<div class="form-group" id="guiaMostrarSuma">
					<div class="checkbox clearfix">
						<label><input type="hidden" id="seccionado" name="seccionado" hidden="hidden">Seleccionar Plantilla para seccionar por esta columna</label>
						<span class="pull-left">
							<span class="btn btn-xs btn-info" id="seccionesAnterioresCheck">
								<span class="fa fa-search"></span>
							</span>
						</span>
					</div>
				</div>
				<br>
				<hr class="hr-line-solid">
				<br>
				<label>Información Inicial del reporte para cada trimestre</label>

				
				<div class="form-group "  id="guiaCopiarColumna">
					<div class="checkbox">
						<cfoutput>
							<cfif columna.getCOPIABLE_EDO() gt 0>
								<label><input type="checkbox" id="transportable" name="transportable" checked />Copiar esta columna para cada trimestre</label>
							<cfelse>
								<label><input type="checkbox" id="transportable" name="transportable"/>Copiar esta columna para cada trimestre</label>
							</cfif>
						</cfoutput>						
					</div>
				</div>

				<!--- <hr class="hr-line-solid"> --->				


				<div class="form-group"  id="guiaPreviosTrimestres">
					<div class="checkbox clearfix">
						<label><input type="hidden" id="trimAnterioresCheck" name="trimAnterioresCheck" >Seleccionar columna de Origen</label>
						<span class="pull-left">
							<span class="btn btn-xs btn-info" id="trimAnteriores">
								<span class="fa fa-share"></span>
							</span>
						</span>
					</div>
				</div>
				
				<cfif columna.getType() eq 'dropdown'>
					<hr>
					<br>
					<label>Dependencia de Catalogos</label>
					<div class="form-group">
						<div class="checkbox clearfix">
							<label><input type="hidden" id="catalogoOrigenCheck" name="catalogoOrigenCheck" >Seleccionar columna de Catalogo de Origen</label>
							<span class="pull-left">
								<span class="btn btn-xs btn-info" id="catalogoOrigen">
									<span class="fa fa-exchange"></span>
								</span>
							</span>
						</div>
					</div>
				</cfif>

				<div class="form-group" hidden >
					<div class="checkbox">						
						<label><input type="checkbox" id="capturaDependencias" name="capturaDependencias">Capturada por la dependencia</label>
					</div>
				</div>				
				
				<div class="form-group " hidden>
					<label>Tipo de Informacion:</label>
					<div class="radio">
						<label><input type="radio" id="metrica" name="tipo"> Metrica</label>
					</div>
					<div class="radio">
						<label><input type="radio" id="dimension" name="tipo"> Dimensión</label>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="modal-Catalogo" class="modal large inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-keyboard="false" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times"></span></button>
					<h4 class="modal-title">Elementos del catalogo</h4>
				</div>
				<div class="modal-body">

				<label>Plantilla actual:</label>
				<cfoutput>
					<cfif columna.getpk_plantilla() eq 0>
						<span>Sin Plantilla</span>
					<cfelse>
						<span>#columna.getnombre_plantilla()#</span>
					</cfif>
				</cfoutput>

				<hr class="hr-line-solid">

				<label for="inPlantillas">Plantilla</label>
					<select class="form-control" name="inPlantillas" id="inPlantillas">
						<option value="0">Seleccione una opción</option>
						<cfset total_records = plantillas.recordcount/>
						<cfloop index="x" from="1" to="#total_records#">
							<cfoutput>
							<cfif plantillas.cve[x] eq columna.getpk_plantilla()>
								<option selected value="#plantillas.cve[x]#">#plantillas.nombre[x]#</option>
							<cfelse>
								<option value="#plantillas.cve[x]#">#plantillas.nombre[x]#</option>
							</cfif>
						</cfoutput>
						</cfloop>
					</select>

					<hr class="hr-line-solid">


					<div class="list-group" id="contenedorlista">
						<cfif columna.getType()eq 'dropdown'>
							<cfloop array="#columna.getSortedSource()#" index="i">
							<div class="list-group-item clearfix"><span class="elemento"><cfoutput>#i#</cfoutput></span>
								<span class="pull-right">
									<button class="btn btn-xs btn-danger eliminar">
										<span class="fa fa-trash"></span>
									</button>
								</span>
							</div>
							</cfloop>
						</cfif>
					</div>
					<button type="button" class="btn btn-block btn-primary" id="anadirElementoCatalogo"><span class="fa fa-plus"></span> Añadir Elemento</button>


				</div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal" class="btn btn-success" id="guardarCatalogo"><span class="fa fa-save"></span> Guardar</button>
					<button type="button" data-dismiss="modal" class="btn btn-danger"><span class="fa fa-times"></span> Cancelar</button>
				</div>
			</div>
		</div>
	</div>

<div id="modal-Sumandos" class="modal large inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times"></span></button>
            	<h4 class="modal-title">Seleccion de Sumandos</h4>
            </div>
            <div class="modal-body">
				<div id="divSumandos"></div>
			</div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-default"><span class="fa fa-times"></span> Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div id="modal-trimAnteriores" class="modal large inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times"></span></button>
            	<h4 class="modal-title">Información de semestres previos</h4>
            </div>
            <div class="modal-body">
            	<div id="trimestresAnteriores">
            		
            	</div>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-danger"><span class="fa fa-times"></span> Cancelar</button>
            </div>
        </div>
    </div>
</div>

<div id="modal-catalogoOrigen" class="modal large inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times"></span></button>
            	<h4 class="modal-title">Catálogo de Origen</h4>
            </div>
            <div class="modal-body">
            	<div id="tablaCatalogoOrigen">
            		
            	</div>
            </div>
            <div class="modal-footer">
                <button id="cerrarCatalogoOrigen" type="button" data-dismiss="modal" class="btn btn-danger"><span class="fa fa-times"></span> Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div id="modal-SumaSecciones" class="modal large inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times"></span></button>
				<h4 class="modal-title">Secciones</h4>
			</div>
			<div class="modal-body">
				<cfif columna.getplantillaSeccion() eq 0>
					Sin plantilla para sección.
				<cfelse>
					<label>Plantilla para la sección actual:</label>
					<cfoutput>#columna.getplantillaseccion()#</cfoutput>
				</cfif>
				<hr class="hr-line-solid">
				<div id="SumaSecciones">					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" data-dismiss="modal" class="btn btn-danger"><span class="fa fa-times"></span> Cancelar</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function () {

	$("#cerrarCatalogoOrigen").click(function(event) {
		$(".modal-backdrop").remove();
	});

	var altura = $(window).height() - 155; //value corresponding to the modal heading + footer
			$('.modal .modal-body').css('overflow-y', 'auto');
			$('.modal .modal-body').css('max-height', $(window).height() * 0.7);

		toastr.options.progressBar = true;

		var elementos = 1;

		$('#descripcionColumna').change(function() {						
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.actualizarDescripcionColumna")#</cfoutput>",
				data:{									
					pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
					descripcion: $.trim($(this).val())
				},
				success:function(data){
					if(data == <cfoutput>#columna.getpk_columna()#</cfoutput>){
						toastr.success('Actualizada','Columna <cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>');						
						refrescarColumna();
					}else{
						toastr.error('Error','de actualización');
					}
				}
			});			
		});

		$('#seccionesAnterioresCheck').click(function(event) {			
			event.stopPropagation();
			$('#modal-SumaSecciones').modal('show');
				$.ajax({
					type:"POST",
					async:false,
					url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.getAsociacionPlantillas")#</cfoutput>",
					data:{
						pkPlantilla: <cfoutput>#columna.getpk_plantilla()#</cfoutput>,						
					},
					success:function(dataAsoc){						
						for(var i = 0; i<dataAsoc.ROWCOUNT;i++){							

							var html ='<div class="row"><div class="panel panel-primary"><div class="panel-heading clearfix"><h3 class="panel-title"><a>'+dataAsoc.DATA.NOMBRE[i]+'</a></h3></div><div class="panel-body" id="sumBodyContainer'+i+'"></div></div></div>';
							$("#SumaSecciones").append(html);							
							
							$.ajax({
								type:"POST",
								async:false,
								url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.getPlantillasAsociadas")#</cfoutput>",
								data:{									
									pkAsociacion: dataAsoc.DATA.CVE[i]
								},
								success:function(data){									
									for(var x = 0; x < data.ROWCOUNT; x++){
										if(x == 0){
											if(data.ROWCOUNT > 1){
												$('#sumBodyContainer'+i).append('<div class="panel panel-primary"><div class="panel-body clearfix" id="hijoContainer'+x+'_'+i+'"><label>'+data.DATA.NOMBRE[x]+'</label><span class="pull-right"><span class="btn btn-xs btn-info seleccionar" data-dismiss="modal" data-asoc="'+dataAsoc.DATA.CVE[i]+'" data-pkp="'+data.DATA.PKPLANTILLA[x]+'"><span class="fa fa-check"></span> Seleccionar Plantilla</span></span><hr></div></div>');
											}else{
												$('#sumBodyContainer'+i).append('<div class="panel panel-primary"><div class="panel-body clearfix" id="hijoContainer'+x+'_'+i+'"><label>'+data.DATA.NOMBRE[x]+'</label><span class="pull-right"><span class="btn btn-xs btn-info seleccionar" data-dismiss="modal" data-asoc="'+dataAsoc.DATA.CVE[i]+'" data-pkp="'+data.DATA.PKPLANTILLA[x]+'"><span class="fa fa-check"></span> Seleccionar Plantilla</span></span></div></div>');
											}											
										}else if(x == data.ROWCOUNT-1){
											$('#hijoContainer'+(x-1)+'_'+i).append('<div class="panel panel-primary"><div class="panel-body clearfix" id="hijoContainer'+x+'_'+i+'"><label>'+data.DATA.NOMBRE[x]+'</label><span class="pull-right"><span class="btn btn-xs btn-info seleccionar" data-dismiss="modal" data-asoc="'+dataAsoc.DATA.CVE[i]+'" data-pkp="'+data.DATA.PKPLANTILLA[x]+'"><span class="fa fa-check"></span> Seleccionar Plantilla</span></span></div></div>');
										}else{
											$('#hijoContainer'+(x-1)+'_'+i).append('<div class="panel panel-primary"><div class="panel-body clearfix" id="hijoContainer'+x+'_'+i+'"><label>'+data.DATA.NOMBRE[x]+'</label><span class="pull-right"><span class="btn btn-xs btn-info seleccionar" data-dismiss="modal" data-asoc="'+dataAsoc.DATA.CVE[i]+'" data-pkp="'+data.DATA.PKPLANTILLA[x]+'"><span class="fa fa-check"></span> Seleccionar Plantilla</span></span><hr></div></div>');
										}															
									}																			
								}
							});
						}													
					}
				});
		});

		$('#SumaSecciones').on('click', '.seleccionar', function() {
					
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.registrarSumaSecciones")#</cfoutput>",
				data:{									
					pkFormato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
					pkPlantilla: $(this).data('pkp'),
					pkColumna: <cfoutput>#columna.getpk_Columna()#</cfoutput>,
					pkAsociacion: $(this).data('asoc')
				},
				success:function(data){									
					toastr.success('Seleccionada','Plantilla');
				}
			});
			
		});

		$("#guardarCatalogo").click(function(event){

			event.stopPropagation();

			var arr = [];
			arr = $(".elemento").map(function(){
				return this.innerHTML;
			});

			console.log(JSON.stringify(arr.get()));

			if($("#inPlantillas").val() != 0){
				$.ajax({
					type:"POST",
					async:false,
					url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.guardarPlantillaColumna")#</cfoutput>",
					data:{
						pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
						pkPlantilla: $('#inPlantillas').val()
					},
					success:function(data){
					}
				});
			}

			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.guardarElementosCatalogo")#</cfoutput>",
				data:{
					pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
					elemCatalogo: JSON.stringify(arr.get())
				},
				success:function(data){
					toastr.success('Guardado','Catalogo');
					$('#modal-Catalogo').modal('hide');
					$('.modal-backdrop').remove();
					refrescarColumna();
					cargarTablap3();
				}
			});

		});

		$("#anadirElementoCatalogo").click(function(){
			var html = $('<div class="list-group-item clearfix"><input class="inputelementoNuevo form-control" type="text"></div>');
			$('#contenedorlista').append(html);
		});

		$("#contenedorlista").on('change', '.inputelementoNuevo', function(){
			var res = $(this).val();
			if(res.trim()){
				var html = $('<div class="list-group-item clearfix" id="elemento'+elementos+'"><span class="elemento">'+res+'</span><span class="pull-right"><button class="btn btn-xs btn-danger eliminar "><span class="fa fa-trash"></span></button></span></div>');
				$(this).parent().remove();
				$('#contenedorlista').append(html);
			elementos++;
			}else{
				toastr.error('Introduzca un nombre valido','Nombre Vacio');
			}
		});

		$("#contenedorlista").on('click', '.eliminar', function(){
			$(this).closest('div').slideUp('normal',function(){
				$(this).closest('div').remove();
				elementos--;
			});
		});


		$('#inPlantillas').change(function(){
			

			var pkPlantilla = $(this).val();
			$.ajax({
					type:"POST",
					async:false,
					url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.getElementosPlantilla")#</cfoutput>",
					data:{
						pkPlantilla: pkPlantilla
					},
					success:function(data){
						$('#contenedorlista').html('');
						for(elementos = 1; elementos<=data.ROWCOUNT; elementos++){
							var html = $('<div class="list-group-item clearfix" id="elemento'+elementos+'"><span class="elemento">'+data.DATA.NOMBRE[elementos-1]+'</span><span class="pull-right"><button class="btn btn-xs btn-danger eliminar"><span class="fa fa-trash"></span></button></span></div>');
							$('#contenedorlista').append(html);
					}
				}
			});
		});

		$('#inTipoColumna').change(function(){

			var pkTipoDato = $(this).val();

			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.actualizarTipoDato")#</cfoutput>",
				data:{
					pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
					pkTipoDato: pkTipoDato
				},
				success:function(data){
					toastr.success('Guardado','Tipo de Dato');
					refrescarColumna();
					cargarTablap3();
					$('.modal-backdrop').remove();
				}
			});
		});

		$('#catalogo').click(function(){
			$('#modal-Catalogo').modal('show');
		});

		$('#nombre').change(function() {			
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.actualizarNombreColumna")#</cfoutput>",
				data:{
					pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
					nombre: $.trim($(this).val())
				},
				success:function(data){
					toastr.success('Guardado','Nombre');
					refrescarColumna();
					cargarTablap3();
					$('.modal-backdrop').remove();
				}
			});				
		});



	$('#verSumandos').click(function(){
		$('#divSumandos').html('');
		$('#modal-Sumandos').modal('show');
		verSumandos()
	});

	$("#catalogoOrigen").click(function(){
		catalogoOrigen();
		$("#modal-catalogoOrigen").modal('show');
	});

	$('#trimAnteriores').click(function(){
		trimestresAnteriores();
		$('#modal-trimAnteriores').modal('show');
	});

	$('#modal-Catalogo').on('hidden.bs.modal', function(){
		$('.modal-backdrop').remove();
		refrescarColumna();
	});

	$('#modal-Sumandos').on('hidden.bs.modal', function(){
		$('.modal-backdrop').remove();
		refrescarColumna();
	});

	$('#modal-SumaSecciones').on('hidden.bs.modal', function(){
		$('.modal-backdrop').remove();
		refrescarColumna();
	});


	$('#capturaDependencias').change(function() {
		if(this.checked) {
			toastr.success('Check');
		}
		else{
			toastr.success('Uncheck');
		}
	});

	$('#bloqueada').change(function() {
		if(this.checked) {
			bloquearparaCaptura(1);
		}
		else{
			bloquearparaCaptura(0);
		}
	});

	$('#referencia').change(function() {
		if(this.checked) {
			columnaReferencia(1);
		}
		else{
			columnaReferencia(0);
		}
	});

	$('#transportable').change(function() {
		if(this.checked) {
			setCopiableTrimestre(1);
		}
		else{
			setCopiableTrimestre(0);
		}
	});

	$('#calcularTotales').change(function() {
		if(this.checked) {
			setCalcularTotales(1);
		}
		else{
			setCalcularTotales(0);
		}
	});


	$('#istotal').change(function() {
		if(this.checked) {
			setCalcularTotalFinal(1);
		}
		else{
			setCalcularTotalFinal(0);
		}
	});
});

	function refrescarColumna(){
		cargarVistaConfiguracionCol(1,<cfoutput>#columna.getpk_columna()#</cfoutput>,2);		
	}

	function catalogoOrigen(){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.vistaCatalogoOrigen")#</cfoutput>', {
			fila: <cfoutput>#columna.getNivel()#</cfoutput>,
			columna: <cfoutput>#columna.getpk_Columna()#</cfoutput>,
			formato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
			}, function(data){
				$('#tablaCatalogoOrigen').html(data);
			}
		);		
	}

function verSumandos(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.getVistaSumandos")#</cfoutput>', {
			fila:<cfoutput>#columna.getNivel()#</cfoutput>,
			columna: <cfoutput>#columna.getpk_Columna()#</cfoutput>,
			formato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
			},
			function(data){
				$('#divSumandos').html( data );
			}
		);
}
<!---
* Fecha creación: Enero de 2017
* @author: SGS
* Descripcion: Crea la vista del modal informacion de semestres previos
--->
function trimestresAnteriores(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.vistaTrimAnteriores")#</cfoutput>', {
		fila: <cfoutput>#columna.getNivel()#</cfoutput>,
		columna: <cfoutput>#columna.getpk_Columna()#</cfoutput>,
		formato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
		}, function(data){
			$('#trimestresAnteriores').html(data);
		}
	);
}

	function bloquearparaCaptura(bloqueada){

		$.ajax({
			type:"POST",
			async:false,
			url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.bloquearparaCaptura")#</cfoutput>",
			data:{
				pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
				bloqueada: parseInt(bloqueada)
			},
			success:function(data){
				if(bloqueada && data == <cfoutput>#columna.getpk_columna()#</cfoutput>){
					toastr.success('Bloqueada para captura','Columna');
					cargarTablap3();													//A.B.J.M. Para que se vean reflejados los cambios de bloqueo de columnas
				}else if(data == <cfoutput>#columna.getpk_columna()#</cfoutput>){
					toastr.success('Desbloqueada','Columna');
					cargarTablap3();													//A.B.J.M. Para que se vean reflejados los cambios de desbloqueo de columnas
				}else{
					toastr.error('Hubo un error','Error');
				}
			}
		});
	}



	function columnaReferencia(referencia){

		$.ajax({
			type:"POST",
			async:false,
			url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.columnaReferencia")#</cfoutput>",
			data:{
				pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
				referencia: parseInt(referencia)
			},
			success:function(data){
				if(data > 0 && referencia == 1){
					toastr.success('establecida como referencia','Columna');
				}else if(data > 0 && referencia == 0){
					toastr.success('desestablecida como referencia','Columna');
				}else{
					toastr.error('Hubo un error','Error')
				}
			}
		});
	}


	function setCopiableTrimestre(copiable){
		$.ajax({
			type:"POST",
			async:false,
			url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.setCopiableTrimestre")#</cfoutput>",
			data:{
				pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>,
				copiable: parseInt(copiable)
			},
			success:function(data){
				if(copiable && data == <cfoutput>#columna.getpk_columna()#</cfoutput>){
					toastr.success('Copiable','Columna');
				}else if(data == <cfoutput>#columna.getpk_columna()#</cfoutput>){
					toastr.success('No Copiable','Columna');
				}else{
					toastr.error('Hubo un error','Error')
				}
			}
		});
	}

	function setCalcularTotales(total){

		if (total) {
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.setCalcularTotales")#</cfoutput>",
				data:{
					pkFormato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
					pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>
				},
				success:function(data){
					if(data == <cfoutput>#columna.getpk_Formato()#</cfoutput>){
						toastr.success('Calcular Totales','Columna');
					}else{
						toastr.error('Hubo un error','Error')
					}
				}
			});	
		} else {
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.setCalcularTotales")#</cfoutput>",
				data:{
					pkFormato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
					pkColumna: parseInt(0)
				},
				success:function(data){
					if(data == <cfoutput>#columna.getpk_Formato()#</cfoutput>){
						toastr.success('No Calcular Totales','Columna');
					}else{
						toastr.error('Hubo un error','Error')
					}
				}
			});				
		}		
	}

	function setCalcularTotalFinal(totalFinal){

		if (totalFinal) {
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.setCalcularTotalFinal")#</cfoutput>",
				data:{
					pkFormato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
					pkColumna: <cfoutput>#columna.getpk_columna()#</cfoutput>
				},
				success:function(data){
					if(data == <cfoutput>#columna.getpk_Formato()#</cfoutput>){
						toastr.success('Calcular Total Final','Columna');
					}else{
						toastr.error('Hubo un error','Error')
					}
				}
			});
		} else {
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.setCalcularTotalFinal")#</cfoutput>",
				data:{
					pkFormato: <cfoutput>#columna.getpk_Formato()#</cfoutput>,
					pkColumna: parseInt(0)
				},
				success:function(data){
					if(data == <cfoutput>#columna.getpk_Formato()#</cfoutput>){
						toastr.success('No Calcular Total Final','Columna');
					}else{
						toastr.error('Hubo un error','Error')
					}
				}
			});
		}		
	}

</script>
