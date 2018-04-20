<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       Junio de 2017
* Descripcion: Contenido js que sera usado por la vista de Convenios/Nuevo
* Autor:       SGS
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">

	function obtenerFormularioTipo(tipo, pkConvenio){
		if (tipo != 0) {
			return $.ajax({
				type: 'POST',
				url: '<cfoutput>#event.buildLink("convenios.Nuevo.obtenerTipoConvenioFormulario")#</cfoutput>',
				data: { pkTipoConvenio: tipo },
				success: function(data){
					$('#tipoConvenioFormulario').html(data);
					if(pkConvenio > 0){
						obtenerDatosEditar(pkConvenio, tipo);
					}
				}
			});
		}
	}

	function agregarConvenio(){
		var con = $('#concurrencia').prop('checked') ? $('#concurrencia').val() : 0;
		if ($("#tipoConvenio").val() == 2 && validarCFA()){
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.agregarConvenioFirmaAutografa")#</cfoutput>',{
				tipoConvenio:       $("#tipoConvenio").val(),
				claveRegistro:      $("#claveRegistro").val(),
				nombre:             $("#nombreCFA").val(),
				descripcion:        $("#descripcionCFA").val(),
				modalidad:          $("#modalidadCFA").val(),
				institucion:        $("#colaborativaCFA").val(),
				fechaInicio:        $("#fechaInicioCFA").val(),
				fechaFin:           $("#fechaFinCFA").val(),
				concurrencia: 		con,
				montoIpn:           parseInt($("#montoLiquidoCFA").val().replace(/,/g,'').replace('.00','')),
				montoConcurrente:   parseInt($("#montoEspecieCFA").val().replace(/,/g,'').replace('.00','')),
				montoConacyt:       parseInt($("#montoConacytCFA").val().replace(/,/g,'').replace('.00','')),
				montoTotal:         parseInt($("#montoTotalCFA").text().replace(/,/g,'').replace('.00','')),
				montoTotalDir:      parseInt($("#montoTotalDirCFA").val().replace(/,/g,'').replace('.00',''))
			}, function(data){
				if ($.isNumeric(data)  && data > 0) {
					$("#claveRegistro").val(pad(data,4));
					toastr.success('','Convenio guardado');
					habilitarTabs(data);
					obtieneDocumentos($("#tipoConvenio").val());
					$("#tipoConvenio").attr('disabled',true);
				} else {
					toastr.error('el convenio','Problemas al guardar');
				}
			});
		} else if ($("#tipoConvenio").val() == 1 && validarCFE()){
			var conEsp 	  = $('#concurrenciaEspecie').prop('checked') ? $('#concurrenciaEspecie').val() : 0;
			var instituto = $("#colaborativaCFE").val() == "" ? 0 : $("#colaborativaCFE").val();
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.agregarConvenioFirmaElectronica")#</cfoutput>',{
				tipoConvenio:       $("#tipoConvenio").val(),
				claveRegistro:      $("#claveRegistro").val(),
				nombre:             $("#nombreCFE").val(),
				descripcion:        $("#descripcionCFE").val(),
				modalidad:          $("#modalidadCFE").val(),
				institucion:        instituto,
				fechaInicio:        $("#fechaInicioCFE").val(),
				fechaFin:           $("#fechaFinCFE").val(),
				concurrencia: 		con,
				concurrenciaEsp: 	conEsp,
				montoIpn:           parseInt($("#montoLiquidoCFE").val().replace(/,/g,'').replace('.00','')),
				montoConcurrente:   parseInt($("#montoEspecieCFE").val().replace(/,/g,'').replace('.00','')),
				montoConacyt:       parseInt($("#montoConacytCFE").val().replace(/,/g,'').replace('.00','')),
				montoEspacio:       parseInt($("#montoEspacioCFE").val().replace(/,/g,'').replace('.00','')),
				montoTotal:         parseInt($("#montoTotalCFA").text().replace(/,/g,'').replace('.00','')),
				montoTotalDir:      parseInt($("#montoTotalDirCFA").val().replace(/,/g,'').replace('.00',''))
			}, function(data){
				if ($.isNumeric(data)  && data > 0) {
					$("#claveRegistro").val(pad(data,4));
					toastr.success('','Convenio guardado');
					habilitarTabs(data);
					obtieneDocumentos($("#tipoConvenio").val());
					$("#tipoConvenio").attr('disabled',true);
				} else {
					toastr.error('el convenio','Problemas al guardar');
				}
			});
		} else if ($("#tipoConvenio").val() == 3 && validarCUC()){
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.agregarConvenioUCMexus")#</cfoutput>',{
				tipoConvenio:       $("#tipoConvenio").val(),
				claveRegistro:      $("#claveRegistro").val(),
				nombre:             $("#nombreCUC").val(),
				descripcion:        $("#descripcionCUC").val(),
				institucion:        $("#colaborativaCUC").val(),
				fechaInicio:        $("#fechaInicioCUC").val(),
				fechaFin:           $("#fechaFinCUC").val(),
				montoTotal:         parseInt($("#montoTotalCUC").val().replace(/,/g,'').replace('.00',''))
			}, function(data){
				if ($.isNumeric(data)  && data > 0) {
					$("#claveRegistro").val(pad(data,4));
					toastr.success('','Convenio guardado');
					habilitarTabs(data);
					obtieneDocumentos($("#tipoConvenio").val());
					$("#tipoConvenio").attr('disabled',true);
				} else {
					toastr.error('el convenio','Problemas al guardar');
				}
			});
		}
	}

	function editarConvenio(){
		var con = $('#concurrencia').prop('checked') ? $('#concurrencia').val() : 0;
		if ($("#tipoConvenio").val() == 2 && validarCFA()){
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.editarConvenioFirmaAutografa")#</cfoutput>',{
				pkConvenio:         $("#hfPkConvenio").val(),
				nombre:             $("#nombreCFA").val(),
				descripcion:        $("#descripcionCFA").val(),
				modalidad:          $("#modalidadCFA").val(),
				institucion:        $("#colaborativaCFA").val(),
				fechaInicio:        $("#fechaInicioCFA").val(),
				fechaFin:           $("#fechaFinCFA").val(),
				concurrencia: 		con,
				montoIpn:           parseInt($("#montoLiquidoCFA").val().replace(/,/g,'').replace('.00','')),
				montoConcurrente:   parseInt($("#montoEspecieCFA").val().replace(/,/g,'').replace('.00','')),
				montoConacyt:       parseInt($("#montoConacytCFA").val().replace(/,/g,'').replace('.00','')),
				montoTotal:         parseInt($("#montoTotalCFA").text().replace(/,/g,'').replace('.00','')),
				montoTotalDir:      parseInt($("#montoTotalDirCFA").val().replace(/,/g,'').replace('.00',''))
			}, function(data){
				if ($.isNumeric(data)  && data > 0) {
					toastr.success('','Convenio editado');
				} else {
					toastr.error('el convenio','Problemas al editar');
				}
			});
		} else if ($("#tipoConvenio").val() == 1 && validarCFE()){
			var conEsp 	  = $('#concurrenciaEspecie').prop('checked') ? $('#concurrenciaEspecie').val() : 0;
			var instituto = $("#colaborativaCFE").val() == "" ? 0 : $("#colaborativaCFE").val();
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.editarConvenioFirmaElectronica")#</cfoutput>',{
				pkConvenio: $("#hfPkConvenio").val(),
				nombre:             $("#nombreCFE").val(),
				descripcion:        $("#descripcionCFE").val(),
				modalidad:          $("#modalidadCFE").val(),
				institucion:        instituto,
				fechaInicio:        $("#fechaInicioCFE").val(),
				fechaFin:           $("#fechaFinCFE").val(),
				concurrencia: 		con,
				concurrenciaEsp: 	conEsp,
				montoIpn:           parseInt($("#montoLiquidoCFE").val().replace(/,/g,'').replace('.00','')),
				montoConcurrente:   parseInt($("#montoEspecieCFE").val().replace(/,/g,'').replace('.00','')),
				montoConacyt:       parseInt($("#montoConacytCFE").val().replace(/,/g,'').replace('.00','')),
				montoEspacio:       parseInt($("#montoEspacioCFE").val().replace(/,/g,'').replace('.00','')),
				montoTotal:         parseInt($("#montoTotalCFA").text().replace(/,/g,'').replace('.00','')),
				montoTotalDir:      parseInt($("#montoTotalDirCFA").val().replace(/,/g,'').replace('.00',''))
			}, function(data){
				if ($.isNumeric(data)  && data > 0) {
					toastr.success('','Convenio editado');
				} else {
					toastr.error('el convenio','Problemas al editar');
				}
			});
		} else if ($("#tipoConvenio").val() == 3 && validarCUC()){
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.editarConvenioUCMexus")#</cfoutput>',{
				pkConvenio:         $("#hfPkConvenio").val(),
				nombre:             $("#nombreCUC").val(),
				descripcion:        $("#descripcionCUC").val(),
				institucion:        $("#colaborativaCUC").val(),
				fechaInicio:        $("#fechaInicioCUC").val(),
				fechaFin:           $("#fechaFinCUC").val(),
				montoTotal:         parseInt($("#montoTotalCUC").val().replace(/,/g,'').replace('.00',''))
			}, function(data){
				if ($.isNumeric(data)  && data > 0) {
					toastr.success('','Convenio editado');
				} else {
					toastr.error('el convenio','Problemas al editar');
				}
			});
		}
	}

	function limpiarCamposConvenio(){
		if ($("#hfPkConvenio").val() != 0){
			$("#btn-editar").removeClass('hide');
			$("#btn-validarConvenioNuevo").removeClass('hide');
		} else {
			$("#btn-guardar").removeClass('hide');
		}  
		$("#claveRegistro").val('');
		if($("#tipoConvenio").val() == 2){
			$("#nombreCFA").val('').removeClass('error').next().remove();
			$("#descripcionCFA").val('').removeClass('error').next().remove();
			$("#modalidadCFA").val('');
			$("#colaborativaCFA").val(0);
			$("#fechaInicioCFA").val('');
			$("#fechaFinCFA").val('');
			$("#montoLiquidoCFA").val('').removeClass('error').next().remove();
			$("#montoEspecieCFA").val('');
			$("#montoConacytCFA").val('').removeClass('error').next().remove();
			$("#montoTotalCFA").text('0');
		} else if ($("#tipoConvenio").val() == 1){
			$("#nombreCFE").val('').removeClass('error').next().remove();
			$("#descripcionCFE").val('').removeClass('error').next().remove();
			$("#modalidadCFE").val('');
			$("#colaborativaCFE").val(0);
			$("#fechaInicioCFE").val('');
			$("#fechaFinCFE").val('');
			$("#montoLiquidoCFE").val('').removeClass('error').next().remove();
			$("#montoEspecieCFE").val('');
			$("#montoConacytCFE").val('').removeClass('error').next().remove();
			$("#montoTotalCFE").text('0');
		} else if($("#tipoConvenio").val() == 3){
			$("#nombreCUC").val('').removeClass('error').next().remove();
			$("#descripcionCUC").val('').removeClass('error').next().remove();
			$("#colaborativaCUC").val(0);
			$("#fechaInicioCUC").val('');
			$("#fechaFinCUC").val('');
			$("#montoTotalCUC").text('0');
		}
	}

	function habilitarTabs(pkConvenio){
		$("#hfPkConvenio").val(pkConvenio);
		$("#btn-guardar").hide();
		$("#btn-editar").removeClass('hide');
		$("#btn-validarConvenioNuevo").removeClass('hide');
		$("#tabChNewGen").children().children().removeClass('fa-circle-o').addClass('fa-circle');
		$("#tabChNewRes").removeClass('hide');
		$("#tabChNewArc").removeClass('hide');
		$("#tabNewRes-2").removeClass('hide');
		$("#tabNewArc-3").removeClass('hide');
	}

	function buscarResponsable() {
		$.post('<cfoutput>#event.buildLink("convenios.Consulta.obtenerEmpleadoByNumEmpleado")#</cfoutput>', {
				numEmpleado: $("#numeroEmpleadoRes").val()
		}, function(data) {
			if (data.ROWCOUNT > 0) {
				$("#numeroEmpleadoRes").val(data.DATA.NUMEMPLEADO[0]);
				$("#nombreResp").val(data.DATA.NOMBRE[0]);
				$("#paternoResp").val(data.DATA.PATERNO[0]);
				$("#maternoResp").val(data.DATA.MATERNO[0]);
				$("#correoResp").val(data.DATA.EMAIL[0]);
				$("#extensionResp").val(data.DATA.EXTENSION[0]);
				$("#gradoAcademicoResp").val(data.DATA.PKGRADO[0]);
				$("#carreraResp").val(data.DATA.PKCARRERA[0]);
				$("#sexoResp").val(data.DATA.FKSEXO[0]);
				$("#dependenciaResp").val(data.DATA.FKUR[0]);
			} else {
				toastr.warning('no existe','El empleado');
				limpiarCamposResponsable();
			}
		});
	}

	function agregarResponsable() {
		if (validarResponsable()){
			$.post('<cfoutput>#event.buildLink("convenios.Nuevo.agregarResponsable")#</cfoutput>', {
					numEmpleado:    $("#numeroEmpleadoRes").val(),
					nombre:         $("#nombreResp").val(),
					paterno:        $("#paternoResp").val(),
					materno:        $("#maternoResp").val(),
					correo:         $("#correoResp").val(),
					extension:      $("#extensionResp").val(),
					pkGrado:        $("#gradoAcademicoResp").val(),
					pkCarrera:      $("#carreraResp").val(),
					sexo:           $("#sexoResp").val(),
					pkUR:           $("#dependenciaResp").val(),
					pkConvenio:     $("#hfPkConvenio").val()
			}, function(data) {
				if ($.isNumeric(data)  && data > 0) {
					toastr.success('','Responsable agregado');
					$("#tabChNewRes").children().children().removeClass('fa-circle-o').addClass('fa-circle');
				} else {
					toastr.error('el responsable','Problemas al agregar');
				}
			});
		}
	}

	function limpiarCamposResponsable(){
		//$("#numeroEmpleadoRes").val('').removeClass('error').next().remove();
		$("#nombreResp").val('').removeClass('error').next().remove();
		$("#paternoResp").val('').removeClass('error').next().remove();
		$("#maternoResp").val('').removeClass('error').next().remove();
		$("#correoResp").val('').removeClass('error').next().remove();
		$("#extensionResp").val('').removeClass('error').next().remove();
		$("#dependenciaResp").val("");
		$("#gradoAcademicoResp").val("");
		$("#carreraResp").val("");
		$("#sexoResp").val("");
	}

	function obtenerDatosEditar(pkConvenio, tipo){
		$("#tipoConvenio").val(tipo);
		$.post('<cfoutput>#event.buildLink("convenios.Consulta.obtenerDatosEditar")#</cfoutput>', {
			pkConvenio: pkConvenio,
			tipo: tipo
		}, function(data) {
			habilitarTabs(pkConvenio);
			$("#claveRegistro").val(data.DATA.CONREGISTRO);
			$("#tipoConvenio").attr('disabled',true);
			if(data.DATA.REGISTRO_SIP != ""){
				$("#numRegistroSIP").val(data.DATA.REGISTRO_SIP);
				$("#formRegistroSIP").removeAttr("hidden");
			}
			if($("#tipoConvenio").val() == 2){
				$("#nombreCFA").val(data.DATA.CONNOMBRE);
				$("#descripcionCFA").val(data.DATA.CONDESCRIPCION);
				$("#modalidadCFA").val(data.DATA.CONMODALIDAD);
				$("#colaborativaCFA").val(data.DATA.CONINSTITUCION);
				$("#fechaInicioCFA").datepicker('setDate', data.DATA.CONFECHAVIGINI);
				$("#fechaFinCFA").datepicker('setDate', data.DATA.CONFECHAVIGFIN);
				if(data.DATA.CONCURRENCIA == 2){
					$("#concurrencia").prop('checked', true);
					$("#montoLiquidoCFA").val(formatoMonetario(data.DATA.CONMONTOLIQUIDO));
					$("#montoEspecieCFA").val(formatoMonetario(data.DATA.CONMONTOESPECIE));
					$("#montoConacytCFA").val(formatoMonetario(data.DATA.CONMONTOCONACYT));
					$("#montoTotalCFA").text(formatoMonetario(data.DATA.CONMONTOTOTAL));
					$("[id*=esConcurrente]").css("display", "block");
		   			$("#sinConcurrencia").css("display", "none");
				}else{
					$("#concurrencia").prop('checked', false);
					$("#montoTotalDirCFA").val(formatoMonetario(data.DATA.CONMONTOTOTAL));
					$("#sinConcurrencia").css("display", "block");
		  			$("[id*=esConcurrente]").css("display", "none");
				}
			} else if ($("#tipoConvenio").val() == 1){
				$("#nombreCFE").val(data.DATA.CONNOMBRE);
				$("#descripcionCFE").val(data.DATA.CONDESCRIPCION);
				$("#modalidadCFE").val(data.DATA.CONMODALIDAD);
				$("#colaborativaCFE").val(data.DATA.CONINSTITUCION);
				$("#fechaInicioCFE").datepicker('setDate', data.DATA.CONFECHAVIGINI);
				$("#fechaFinCFE").datepicker('setDate', data.DATA.CONFECHAVIGFIN);
				if(data.DATA.CONCURRENCIA == 2){
					$("#concurrencia").prop('checked', true);
					$("#concurrenciaEspecie").prop('checked', false);
					$("#montoLiquidoCFE").val(formatoMonetario(data.DATA.CONMONTOLIQUIDO));
					$("#montoConacytCFE").val(formatoMonetario(data.DATA.CONMONTOCONACYT));
					$("#montoTotalCFA").text(formatoMonetario(data.DATA.CONMONTOTOTAL));
					$("[id*=esConcurrente]").css("display", "block");
		   			$("#esConcurrenteTot").css("display", "block");
		   			$("#sinConcurrencia").css("display", "none");
		   			$("#esConcurrenteTot").addClass('col-md-offset-1'); 
				}else if(data.DATA.CONCURRENCIA == 3){
					$("#concurrencia").prop('checked', true);
					$("#concurrenciaEspecie").prop('checked', true);
					$("#montoLiquidoCFE").val(formatoMonetario(data.DATA.CONMONTOLIQUIDO));
					$("#montoEspecieCFE").val(formatoMonetario(data.DATA.CONMONTOESPECIE));
					$("#montoConacytCFE").val(formatoMonetario(data.DATA.CONMONTOCONACYT));
					$("#montoEspacioCFE").val(formatoMonetario(data.DATA.CONMONTOESPACIO));
					$("#montoTotalCFA").text(formatoMonetario(data.DATA.CONMONTOTOTAL));
					$("[id*=esConcurrente]").css("display", "block");
		   			$("#esConcurrenteTot").css("display", "block");
		   			$("#sinConcurrencia").css("display", "none");
		   			$("[id*=concurrenteEspecie]").css("display", "block");
				}else{
					$("#concurrencia").prop('checked', false);
					$("#concurrenciaEspecie").prop('checked', false);
					$("#montoTotalDirCFA").val(formatoMonetario(data.DATA.CONMONTOTOTAL));
					$("#sinConcurrencia").css("display", "block");
					$("[id*=esConcurrente]").css("display", "none");
		   			$("#esConcurrenteTot").css("display", "none");
				}	
			} else if($("#tipoConvenio").val() == 3){
				$("#nombreCUC").val(data.DATA.CONNOMBRE);
				$("#descripcionCUC").val(data.DATA.CONDESCRIPCION);
				$("#colaborativaCUC").val(data.DATA.CONINSTITUCION);
				$("#fechaInicioCUC").datepicker('setDate', data.DATA.CONFECHAVIGINI);
				$("#fechaFinCUC").datepicker('setDate', data.DATA.CONFECHAVIGFIN);
				$("#montoTotalCUC").val(formatoMonetario(data.DATA.CONMONTOTOTAL));
			}
			if (data.DATA.RESPK > 0) {
				$("#tabChNewRes").children().children().removeClass('fa-circle-o').addClass('fa-circle');
				$("#numeroEmpleadoRes").val(data.DATA.RESNUMEMPLEADO);
				$("#nombreResp").val(data.DATA.RESNOMBRE);
				$("#paternoResp").val(data.DATA.RESAPATERNO);
				$("#maternoResp").val(data.DATA.RESAMATERNO);
				$("#correoResp").val(data.DATA.RESMAIL);
				$("#extensionResp").val(data.DATA.RESEXTENSION);
				$("#dependenciaResp").val(data.DATA.RESPKUR);
				$("#gradoAcademicoResp").val(data.DATA.RESPKGRADO);
				$("#carreraResp").val(data.DATA.RESPKCARRERA);
				$("#sexoResp").val(data.DATA.RESPKSEXO);
			}
		});
		$.post('<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>', {
			pkRegistro:     pkConvenio,
			tipoConvenio:   tipo
		}, function(data) {
			if(data.EXITO){
				$("#tabChNewArc").children().children().removeClass('fa-circle-o').addClass('fa-circle');
			}
		});
	}

	/** 
	* Descripcion:    Abre la modal para hacer comentarios
	* Fecha creacion: Junio de 2017
	* @author:        Alejandro Tovar
	*/
	function modalComentario(pkReg, pkAccion){
		$("#mdl-addComentarioCambioEstado").modal('show');
		$("#inRegistro").val(pkReg);
		$("#inAccion").val(pkAccion);
		$.post('<cfoutput>#event.buildLink("convenios.Consulta.getUsuComentario")#</cfoutput>', {
			pkElemento: pkReg,
			tipoElemento: '<cfoutput>#application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS#</cfoutput>'
		}, function(data) {
			if (data.ROWCOUNT > 0){
				$("#accordion").removeClass('hide');
				$.post('<cfoutput>#event.buildLink("convenios.Consulta.asuntoComentario")#</cfoutput>', {
					pkTipoComent: 1
				}, function(data){
					$('#inAsunto').val(data.DATA.ASUNTO[0]);
				});
				var list = $(".destinatarios").append('<ol type="none"></ol>').find('ol');
				for (var i = 0; i < data.ROWCOUNT; i++){
					list.append("<li><div class='checkbox checkbox-primary'><input id='checkboxDestin"+i+"' name='destinatarios' type='checkbox' value=" + data.DATA.USU_PK[i] + "><label for='checkboxDestin"+i+"'>" + data.DATA.USU_NAME[i] + "</label></div></li>");
				}
			}
		});
	}

	<!---
	* Fecha : Noviembre de 2016
	* Autor : Alejandro Tovar
	* Comentario: Limpia la modal de agregar comentario
	---> 
	function limpiaModal(){
		$("#mdl-addComentarioCambioEstado").modal('hide');
		$("#inRegistro").val(0);
		$("#inAccion").val('');
		$("#inComent").val('');
		$("#inPrior").prop("checked",false);
		$("#accordion").addClass('hide');
		$(".destinatarios").html('').parent().attr('aria-expanded',"false").css('height','0px').removeClass('in');
		$("#inAsunto").val('');
		tinyMCE.get("inComent").setContent('');
	}

	/** 
	* Descripcion:    Realiza el cambio de estado
	* Fecha creacion: Junio de 2017
	* @author:        Alejandro Tovar
	*/
	function cambiarEstado(omitir){
		var checkDestin = new Array();
		
		$('input[name="destinatarios"]:checked').each(function() {
		   checkDestin.push($(this).val());
		});

		var prioridad   = ($('#inPrior').prop('checked')) ? 1 : 0;
		var comentario  = (omitir == 1) ? tinyMCE.activeEditor.getContent() : '';

		$.post('<cfoutput>#event.buildLink("convenios.Consulta.cambiarEstadoConvenio")#</cfoutput>', {
			pkRegistro:     $("#inRegistro").val(),
			accion:         $("#inAccion").val(),
			asunto:         $("#inAsunto").val(),
			comentario:     comentario,
			prioridad:      prioridad,
			destinatarios:  JSON.stringify(checkDestin),
			tipoComent:     '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.CONVENIO#</cfoutput>'
		}, function(data) {
			limpiaModal();
			if(data.EXITO == true) {
				if (data.COMENTARIO) {
					toastr.success('','Comentario guardado');
				}
				swal("El estado del convenio ha sido modificado", null, "success");
				busquedaConvenios();
			}
			else {
				swal("Error al modificar el convenio", null, "error");
			}
		});
	}


	/** 
	* Descripcion:    Valida el Convenio seleccionado
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	*/
	function CambiaEstadoNuevoConvenioValidar() {
		var responsable = existeResponsable();
		var archivos = validarArchivos();
		if(responsable && archivos){
			swal({
				title:              "¿Desea validar el convenio?",
				text:               "Número de registro : <strong>" + $("#claveRegistro").val() + "</strong>",
				type:               "info",
				confirmButtonColor: "#00303F",
				confirmButtonText:  "Validar",
				cancelButtonText:   "Cerrar",
				showCancelButton:   true,
				closeOnConfirm:     false,
				showLoaderOnConfirm:true,
				html:               true
			}, function () {
				modalComentario($("#hfPkConvenio").val(), 'busqueda.validar');
			});
		} else if(!responsable && archivos) {
			swal("Aún falta asignar un responsable", null, "warning");
		} else if(responsable && !archivos) {
			swal("Aún faltan archivos por cargar", null, "warning");
		} else {
			swal("Aún faltan archivos por cargar y asignar un responsable", null, "warning");
		}
	}

	function validarArchivos(){
		var exito = $.ajax({
			type: 'POST',
			url:  '<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>',
			data: { pkRegistro: $("#hfPkConvenio").val(), tipoConvenio: $("#tipoConvenio").val() },
			async: false
		}).responseJSON;
		return exito.EXITO;
	}

	function existeResponsable(){
		var exito = $.ajax({
			type: 'POST',
			url:  '<cfoutput>#event.buildLink("convenios.Consulta.responsableAsignado")#</cfoutput>',
			data: { pkRegistro: $("#hfPkConvenio").val() },
			async: false
		}).responseJSON;
		return exito.EXITO;
	}

	function busquedaConvenios(){
		document.location = '<cfoutput>#event.buildLink("convenios.Consulta")#</cfoutput>'
	}

	function MuestraAnexo(opcion) {
		$("#divPanelAnexo").removeClass("hide");
		$("#divPanelAnexo").show();
	}  

	function validarCUC(){
		var validadcionCUC = $("#formGenerales").validate({
			rules: {
				nombreCUC:              {required: true, iniciaConLetra: true},
				descripcionCUC:         {required: true, iniciaConLetra: true},
				modalidadCUC:           {required: true},
				colaborativaCUC:        {required: true},
				fechaInicioCUC:         {required: true},
				fechaFinCUC:            {required: true},
				montoLiquidoCUC:        {required: true, number: true},
				montoConacytCUC:        {required: true, number: true}
			}, messages: {
				montoLiquidoCUC:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoConacytCUC:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoEspecieCUC:        {maxlength:"Por favor, no escribas más de 10 digitos."}
			}, errorPlacement: function (error, element) {
				if ( element.attr("name") == "fechaInicioCUC") {
					error.insertAfter($("#fechaInicioCUC").parent());
				} else if ( element.attr("name") == "fechaFinCUC" ) {
					 error.insertAfter($("#fechaFinCUC").parent());
				} 
				else {
					error.insertAfter(element);
				}
			}, submitHandler: function(form) {
				return false;
			}
		});
		return validadcionCUC.form();
	}

	function validarCFE(){
		var validadcionCFE = $("#formGenerales").validate({
			rules: {
				nombreCFE:              {required: true, iniciaConLetra: true},
				descripcionCFE:         {required: true, iniciaConLetra: true},
				modalidadCFE:           {required: true},
				colaborativaCFE:        {required: true},
				fechaInicioCFE:         {required: true},
				fechaFinCFE:            {required: true},
				montoLiquidoCFE:        {required: true, number: true},
				montoConacytCFE:        {required: true, number: true}
			}, messages: {
				montoLiquidoCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoConacytCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoEspecieCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."}
			}, errorPlacement: function (error, element) {
				if ( element.attr("name") == "fechaInicioCFE") {
					error.insertAfter($("#fechaInicioCFE").parent());
				} else if ( element.attr("name") == "fechaFinCFE" ) {
					 error.insertAfter($("#fechaFinCFE").parent());
				} 
				else {
					error.insertAfter(element);
				}
			}, submitHandler: function(form) {
				return false;
			}
		});
		return validadcionCFE.form();
	}

	function validarCFA(){
		var validadcionCFA = $("#formGenerales").validate({
			rules: {
				nombreCFA:              {required: true, iniciaConLetra: true},
				descripcionCFA:         {required: true, iniciaConLetra: true},
				modalidadCFA:           {required: true},
				colaborativaCFA:        {required: true},
				fechaInicioCFA:         {required: true},
				fechaFinCFA:            {required: true},
				montoLiquidoCFA:        {required: true, number: true},
				montoConacytCFA:        {required: true, number: true}
			}, messages: {
				montoLiquidoCFA:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoConacytCFA:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoEspecieCFA:        {maxlength:"Por favor, no escribas más de 10 digitos."}
			}, errorPlacement: function (error, element) {
				if ( element.attr("name") == "fechaInicioCFA") {
					error.insertAfter($("#fechaInicioCFA").parent());
				} else if ( element.attr("name") == "fechaFinCFA" ) {
					 error.insertAfter($("#fechaFinCFA").parent());
				}
				else {
					error.insertAfter(element);
				}
			}, submitHandler: function(form) {
				return false;
			}
		});
		return validadcionCFA.form();
	}

	function validarResponsable(){
		var validarResponsable = $("#formResponsable").validate({
			rules: {
				numeroEmpleadoRes: {required: true, number: true},
				nombreResp:        {required: true},
				paternoResp:       {required: true},
				maternoResp:       {required: true},
				correoResp:        {required: true, email: true},
				extensionResp:     {required: true, number: true},
				sexoResp: 	   	   {required: true},
				dependenciaResp:   {required: true},
				carreraResp: 	   {required: true},
				gradoAcademicoResp: {required: true}
			}, submitHandler: function(form) {
				return false;
			}
		});
		return validarResponsable.form();
	}

	$(document).ready(function() {

		$("#divModalAnexo").draggable({
			handle: ".modal-header"
		});

		$(".fullscreen-link").click( function() {
			var panel = $(this).closest('div.panel');
			var liga  = $(this).find('i');
			liga.toggleClass('fa-expand').toggleClass('fa-compress');
			panel.toggleClass('panel-fullscreen');
		});
		
		$("#cierraPanelAnexo").click(function() {
			$("#divPanelAnexo").hide();
		});

		// $("#formResponsable").validate({
		//     rules: {
		//         numeroEmpleadoRes: {required: true, number: true},
		//         nombreResp:        {required: true},
		//         paternoResp:       {required: true},
		//         maternoResp:       {required: true},
		//         correoResp:        {required: true, email: true},
		//         extensionResp:     {required: true, number: true}
		//     }, submitHandler: function(form) {
		//         return false;
		//     }
		// });

		$("#tipoConvenio").change(function(){
			obtenerFormularioTipo($(this).val());
		});

		$("#tabChNewGen").click(function() {
			if ($("#hfPkConvenio").val() != 0){
				$("#btn-editar").removeClass('hide');
			} else {
				$("#btn-guardar").removeClass('hide');
			}   
			$("#btn-limpiarConvenio").removeClass('hide');
			$("#btn-agregarResp").addClass('hide');
			$("#btn-limpiarResp").addClass('hide');
		});

		$("#tabChNewRes").click(function() {
			$("#btn-guardar").addClass('hide');
			$("#btn-editar").addClass('hide');
			$("#btn-limpiarConvenio").addClass('hide');
			$("#btn-agregarResp").removeClass('hide');
			$("#btn-limpiarResp").removeClass('hide');
		});

		$("#tabChNewArc").click(function() {
			$("#btn-guardar").addClass('hide');
			$("#btn-editar").addClass('hide');
			$("#btn-limpiarConvenio").addClass('hide');
			$("#btn-agregarResp").addClass('hide');
			$("#btn-limpiarResp").addClass('hide');
		});

		if ($("#hfPkConvenio").val() > 0) {
			obtenerFormularioTipo($("#tipoDelConvenio").val(), $("#hfPkConvenio").val());

		}

		$(document).tooltip({
			selector: '[data-tooltip=tooltip]'
		});

		tinymce.init({
			selector: "textarea#inComent",
			language: 'es_MX',
			height: 250,
			resize: false,
			menubar: false,
			plugins: 'textcolor',
			toolbar: 'undo redo | bold italic | forecolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',

			spellchecker_callback: function(method, data, success) {
				if (method == "spellcheck") {
					var words = data.match(this.getWordCharPattern());
					var suggestions = {};

					for (var i = 0; i < words.length; i++) {
						suggestions[words[i]] = ["First", "second"];
					}

					success({words: suggestions, dictionary: true});
				}

				if (method == "addToDictionary") {
					success();
				}
			}
		});

	});

	<!---
	* Descripcion: Funcion que agrega ceros al inicio del monto
	* Fecha : Enero 23, 2018
	* Autor : Edgar Allan Soriano Najera
	---> 
	function pad (str, max) {
		str = str.toString();
		return str.length < max ? pad("0" + str, max) : str;
	}

</script>