<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de registro de solicitudes al comite
* Fecha:       28 de diciembre de 2017
* Descripcion: Contenido js que sera usado por la vista
* Autor:       JLGC    
* ================================
--->
<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">  

    <!--- 
    * Descripcion:    Llena contenidoTablaComite
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    function getTablaComite() {
        var persona     = '<cfoutput>#SESSION.cbstorage.persona.PK#</cfoutput>';

        $.post('<cfoutput>#event.buildLink("EDI.solicitud.cargarTablaComite")#</cfoutput>', {
            fkPersona: persona
        }, function( dataTabla ) {
            $("#contenidoTablaComite").html( dataTabla );
        });
    }

    function limpiaFormulario() {
        $("#formComite")[0].reset();
        $(".form-control").removeClass('error');
        $("#btn-admon-comite").html('<span class="glyphicon glyphicon-floppy-disk"></span> Guardar comite');
        $("#hfPkComite").val(0);
        $("#docComiteNuevo").html('');
        $("#docComite").html('');

        $("#formComiteEdit")[0].reset();
        $("#mdl-admon-comite").modal('hide');
    }

    $.validator.addMethod("valueNotEquals", function(value, element, arg) { return arg !== value; });
    
    function validarComite() {
        var validar = $("#formComite").validate( {
            rules: {
                ddlTipo:       {valueNotEquals: "0"},
                inDescripcion: {required: true, nombre: true}
            },
            messages: {
                ddlTipo:  {valueNotEquals: "Debe seleccionar el tipo de solicitud"}
            }  
        }); 
        return validar.form();
    }

    function validarComiteModal() {
        var validar = $("#formComiteEdit").validate( {
            rules: {
                ddlTipoEdi:       {valueNotEquals: "0"},
                inDescripcionEdi: {required: true, nombre: true}
            },
            messages: {
                ddlTipoEdi:  {valueNotEquals: "Debe seleccionar el tipo de solicitud"}
            }  
        }); 
        return validar.form();
    }

    function agregarComite() {
        
        var persona     = '<cfoutput>#SESSION.cbstorage.persona.PK#</cfoutput>';
        var proceso     = '<cfoutput>#prc.proceso.getpkproceso()#</cfoutput>';
        var tipo        = $("#ddlTipo").val();
        var descripcion = $("#inDescripcion").val();

        $.post('<cfoutput>#event.buildLink("EDI.solicitud.agregarComite")#</cfoutput>', {
            fkPersona:   persona,
            fkProceso:   proceso,
            descripcion: descripcion,
            fkTipo:      tipo,
            fkEstado:    0
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                docComiteNuevo(data);
                $("#hfPkComite").val(data);
            } else {
                swal("Error al agregar la solicitud al comite", null, "error");
            }
        });
    }

    function editarComite() {
        var PkComite = $("#hfPkComite").val();

        var persona     = '<cfoutput>#SESSION.cbstorage.persona.PK#</cfoutput>';
        var proceso     = '<cfoutput>#prc.proceso.getpkproceso()#</cfoutput>';
        var tipo        = $("#ddlTipo").val();
        var descripcion = $("#inDescripcion").val();

        $.post('<cfoutput>#event.buildLink("EDI.solicitud.editarComite")#</cfoutput>', {
            PkSolicitud: PkComite,
            fkPersona:   persona,
            fkProceso:   proceso,
            descripcion: descripcion,
            fkTipo:      tipo
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                docComiteNuevo(data);
            } else {
                swal("Error al editar el comite", null, "error");
            }
        });
    }

    function editarComiteModal() {
        var PkComite = $("#hfPkComite").val();

        if(validarComiteModal()) {
            var persona     = '<cfoutput>#SESSION.cbstorage.persona.PK#</cfoutput>';
            var proceso     = '<cfoutput>#prc.proceso.getpkproceso()#</cfoutput>';
            var tipo        = $("#ddlTipoEdi").val();
            var descripcion = $("#inDescripcionEdi").val();

            $.post('<cfoutput>#event.buildLink("EDI.solicitud.editarComite")#</cfoutput>', {
                PkSolicitud: PkComite,
                fkPersona:   persona,
                fkProceso:   proceso,
                descripcion: descripcion,
                fkTipo:      tipo
            }, function(data) {
                if ($.isNumeric(data)  && data > 0) {
                    swal("La solicitud al comite fue editada con exito", null, "success");
                    getTablaComite();
                    limpiaFormulario();
                    $("#ddlTipo").val("0");
                    $("#btn-admon-comite").html('<span class="glyphicon glyphicon-floppy-disk"></span> Guardar solicitud');
                } else {
                    swal("Error al editar el comite", null, "error");
                }
            });
        }
    }

    function eliminarComite(PkSolicitud) {
        $.post('<cfoutput>#event.buildLink("EDI.solicitud.eliminarComite")#</cfoutput>', {
            PkSolicitud: PkSolicitud,
            fkEstado:    0
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("La solicitud al comite fue eliminada con exito", null, "success");
                limpiaFormulario();
                getTablaComite();
            } else {
                swal("Error al eliminar la solicitud al comitea", null, "error");
            }
        });
    }

    function docComite(pkComite){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 881,
            requerido:  1,
            extension:  JSON.stringify(['txt', 'pdf']),
            convenio:   pkComite,
            recargar:   'docComite('+pkComite+');'
        }, function(data) {
            $("#docComite").html(data);
        });
    }

    function docComiteNuevo(pkComite) {
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 881,
            requerido:  1,
            extension:  JSON.stringify(['txt', 'pdf']),
            convenio:   pkComite,
            recargar:   'docComiteNuevo('+pkComite+');'
        }, function(data) {
            $("#docComiteNuevo").html(data);
            $('.modal-backdrop').remove();
        });
    }
       
    var form = $("#formComite").show();
    form.steps( {
        headerTag:        "h3",
        bodyTag:          "section",
        transitionEffect: "slideLeft",
        labels: {
            cancel:   "Cancelar",
            finish:   "Terminar",
            next:     "Siguiente",
            previous: "Anterior"
        },
        onStepChanging: function (event, currentIndex, newIndex) {
            // Permite accion previa
            if (currentIndex > newIndex) {
                return true;
            }
            
            // Pasa a guardar solicitud
            if (newIndex == 1) {
                if(validarComite()) {
                    if($("#hfPkComite").val() == 0) {
                        //ES NUEVO
                        agregarComite();
                    }
                    else {
                        //ES EDITA POR REGRESAR
                        editarComite();
                    }
                    return true;
                } else {
                    return false;
                }
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
            if($('#existe'+881).val() != 0) {
                $.post('<cfoutput>#event.buildLink("EDI.solicitud.eliminarComite")#</cfoutput>', {
                    PkSolicitud: $("#hfPkComite").val(),
                    fkEstado:    1
                }, function(data) {
                    if ($.isNumeric(data)  && data > 0) {
                        swal("La solicitud al comité fue guardada exitosamente", null, "success");
                        getTablaComite();
                        limpiaFormulario();
                        $("#ddlTipo").val("0");
                        form.steps("previous");
                    } else {
                        swal("Error al guardar solicitud", null, "error");
                    }
                });
            } else {
                swal("No se ha adjuntado la documentación", null, "error");
            }
        }
    });

    $(document).ready(function() {
        getTablaComite();
        
        jQuery.validator.addMethod("nombre", function (value, element) {
            if (/^[a-zA-Z_áéíóúñ\s]/.test(value)) {
                return true;
            } else {
                return false;
            };
        }, "* Debe comenzar con una letra.");
    });
</script>