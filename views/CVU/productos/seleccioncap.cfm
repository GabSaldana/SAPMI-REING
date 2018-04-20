
<cfprocessingdirective pageEncoding="utf-8">
<cfset total_records = prc.opcionesProductos.recordcount>

	<cfset i=0>
	<!--Size = 3 para desktops, Size = 2 para moviles-->
	<cfset size=3>
	<cfset number_of_rows = ceiling(total_records / size)  >
<div>	
	<cfloop index="current" from="1" to="#number_of_rows#" >
		<div class="row" id="opcionProductosCap">
			<cfloop index="x" from= "#i+1#" to="#i+size#" step="1">
				<cfif prc.opcionesProductos.PRODUCTO[x] neq "">

						<div class="col-md-4 col-xs-6">

							<div class="contact-box primary tarjetaProducto tarjetaProductoCap" id_prod="<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" revista="<cfoutput>#prc.opcionesProductos.REVISTAISSN[x]#</cfoutput>">			
								<div class="text-center textoseleccion">
										<div  class="text-center">
												<strong> <cfoutput>#prc.opcionesProductos.PRODUCTO[x]#</cfoutput> </strong>											
										</div>
										<!--div >
											<div class="col-md-2 col-xs-2 pull-right" > 
												<div class="outter "><i class="fa <cfoutput>#prc.opcionesProductos.ICONO[x]#</cfoutput> image-circle"></i></div>   
											</div> 	
										</div-->
								</div>	
								
								<div class= "descProducto" align="center"> 
									<p>
										<cfoutput>#prc.opcionesProductos.DESCRIPCION[x]#</cfoutput>
									</p>
								</div>	
							</div>
						</div>
				</cfif>
				<cfset i=x>
			</cfloop>
		</div>		
	</cfloop>
	
	<div class="<!--- row --->" id="revistaIssnCap">
		<div class="panel panel-primary">
			  <div class="panel-heading">Artículos en el índice de revistas del IPN</div>
			  <div class="panel-body">
			  	<form>
			  		<div class="row">
				  		<div class="col-md-3">
				  			<span class="input-group-addon">ISSN de la revista</span>
				  		</div>
				  		<div class="col-md-3">
	    					<input id="issnCap" type="text" class="form-control" name="msg">
	    				</div>	
	    				<div id="anio_revista" class="form-group col-md-6">
	    					<label class="control-label">Año:</label>
	    					<div class="selectContainer">
	    						<select class="selectpicker" data-style="btn-primary" id="anio_issn" title="Selecciona un año"></select>
	    					</div>
	    				</div>
	    				<!--- <div class="col-md-1"></div> --->
	    			</div>
	    			<div class="row">
	    				<div class="col-md-8"></div>
	    				<div class="col-md-2">				
	    					<button type="button" id="btn-issn-Cancelar" class="btn btn-primary">Cancelar</button>
	    				</div>
	    				<div class="col-md-2">				
	    					<button type="button" id="btn-issn-Cap" class="btn btn-primary">Aceptar</button>
	    				</div>
	    			</div>	
			  	</form>
			  </div>
		</div>	
	</div>	
</div>

<div class="modal inmodal fade" id="modalAnioNuevo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Agregar nuevo año</h4>
            </div>
            <div class="modal-body">
            	<div class="row form-group">
            		<div class="col-md-3"><label>Año: </label></div>
            		<div class="col-md-9"><input class="form-control" type="number" min="1900" max="2100" value="2000" id="nuveoAnioISSN"></div>
            	</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white cancelarNuevoAnio">Cancelar</button>
                <button type="button" class="btn btn-primary guardarNuevoAnio">Guardar</button>
            </div>
        </div>
    </div>
</div>

<script>

	$(document).ready(function() {

		//carga el formulario del nivel de la revista de acuerdo al año seleccionado
		$('body').on('change', '#anio_issn', function(){
			$("#issnPrecargados").val($("#issnCap").val());
			$("#anio_issnPrecargados").val($("#anio_issn option:selected").html());
			if($("#anio_issn option:selected").html() != 'Agregar nuevo año'){
				cargaTabs($("#anio_issn").val(), 0);
			} else {
				$("#modalAnioNuevo").modal('show');
			}			
		});

		$(".cancelarNuevoAnio").on('click', function(){
			$("#modalAnioNuevo").modal('hide');
			$("#anio_issn").selectpicker('deselectAll');
		});

		$(".guardarNuevoAnio").on('click', function(){
			$("#anio_issnPrecargados").val($("#nuveoAnioISSN").val());
			$("#modalAnioNuevo").modal('hide');
			cargaTabs(128, 0);
		});
			
		$("#revistaIssnCap").hide();

		$('.tarjetaProductoCap').click(function(){	
			if($(this).attr('revista') == 1) {
				$("#revistaIssnCap").show();
				$("#anio_revista").hide();
				$("#btn-issn-Cancelar").hide();
				$("#opcionProductosCap").hide();
			} else {			
				cargaTabs($(this).attr('id_prod'), $(this).attr('revista'));
			}		
		});

		$("#btn-issn-Cancelar").click(function(){ 
			$("#anio_revista").hide();
			document.getElementById("issnCap").disabled = false;
			document.getElementById("issnCap").value = "";
			$("#btn-issn-Cancelar").hide();
			$("#btn-issn-Cap").show();
				
		});

		$("#btn-issn-Cap").click(function(){
		
			$("#issnCap").val($("#issnCap").val().replace(/[^a-zA-Z0-9]/g,"").slice(0, 4)+'-'+$("#issnCap").val().replace(/[^a-zA-Z0-9]/g,"").slice(4,8));	// Cambia el valor del issn a un formato 00XX-00XX
			document.getElementById("issnCap").disabled = true;
			
			$.post('<cfoutput>#event.buildLink("CVU.productos.traeTipoRevista")#</cfoutput>', {
				issn: document.getElementById("issnCap").value
			}, function(data){
				if(data.ROWCOUNT==0){
					cargaTabs(127,0);					//Si no existe el ISSN, se manda a elejir entre articulo de revista de nivel f o g
					$("#anio_issnPrecargados").val(''); //Se limpia el input para no precargar datos, ya que no existe el ISSN
				} else {
					$("#anio_revista").show();
					$("#btn-issn-Cancelar").show();
					$("#btn-issn-Cap").hide();
					$('#anio_issn').empty().selectpicker('refresh');				
					for ( var i = 0; i < data.ROWCOUNT; i++ ) {
						$('#anio_issn').append($("<option></option>").attr("value",data.DATA.PRODUCTOA[i]).text(data.DATA.ANIO[i])).selectpicker('refresh');
					}
					$('#anio_issn').append('<option data-icon="glyphicon-plus">Agregar nuevo año</option>').selectpicker('refresh');
						//
				}	
			});	
		});

	});

</script>