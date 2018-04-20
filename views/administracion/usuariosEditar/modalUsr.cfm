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
			<form id="validaUsuarioMain" class="form-horizontal" role="form" onsubmit="return false;">
				<cfoutput>
				<h3> Datos personales</h3>
				<div>
					<label class="control-label">Nombre</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input type="text" id="inNombre" name="inNombre" class="form-control" value="#request.datos.Nombre#" placeholder="Ingresar nombre" maxlength="25" required/>
					</div>
				</div>
				<div>
					<label class="control-label">Apellido Paterno</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input type="text" id="inPaterno" name="inPaterno" class="form-control"  value="#request.datos.PATERNO#" placeholder="Ingresar apellido paterno" maxlength="25" required/>
					</div>
				</div>
				<div>
					<label class="control-label">Apellido Materno</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</span>
						<input type="text" id="inMaterno" name="inMaterno" class="form-control" value="#request.datos.MATERNO#" placeholder="Ingresar apellido materno" maxlength="25" required/>
					</div>
				</div>

				<div>
					<label class="control-label">Género</label><br>

			        <div class="radio radio-info radio-inline">
			            <input type="radio" name="inGenero" id="opcM" value="2" <cfif request.datos.GENERO eq 2> checked </cfif>>
			            <label for="opcM">
			                <h4><span class="fa fa-male"></span> Masculino</h4>
			            </label>
			        </div>
			        <div class="radio radio-info radio-inline">
			            <input type="radio" name="inGenero" id="opcF" value="1"  <cfif request.datos.GENERO eq 1> checked </cfif>>
			            <label for="opcF">
			                <h4><span class="fa fa-female"></span> Femenino</h4>
			            </label>
			        </div>
				</div>
				<hr>
				<h3> Datos institucionales</h3>
				<div class="row">
					<div class="col-sm-6">
						<label style="text-align:right;" class="control-label">Unidad Responsable</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-tags"></span>
							</span>
							<input type="text" id="inResponsable" name="inResponsable" class="form-control" title="#Request.datos.UR#" value="#Request.datos.SIGLAUR#" disabled="disabled"/>
						</div>
					</div>
					<div class="col-sm-6">
						<label style="text-align:right;" class="control-label">Acrónimo</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-tags"></span>
							</span>
							<input type="text" id="inAcr" name="inAcr" class="form-control" data-acr="#Request.datos.PKACRONIMO#" title="#Request.datos.desACRONIMO#" value="#Request.datos.ACRONIMO#" disabled="disabled"/>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6">
						<label class="control-label">Teléfono</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-earphone"></span>
							</span>
							<input type="text" name="inTel" class="form-control" id="inTel" value="#Request.datos.telefono#" placeholder="Ingresar teléfono" maxlength="15" required/>
						</div>
					</div>
					<div class="col-sm-6">
						<label class="control-label">Extensión</label>
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-option-horizontal"></span>
							</span>
							<input type="text" id="inExt" name="inExt" class="form-control" maxlength="5" placeholder="Ingresar extensión" value="#Request.datos.extension#"/>
						</div>
					</div>
				</div>
				<div>
					<label class="control-label">Correo Electrónico</label>
					<div class="input-group">
						<span class="input-group-addon">
							<span class="glyphicon glyphicon-envelope"></span>
						</span>
						<input type="email" name="inEmail" class="form-control" id="inEmail" value="#request.datos.email#" placeholder="Ingresar correo electrónico" maxlength="50"  required/>
					</div>
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
								<input type="text" name="inRol" class="form-control" id="inRol" data-rol="#request.datos.PKrol#" value="#Request.datos.rol#" title="#Request.datos.rol#" disabled="disabled"/>
							</div>
					</div>
					<div class="col-sm-6">
						<label class="control-label">Nombre de usuario</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-user"></span>
								</span>
								<input class="form-control" required  type="text" id="inUser" name="inUser" value="#request.datos.usr#" maxlength="18">
							</div>
							<p class="text-small">Nombre de usuario sugerido por el sistema.</p>
					</div>
				</div>

			</cfoutput>

			<div class="modal-footer">
				<button type="submit" id="actualizaUsrMain" class="btn btn-success btn-lg pull-right">
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
					<input type="password" id="contAct" name="contAct" class="form-control" maxlength="15" required/>
				</div>
			</div>
			<div>
				<label class="control-label">Nueva Contraseña</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-lock"></span>
					</span>
					<input type="password" id="nuevaCont" name="nuevaCont" class="form-control" maxlength="15" required/>
				</div>
			</div>
			<div>
				<label class="control-label">Confirmar Contraseña</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-lock"></span>
					</span>
					<input type="password" id="repCont" name="repCont" class="form-control" maxlength="15" required/>
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

	$('body').undelegate('#actualizaUsrMain', 'click');
    $('body').on('click', '#actualizaUsrMain', function() {
	    var validacion = $("#validaUsuarioMain").validate({
	        rules: {
	            inNombre:   {required: true},
	            inPaterno:  {required: true},
	            inMaterno:  {required: true},
	            inTel:      {required: true},
	            inEmail:    {required:true},
	            inUser:     {required: true}
	        },
	        messages: {
	            inNombre:   "Ingresar el Nombre.",
	            inPaterno:  "Ingresar el Apellido Paterno.",
	            inMaterno:  "Ingresar el Apellido Materno.",
	            inTel:      "Ingresar su número telefónico.",
	            inEmail:    "Ingresar un correo.",
	            inUser:     "Ingresar un usuario."
	        } ,submitHandler: function(form) {
	            return true;
	        }
	    });
	    if(validacion.form()){

	        $.post('<cfoutput>#event.buildLink("administracion/usuarios/getUsr")#</cfoutput>',{	        	
	            inUser:    $('#inUser').val()
	        }, function(data){
	        	if(data == 0){
	        		$.post('<cfoutput>#event.buildLink("administracion/usuarios/editarUsr")#</cfoutput>',{
			            inNombre:  $('#inNombre').val(),
			            inPaterno: $('#inPaterno').val(),
			            inMaterno: $('#inMaterno').val(),
			            inGenero:  $('[name=inGenero]:checked').val(),
			            inTel:     $('#inTel').val(),
			            inExt:     $('#inExt').val(),
			            inEmail:   $('#inEmail').val(),
			            inUser:    $('#inUser').val()
			        },function(data){
			            if(data > 0 ){
			                $('#mdl-admon-usuario-Main').modal('hide');
		                	toastr.success('Datos guardados correctamente');
			            } else
		                	toastr.error('Ha ocurrido un error al guardar los datos','Error');
			        });
	        	}
	        	else
		            toastr.error('El usuario ya fue seleccionado','Error');
	        
	    	});
	    }
	});


	$('body').undelegate('#actualizaCont', 'click');
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
			 $.post('<cfoutput>#event.buildLink("administracion/usuarios/getPass")#</cfoutput>',{
			 	pass: $('#contAct').val()
			 }, function(data){
			 	if(data > 0){
			 		$.post('<cfoutput>#event.buildLink("administracion/usuarios/editarPass")#</cfoutput>',{
			 			pass: $('#nuevaCont').val()
			 		}, function(data){
			 			if(data > 0){
			 				$('#mdl-admon-usuario-Main').modal('hide');
                			toastr.success('Datos guardados correctamente');
			 			} else
                			toastr.error('Ha ocurrido un error al guardar los datos','Error');
			 		});
			 	} else
                	toastr.error('La contraseña actual es incorrecta.','Error');
			});
		}
	});

</script>