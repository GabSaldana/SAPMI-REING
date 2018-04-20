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
		$('select').each(function(index, el) {
			$(el).val('-1').trigger('change');		
		});
		$('input[type=radio]').prop('checked',false);
		$("#in_reg_colonia").replaceWith('<input type="text" class="form-control" readonly id="in_reg_colonia" name="in_reg_colonia">');
		$('#in_reg_pkColonia').val('');
    $('#in_reg_pkDelegacion').val('');
    $('#in_reg_pkEntidad').val('');
    $('.date').datepicker('clearDates').datepicker('update');
	}

	/**
	* guardarInvestigadorSinNumEmpleado
	*/
	function guardarInvestigadorSinNumEmpleado(){
		$.validator.addMethod("correoVerif", function(value, element, arg){									
			return $('#in_reg_correoInst').val() === value;			
		}, "Los correos no coinciden.");
		$.validator.addMethod("select", function(value, element, arg){									
			return arg !== value;			
		}, "Seleccione una opción.");
		var validacion = $("#reg_form").validate({
			rules:{
				in_reg_nombre:{
					required: true
				},
				in_reg_apPaterno:{
					required: true
				},
				in_reg_apMaterno:{
					required: true
				},
				in_reg_rfc:{
					required: true
				},
				in_reg_curp:{
					required: true
				},
				in_reg_nacionalidad:{
					required: true,
					select: '-1'
				},
				in_reg_calle:{
					required: true
				},
				in_reg_numero:{
					required: true
				},
				in_reg_cPostal:{
					required: true
				},
				in_reg_colonia:{
					required: true
				},
				in_reg_delegacion:{
					required: true
				},
				in_reg_entFederativa:{
					required: true
				},
				in_reg_pais:{
					required: true,
					select: '-1'
				},
				in_reg_fechaNacimiento:{
					required: true
				},
				in_reg_genero				:{
					required: true
				},
				in_reg_niveles:{
					required: true,
					select: '-1'
				},
				in_reg_dependencia:{
					required: true,
					select: '-1'
				},
				in_reg_correoInst:{
					required: true,
					email: true
				},
				in_reg_validCorreoInst:{
					required: true,
					email: true,
					correoVerif: true
				},
			}			
		});
		if(validacion.form()){
			var rfc             = $('#in_reg_rfc').val();
			var homoclave       = rfc.substr(rfc.length - 3);
			var curp            = $('#in_reg_curp').val();
			var nombre          = $('#in_reg_nombre').val();
			var apPat           = $('#in_reg_apPaterno').val();
			var apMat           = $('#in_reg_apMaterno').val();
			var dependencia     = $('#in_reg_dependencia').val();
			var calle           = $('#in_reg_calle').val();			
			var pais            = $('#in_reg_pais').val();
			var nacionalidad    = $('#in_reg_nacionalidad').val();
			var entidad         = $('#in_reg_pkEntidad').val();
			var municipio       = $('#in_reg_pkDelegacion').val();
			var cp              = $('#in_reg_cPostal').val();
			var colonia         = $('#in_reg_colonia').is('select') ? $('#in_reg_colonia').val() : $('#in_reg_pkColonia').val();
			var noExt           = $('#in_reg_numero').val();
			var genero          = $('input[name=in_reg_genero]:checked').val();
			var fechaNacimiento = $('#in_reg_fechaNacimiento').val();
			var correo          = $('#in_reg_correoInst').val();
			$.ajax({
				url: '<cfoutput>#event.buildLink("CVU.registro.guardarInvestigadorSinNumEmpleado")#</cfoutput>',
				type: 'POST',				
				data: {
					rfc             : rfc,
					homoclave       : homoclave,
					curp            : curp,
					nombre          : nombre,
					apPat           : apPat,
					apMat           : apMat,
					dependencia     : dependencia,
					calle           : calle,
					pais            : pais,
					nacionalidad    : nacionalidad,
					entidad         : entidad,
					municipio       : municipio,
					cp              : cp,
					colonia         : colonia,
					noExt           : noExt,
					genero          : genero,
					fechaNacimiento : fechaNacimiento,
					correo          : correo
				},
			}).done(function(data){
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

	/**
	* obtenerDireccion
	*/
	function obtenerDireccion(codigoPostal, colonia){
		$.ajax({
			url: '<cfoutput>#event.buildLink("CVU.registro.obtenerDireccion")#</cfoutput>',
			type: 'POST',			
			data: {
				codigoPostal: codigoPostal
			},
		})
		.done(function(data) {			
			if (data.ROWCOUNT > 0) {
				$('#in_reg_pkDelegacion').val(data.DATA.PK_DELMUN[0]);
				$('#in_reg_delegacion').val(data.DATA.DELMUNICIPIO[0]);
				$('#in_reg_pkEntidad').val(data.DATA.PK_ESTADO[0]);
				$('#in_reg_entFederativa').val(data.DATA.ESTADO[0]);
				if (data.DATA.COLONIA.length > 1) {
          $("#in_reg_pkColonia").val(0);
          $("#in_reg_colonia").replaceWith('<select type="text" class="form-control" id="in_reg_colonia" name="in_reg_colonia"></select>');
          $("#in_reg_colonia").append('<option value="-1">Seleccione una opción</option>');
  	      for (var i = 1; i <= data.DATA.COLONIA.length; i++) {
	          $("#in_reg_colonia").append('<option value="'+data.DATA.PK_COLONIA[i-1]+'">'+data.DATA.COLONIA[i-1]+'</option>');
          }
        } else {
          $("#in_reg_colonia").replaceWith('<input type="text" class="form-control" readonly id="in_reg_colonia" name="in_reg_colonia">');
          $("#in_reg_pkColonia").val(data.DATA.PK_COLONIA[0]);
          $("#in_reg_colonia").val(data.DATA.COLONIA[0]);
        }
        if (colonia !=0 && data.DATA.COLONIA.length > 1) {
          $("#in_reg_colonia").val(colonia);
        }
			}			
		});				
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
				}else if(element.is('select')){
					element.parent().append(error);
				}
				else {
					error.insertAfter(element);
				}				
			}
		});

		/* DATE PICKER */
		$('.date').datepicker({
			format: 'dd/mm/yyyy',
			language: 'es',
			calendarWeeks: true,
			autoclose: true,
			startDate: '01/01/1900',
			todayHighlight: true
		}).on('changeDate', function(e) {			
			$(this).closest('.form-group').removeClass('has-error');
			$(this).parent().find('label[id$="-error"]').hide();        
    });    

		/* SELECT 2 */
		$('select').select2({
			containerCssClass: 'form-control'
		}).on('change',function(event){
			if($(this).val() !== '-1'){    		
				$(this).closest('.form-group').removeClass('has-error');
				$(this).parent().find('label[id$="-error"]').hide();
    	}
		});

		/* On change de Clasificacion */
		$('#in_reg_niveles').change(function(event) {
			var $selectDependencia = $('#in_reg_dependencia');
			$selectDependencia.prop('disabled',true);			
			if ($(this).val() === "-1"){
				$selectDependencia.empty();								
				var opcion = document.createElement('option');
				opcion.innerHTML = 'Seleccione una Opción';
				opcion.value = '-1';
				$selectDependencia.append(opcion);
			}
			else{
				$.ajax({
					url: '<cfoutput>#event.buildLink("CVU.registro.getUrByFechaClasif")#</cfoutput>',
					type: 'POST',				
					data: {
						clasificacion: $(this).val()
					},
				})
				.done(function(data) {											
					$selectDependencia.empty();								
					var opcion = document.createElement('option');
					opcion.innerHTML = 'Seleccione una Opción';
					opcion.value = '-1';
					$selectDependencia.append(opcion);
					for(var i = 0; i < data.ROWCOUNT; i++){		
						var opcion = document.createElement('option');									
						opcion.innerHTML = data.DATA.NOMBRE[i];
						opcion.value = data.DATA.CLAVE[i];
						$selectDependencia.append(opcion);
					}
					$selectDependencia.prop('disabled',false);				
				});						
			}				
		});

		/* On keypress de Codigo Postal */
		$('#in_reg_cPostal').keyup(function() {			
			if ($(this).val().length == 5 && /^\d+$/.test($(this).val())) {
        obtenerDireccion($(this).val(),0);
      } else {      	
	      $("#in_reg_delegacion").val('');
	      $("#in_reg_entFederativa").val('');
	      $("#in_reg_colonia").replaceWith('<input type="text" class="form-control" readonly id="in_reg_colonia" name="in_reg_colonia">');
	      $("#in_reg_colonia").val('');
	      $('#in_reg_pkColonia').val('');
	      $('#in_reg_pkDelegacion').val('');
	      $('#in_reg_pkEntidad').val('');
      }
		});

		$('input:not(#in_reg_correoInst,#in_reg_validCorreoInst)').on('input', function(event) {
			var upper = $(this).val().toUpperCase();
			$(this).val(upper);
		});

		// $('input[name=in_reg_genero]:checked').val();

	});
</script>
