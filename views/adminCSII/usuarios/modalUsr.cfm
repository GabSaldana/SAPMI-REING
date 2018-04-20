<cfprocessingdirective pageEncoding="utf-8">
<div class="tabs-container">
	<ul class="nav nav-tabs">
		<li class="active">
			<a class="guiaEstados" data-toggle="tab" data-container="body" data-placement="top" href="#tab-1" aria-expanded="false">
				<i class="fa fa-user"></i>
				Datos
			</a>
		</li>
		<li class="">
			<a class="guiaValidaciones" data-toggle="tab" data-container="body" data-placement="top" href="#tab-2" aria-expanded="false">
				<i class="fa fa-key"></i>
				Contraseña
			</a>
		</li>
	</ul>
</div>

<div class="tab-content">
	<div id="tab-1" class="tab-pane active">
		<div class="modal-body">
			<form id="validaUsuario" class="form-horizontal" role="form" onsubmit="return false;">
				<cfoutput>
				<h3> Datos personales</h3>
				<div>
					<label class="control-label">Nombre</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input type="text" id="inUsuarioNombre" name="inUsuarioNombre" class="form-control" value="#request.datos.Nombre#" required/>
					</div>
				</div>
				<div>
					<label class="control-label">Apellido Paterno</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input type="text" id="inUsuarioPaterno" name="inUsuarioPaterno" class="form-control"  value="#request.datos.PATERNO#" required/>
					</div>
				</div>
				<div>
					<label class="control-label">Apellido Materno</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input type="text" id="inUsuarioMaterno" name="inUsuarioMaterno" class="form-control" value="#request.datos.MATERNO#" required/>
					</div>
				</div>

				<div>
					<label class="control-label">Género</label><br>

			        <div class="radio radio-info radio-inline">
			            <input type="radio" name="inUsuarioGenero" id="opcM" value="1" <cfif request.datos.GENERO eq 1> checked </cfif>>
			            <label for="opcM">
			                <h4><span class="fa fa-male"></span> Masculino</h4>
			            </label>
			        </div>
			        <div class="radio radio-info radio-inline">
			            <input type="radio" name="inUsuarioGenero" id="opcF" value="2"  <cfif request.datos.GENERO neq 1> checked </cfif>>
			            <label for="opcF">
			                <h4><span class="fa fa-female"></span> Femenino</h4>
			            </label>
			        </div>
				</div>
				<hr>
				<!---<h3> Datos institucionales</h3>
				<div class="row">
					<div class="col-sm-6">
						<label style="text-align:right;" class="control-label">Unidad Responsable</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-tags"></span>
							</span>
							<input type="text" id="inUsuarioResponsable" name="inUsuarioResponsable" class="form-control" title="#Request.datos.UR#" value="#Request.datos.SIGLAUR#" disabled="disabled"/>
						</div>
					</div>
					<div class="col-sm-6">
						<label style="text-align:right;" class="control-label">Acrónimo</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-tags"></span>
							</span>
							<input type="text" id="inUsuarioAcr" name="inUsuarioAcr" class="form-control" data-acr="#Request.datos.PKACRONIMO#" title="#Request.datos.desACRONIMO#" value="#Request.datos.ACRONIMO#" disabled="disabled"/>
						</div>
					</div>
				</div> !--->
				<div class="row">
					<div class="col-sm-6">
						<label class="control-label">Teléfono</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-earphone"></span>
							</span>
							<input type="text" name="inUsuarioTel" class="form-control" id="inUsuarioTel" value="#Request.datos.telefono#" required/>
						</div>
					</div>
					<div class="col-sm-6">
						<label class="control-label">Extensión</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-option-horizontal"></span>
							</span>
							<input type="text" id="inUsuarioExt" name="inUsuarioExt" class="form-control" maxlength="5" value="#Request.datos.extension#"/>
						</div>
					</div>
				</div>
				<div>
					<label class="control-label">Correo Electrónico</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-envelope"></span>
						</span>
						<input type="email" name="inUsuarioEmail" class="form-control" id="inUsuarioEmail" value="#request.datos.email#"  required/>
					</div>
					<p class="text-small" style="color:red;">A este correo se enviaran todas las notificaciones relacionadas con la cuenta	.</p>
				</div>
				<hr>
				<h3> Cuenta de usuario</h3>
				<div class="row">
					<div class="col-sm-6">
							<label style="text-align:right;" class="control-label">Rol</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-tags"></span>
								</span>
								<input type="text" name="inUsuarioRol" class="form-control" id="inUsuarioRol" data-rol="#request.datos.PKrol#" value="#Request.datos.rol#" title="#Request.datos.rol#" disabled="disabled"/>
							</div>
					</div>
					<div class="col-sm-6">
						<label class="control-label">Clave de usuario</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-user"></span>
								</span>
								<input class="form-control" required style="text-transform:uppercase;" type="text" id="inUsuarioUser" name="inUsuarioUser" value="#request.datos.usr#">
							</div>
							<p class="text-small" style="color:red;">Clave con que ingresa al sistema.</p>
					</div>
				</div>

			</cfoutput>

			<div class="modal-footer">
				<button type="submit" id="actualizaUsr" class="btn btn-success btn-lg pull-right">
			    	Actualizar
				</button>
			</div>
		</form>
	</div>
</div>

<div id="tab-2" class="tab-pane">
	<div class="modal-body">
		<form id="validaCont" class="form-horizontal" role="form" onsubmit="return false;">
			<h3> Cambiar Contraseña</h3>
			<div>
				<label class="control-label">Contraseña Actual</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-lock"></span>
					</span>
					<input type="password" id="contAct" name="contAct" class="form-control" required/>
				</div>
			</div>
			<div>
				<label class="control-label">Nueva Contraseña</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-lock"></span>
					</span>
					<input type="password" id="nuevaCont" name="nuevaCont" class="form-control" required/>
				</div>
			</div>
			<div>
				<label class="control-label">Confirmar Contraseña</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-lock"></span>
					</span>
					<input type="password" id="repCont" name="repCont" class="form-control" required/>
				</div>
			</div>

			<div class="modal-footer">
				<button type="submit" id="actualizaCont" class="btn btn-success btn-lg pull-right">
			    	Actualizar
				</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	
   	$('body').undelegate('#actualizaUsr', 'click');
    $('body').on('click', '#actualizaUsr', function() {
	    var validacion = $("#validaUsuario").validate({
	        rules: {
	            inUsuarioNombre:   {required: true},
	            inUsuarioPaterno:  {required: true},
	            inUsuarioMaterno:  {required: true},
	            inUsuarioTel:      {required: true},
	            inUsuarioEmail:    {required:true},
	            inUsuarioUser:     {required: true}
	        },
	        messages: {
	            inUsuarioNombre:   "Ingresar el Nombre.",
	            inUsuarioPaterno:  "Ingresar el Apellido Paterno.",
	            inUsuarioMaterno:  "Ingresar el Apellido Materno.",
	            inUsuarioTel:      "Ingresar su número telefónico.",
	            inUsuarioEmail:    "Ingresar un correo.",
	            inUsuarioUser:     "Ingresar un usuario."
	        } ,submitHandler: function(form) {
	            return true;
	        }
	    });
	    if(validacion.form()){
	    	$.post('<cfoutput>#event.buildLink("adminCSII/usuarios/usuarios/getUsr")#</cfoutput>',{	        	
	            inUsuarioUser:    $('#inUsuarioUser').val()
	        }, function(data){
	        	if(data == 0){
			        $.post('<cfoutput>#event.buildLink("adminCSII/usuarios/usuarios/editarUsr")#</cfoutput>',{
			            inUsuarioNombre:  $('#inUsuarioNombre').val(),
			            inUsuarioPaterno: $('#inUsuarioPaterno').val(),
			            inUsuarioMaterno: $('#inUsuarioMaterno').val(),
			            inUsuarioGenero:  $('[name=inUsuarioGenero]:checked').val(),
			            inUsuarioTel:     $('#inUsuarioTel').val(),
			            inUsuarioExt:     $('#inUsuarioExt').val(),
			            inUsuarioEmail:   $('#inUsuarioEmail').val(),
			            inUsuarioUser:    $('#inUsuarioUser').val()
			        },function(data){
			            if(data > 0 ){
			                $('#mdl-admon-usuario-main').modal('hide');
				            swal({
							   type: "success",
							   title: "Datos guardados correctamente",
							   timer: 1000,
							   showConfirmButton: false
							});
			            } else{
				            swal({
							   type: "error",
							   title: "Error",
							   text: "Ha ocurrido un error al guardar los datos.",
							   timer: 1000,
							   showConfirmButton: false
							});
				        }
			        });
		    	} else if(data > 0)		    		
		            swal({
					   type: "error",
					   title: "Error",
					   text: "Ya existe un usuario con ese nombre de usuario.",
					   timer: 1000,
					   showConfirmButton: false
					});
		        else
		            swal({
					   type: "error",
					   title: "Error",
					   text: "Ha ocurrido un error al guardar los datos.",
					   timer: 1000,
					   showConfirmButton: false
					});        	
		    });
	    }
	});

    $('body').on('click', '#actualizaCont', function(){
	    var validacion = $("#validaCont").validate({
		 	rules: {
		 		contAct:	{required: true},
		        nuevaCont:	{required: true, minlength: 5},
		        repCont:	{required: true, minlength: 5, equalTo: '[name="nuevaCont"]'}
		    },
		    messages: {
	            contAct:  	"Ingresar la antigua contraseña.",
	            nuevaCont:  {required:"Ingresar la nueva contraseña.", minlength:"Contraseña muy corta"},
	            repCont:  	{required:"Ingresar la nueva contraseña.", equalTo:"Las contraseñas no coinciden"}
		    } ,submitHandler: function(form) {
	            return true;
	        }
		});

		if(validacion.form()){
			 $.post('<cfoutput>#event.buildLink("adminCSII/usuarios/usuarios/getPass")#</cfoutput>',{
			 	pass: $('#contAct').val()
			 }, function(data){
			 	if(data > 0){
			 		$.post('<cfoutput>#event.buildLink("adminCSII/usuarios/usuarios/editarPass")#</cfoutput>',{
			 			pass: $('#nuevaCont').val()
			 		}, function(data){
			 			if(data > 0){
			 				 $('#mdl-admon-usuario.main').modal('hide');
				            swal({
							   type: "success",
							   title: "Datos guardados correctamente",
							   timer: 1000,
							   showConfirmButton: false
							});
			 			} else{
							swal({
							   type: "error",
							   title: "Error",
							   text: "Ha ocurrido un error al guardar los datos.",
							   timer: 1000,
							   showConfirmButton: false
							});
			 			}
			 		});
			 	} else{
		            swal({
					   type: "warning",
					   title: "Error",
					   text: "La contraseña actual es incorrecta.",
					   timer: 1000,
					   showConfirmButton: false
					});
		        }
			});
		}
	});

</script>