<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Revision
* Fecha:       22 de mayo de 2017
* Descripcion: Contenido js que sera usado por la vista de Revision
* Autor:       Jose Luis Granados Chavez
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">
    
    $(document).ready(function() {
        
        /** inicializa 3 secciones redimensionables */   
        secciones_redimensionables = new secciones3L();
        secciones_redimensionables.init_3L();
        $(".mq-panelBotonera").hide();

        /** Llamado de funciones */    
        getTablaInformacion();

        /** Inicializa treeview para: divArbolConvenios y llena sus valores */
        $("#divArbolConvenios").treeview({
            data:              llenaArbolConvenios(),
            color:             "#00695c",
            selectedColor:     "#00695c" ,
            backColor:         "#E5E8EB",
            selectedBackColor: "#ffffff",
            borderColor:       "#ffffff",
            levels:            0
        });

        /** Permite la Pantalla Completa del Panel divPanelAnexo */ 
        $(".fullscreen-link").click( function() {
            $(this).toggleClass('fa-expand').toggleClass('fa-compress');
            $("#iframeResult3").toggleClass('panel-fullscreen');

            switch(($("#iframeResult3").hasClass('panel-fullscreen')) ? 0 : 1){
                case 0:
                    $("#cierraPanelAnexo").hide();
                    $(".mq-modal").hide();
                    //$("#mq-pdf-embed-responsive-4by3").css('height', '95.3%');
                    secciones_redimensionables.maxCont(false); //Si se maximiza el contenedor3
                break;    
                case 1:
                    $("#cierraPanelAnexo").show();
                    $(".mq-modal").show(); // boton modal
                    //$("#mq-pdf-embed-responsive-4by3").css('height', '90%');
                    secciones_redimensionables.maxCont(true); 
                break;    
            }       
        });

        /** Permite Colapsar el Panel divPanelEstados */ 
        $(".collapse-link").click( function() {
            var liga = $(this).find('panel-heading.i');
            liga.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
            $("#divPanelEstados").find("ul").slideToggle(200);
        });

        /** Oculta el PANEL divPanelAnexo */ 
        $("#cierraPanelAnexo").click(function() {
            $(".mq-panelBotonera").hide();
            $("#agregarDocto").html('');
        });

        /** Permite arrastrar el MODAL divModalAnexo */ 
        $("#divModalAnexo").draggable({
            handle: ".modal-header"
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

        if ($("#tipoConv").val() == 1) {
            $("#tituloConvenios").text('Firma electrónica');
        } else if($("#tipoConv").val() == 2){
            $("#tituloConvenios").text('Firma autógrafa');
        } else if ($("#tipoConv").val() == 3) {
            $("#tituloConvenios").text('UC-Mexus');
        }

    });

    /** 
    * Descripcion:    Llena contenidoTablaConvenios con informacion listada de todos los convenios 
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    */
    function getTablaInformacion() {
        $.post("convenios/Revision/cargarTablaRevision", { }, function(data){
            $("#contenidoTablaRevision").html( data );
        });
    }

    /** 
    * Descripcion:    Muestra el DIV del Panel Listado de Convenios
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    */
    function MuestraListado() {
        ocultaPaneles();
        $("#divPanelInfo").show();

        //INICIALIZA LOS TAMAÑOS DE LOS PANELES
        $("#btn-controlEdos").addClass('hide');
        $("#divPanelConsulta").addClass('hide');
        $("#divPanelConsulta").removeClass('col-md-8');
        $("#divPanelConsulta").addClass('col-md-12');
        $("#divPanelControlEstados").addClass('hide');
        $("#divPanelControlEstados").removeClass('col-md-4');
        $("#divPanelControlEstados").addClass('col-md-0');
    }   

    function ControlEstados(){
        $("#divPanelConsulta").toggleClass('col-md-12').toggleClass('col-md-8');
        $("#divPanelControlEstados").toggleClass('col-md-0').toggleClass('col-md-4').toggleClass('hide');
    }

    //Carga los estados del convenio al seleccionarlo
    function cargarControlEstados(pPKConvenio){
        $.post('<cfoutput>#event.buildLink("adminCSII.historial.historial.getHistorial")#</cfoutput>', {
            pkRegistro: pPKConvenio,
            pkProcedimiento: '<cfoutput>#application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS#</cfoutput>'
        }, function(data) {
            $('#divControlEstados').html(data);
            //SE OCULTAN ELEMENTOS SOLO PARA CONVENIOS
            $('.guiaBotonHistorial').hide();
        });
    }

    /** 
    * Descripcion:    Muestra el DIV del Panel Detalle
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    */
    function MuestraDetalle() {
        ocultaPaneles();
        $("#divPanelDetalle").removeClass("hide");
        $("#divPanelDetalle").show();
    }   

    /** 
    * Descripcion:    Muestra el DIV del Panel Anexo
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    */
    // function MuestraAnexo(opcion) {
    //     $(".mq-panelBotonera").show();
    //     $(".mq-pdf").show();
    //     switch(opcion){
    //             case 1:
    //                 $("#frmAnexo").attr("src","");
    //                 break;
    //             case 2:  
    //                 $("#frmAnexo").attr("src","");
    //                 break;
    //             case 3:
    //                  $("#frmAnexo").attr("src","");
    //                 break;
    //     }     
    // }   

    /** 
    * Descripcion:    Oculta todos los Paneles de la vista
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    */
    function ocultaPaneles() {
        $("#divPanelInfo").hide();
        $("#divPanelDetalle").hide();
        
    }

    /** 
    * Descripcion: Se forma el arbol dinamicamente
    * Fecha creacion: 22 de mayo de 2017
    * @autor aaron quintana gomez  
    * Descripcion:    Trae la informacion listada de todos los convenios para mostrarse en la estructura de arbol
    * @param:         tipoConvenio, PK del tipoConvenio  
    * @return:        arbolConvenios, lista definida de todos los convenios
    * @author:        José Luis Granados Chávez
    */
    function llenaArbolConvenios(tipoConvenio) {
        nivel1 =  $("#arbolStr").val().replace(/%/gi,'"');
        nivel1 = nivel1.replace(/@/gi,"'");
        nivel1 = nivel1.replace(/ó/gi,"\u00F3"); 
        nivel1 = caracteresEspeciales(nivel1);
        
        return JSON.parse(nivel1);
    }

     /** 
    * Descripcion:    da formato para los caracteres especiales
    * Fecha creacion: 22 de mayo de 2017
    * @author:        aaron quintana gomez
    */
    function caracteresEspeciales(cad){
        cad = cad.replace(/Á/g,"\u00C1"); 
        cad = cad.replace(/É/g,"\u00C9"); 
        cad = cad.replace(/Í/g,"\u00CD"); 
        cad = cad.replace(/Ó/g,"\u00D3"); 
        cad = cad.replace(/Ú/g,"\u00DA"); 
        cad = cad.replace(/ñ/g,"\u0148"); 
        cad = cad.replace(/Ñ/g,"\u0147"); 

        return cad; 
    }

/** 
    * Descripcion:    Muestra el DIV del Panel Detalle
    * Fecha creacion: junio 2017
    * @author:        aaron quintana gomez
    */
    function consultaConvenio(pkConvenio) {
        $("#hfPkConvenio").val(pkConvenio);
        $("#botonValidado").addClass('hide');
        $("#botonRechazado").addClass('hide');
        $.post('<cfoutput>#event.buildLink("convenios.Revision.getVistabyPKConvenioTipo")#</cfoutput>',{ 
             pkConvenio: pkConvenio,
             pkTipo: $("#tipoConv").val()
        }, function(data){
            cargarControlEstados(pkConvenio);
            $("#rev_informacionConvenio").html( data );
            if ($("#validacionHabilitada").val().indexOf('busqueda.validar') != -1) {
                $("#botonValidado").removeClass('hide');
            } else {
                $("#botonValidado").addClass('hide');         
            }
            if ($("#validacionHabilitada").val().indexOf('busqueda.rechazar') != -1) {
                $("#botonRechazado").removeClass('hide');
            } else {
                $("#botonRechazado").addClass('hide');         
            }
            $("body").addClass("mini-navbar");
        });

        $("#btn-controlEdos").removeClass('hide');
        $("#divPanelDetalle").removeClass("hide");
        $("#divPanelDetalle").show();
        $("#agregarDocto").html('');
        $("#panelEncabezado").hide();
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
                consultaConvenio($("#hfPkConvenio").val());
                $("#mdl-addComentarioCambioEstado").modal('hide'); //SE ANEXA AUNQUE EXISTE EN limpiaModal()
            }
            else {
                swal("Error al modificadar el convenio", null, "error");
            }
        });
    }

    /** 
    * Descripcion:    Valida el Convenio seleccionado
    * Fecha creacion: Junio de 2017
    * @author:        SGS
    */
    function ValidarConvenio() {
        CambiaEstadoConvenioValidar($("#hfPkConvenio").val(),$("#lblRegistro").text());
    }

    /** 
    * Descripcion:    Valida el Convenio seleccionado
    * Fecha creacion: Junio de 2017
    * @author:        SGS
    */
    function CambiaEstadoConvenioValidar(PKConvenio, pRegistro) {
        var responsable = existeResponsable(PKConvenio);
        var archivos = validarArchivos(PKConvenio);
        if(responsable && archivos){
            swal({
                title:              "¿Desea validar el convenio?",
                text:               "Número de registro : <strong>" + pRegistro + "</strong>",
                type:               "info",
                confirmButtonColor: "#00303F",
                confirmButtonText:  "Validar",
                cancelButtonText:   "Cerrar",
                showCancelButton:   true,
                closeOnConfirm:     false,
                showLoaderOnConfirm:true,
                html:               true
            }, function () {
                modalComentario(PKConvenio, 'busqueda.validar');
            });
        } else if(!responsable && archivos) {
            swal("Aún falta asignar un responsable", null, "warning");
        } else if(responsable && !archivos) {
            swal("Aún faltan archivos por cargar", null, "warning");
        } else {
            swal("Aún faltan archivos por cargar y asignar un responsable", null, "warning");
        }
    }

    function validarArchivos(PKConvenio){
        var exito = $.ajax({
            type: 'POST',
            url:  '<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>',
            data: { pkRegistro: PKConvenio, tipoConvenio: $("#tipoConv").val() },
            async: false
        }).responseJSON;
        return exito.EXITO;
    }

    function existeResponsable(PKConvenio){
        var exito = $.ajax({
            type: 'POST',
            url:  '<cfoutput>#event.buildLink("convenios.Consulta.responsableAsignado")#</cfoutput>',
            data: { pkRegistro: PKConvenio },
            async: false
        }).responseJSON;
        return exito.EXITO;
    }

    /** 
    * Descripcion:    Rechaza el Convenio seleccionado
    * Fecha creacion: Junio de 2017
    * @author:        SGS
    */
    function RechazarConvenio() {
        CambiaEstadoConvenioRechazar($("#hfPkConvenio").val(),$("#lblRegistro").text());
    }

    /** 
    * Descripcion:    Rechaza el Convenio seleccionado
    * Fecha creacion: Junio de 2017
    * @author:        SGS
    */
    function CambiaEstadoConvenioRechazar(PKConvenio, pRegistro) {
        swal({
            title:              "¿Desea rechazar el convenio?",
            text:               "Número de registro : <strong>" + pRegistro + "</strong>",
            type:               "warning",
            confirmButtonColor: "#00303F",
            confirmButtonText:  "Rechazar",
            cancelButtonText:   "Cerrar",
            showCancelButton:   true,
            closeOnConfirm:     false,
            showLoaderOnConfirm:true,
            html:               true
        }, function () {
            modalComentario(PKConvenio, 'busqueda.rechazar');
        });
    }


</script>