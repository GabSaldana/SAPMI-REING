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
	<div class="row">
		<div class="col-md-12">
			<form id="registroForm" class="form-horizontal" role="form">
               	<div class="form-group" style="margin-left:20px">
               		<input type="hidden" id="in-pkFormato" value="0">
					<table>
						<tr id="guiaInsercionFilas">
					    	<td><label>No permitir nuevas filas:</label></td>
					    	<td><div class="onoffswitch" style="margin-left:20px;">
		                        <input type="checkbox" class="onoffswitch-checkbox" id="insercionFilas" value="0" style="display:none;">
		                        <label class="onoffswitch-label" for="insercionFilas">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch" style="height:20px;"></span>
		                        </label>
			                </div></td>
					  	</tr>
					  	<tr id="guiaTotalFinal">
						    <td><label>Calcular la fila total final:</label></td>
						    <td><div class="onoffswitch" style="margin-left:20px">
		                        <input type="checkbox" class="onoffswitch-checkbox" id="totalFinal" value="0" style="display:none;">
		                        <label class="onoffswitch-label" for="totalFinal">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch" style="height:20px;"></span>
		                        </label>
		                    </div></td>
						</tr>
						<tr id="guiaAcumulado">
						    <td><label>Generar reporte acumulado:</label></td>
						    <td><div class="onoffswitch" style="margin-left:20px">
		                        <input type="checkbox" class="onoffswitch-checkbox" id="acumulado" value="0" style="display:none;">
		                        <label class="onoffswitch-label" for="acumulado">
		                            <span class="onoffswitch-inner"></span>
		                            <span class="onoffswitch-switch" style="height:20px;"></span>
		                        </label>
		                    </div></td>
						</tr>						
					</table>
				</div>
	        </form>
		</div>
	</div>


<script>

	function cambiaConfigGral(){
		url = "<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.cambiaConfigGral")#</cfoutput>";
		$.post(url, {
			pkFormato: $("#in-pkFormato").val(),
			insercionFilas: $("#insercionFilas").val(),
			totalFinal: $("#totalFinal").val(),
			acumulado: $("#acumulado").val()
			}, function(data){
				if(data > 0){
					toastr.success('actualizadas','Configuraciones');
				} else{
					toastr.error('las configuraciones','Error al actualiar');
				}				
			}
	    );
	}

	$(document).ready(function () {
		$("#in-pkFormato").val(<cfoutput>#prc.Formato.PKFORMATO#</cfoutput>);
		$("#insercionFilas").val(<cfoutput>#prc.Formato.FIJARFILAS#</cfoutput>);
		$("#totalFinal").val(<cfoutput>#prc.Formato.VERTOTALES#</cfoutput>);
		$("#acumulado").val(<cfoutput>#prc.Formato.ACUMULADO#</cfoutput>);

		<cfif (prc.Formato.FIJARFILAS gt 0) and (prc.Formato.FIJARFILAS neq '')> 
			$("#insercionFilas").attr("checked","");
		</cfif>

		<cfif (prc.Formato.VERTOTALES gt 0) and (prc.Formato.VERTOTALES neq '')> 
			$("#totalFinal").attr("checked","");
		</cfif>

		<cfif (prc.Formato.ACUMULADO eq 1)> 
			$("#acumulado").attr("checked","");
		</cfif>
		
	 	$("#insercionFilas").click(function(){
 			if ($(this).val() == 0) {
 				$(this).val(1);
 			} else if ($(this).val() == 1) {
 				$(this).val(0);
 			}
 			cambiaConfigGral();
 		});
 		
 		$("#totalFinal").click(function(){
 			if ($(this).val() == 0) {
 				$(this).val(1);
 			} else if ($(this).val() == 1) {
 				$(this).val(0);
 			}
 			cambiaConfigGral();
 		});

 		$("#acumulado").click(function(){
 			if ($(this).val() == 0) {
 				$(this).val(1);
 			} else if ($(this).val() == 1) {
 				$(this).val(0);
 			}
 			cambiaConfigGral();
 		});
	});
</script>
