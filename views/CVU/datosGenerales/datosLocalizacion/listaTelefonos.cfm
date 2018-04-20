<cfprocessingdirective pageEncoding="utf-8">

<style type="text/css">
	.tabcontrol > .content > .body ul > li {
    display: block !important;
	}	
</style>

<cfoutput>
	<h2>Teléfonos Registrados</h2>
	<cfif NOT prc.telefonos.recordcount>
		<div id="tbl_telTabla">
			No se encontraron teléfonos registrados.
		</div>
	<cfelse>
		<table id="tbl_telTabla" class="table table-hover">
			<thead>
				<tr>				
					<th>LADA</th>
					<th>TELÉFONO</th>
					<th>EXTENSIÓN</th>
					<th>ACCIÓN</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="#prc.telefonos#">
					<tr>				
						<td>#LADA#</td>
						<td>#TELEFONO#</td>
						<td>#EXTENSION#</td>
						<td><div onclick="eliminarTelefono(#PK_TELEFONO#)" class="btn btn-xs btn-danger"><i class="fa fa-trash"></i></div></td>
					</tr>
				</cfloop>				
			</tbody>
		</table>		
	</cfif>
	<form id="formTelefono">
		<div id="frm_telForm" class="form-group" style="display: none">
			<div class="row">
				<div class="col-md-3">
					<label for="in_tel_lada" class="control-label">Clave LADA</label>
					<input id="in_tel_lada" name="in_tel_lada" type="text" class="form-control correo" >					
				</div>
				<div class="col-md-6">
					<label for="in_tel_tel" class="control-label"><span class="requerido">*</span>Teléfono</label>
					<input id="in_tel_tel" name="in_tel_tel" type="text" class="form-control correo" >					
				</div>
				<div class="col-md-3">
					<label for="in_tel_ext" class="control-label">Extensión</label>
					<input id="in_tel_ext" name="in_tel_ext" type="text" class="form-control correo" >					
				</div>
			</div>
		</div>
	</form>
	<div class="form-group">
		<div class="row">		
			<div class="pull-right">
				<button type="button" id="btn_addTelBtn" class="btn btn-primary btn-rounded "><i class="fa fa-plus"></i>&nbsp;&nbsp; AGREGAR TELÉFONO</button>
				<button type="button" id="btn_saveTelBtn" class="btn btn-primary btn-rounded " style="display: none"><i class="fa fa-save"></i>&nbsp;&nbsp; GUARDAR TELÉFONO</button>
	    	<button type="button" id="btn_cancelTelBtn" class="btn btn-danger btn-rounded " style="display: none"><i class="fa fa-times"></i>&nbsp;&nbsp; CANCELAR</button>			
			</div>									
			
		</div>
	</div>	
</cfoutput>


<script type="text/javascript">

	// Elimina un telefono
	function eliminarTelefono(pkTelefono){
		$.ajax({
			url: '<cfoutput>#event.buildLink("CVU.datosGenerales.eliminarTelefono")#</cfoutput>',
			type: 'POST',			
			data: {
				pkTelefono : pkTelefono
			},
		})
		.done(function(data) {
			if(typeof data === typeof 0 && data > 0){
				toastr.success('Exitosamente','Teléfono Eliminado');
				recargarVista();
			}else{
				toastr.error('al eliminar el Teléfono','Ocurrió un error');
			}			
		});
		
	}

	// Muestra el formulario
	function mostrarFormTelefono(){		
		$('#btn_addTelBtn').hide();
		$('#btn_saveTelBtn,#btn_cancelTelBtn').show();			
		$('#tbl_telTabla').hide('fade',400,function(){
			$('#frm_telForm').show('fade',400);
		});
	}

	// Recarga la vista
	function recargarVista(){
		getvistaListaTelefonos(<cfoutput>#prc.pkPersona#</cfoutput>);
	}

	function guardarTelefono(){
		var validacion = $("#formTelefono").validate({
			rules:{
				in_tel_lada : {
					maxlength: 5
				},
				in_tel_tel : {
					required: true,
					maxlength: 10
				},
				in_tel_ext : {
					maxlength: 5
				},
			}			
		});			
		if(validacion.form()){
			var persona = '<cfoutput>#prc.pkPersona#</cfoutput>';
			var lada      = $('#in_tel_lada').val();
			var telefono  = $('#in_tel_tel').val();
			var extension = $('#in_tel_ext').val();
			$.ajax({
				url: '<cfoutput>#event.buildLink("CVU.datosGenerales.guardarTelefonoPersona")#</cfoutput>',
				type: 'POST',			
				data: {
					persona : persona,
					lada:lada,
					telefono:telefono,
					extension:extension				
				},
			})
			.done(function(data) {
				if(typeof data === typeof 0 && data > 0){
					toastr.success('Exitosamente','Teléfono Registrado');
					recargarVista();
				}else{
					toastr.error('al registrar el Teléfono','Ocurrió un error');
				}			
			});
		}
	}	

	$(function() {
		$('#btn_addTelBtn').click(mostrarFormTelefono);	
		$('#btn_cancelTelBtn').click(recargarVista);
		$('#btn_saveTelBtn').click(guardarTelefono);
	});
</script>
