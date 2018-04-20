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
<cfset numPlantillas = arrayLen(prc.plantillas.datos)>
<cfoutput>
<style>
.dropActive2{    
	border: 2px solid ##1c84c6;	
}
.hoverActive2{
	background-color:##1c84c6;
	color:##1c84c6;
}
</style>
<div class="container">
	<table class= "table">
		<td width="60%">
			<div>
				<label for="nombreAsociacion">Nombre de la asociación:</label><br>
				<div class="input-group gia-guardar-plant">
					<input type="text" class="form-control nombreAsociacion" name="nombreAsociacion" value="#prc.nombres#" id="nombreAsociacion">
					<div class="input-group-btn">
						<br>
						<button type='button' class='btn btn-primary btn-xs dim pull-left ml5 guardar' style="margin-right: 15px"  title='Guardar Asociación' id="bt-guardaAsociacion" name="bt-guardaAsociacion">
							<i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i>
						</button>
					</div>
				</div>
			</div>
		</td>
		<td width="40%">
			<div class="alert alert-info form-group col-md-16 guia-asociacion">
				Los elementos están denotadas por colores que corresponden a la plantilla en la que están contenidos.
				La nomenclatura usada es la siguente:<br>
			<cfloop from="1" to="#numPlantillas#" index="i">
				<span class="badge" style="background-color:###formatBaseN(300-45*i, 16)##formatBaseN(285-30*i, 16)##formatBaseN(260-5*i, 16)#;
					<cfif (i gt 4 ) and (i LTE 6)> color:##ffffff;</cfif>">#prc.plantillas.nombreplantilla[i].nombre#
				</span>
			</cfloop>
			</div>
		</td>
	</table>
	<div style="overflow-x: scroll;" class="guia-Contenedor">
	<table class="table table-bordered ">	
		<tr>
			<cfloop from="1" to="#numPlantillas#" index="i" >
				<td >								
					<table >
						<td ><h4 >Plantilla: <b>#prc.plantillas.nombreplantilla[i].nombre#</b></h4></td>
					</table>	
				</td>
			</cfloop>
		</tr>
		<tr>
			<cfloop from="1" to="#numPlantillas#" index="i" >
				<td>
					<div style="max-height:550px;overflow:auto;width;auto;padding:10px;">
						<div class="contenedorDrop#i#" style="min-height:200px;min-width:150px">
							<cfloop query="#prc.plantillas.datos[i]#">								
								<table class="elementoHijo#i# table table-bordered table-hover elementoHijo" val-pkElementoHijo="#PK_PLANTILLA#" title="#prc.plantillas.nombreplantilla[i].nombre#" id="hijo#PK_PLANTILLA#" style="min-width:350px">	
									<tr>
										<td width="#20*i#%" 
											style="background-color:###formatBaseN(300-45*i, 16)##formatBaseN(285-30*i, 16)##formatBaseN(260-5*i, 16)#;
											<cfif (i gt 4 ) and (i LTE 6)> color:##ffffff;</cfif>">
											#VALORES_PLANTILLA#
										</td>
										<cfif numPlantillas neq i>
										<td height="50px" width="#100-20*i#%">
											<div class="elementoPadre#i# elementoPadre" val-pkElementoPadre="#PK_PLANTILLA#" id="padre#PK_PLANTILLA#" style="height:100%;min-width:200px;">
											</div>
										</td>
										</cfif>    
									</tr>
								</table>
							</cfloop>
						</div>
					</div>
				</td>
			</cfloop>
		</tr>
	</table>
	</div>
</div>	
<script>
<cfloop from="1" to="#numPlantillas#" index="i" >
	$( ".elementoHijo#i#" ).draggable({
		revert: "invalid", 
		containment: ".wrapper-content",
		cursor: "move",

		zIndex:800,
		helper:function(event,ui){
			var element=$("<div style='width:50px;'></div>");
			return element.append($(this).html());
		}
	});

	$(".elementoPadre#i#").droppable({
		accept: " .elementoHijo#i+1#",
		activeClass: "dropActive2",
		hoverClass: "hoverActive2",
		drop: function( event, ui ) {
			$(this).append(ui.draggable);
			ui.draggable.removeClass('col-md-6').addClass('col-md-12');
		}
	});
	$(".contenedorDrop#i#").droppable({
			accept: " .elementoHijo#i#",
			activeClass: "dropActive2",
			hoverClass: "hoverActive2",
	
			drop: function( event, ui ) {
				$(this).append(ui.draggable);
				ui.draggable.removeClass('col-md-6').addClass('col-md-12');
			}
		}); 
</cfloop>       
	$('##bt-guardaAsociacion').click(function(){
		if( nombreAsociacion.value == null || nombreAsociacion.value.length == 0 || /^\s+$/.test(nombreAsociacion.value))
			toastr.error('Error','Nombre en blanco');
		else{
			var asociaciones = [];
			$('.elementoHijo').each(function(){			
				asociado = {
					pkelemento:$(this).attr('val-pkElementoHijo'),
					pkPadre:$(this).parent().attr('val-pkElementoPadre')
				}			
				if(typeof asociado.pkPadre  !== 'undefined'){
					asociaciones.push(asociado);
				}
			});
			var plantSelect = [];
			$('##asociacion').children('.cont-reporte').each(function(){
				plantSelect.push($(this).attr('data-rep-id'));	
			});
			console.log(asociaciones);
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.asociarPlantilla")#</cfoutput>',{
					nombreA: $("##nombreAsociacion").val(),
					plantSelect:JSON.stringify(plantSelect),
					asociaciones:JSON.stringify(asociaciones)
					}, 
				function(data){
					
					alert('Se ha guardado la asociación exitosamente');
					window.location="<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.indexAsociados")#</cfoutput>";
				}
			);
		}    
	});
</script>
</cfoutput>