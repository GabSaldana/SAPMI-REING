<cfprocessingdirective pageEncoding="UTF-8">

<script type="text/javascript">

	/**
	* regresarInicio
	*/
	function regresarInicio(){
		window.location = '/index.cfm';	
	}

	/**
	* limpiarFormulario
	*/
	function limpiarFormulario(){
		$('input').each(function(index, el) {
			$(el).val('');		
		});		
	}

	/**
	* guardarInvestigadorSinNumEmpleado
	*/
	function guardarInvestigadorNumEmpleado(){
		$.validator.addMethod("CURP", function(value, element, arg){						
			var patronCURP = /^[A-Z]{4}[0-9]{2}([0][1-9]|[1][0-2])([0][1-9]|[1][0-9]|[2][0-9]|[3][0-1])\w{8}$/i;
			return patronCURP.test(value);			
		}, "Formato de CURP invalido.");
		$.validator.addMethod("correoVerif", function(value, element, arg){									
			return $('#in_reg_correoInst').val() === value;			
		}, "Los correos no coinciden.");
		var validacion = $("#reg_form").validate({
			rules:{
				in_reg_numEmpleado : {
					required: true
				},
				in_reg_plazaCat : {
					required: true
				},
				in_reg_curp : {
					required: true,
					// CURP: true
				},
				in_reg_correoInst : {
					required: true,
					email: true
				},
				in_reg_validCorreoInst : {
					required: true,
					email: true,
					correoVerif: true
				}				
			}			
		});			
		if(validacion.form()){

			var numEmpleado = $('#in_reg_numEmpleado').val();
			var curpEmpleado = $('#in_reg_curp').val();
			var tipoPlaza = $('#in_reg_plazaCat').val();
			var correoEmpleado = $('#in_reg_correoInst').val();

			$.ajax({
				url: '<cfoutput>#event.buildLink("CVU.registro.guardarInvestigadorNumEmpleado")#</cfoutput>',
				type: 'POST',				
				data: {
					numEmpleado: numEmpleado,
					curpEmpleado: curpEmpleado,
					tipoPlaza: tipoPlaza,
					correoEmpleado: correoEmpleado
				},
			})
			.done(function(data) {
				if(data.PKPERSONA > 0){
					var correo = data.DATOSPERSONA.TPS_CORREO_IPN;
					swal({
						html: true,
						title:"Registro Exitoso",
						text: "Se enviará la información de la cuenta al correo <b>"+correo+"</b>",
						type: "success"
					},
					function(){
  					window.location = '<cfoutput>#event.buildLink("index")#</cfoutput>';
					});					
				}else if (data.PKPERSONA == -1) {
					toastr.warning('ya ha sido registrado anteriormente.','El investigador');
				}else if (data.PKPERSONA == -2) {
					toastr.error('son incorrectos.','Los datos del investigador');
				}				
			});				
		}	
	}	

	$(function() {

		$.validator.setDefaults({
			errorElement: "label",
			errorClass: "help-block",
			highlight: function (element, errorClass, validClass) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function (element, errorClass, validClass) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			errorPlacement: function (error, element) {								
				if (element.parent('.input-group').length) {				
					error.insertAfter(element.parent());
				} else if(element.prop('type') === 'checkbox' || element.prop('type') === 'radio'){
					element.parent().parent().append(error);
				}
				else {
					error.insertAfter(element);
				}				
			}
		});

		$('#in_reg_numEmpleado,#in_reg_plazaCat,#in_reg_curp').on('input', function(event) {
			var upper = $(this).val().toUpperCase();
			$(this).val(upper);
		});		
	});
</script>
