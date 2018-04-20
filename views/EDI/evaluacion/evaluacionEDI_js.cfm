<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">
	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip();
		$('.selectpicker').selectpicker();
		$('#tablaProyectos').bootstrapTable();

        $('#nombreInvestigador').html($("#dependenciaInvest").val() + " - " + $("#hNombreInvest").val());   

		$('body').undelegate('#cerrarEvaluacion', 'click');
		$('body').on('click', '#cerrarEvaluacion', function(){
			abrirCerrarEvaluacion();
		});

		$('body').undelegate('.verProducto', 'click');
		$('body').on('click', '.verProducto', function(e){
			e.stopPropagation();
			var clasif = $(this).data('clasif');
			var subclasif = $(this).data('subclasif');
			$('#clasifSeleccionada').val(clasif);
			$('#subClasifSeleccionada').val(subclasif);		
			$('.productoEvaluacion').show();
			$('.productoEvaluacion:not([data-clasif="'+clasif+'"][data-subclasif="'+subclasif+'"])').hide();		
		});

		$('body').undelegate('.verClasif', 'click');
		$('body').on('click', '.verClasif', function(e){
			e.stopPropagation();
			var clasif = $(this).data('clasif');
			$('#clasifSeleccionada').val(clasif);				
			$('.productoEvaluacion').show();
			$('.productoEvaluacion:not([data-clasif="'+clasif+'"])').hide();		
		});

		$('body').undelegate('.verProductoEval', 'click');
		$('body').on('click', '.verProductoEval', function(e){
			e.stopPropagation();
			var clasif = $(this).data('clasif');
			var subclasif = $(this).data('subclasif');			
			$('.productoEvaluacionEval').show();
			$('.productoEvaluacionEval:not([data-clasif="'+clasif+'"][data-subclasif="'+subclasif+'"])').hide();					
		});

		$('body').undelegate('.verClasifEval', 'click');
		$('body').on('click', '.verClasifEval', function(e){
			e.stopPropagation();
			var clasif = $(this).data('clasif');			
			$('.productoEvaluacionEval').show();
			$('.productoEvaluacionEval:not([data-clasif="'+clasif+'"])').hide();					
		});
				
		$('#jstree').jstree();
		$('#jstree2').jstree();
		getAllProductosEDI();
		getTablaSolicitudComite("divSolicitudComite");
    getTablaEscolaridad();
    getTablaEscolaridadConsulta();
		getTablaPlazas();
		getTablaProyectos();		

        jQuery.validator.addMethod("nombre", function (value, element) {
            if (/^[a-zA-Z_áéíóúñ\s]/.test(value)) {
                return true;
            } else {
                return false;
            };
        }, "* Debe comenzar con una letra.");

        arrancarTinyMCE();
        
        $(".divScroll").slimScroll({
            height:        "700px",
            width:         "none",
            railVisible:   true,
            alwaysVisible: true
        });
        getSolicitudResidenciaInv("divSolicitudResidencia");
	});

	function getAllProductosEDI(){
		$.ajax({
			type: "POST",
			url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
			data: {
				pkUsuario : '<cfoutput>#prc.pkUsuario#</cfoutput>'
			}
		}).done(function(data){
			$('#divSelectProductos').html(data);			
		});		
	}

	function getTablaSolicitudComite(elemtDiv){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.cargarTablaComite")#</cfoutput>', {
			fkPersona: $('#pkPersona').val()
		}, function(data){
			$('#'+elemtDiv).html(data);
			$('#tabla_comites .btn-editar-modal').hide();
			$('#tabla_comites .btn-borrar').hide();
		});
	}		

    function getTablaEscolaridad() {
        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.getTablaEscolaridad")#</cfoutput>', {
            pkPersona: $('#pkPersona').val()
        }, function( dataTabla ) {
            $("#contenidoTablaEscolaridad").html( dataTabla );
        });
    }

    function getTablaEscolaridadConsulta() {
        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.getTablaEscolaridadConsulta")#</cfoutput>', {
            pkPersona: $('#pkPersona').val()
        }, function( dataTabla ) {
            $("#contenidoTablaFormacionAcademicaConsulta").html( dataTabla );
        });
    }    

	function getTablaPlazas() {
        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.getTablaPlazas")#</cfoutput>', {
        	pkPersona: $('#pkPersona').val()
        }, function( dataTabla ) {
            $("#contenidoTablaPlazas").html( dataTabla );
        });
    }

    function getTablaProyectos() {
        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.getTablaProyectos")#</cfoutput>', {
        	pkPersona:     $('#pkPersona').val(),
			pkUsuario:     $('#pkUsuario').val(),
			pkMovimiento : $('#pkMovimiento').val()
        }, function( dataTabla ) {
            $("#contenidoTablaProyectos").html(dataTabla);
        });
    }

	$(".btn-verDoctoNivelSNI").on("click", function() {   
        var pkObjeto = $(this).attr('id_nivel');
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
            pkCatalogo: 896,//356,//798
            pkObjeto:   pkObjeto
        }, function(data) {
            cargarDocumento(data);
        });
    });

    $(".btn-verDoctoNivelSNIObs").on("click", function() {   
        var pkObjeto = $(this).attr('id_nivel');
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
            pkCatalogo: 896,
            pkObjeto:   pkObjeto
        }, function(data) {
            cargarDocumento(data);
        });
    });

    $(".btn-verDoctoRedes").on("click", function() {   
        var pkObjeto = $(this).attr('id_persona');
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
            pkCatalogo: 897,//357, //799
            pkObjeto:   pkObjeto
        }, function(data) {
            cargarDocumento(data);
        });
    });

    function consultaDocResidencia(aspiranate){
        var pkObjeto = aspiranate;
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
            pkCatalogo: 960,
            pkObjeto:   pkObjeto
        }, function(data) {
            cargarDocumento(data);
        });
    }

    function mostrarDoc(ruta){
    	$("#mdlDocsAyuda #objetoPfd").attr('data', ruta);
    	$("#mdlDocsAyuda").modal('show');
	}
	
	function mostrarResumenEvaluacion(){
		var pkUsuario = $('#pkUsuario').val();
		
		if ($("#tipoEvaluacion").val() == '' )
			pkTipoEvaluacion = $("#tipoEvaluacionRealizada").val();
		else
			pkTipoEvaluacion = $("#tipoEvaluacion").val();
		
		$.ajax({
			type: "POST",
			url: "<cfoutput>#event.buildLink('EDI.evaluacion.getResumenEvaluacion')#</cfoutput>",
			data: {
				pkUsuario : pkUsuario,
				pkTipoEvaluacion : pkTipoEvaluacion
			}			
		}).done(function(data) {
            $(".btnValEval").hide();
			$("#mdlResumenEvaluacionBody").html(data);
			$("#mdlResumenEvaluacion").modal('show');
            ocultaNivelSolicitud(false);
            <cfoutput>
	            <cfif #arraycontains(session.cbstorage.grant,'evalEDI.verTodos')#>
					ocultaNivelSolicitud(true);
					$("##divFormulario").empty();
					$("##divFormulario").append("<div id='nivelesForAdminEdi'></div>");
					
					<cfloop query="#prc.nivelesForAdminEdi#">
						$("##nivelesForAdminEdi").append("<div class='panel panel-default'><div class='panel-heading'><b>Nivel EDI asignado por #TIPO#:</b> #NIVEL#</div><div class='panel-body'>#JSStringFormat(ReplaceNoCase((REReplaceNoCase(REReplaceNoCase(OBSERVACION,"<!--(.*)-->","","ALL"),"<[^>]*>","","ALL")),chr(10)," ","all"))#</div></div>");
					</cfloop>
				</cfif>
			</cfoutput>
		});
	}

    /*
    * Descripcion:  Muestra y oculta elementos de captura nilel y observaciones y pestaña Solicitud
    * Fecha:        Febrero de 2018
    * @author:      jlgc
    * @param:       false oculta true muestra
    */
    function ocultaNivelSolicitud(param) {
        if (param) {
            $("#divFormulario").removeClass('col-md-0').addClass('col-md-2').removeClass('hide');
            $("#mdlResumenEvaluacionBody").removeClass('col-md-12').addClass('col-md-10');
            $("#tabResSol").removeClass('hide');
            $("#tabActAlt").removeClass('hide');
        }
        else {
            $("#divFormulario").removeClass('col-md-2').addClass('col-md-0').addClass('hide');
            $("#mdlResumenEvaluacionBody").removeClass('col-md-10').addClass('col-md-12');
            $("#tabResSol").addClass('hide');
            $("#tabActAlt").addClass('hide');
        }
    }

    /*
    * Descripcion: 	Lanza modal para registrar un comentario
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
    function modalComentarEval(pkEval) {
    	$(".saveComentario").show();
		$(".guardaComent").show();
		$(".getComentario").hide();
        arrancarTinyMCE();
    	$(".mdl-comentarEval").modal('show');
		$("#pkEvalComent").val(pkEval);
    }


    /*
    * Descripcion: 	Guarda el comentario de una evaluacion
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
	function saveComentEval() {
		var contComent 	= tinyMCE.get("inContentCorreo").getContent();
		
		if(	contComent.indexOf('OfficeDocumentSettings') !== -1){
			alert('Lo sentimos pero no podemos guardar comentarios provenientes de MSWORD.');
			tinyMCE.get("inContentCorreo").setContent('');
			return;	
		}
		
		
		var pkEval 		= $("#pkEvalComent").val();
		$.post('<cfoutput>#event.buildLink("EDI.evaluacion.guardaComentarioEvaluacion")#</cfoutput>',{
			pkEvaluacion: $("#pkEvalComent").val(),
			contenido:    contComent
		}, function(data){
			if (data > 0){
				toastr.success('Comentario guardado correctamente');
				$(".mdl-comentarEval").modal('hide');

				if (! contComent.length){
					$("#coment2_"+pkEval+"").hide();
					$("#botCom_"+pkEval+"").remove();
					$("#coment1_"+pkEval+"").append("<div id='botCom_" +pkEval+"' ><button class='btn btn-primary fa fa-comment' title='Comentar evaluacion' onclick='modalComentarEval("+pkEval+");'></button></div>");
				}else {
					$("#botCom_"+pkEval+"").hide();
					$("#coment2_"+pkEval+"").remove();
					$("#coment1_"+pkEval+"").append("<div id='coment2_" +pkEval+"' onclick='editaComentario("+pkEval+")'></div>");
					$("#coment2_"+pkEval+"").html(contComent);
				}
			}
			tinyMCE.get("inContentCorreo").setContent('');
            cancelarTinyMCE();
		});
	}

    /*
    * Descripcion: 	Lanza modal para mostrar clasificaciones
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
    function cambiarReclasificacion(pkEvalEtapa, tipoPuntuacion) {
    	$("#reclasificaProducto").val(pkEvalEtapa);
    	$("#tipoPuntuacion").val(tipoPuntuacion);
    	$(".modal_reclasificacion").modal('show');
    }

    /*
    * Descripcion: 	Guarda el comentario de una evaluacion
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
    function validarEvaluacion(accion, pkRegistro, tipoEval) {
		//Define si pinta la asignacion de residencia y/o año de gracia considerado solo en la evaluacion del CA.
		if($("#tipoEvaluacion").val() == 3){
			$("#elemAsignacion").empty();
			$("#nivelesAsignacion").empty();
			<cfoutput>
				<cfif (#prc.pkMovimiento# EQ #application.SIIIP_CTES.MOVIMIENTO.REINGRESO_RESIDENCIA#) OR (#prc.pkMovimiento# EQ #application.SIIIP_CTES.MOVIMIENTO.INGRESO_RESIDENCIA#)>
					$("##elemAsignacion").append("<br><label class='control-label'>Residencia:</label><br><div class='radio radio-primary radio-inline'><input value='1' name='inResidencia' type='radio'><label><i class='fa fa-lg fa-check'></i> Sí</label></div><div class='radio radio-primary radio-inline'><input value='0' name='inResidencia' checked='checked' type='radio'><label><i class='fa fa-lg fa-close'></i> No</label></div><br>");
				</cfif>
				<cfif #prc.anioGracia#>
					$("##elemAsignacion").append("<br><label class='control-label'>Año de gracia:</label><br><div class='radio radio-primary radio-inline'><input value='1' name='inGracia' type='radio'><label><i class='fa fa-lg fa-check'></i> Sí</label></div><div class='radio radio-primary radio-inline'><input value='0' name='inGracia' checked='checked' type='radio'><label><i class='fa fa-lg fa-close'></i> No</label></div>");
				</cfif>
				<cfif #prc.dispensa#>
					$("##elemAsignacion").append("<br><label class='control-label'>Dispensa:</label><br><div class='radio radio-primary radio-inline'><input value='1' name='inDispensa' type='radio' onclick='comboDispensa(1);'><label><i class='fa fa-lg fa-check'></i> Sí</label></div><div class='radio radio-primary radio-inline'><input value='0' name='inDispensa' checked='checked' type='radio' onclick='comboDispensa(0);'><label><i class='fa fa-lg fa-close'></i> No</label></div><div id='selectDisp'></div>");
				</cfif>

				<cfloop query="#prc.nivelesEvaluados#">
					$("##nivelesAsignacion").append("<br><button type='button' class='form-control' data-toggle='tooltip' title='Observaci&oacute;n: #JSStringFormat(ReplaceNoCase((REReplaceNoCase(REReplaceNoCase(OBSERVACION,"<!--(.*)-->","","ALL"),"<[^>]*>","","ALL")),chr(10)," ","all"))#'><b>Nivel EDI asignado por #TIPO#:</b> #NIVEL#</button>");
				</cfloop>
			</cfoutput>
		}

    	var pkUsuario = $('#pkUsuario').val();
		$.ajax({
			type: "POST",
			url: "<cfoutput>#event.buildLink('EDI.evaluacion.getResumenEvaluacion')#</cfoutput>",
			data: {
				pkUsuario : pkUsuario,
				pkTipoEvaluacion : tipoEval
			}			
		}).done(function(data) {
			$("#accionValSol").val(accion);
			$("#pkAspProcValSol").val(pkRegistro);
			$("#pkTipoEvaluacionValSol").val(tipoEval);
			$(".btnValEval").show();
			$("#mdlResumenEvaluacionBody").html(data);
			$("#mdlResumenEvaluacion").modal('show');
      ocultaNivelSolicitud(true);
      getObservaciones();
      $("#falgTabResumenSolicitudes").val(0);
      $("#falgTabActivAlternas").val(0);      
		});
    }


    /*
    * Descripcion: 	Guarda el comentario de una evaluacion
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
    function cambiaEdoAspProc() {

		var validar = $("#formObservacionesNivel").validate( {
			rules: {
				ddlNivelEDI:  {required: true},
				inResidencia: {required: true},
				inGracia: 	  {required: true},
				inDispensa:   {required: true},
				opcDispensa:  {required: true}
			},
			messages: {
				ddlNivelEDI:  {required: "Debe seleccionar el nivel EDI"}
			}
		});

		var observacion = tinyMCE.activeEditor.getContent();
				
				if(	observacion.indexOf('OfficeDocumentSettings') !== -1){
					alert('Lo sentimos pero no podemos guardar comentarios provenientes de MSWORD.');
					tinyMCE.activeEditor.setContent('');
					return;	
				}

		swal({
			title:             "&iquest;Desea validar la evaluaci&oacute;n?",
			text:              "Para realizar la acci&oacute;n debe seleccionar el nivel EDI",
			type:              "warning",
			confirmButtonText: "Aceptar",
			cancelButtonText:  "Cerrar",
			showCancelButton:  true,
			closeOnConfirm:    true,
			html:              true
		}, function () {
			
			if(validar.form()){							
				var residencia  = $("input[name=inResidencia]:checked").val() == undefined ? -1 : $("input[name=inResidencia]:checked").val();
				var anioGracia  = $("input[name=inGracia]:checked").val() 	  == undefined ? -1 : $("input[name=inGracia]:checked").val();
				var dispensa    = $("input[name=inDispensa]:checked").val()   == undefined ? -1 : $("input[name=inDispensa]:checked").val();
				var artDispensa = $("#opcDispensa option:selected").val()    == undefined ? '' : $("#opcDispensa option:selected").val();
				$.post('<cfoutput>#event.buildLink("EDI.evaluacion.cambiaEstadoEvalAspiranteProceso")#</cfoutput>',{
					accion:      $("#accionValSol").val(),
					pkRegistro:  $("#pkAspProcValSol").val(),
					tipoEval:    $("#pkTipoEvaluacionValSol").val(),
					pkEvaluado:  $("#pkUsuarioEvaluado").val(),
					pkNivel:     $("#ddlNivelEDI").val(),
					residencia:  residencia,
					anioGracia:  anioGracia,
					dispensa: 	 dispensa,
					artDispensa: artDispensa,
					observacion: observacion
				}, function(data){
                    if (data.EXITO){                    		
                    		cambiaEstadoEvaluacionEscolaridad($("#accionValSol").val());				
                        $("#mdlResumenEvaluacion").modal('hide');
                        toastr.success('Validaci&oacute;n de la evaluaci&oacute;n realizada correctamente');
                        $.ajax({
                            type: "POST",
                            url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
                            data: {
                                pkUsuario: $('#pkUsuario').val()
                            }
                        }).done(function(data){
                            $('#divSelectProductos').html(data);
                        });
                        getTablaInvestigadores();
                    }else{
                        toastr.error('Verifique que haya evaluado todos los productos del investigador');
                    }
                });
            }
        });
    }

    /*
    * Descripcion: 	Quitar reclasificación
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
    function desReclasificar(pkEtapa) {
        swal({
            title:              "&iquest;Quitar reclasificaci&oacute;n?",
            type:               "warning",
            confirmButtonColor: "#00303F",
            confirmButtonText:  "Aceptar",
            cancelButtonText:   "Cancelar",
            showCancelButton:   true,
            closeOnConfirm:     true,
            showLoaderOnConfirm:true,
            html:               true
        }, function () {
           $.post('<cfoutput>#event.buildLink("EDI.evaluacion.quitarReclasificacion")#</cfoutput>',{
				pkEtapa: pkEtapa
			}, function(data){
				if (data > 0){
					toastr.success('Reclasificaci&oacute;n eliminada correctamente');
					$.ajax({
						type: "POST",
						url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
						data: {
							pkUsuario: $('#pkUsuario').val()
						}									
					}).done(function(data){
						$('#divSelectProductos').html(data);					
					});
				}
			});
        });
    }

    /*
    * Descripcion: 	Crea el arreglo de puntajes y evaluaciones
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
	$('.validaEvaluacion2').click(function(){
   		var puntajesEva = [];

		if(validacion.form()){
	    	var clasif = $('#clasifSeleccionada').val();
			var subClasif = $('#subClasifSeleccionada').val();

		    $('.guardaFija:visible').each(function() {
				pkEtapa 	 = $(this).attr('pk_etapa');
		        puntajes	 = $(this).val();
				pkEvaluacion = $(this).attr('pk_evaluacion');
				accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');
			    puntajesEva.push({pkEtapa, puntajes, pkEvaluacion, accion});
			});

			$('.guardaContinua:visible').each(function() {
	        	pkEtapa 	 = $(this).attr('pk_etapa');
		        puntajes	 = $(this).val();
				pkEvaluacion = $(this).attr('pk_evaluacion');
				accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');
		        puntajesEva.push({pkEtapa, puntajes, pkEvaluacion, accion});
		    });

		    $('.guardaHoras:visible').each(function() {
	        	pkEtapa 	 = $(this).attr('pk_etapa');
		        puntajes	 = $(this).val();
				pkEvaluacion = $(this).attr('pk_evaluacion');
				accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');
		        puntajesEva.push({pkEtapa, puntajes, pkEvaluacion, accion});
		    });

			guardaPuntajes(puntajesEva);
			puntajesEva = [];
		}
	});

	/*
    * Descripcion: 	Guarda puntajes y cambia el estado de la evaluación
    * Fecha: 		Enero de 2018
    * @author: 		Alejandro Tovar
    */
	function guardaPuntajes(puntajes) {
    	$.post('<cfoutput>#event.buildLink("EDI.evaluacion.guardaPuntajeProducto")#</cfoutput>',{
			puntajes: JSON.stringify(puntajes)
		}, function(data){
			if(data >= 1){
				toastr.success('Evaluaci&oacute;n realizada correctamente');
				$.ajax({
					type: "POST",
					url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
					data: {
						pkUsuario: $('#pkUsuario').val()
					}									
				}).done(function(data){
					$('#divSelectProductos').html(data);					
				});				
			}else{
				toastr.error('Verificar que exista un puntaje asignado a cada producto');
			}
		});
    }


    /*
    * Descripcion: 	Guarda puntajes de cero e ingresa un motivo
    * Fecha: 		Febrero de 2018
    * @author: 		Alejandro Tovar
    */
	function guardaCero() {

		var valMotivo = $("#validaMotivo").validate({
			rules: {
				inMotivo: {required: true}
			},submitHandler: function(form) {
				return true;
			}
		});

		if(valMotivo.form()){
			puntajesCero = [];
			var etapaCero 		= $("#pkEtapaCero").val();
			var evaluacionCero 	= $("#pkEvaluacionCero").val();
			var accionCero 		= $("#accionCero").val();
			var motivoCero 		= $("#inMotivo").val();

			if( Number($("#accionCero").val()) >= 0 ){
				accionCero = 0;
			}

			puntajesCero.push({etapaCero, puntajes:0, evaluacionCero, accionCero, motivoCero});

	    	$.post('<cfoutput>#event.buildLink("EDI.evaluacion.guardaPuntajeProductoCero")#</cfoutput>',{
				puntajes: JSON.stringify(puntajesCero)
			}, function(data){
				if(data >= 1){
					toastr.success('Evaluaci&oacute;n realizada correctamente');
					$.ajax({
						type: "POST",
						url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
						data: {
							pkUsuario: $('#pkUsuario').val()
						}									
					}).done(function(data){
						$('#divSelectProductos').html(data);					
					});				
				}else{
					toastr.error('Verificar que exista un puntaje asignado a cada producto');
				}

				$("body .modal-backdrop").remove();
				$("body").removeClass('modal-open');
				$("body").removeAttr('style');
			});
	    }
    }

    function guardarRegistroObservaciones(){
        var PkAspProc     = $("#pkAspiranteProceso").val();
        var PkTipoEva     = $("#tipoEvaluacion").val();
        var observaciones = tinyMCE.activeEditor.getContent();

		if(	observaciones.indexOf('OfficeDocumentSettings') !== -1){
			alert('Lo sentimos pero no podemos guardar comentarios provenientes de MSWORD.');
			tinyMCE.activeEditor.setContent('');
			return;	
		}

        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.guardarObservacion")#</cfoutput>', {
            PkAspProc:     PkAspProc,
            PkTipoEva:     PkTipoEva,
            observaciones: observaciones
        }, function(data) {
            cancelarTinyMCE();
            $("#mdl-registroObservaciones").modal('hide');
            if ($.isNumeric(data)  && data > 0) {
                swal("Se registro la observacion", null, "success");
            }
            else {
                swal("Error al registrar la observacion", null, "error");
            }
        });
    }

    function getObservaciones(){
        var PkNivelSNI    = $("#verDoctoNivelSNI").attr("id_nivel");
        var NomNivelSNI   = $('#inNIvelSNI').text();
        $("#inNivelSNIObs").text(NomNivelSNI);
        $("#verDoctoNivelSNIObs").attr("id_nivel",PkNivelSNI);

        var PkAspProc     = $("#pkAspiranteProceso").val();
        var PkTipoEva     = $("#tipoEvaluacion").val();
        
        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.getObservacion")#</cfoutput>', {
           PkAspProc:     PkAspProc,
           PkTipoEva:     PkTipoEva
        }, function(data) {
            arrancarTinyMCE();
            if (data.ROWCOUNT > 0){
                tinyMCE.get("inComent").setContent(data.DATA.OBSERVACION[0]);
                tinyMCE.get("inObservaciones").setContent(data.DATA.OBSERVACION[0]);
            }
        });
    }

    function getSolicitudResidenciaInv(div){
        var PkAspProc = $("#pkAspProcListInv").val();

        $.post('<cfoutput>#event.buildLink("EDI.evaluacion.getSolicitudResidenciaInv")#</cfoutput>', {
           PkAspProc:     PkAspProc
        }, function(data) {

            if (data.ROWCOUNT > 0 && data.DATA.SOLICITUD[0] != null){
                llenaSolicitudResidenciaInv(PkAspProc, div, data.DATA.SOLICITUD[0]);
            }
        });
    }

    function llenaSolicitudResidenciaInv(PkAspProc, nomDiv, textSolicitud){
        var contenido = "";
        contenido =  " <div class='panel panel-default'>" +
                     "   <div class='panel-heading'><i class='fa fa-building-o'></i>" + 
                     "       <strong>Solicitud de residencia</strong> " +
                     "       <button class='btn btn-success pull-right' style='margin-right: -13px; margin-top: -8px !important;' data-tooltip='tooltip' title='Documento Solicitud de residencia' onclick='consultaDocResidencia(" + PkAspProc + ");'><i class='fa fa-file'></i></button>" + 
                     "   </div>" +
                     "   <div class='panel-body'>" + textSolicitud + "</div>" +
                     " </div>";
        $('#'+nomDiv).html(contenido);
    }

    function cancelarTinyMCE(){
        tinymce.remove();
        tinymce.execCommand('mceRemoveEditor', true);
    }

    function arrancarTinyMCE(){
        tinymce.init({
            selector: "textarea#inComent,#inObservaciones,#inContentCorreo",
            language: 'es_MX',
            height:   250,
            resize:   false,
            menubar:  false,
    		statusbar: false,
            toolbar:  'bold italic | alignleft aligncenter alignright alignjustify'
        });
    }

    /*
    * Descripcion: 	Mantiene la residencia del investigador
    * Fecha: 		Febrero de 2018
    * @author: 		Alejandro Tovar
    */
    function mantenerResidencia(accion, pkAspProc, pkPersona, evaluacion) {
  		swal({
            title:             "&iquest;Desea validar informe de actividades (residencia)?",
            type:              "warning",
            confirmButtonText: "Aceptar",
            cancelButtonText:  "Cerrar",
            showCancelButton:  true,
            closeOnConfirm:    true,
            html:              true
        }, function () {
            $.post('<cfoutput>#event.buildLink("EDI.evaluacion.evaluarResidencia")#</cfoutput>', {
	           accion:    accion,
	           pkAspProc: pkAspProc,
	           pkPersona: pkPersona,
	           evaluacion: evaluacion
	        }, function(data) {
	            if (data.EXITO){
                    toastr.success('Acci&oacute;n ejecutada correctamente');
                    $.ajax({
                        type: "POST",
                        url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
                        data: {
                            pkUsuario: $('#pkUsuario').val()
                        }
                    }).done(function(data){
                        $('#divSelectProductos').html(data);
                    });
                    getTablaInvestigadores();
                }else{
                    toastr.error('Error al asignar residencia del investigador');
                }
	        });
        });
    }
    
    <!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
   	* descripcion: abre la vista para editar un producto
	 --->
    function editarFila (formato, periodo, reporte,pkfila) {
		$('#formularioLlenado').html('');
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.editarproductoEvaluado")#</cfoutput>', {
			formato: formato,
			periodo: periodo,
			reporte: reporte,
		}, function(data){
			$("#boxesContraparte").show();
			$(".divevaluacionInvr").slideToggle( 1000,'easeOutExpo');
			$('#formularioLlenado').html(data);	
			$("#pkFila").val(pkfila);
			obtenerDatosFila(pkfila);
		});
    }
    
    <!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
   	* descripcion: cierra la vista para editar un producto
    --->
	function cierraPanelCelda(){
		$("#boxesContraparte").slideToggle( 1000,'easeOutExpo');
		$(".divevaluacionInvr").show();
	}
    
    <!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
   	* descripcion: funcion que se ejecuta en la respuesta del guardado de la edicion de una fila
    --->
    function cargaTabla(){
		$(".divevaluacionInvr").show();
    	$.ajax({
					type: "POST",
					url: "<cfoutput>#event.buildLink("EDI.evaluacion.verProductosTodos")#</cfoutput>",
					data: {
						pkUsuario: $('#pkUsuario').val()
					}									
				}).done(function(data){
					$('#divSelectProductos').html(data);					
				});
    }
 	<!---
    * Fecha: Febrero 2018
    * @author: Marco Torres
   	* descripcion: envia un producto evaluado a la evaluacion actual
	 --->
    function enviarToEvaluacion(pkfila) {
    	
    	swal({
				title:             "&iquest;Estas seguro que deseas enviar el producto al proceso de evaluaci&oacute;n actual?",
				text:              "Se perderan las evaluaciones de este producto",
				type:              "warning",
				confirmButtonText: "Aceptar",
				cancelButtonText:  "Cerrar",
				showCancelButton:  true,
				closeOnConfirm:    true,
				html:              true
			}, function () {
					$.post('<cfoutput>#event.buildLink("EDI.evaluacion.enviarToEvaluacion")#</cfoutput>', {
						pkfila: pkfila
					}, function(data){
						 cargaTabla();
					});
			}
    	);
    }

    function comboDispensa(argument) {
    	if (argument == 1){
    		$("#selectDisp").append("<select id='opcDispensa' name='opcDispensa' class='form-control'><option value=''>Seleccioar opción...</option><option value='Art_13_FIII'>Art 13 FIII</option><option value='Art_13_FIV'>Art 13 FIV</option></select>");
    	}else {
    		$("#selectDisp").empty();
    	}
    }

</script>