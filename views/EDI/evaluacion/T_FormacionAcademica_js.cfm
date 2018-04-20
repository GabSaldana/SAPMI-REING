<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

	window.validaEscolaridad = false;

	<cfif prc.escolaridad.recordcount GT 0 >
		window.validaEscolaridad = true;
	</cfif>	
	
	var tipoEvaluacionEscolariad = "";
	var no_evaluadosEscolaridad = [];

	$(function(){		

		$('#tabla_escolaridad').bootstrapTable();
		$('#tabla_escolaridad').bootstrapTable('hideColumn', 'pk');

		<cfif listFind(accionesValidacion.ACCIONESCVE,"evalEDI.evalCE","$")>			
			if($('.setEvaluacionEscolaridad[data-accion="evalEDI.evalCE"]').length){
				$('.filaEscolaridad').hide();
				$('.filaEscolaridad[data-accion="evalEDI.evalCE"]').show();
				tipoEvaluacionEscolariad = "evalEDI.evalCE";
			}
		</cfif>
		<cfif listFind(accionesValidacion.ACCIONESCVE,"evalEDI.evalSIP","$")>			
			if($('.setEvaluacionEscolaridad[data-accion="evalEDI.evalSIP"]').length){
				$('.filaEscolaridad').hide();
				$('.filaEscolaridad[data-accion="evalEDI.evalSIP"]').show();
				tipoEvaluacionEscolariad = "evalEDI.evalSIP";
			}
		</cfif>
		<cfif listFind(accionesValidacion.ACCIONESCVE,"evalEDI.evalCA","$")>			
			if($('.setEvaluacionEscolaridad[data-accion="evalEDI.evalCA"]').length){
				$('.filaEscolaridad').hide();
				$('.filaEscolaridad[data-accion="evalEDI.evalCA"]').show();
				tipoEvaluacionEscolariad = "evalEDI.evalCA";
			}
		</cfif>
		<cfif listFind(accionesValidacion.ACCIONESCVE,"evalEDI.evalRI","$")>			
			if($('.setEvaluacionEscolaridad[data-accion="evalEDI.evalRI"]').length){
				$('.filaEscolaridad').hide();
				$('.filaEscolaridad[data-accion="evalEDI.evalRI"]').show();
				tipoEvaluacionEscolariad = "evalEDI.evalRI";
			}
		</cfif>
		<cfoutput>
			<cfloop query="#prc.escolaridad#">
				<cfif listFind(accionesValidacion.ACCIONESCVE,CET_ACC_CVE,"$") AND len(TES_PUNTAJEOBTENIDO) EQ 0>
					if("#CET_ACC_CVE#" == tipoEvaluacionEscolariad){
						no_evaluadosEscolaridad.push(#TOG_PK_OBTENCIONGRADO#);
					}
				</cfif>
			</cfloop>			
		</cfoutput>		

		$('.setEvaluacionEscolaridad').off('change');
		$('.validaEvaluacionEscolaridad').off('click');

		$('.setEvaluacionEscolaridad').change(function(event) {
			var val = $(this).val();			
			if(val != 0){
				$.ajax({				
					url: '<cfoutput>#event.buildLink("EDI.evaluacion.guardaPuntajeEvaluacionEsc")#</cfoutput>',
					type: 'POST',				
					data: {
						pkEvaluacion: $(this).data('pkeval'),
						puntaje: $(this).val()					
					}
				})
				.done(function(data) {
					if(data > 0){
						toastr.success('Registrada Exitosamente','Evaluación');					
						getTablaEscolaridad();
					}
				});
			}else{
				$('.modalCalificacionCeroEscolaridad').modal();
				$('#pkEtapaCeroEscolaridad').val($(this).data('pkeval'));
			}
		});
	});	

	function cambiaEstadoEvaluacionEscolaridad(){				
		var elementospk = [];			
		var accion = "";
		$('.setEvaluacionEscolaridad:visible').each(function(index, el) {
			elementospk.push($(el).data('pktog'));
			accion = $(el).data("accion");
		});		
		if(window.validaEscolaridad && elementospk.length > 0){
			$.ajax({
				url: '<cfoutput>#event.buildLink("EDI.evaluacion.cambiaEstadoEvaluacionEscolaridad")#</cfoutput>',
				type: 'POST',				
				data: {
					pkRegistro: JSON.stringify(elementospk),
					accion: accion
				},
			})
			.done(function(data) {						
				if(data.EXITO){
					toastr.success('Registros Validados Exitosamente.');
					getTablaEscolaridad();
				}else{
					toastr.error('Error al validar los Registros.');
				}												
			});			
		}
	}	

	function guardaCeroEscolaridad(){
		var val = $('#inMotivoEscolaridad').val();		
		if(val != 0 && $.trim(val).length != 0){			
			$('.modalCalificacionCeroEscolaridad').modal('hide');
			$.ajax({				
				url: '<cfoutput>#event.buildLink("EDI.evaluacion.guardaPuntajeEvaluacionEscCero")#</cfoutput>',
				type: 'POST',				
				data: {
					pkEvaluacion: $('#pkEtapaCeroEscolaridad').val(),
					puntaje: 0,
					motivo: val					
				}
			})
			.done(function(data) {				
				if(data > 0){
					toastr.success('Registrada Exitosamente','Evaluación');					
					getTablaEscolaridad();
				}
			});			
		}else{
			toastr.error('Seleccione un motivo','Error');
		}
	}

	function cancelarCeroEscolaridad(){
		setTimeout(function(){
			getTablaEscolaridad();
		},50);
	}

	function descargaComprobanteConsulta(pkCatalogo, pkEscolaridad){
		$("#pkFrmCatArchEscolaridad").val(pkCatalogo);
		$("#pkFrmEscolaridad").val(pkEscolaridad);
		$('#downloadComprobanteEscolaridad').submit();
	}

	function getIndex(value, row, index) {
		return index+1;
	}
</script>
