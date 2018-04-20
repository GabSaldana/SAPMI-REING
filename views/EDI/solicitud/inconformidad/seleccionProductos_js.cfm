<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de registro de inconformidades
* Descripcion: Contenido js que sera usado por la vista
* Autor:       JLGC    
* ================================
--->

<script type="text/javascript">
	var form = $("#formInconformidad").show();
	form.steps( {
		headerTag:        "h3",
		bodyTag:          "section",
		transitionEffect: "slideLeft",
		labels: {
			cancel:   "Cancelar",
			finish:   "Aplicar",
			next:     "Siguiente",
			previous: "Anterior"
		},
		onStepChanging: function (event, currentIndex, newIndex) {
			// Permite accion previa
			if (currentIndex > newIndex) {
				return true;
			}
			
			// Pasa a captura de observacion
			if (newIndex == 1) {
				return true;
			}

			// Limpieza al regresar
			if (currentIndex < newIndex) {
				form.find(".body:eq(" + newIndex + ") label.error").remove();
				form.find(".body:eq(" + newIndex + ") .error").removeClass("error");
			}
			return form.valid();
		},
		onStepChanged: function (event, currentIndex, priorIndex) { },
		onFinishing: function (event, currentIndex) {
			return form.valid();
		},
		onFinished: function (event, currentIndex) {
			<cfoutput>
				<cfif #prc.validaciones.ACCIONESCVE[1]# NEQ ''>
					cambiarEstadoSol('#prc.validaciones.ACCIONESCVE[1]#', #prc.validaciones.PK_ASCPROC[1]#);
				<cfelse>
					$('##panelInconformidad').toggle("slow");
					$('##elemSolicitudes').toggle("slow");
				</cfif>
			</cfoutput>
		}
	});

	$(document).ready(function() {
		$("#otrosAdjuntosN").empty();
		otrosAdjuntos();

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

		getNarracion();

		<cfif #prc.validaciones.CESESTADO[1]# EQ #application.SIIIP_CTES.ESTADO.APLICO_RI#>
			$(".checkInconformar").hide();
			$("#inHechos").attr('disabled', true);
		</cfif>
	});

	function ordenarProductos(selector){
		return $($(selector).toArray().sort((a,b) => {
		var clasifA = parseInt($(a).data('clasif'));
		var clasifB = parseInt($(b).data('clasif'));
		var subclasifA = parseInt($(a).data('subclasif'));
		var subclasifB = parseInt($(b).data('subclasif'));      
		return clasifA - clasifB || subclasifA - subclasifB;      
    	}));        
    }

	$(function(){

    	var productosOrdenados = ordenarProductos('.producto');    
        var clasif_array = [];
        $.each(productosOrdenados,(indice,elemento) => clasif_array.push($(elemento).data('clasif')));
        clasif_array = clasif_array.filter((indice,elemento) => clasif_array.indexOf(elemento) == indice);              
        $.each(productosOrdenados,(indice,elemento) => {
            var clasificacion = $(elemento).data('clasif');
            var subclasificacion = $(elemento).data('subclasif');
            var clasificacionNombre = $(elemento).data('clasif');
            var anio = $(elemento).data('anio');
            $('#tableBody_'+clasificacion).append(elemento);
        });
        $.each($('.producto_anio'), (indice,elemento) => { 
                if(!$(elemento).find('.producto').length){
                    $(elemento).parent().hide();                    
                }   
        });

        $('.minimizarCategoria').click(function (e) { 
            var data_abierto = $(this).data('abierto');
            if(data_abierto){           
                $(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
                $(this).parent().parent().parent().find('.prodContainer').slideUp(300);
            }else{
                $(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
                $(this).parent().parent().parent().find('.prodContainer').slideDown(300);
            }   
        });

        $('.minimizarProducto').click(function (e) { 
            var data_abierto = $(this).data('abierto');
            if(data_abierto){           
                $(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
                $(this).parent().parent().find('.panel-body').slideUp(250);
            }else{
                $(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
                $(this).parent().parent().find('.panel-body').slideDown(250);
            }       
        });   

    });

	$('body').undelegate('.selectInconformidad', 'click');
	$('body').on('click', '.selectInconformidad', function(){
		$("#inPkProducto").val($(this).attr('evaluacionProductoEDI'));
		$("#inPkFila").val($(this).attr('fila'));
		$("#inSelection").val($(this).attr('selectionInc'));
		pkEstado = $(this).is(":checked")? true:false;
		tinyMCE.get("inComent").setContent('');

		if (pkEstado) {
			$("#mdl-registroInconformidad").modal('show');
		}
		else {
			swal({
				title:              "&iquest;Desea quitar la inconformidad?",
				text:               "Perdera la descripcci&oacute;n",
				type:               "info",
				confirmButtonColor: "#00303F",
				confirmButtonText:  "Quitar",
				cancelButtonText:   "Cerrar",
				showCancelButton:   true,
				closeOnConfirm:     false,
				showLoaderOnConfirm:true,
				html:               true,
				cancel: { className: "CheckReresh"}
			}, function (isConfirm) {
				if (isConfirm) {
					eliminarInconformidad();
				} else {
					checkOrigenSelect();
				}
			});
		}
	});

	$('body').on('click', '.CheckReresh', function(){
		checkOrigenSelect();
	});

	function descargaComprobanteConsulta(pkformato, pkfila, pkcol){
		$("#pkColDownInv").val(pkcol);
		$("#pkFilaDownInv").val(pkfila);
		$("#pkCatFmtInv").val(pkformato);
		$('#downloadComprobanteInv').submit();
	}

	function checkOrigenSelect(){
		var fila      = $("#inPkFila").val();
		var selection = $("#inSelection").val();

		if(selection == 2) {
			$("#checkInconf" + fila).prop('checked', true);
		} else {
			$("#checkInconf" + fila).prop('checked', false);
		}
	}

    var totElementos = parseInt($("#hElementSeleccion").val());
	function guardarInconformidad(){
        var PkProducto = $("#inPkProducto").val();
        var fila       = $("#inPkFila").val();
        var descripcionInconformidad = tinyMCE.activeEditor.getContent();
		
		if(	descripcionInconformidad.indexOf('OfficeDocumentSettings') !== -1){
			alert('Lo sentimos pero no podemos guardar comentarios provenientes de MSWORD.');
			tinyMCE.activeEditor.setContent('');
			return;	
		}
		
		
        $.post('<cfoutput>#event.buildLink("EDI.solicitud.guardaRecursoInconformidad")#</cfoutput>', {
            PkProducto:               PkProducto,
            descripcionInconformidad: descripcionInconformidad
        }, function(data) {
            $("#mdl-registroInconformidad").modal('hide');
            $("#checkInconf" + fila).attr('selectionInc', 2);
            if ($.isNumeric(data)  && data > 0) {
                swal("Se realizo el registro del recurso de inconformidad", null, "success");
                totElementos = totElementos + 1;
                elementosSeleccion(totElementos);
            }
            else {
                swal("Error al registrar el recurso de inconformidad", null, "error");
            }
        });
    }

	function guardarNarracion(){
		var PkPersona = '<cfoutput>#SESSION.cbstorage.persona.PK#</cfoutput>';
		var PkProceso = $("#inPkProceso").val();
		var hechos = $("#inHechos").val();
		
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.guardaNarracion")#</cfoutput>', {
			PkPersona: PkPersona,
			PkProceso: PkProceso,
			hechos:    hechos
		}, function(data) {
			if ($.isNumeric(data)  && data > 0) {
				swal({
					title: "Se aplic&oacute; al recurso de inconformidad",
					text:  null,
					type:  "success",
					html:  true
				});
			}else {
				swal("Error al aplicar al recurso de inconformidad", null, "error");
			}
		});
	}

	function getNarracion(){
		var PkPersona = '<cfoutput>#SESSION.cbstorage.persona.PK#</cfoutput>';
		var PkProceso = $("#inPkProceso").val();
		
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.getNarracion")#</cfoutput>', {
			PkPersona: PkPersona,
			PkProceso: PkProceso
		}, function(data) {
			if (data.ROWCOUNT > 0){
				$("#inHechos").val(data.DATA.NARRACION);
			}
		});
	}

    function eliminarInconformidad(){
        var PkProducto = $("#inPkProducto").val();
        var fila       = $("#inPkFila").val();

        $.post('<cfoutput>#event.buildLink("EDI.solicitud.eliminaRecursoInconformidad")#</cfoutput>', {
            PkProducto: PkProducto
        }, function(data) {
        	$("#checkInconf" + fila).attr('selectionInc', 0);
            if ($.isNumeric(data)  && data > 0) {
                swal({
                    title: "Se realizo la eliminaci&oacute;n del recurso de inconformidad",
                    text:  null,
                    type:  "success",
                    html:  true
                });
                totElementos = totElementos - 1;
                elementosSeleccion(totElementos);
            }
            else {
                swal("Error al eliminar el recurso de inconformidad", null, "error");
            }
        });
    }

    function elementosSeleccion(totElementos){
        $("#hElementSeleccion").val(totElementos);
        $("#divTotElements").html("<span class='fa fa-check-square-o'></span>&nbsp;&nbsp;Productos seleccionados: <span class='badge' style='color: #b77021; font-size: 20px;'>" + totElementos + "</span>");
    }

	function otrosAdjuntos(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 920,
			requerido: 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: '<cfoutput>#prc.validaciones.PK_ASCPROC[1]#</cfoutput>',
			recargar: 'otrosAdjuntos()'
		}, function(data) {
			$("#otrosAdjuntos").html(data);
		});
	}

	function otrosAdjuntosN(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaOtros")#</cfoutput>', {
			documentos: 920,
			requerido: 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: '<cfoutput>#prc.validaciones.PK_ASCPROC[1]#</cfoutput>',
			recargar: 'otrosAdjuntos()'
		}, function(data) {
			$("#otrosAdjuntosN").html(data);
		});
	}

	function cambiarEstadoSol(accion, pkAspProc) {
		swal({
			title:             "&iquest;Desea aplicar al recurso de inconformidad?",
			type:              "warning",
			confirmButtonText: "Aceptar",
			cancelButtonText:  "Cerrar",
			showCancelButton:  true,
			closeOnConfirm:    true,
			html:              true
		}, function () {
			$.post('<cfoutput>#event.buildLink("EDI.evaluacion.cambiarEstadoSolicitudSimple")#</cfoutput>', {
				accion:    accion,
				pkAspProc: pkAspProc
			}, function(data) {
				if (data.EXITO){
					guardarNarracion();
					$('#panelInconformidad').toggle("slow");
        			$('#elemSolicitudes').toggle("slow");
				}else{
					toastr.error('Error al aplicar recurso de inconformidad');
				}
			});
		});
	}
</script>