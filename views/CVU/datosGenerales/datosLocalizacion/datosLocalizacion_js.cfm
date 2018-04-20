<!---
* =========================================================================
* IPN - CSII
* Sistema:			SIIP
* Modulo:				Datos de localizacion del investigador
* Fecha:				Enero de 2018
* Descripcion:	JS de la vista de los datos de localizacion del investigador
* Autor:				Daniel Memije
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

	function mostrarBotonGuardaCorreo(){
		$('#lbl_guardaCorreo').closest('button').prop('disabled',false);
		$('#lbl_guardaCorreo').show(500,'easeOutBounce');		
	}	

	function editarDatosLocalizacion(pkPersonaSIGA){
		
		var validacion = $("#formDireccion").validate({
			rules:{
				in_corr_inst : {
					required : true,
					email    : true
				},
				in_corr_alt : {
					required : true,
					email    : true
				},							
			}			
		});
		if(validacion.form()){			
			var correoInst = $('#in_corr_inst').val();
			var correoAlt  = $('#in_corr_alt').val();
			$.ajax({
				url: '<cfoutput>#event.buildLink("CVU.datosGenerales.editarCorreosLocalizacion")#</cfoutput>',
				type: 'POST',				
				data: {
					pkPersonaSIGA: pkPersonaSIGA,
					correoIPN: correoInst,
					correoAlt: correoAlt			
				},
			})
			.done(function(data) {
				if(typeof data === typeof 0 && data > 0){
					toastr.success('Exitosamente','Información Editada');
					$('#lbl_guardaCorreo').closest('button').prop('disabled',true);	
					setTimeout(function(){
						$('#lbl_guardaCorreo').hide(500,'easeOutBounce')
					},300);									
				}else{
					toastr.error('al editar la Información','Ocurrió un error');
				}				
			});			
		}
	}

	function getvistaListaTelefonos(pkPersona){
		$.ajax({
			url: '<cfoutput>#event.buildLink("CVU.datosGenerales.vistaListaTelefonos")#</cfoutput>',
			type: 'POST',			
			data: {
				pkPersona: pkPersona
			},
		})
		.done(function(data) {
			$('#telefonosContainer').html(data);
		});		
	}	

	$(function() {

		getvistaListaTelefonos($('#pkPersona').val());		

		$('#in_corr_inst,#in_corr_alt').on('input',mostrarBotonGuardaCorreo);

		$('#lbl_guardaCorreo').closest('button').click(function(){
			editarDatosLocalizacion(<cfoutput>#personaSiga.getPK_PERSONAL()#</cfoutput>);
		});					

	});
</script>
