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

<cfset formato =  prc.formato>

<cfprocessingdirective pageEncoding="utf-8">
	<div class="row">
		<div class="col-md-12">
			<form id="registroForm" class="form-horizontal" role="form">	
				<fieldset>
					<div class="form-group">
						<label for="nombreFormato" class="col-md-2 control-label">Formato:</label>
						<div class="col-md-10">  
							<input type="text" id="in-nombreFormato" name="nombreFormato" class="required form-control required nombreFormato" value="<cfoutput>#formato.getNombre()#</cfoutput>"/>
						</div>
					</div>

					<div class="form-group">
						<label for="claveFormato" class="col-md-2 control-label">Clave:</label>
						<div class="col-md-4">	 
							<div class="input-group" id="claveFormato">
								<span class="input-group-addon">SGE-EV-</span>
								<input type="text" id="in-claveFormato" name="claveFormato" class="required form-control" value="<cfoutput>#mid(formato.getClave(),8,100) #</cfoutput>" />							
							</div>
						</div>
						<label for="vigencia" class="col-md-2 control-label">Vigencia:</label>  
						<div class="date col-md-4">
							<div class="input-group" id="vigenciaFormato">
								<input type="text" class="required form-control" id="in-vigencia" readonly value="<cfoutput>#dateFormat(formato.getVigencia(),'dd/mm/yyyy') #</cfoutput>">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="clasificacion" class="col-md-2 control-label">Clasificación:</label>  
						<div class="col-md-4">          	
							<select class="required form-control clasificacionFormato" id="sl-clasificacion" name="selectClasif" onchange="selectInClasif()">
								<option value="0">Seleccione una opción</option>								
								<cfset total_records = prc.clasif.recordcount/>
								<cfloop index="x" from="1" to="#total_records#">
									<cfoutput>
										<cfif prc.clasif.cve[x] eq formato.getclasificacion()>
											<option value="#prc.clasif.cve[x]#" selected="selected">#prc.clasif.nombre[x]#</option>
										<cfelse>
											<option value="#prc.clasif.cve[x]#">#prc.clasif.nombre[x]#</option>
										</cfif>
									</cfoutput>
								</cfloop>
							</select>
						</div>
						<label for="area" class="col-md-2 control-label" >Área:</label>  
						<div class="col-md-4">              
							<select class="required form-control areaFormato" id="sl-area" name="selectArea" disabled>	
									<cfif formato.getUR() neq ''>	
										<cfoutput>		
											<option value="#formato.getUR()#">#formato.getURnombre()#</option>
										</cfoutput>
									<cfelse>														
										<option value="0">Seleccione una opción</option>	
									</cfif>							
							</select> 
						</div>     
					</div>

					<div class="form-group">
						<label for="nombre"  class="col-md-2 control-label">Instrucciones de Llenado:</label>
						<div class="col-md-10">  
							<textarea type="text" id="descripcion" name="inText" class="form-control instruccionFormato" placeholder="Instrucciones de Llenado"><cfoutput>#formato.getinstrucciones()#</cfoutput></textarea>
						</div>
					</div>
				</fieldset>        
			</form>
		</div>
	</div>	

	<script>

		function actualizar(){			
			var pkFormato = $('#in-formatos').val();
			var claveFormato = 'SGE-EV-'+$('#in-claveFormato').val();
			var nombreFormato = $('#in-nombreFormato').val();
			var vigenciaFormato = $('#in-vigencia').val();
			var areaFormato = $('#sl-area').find(":selected").val();
			var instrucciones = $("#descripcion").val();
			var estado;			
			
				$.ajax({
				type:"POST",
				async:false,				
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.actualizarFormato")#</cfoutput>",
				data:{
					pkFormato: pkFormato,
					claveFormato: claveFormato,
					nombreFormato: nombreFormato,
					vigenciaFormato: vigenciaFormato,
					areaFormato: areaFormato,
					instrucciones: instrucciones
					},
					success:function(data){
						if(data > 0){														
							estado = true;				
						}
						else{							
							toastr.error('Hubo un problema en la actualización','Error');
							estado = false;
						}
					}
			});
				return estado;
		}			

			<!---
* Fecha      : Enero 2017
* Autor      : Daniel Memije
* Descripcion: Carga las UR con la clasificacion dada
* --->

function selectInClasif(){
    pkClasif = $("#sl-clasificacion").find(":selected").val();
	
    if(pkClasif != "0"){
		$("#sl-area").prop('disabled',false);
    }
    else{
		$("#sl-area").prop('disabled', true);
    }

    $.post('/index.cfm/formatosTrimestrales/configuracion/getUR',{
        pkClasif : pkClasif
        }, function(data){
            $('#sl-area').html('<option value="0">Seleccione una opción</option>');
            for(var i = 0; i < data.ROWCOUNT; i++){
                $('#sl-area')
                .append($("<option></option>")
                .attr("value",data.DATA.CVE[i])
                .text(data.DATA.NOMBRE[i]));
            }
    	}); 
}					
			



		$(document).ready(function () {

			toastr.options.progressBar = true;
	
			$('.date').datepicker({
				format: 'dd/mm/yyyy',
				language: 'es',
				calendarWeeks: true,
				autoclose: true,
				startDate: '01/01/2015',
				todayHighlight: true				
			}).on("changeDate", function (e) {
    			if($('#in-formatos').val() != 0){
    				
						if(actualizar()){
							toastr.success('Fecha actualizada', 'Guardado');
						}					
				}
			});

			$('#descripcion').change(function() {
				if($('#in-formatos').val() != 0){
					if($.trim(this.value).length){
						if(actualizar()){
							toastr.success('Instrucciones Actualizadas', 'Guardado');
						}
					}
					else{
						toastr.error('El campo no debe estar vacio','Error');
					}							
				}			
			});

			$('#in-nombreFormato').change(function(){
				if($('#in-formatos').val() != 0){
					if($.trim(this.value).length){
						if(actualizar()){
							toastr.success('Nombre actualizado', 'Guardado');
						}
					}
					else{
						toastr.error('El campo no debe estar vacio','Error');
					}							
				}				
			})

			<!---
			$('#in-vigencia').change(function(){
				if($('#in-formatos').val() != 0){
					toastr.success('Vigencia actualizada', 'Guardado');
				}
			})
			--->

			$('#in-claveFormato').change(function(){
				if($('#in-formatos').val() != 0){
					if($.trim(this.value).length){
						if(actualizar()){
							toastr.success('Clave actualizada', 'Guardado');
						}
					}
					else{
						toastr.error('El campo no debe estar vacio','Error');
					}					
				}
			})

			$('#sl-area').change(function(){
				if($('#in-formatos').val() != 0){
					if($.trim(this.value).length){
						if(actualizar()){
							toastr.success('Area actualizada', 'Guardado');
						}
					}
					else{
						toastr.error('El campo no debe estar vacio','Error');
					}					
				}
			})									
		});

	</script>	