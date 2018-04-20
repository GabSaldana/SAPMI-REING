<cfprocessingdirective pageEncoding="utf-8">

<div id="toolbarInvEval">
	<button id="enviarCorreo" type="button" class="btn btn-w-m btn-success">
        <i class="fa fa-envelope"></i> Enviar correo
    </button>
</div>
<table id="listaInv" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-toolbar="#toolbarInvEval" data-search-accent-neutralise="true">
	<thead>
		<tr>
			<th data-sortable='true' class="text-center" data-valign="middle" data-field="numEmp"><h4>No. Empleado</h4></th>
			<th data-sortable='true' class="text-center" data-valign="middle" data-field="nombre"><h4>Investigador</h4></th>
			<th data-sortable='true' class="text-center" data-valign="middle" data-field="dep"><h4>Dependencia</h4></th>
			<cfoutput>
				<cfloop index = "i" from="1" to="#arrayLen(prc.tipoInvest)#">
					<th data-field="#prc.tipoInvest[i]#" class="text-center">
						Evaluación #replace(prc.tipoInvest[i], 'EVAL', '')#
						<div class="checkbox checkbox-primary">
							<input id="asigInvSelectAll#replace(prc.tipoInvest[i], 'EVAL', '')#" class="styled asigInvSelectAll" pkTipoEval="#prc.pkTipoInvest[i]#" type="checkbox">
							<label for="asigInvSelectAll#replace(prc.tipoInvest[i], 'EVAL', '')#"></label>
						</div>
					</th>
				</cfloop>
			</cfoutput>
		</tr>
	</thead>
</table>

<script>
	var data = [];
	<cfif isDefined('prc.personas.recordCount')>
		<cfloop index='i' from='1' to='#prc.personas.recordCount#'>
			<cfoutput>
				data.push({
					numEmp:	'#prc.personas.NUMEMPLEADO[i]#',
					nombre:	'#prc.personas.NOMBRE[i]# #prc.personas.PATERNO[i]# #prc.personas.MATERNO[i]#',
					dep:	'#prc.personas.DEPENDENCIA[i]#'
					<cfloop index = "j" from="1" to="#arrayLen(prc.tipoInvest)#">
						,#prc.tipoInvest[j]#:'<div class="checkbox checkbox-primary"><input id="pkAsigInves#prc.tipoInvest[j]##prc.personas.PKPERSONA[i]#" class="styled asigInves" #prc.personas["CHECKED"& prc.tipoInvest[j]][i]# type="checkbox" pkPersona="#prc.personas.PKPERSONA[i]#" tipoEval="#prc.pkTipoInvest[j]#"><label for="pkAsigInves#prc.tipoInvest[j]##prc.personas.PKPERSONA[i]#"></label></div>'
					</cfloop>
				});
			</cfoutput>
		</cfloop>
	</cfif>

	$(document).ready(function(){
		$("#listaInv").bootstrapTable();
		$('#listaInv').bootstrapTable('load', data);
		//$('#enviarCorreo').css('display', $('.asigInves[tipoEval=1]:checked').length > 0 || $('.asigInves[tipoEval=2]:checked').length > 0 ? 'inline' : 'none' );
	});

	$('body').off("click", '.asigInvSelectAll',);
	$('body').on('click', '.asigInvSelectAll', function(){
		$('.asigInves[tipoEval='+$(this).attr('pkTipoEval')+']').prop('checked', $(this).is(':checked')).change();
	});

	$('body').off('change', '.asigInves');
	$('body').on('change', '.asigInves', function(){
		var pkPersona   = $(this).attr('pkPersona');
		var pkTipoEval  = $(this).attr('tipoEval');
		var estado      = $(this).is(':checked') == true ? 2 : 0;
		var pkEvaluador = $('#selecEvaluador').val();
		if(estado == 2)
			$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.setEvaluadorInvestigador")#</cfoutput>',{
				pkPersona:      pkPersona,
				pkEvaluador:    pkEvaluador,
				pkTipoEval:     pkTipoEval
			}, function(data){
				if(data != 0){
					toastr.success('Registro actualizado correctamente.');
				}
				else{
					toastr.error('Problemas al actualizar el registro.');
					$('#pkAsigInves'+pkTipoEval+pkPersona).prop('checked', estado == 0 ? true: false);
				}
			});
		else
			$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.eliminarEvaluador")#</cfoutput>',{
				pkPersona:		pkPersona,
				pkEvaluador:	pkEvaluador,
				pkTipoEval:		pkTipoEval
			}, function(data){
				if(data != 0){
					toastr.success('Registro actualizado correctamente.');
					// consultarListaEvaluadores();
				}
				else{
					toastr.error('Problemas al actualizar el registro.');
					$('#pkAsigInves'+pkTipoEval+pkPersona).prop('checked', estado == 0 ? true: false);
				}
			});
		//$('#enviarCorreo').css('display', $('.asigInves[tipoEval=1]:checked').length > 0 || $('.asigInves[tipoEval=2]:checked').length > 0 ? 'inline' : 'none' );
	});

	$('body').off("click", '#enviarCorreo',);
	$('body').on('click', '#enviarCorreo', function(){
		var pkEvaluador = $('#selecEvaluador').val();
		$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.getCorreoUsuario")#</cfoutput>',{
			pkEvaluador:	pkEvaluador
		}, function(data){
			if(data != 0){
				$('#mdl-correo').modal();
				$('#MensajeCorreo').html('<form id="formCorreos"><input type="hidden" id="correoAlternativo" value="'+data+'"><h3>Enviar correo a la cuenta "<b>' + data + '</b>"</h3><br><br>Si no está de acuerdo con el correo anterior, ingresar correo alternativo a enviar<br><input type="text" name="inEmailEnviar" class="form-control" id="inEmailEnviar" placeholder="Ingresar correo alternativo para enviar"></form>');
			} else {
				$('#mdl-correo').modal();
				$('#MensajeCorreo').html('<form id="formCorreos"><input type="hidden" id="correoAlternativo" value="'+data+'"><h3>No se encontro una cuenta de correo, por favor proporcione una cuenta valida.<b>' + data + '</b></h3><br><input type="text" name="inEmailEnviar" class="form-control" id="inEmailEnviar" placeholder="Ingresar correo alternativo para enviar"></form>');
			}
		});
	});

	//validaciones de formulario 
	jQuery.validator.addMethod("correo", function(value, element) {
		return this.optional(element) ||  /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i.test(value);
	}, "Ingresar un correo válido");

	$('body').off("click", '#btn-enviarCorreo',);
	$('body').on('click', '#btn-enviarCorreo', function(){
		var pkEvaluador	= $('#selecEvaluador').val();
		var correo	= $('#inEmailEnviar').val() != '' ? $('#inEmailEnviar').val()  : $('#correoAlternativo').val();

		var validacion = $("#formCorreos").validate({
			rules: {
				inEmailEnviar: {correo:true}
			},
			messages: {
				correo:		{correo:"Ingresar un correo válido"}
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
				$.post('<cfoutput>#event.buildLink("EDI.asignacionEvaluadores.enviarCorreoEvaluaciones")#</cfoutput>',{
					pkEvaluador:	pkEvaluador,
					correo:			correo
				}, function(data){
					if(data != 0)
						toastr.success('Correo enviado correctamente.');
					else
						toastr.error('Problemas al enviar el correo.');
					 $('#mdl-correo').modal('toggle');
				});
		}
	});

</script>
