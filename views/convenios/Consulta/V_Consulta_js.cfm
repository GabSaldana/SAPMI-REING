<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       22 de mayo de 2017
* Descripcion: Contenido js que sera usado por la vista de Consulta
* Autor:       Jose Luis Granados Chavez
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">  

    <!--- 
    * Descripcion:    Muestra el DIV del Panel Nuevo Convenio
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    --->
    function MuestraAgregar() {
        document.location = '<cfoutput>#event.buildLink("convenios.Nuevo")#</cfoutput>'
    }

    <!--- 
    * Descripcion:    Muestra el DIV del Panel Detalle
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    * @param:         pPKConvenio, PK del Convenio  
    *                 pPKTipo, PK del Tipo de Convenio
    --->
    function ConsultaConvenio(pPKConvenio, pPKTipo, hideBotonValidar, estado, hideBotonRechazar) {
        $.post('<cfoutput>#event.buildLink("convenios.Consulta.getVistabyPKConvenioTipo")#</cfoutput>',{ 
             pkConvenio: pPKConvenio,
             pkTipo:     pPKTipo
        }, function( dataInfo ) {
            cargarControlEstados(pPKConvenio);
            $("#hfPkConvenio").val(pPKConvenio);
            $("#informacionConvenio").html( dataInfo );
            $("#divPanelConsulta").removeClass('hide');
            
            if (hideBotonValidar == true) {
                $("#btn-validarConvenio").removeClass('hide');
                $("#btn-controlEdos").removeClass('hide');
                if(hideBotonValidar == true && estado != 1){
                   $("#btn-rechazarConvenio").removeClass('hide'); 
                }
            }
            
            $("#btn-buscarConvenio").removeClass('hide');
            $("#btn-controlEdos").removeClass('hide');
            $("#btn-agregarConvenio").addClass('hide');
            $("#PanelListado").addClass('hide');
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios realizados sobre el documento.
    --->  
    function getComentariosConvenio(pkRegistro){
        $("#pkRegistroComentario").val(pkRegistro);
        var tipoComentario = '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.CONVENIO#</cfoutput>';
        $("#pkTipoComentario").val(tipoComentario);
        
        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getComentariosReg")#</cfoutput>', {
            pkRegistro: pkRegistro,
            pkTipoComent: tipoComentario
        },
        function(data){
            $('#mdl-comentariosConvenio').modal('show');
            $('#mdl-comentariosConvenio .contnido').html(data);
            $("#mdl-comentariosConvenio .mail-comentarios").show();
            $("#mdl-comentariosConvenio .mail-contenido").hide();
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función cambia el estado de un registro de la tabla en cuestion.
    --->
    function comentarConvenio(pkDoc, pkDocEdo) {
        $('#funcionComentGral').attr('onclick','comentaConvenio()');
        getInvolucrados();

        $(".cambiosEdo").hide();
        $('#cerrarComent').removeClass('hide');
        $('#funcionComentGral').removeClass('hide');
        
        $("#mdl-addComentarioCambioEstado").modal('show');
        $("#comentDoc").val(pkDoc);
        $("#comentEdo").val(pkDocEdo);
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función cambia el estado de un registro de la tabla en cuestion(TMPTPRUEBACES).
    --->
    function comentaConvenio() {
        var checkDestin = new Array();

        $('input[name="destinatarios"]:checked').each(function() {
           checkDestin.push($(this).val());
        });

        var prioridad = (!($("#check").children().hasClass('off'))) ? 1 : 0;

        var comentario = tinyMCE.activeEditor.getContent();

        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.registraComentario")#</cfoutput>', {
            asunto:        $("#inAsunto").val(),
            comentario:    comentario,
            prioridad:     prioridad,
            estado:        $("#comentEdo").val(),
            pkRegistro:    $("#comentDoc").val(),
            destinatarios: JSON.stringify(checkDestin),
            tipoComent:    '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.CONVENIO#</cfoutput>'
        }, function(data) {

            if(data > 0){
                toastr.success('Comentario registrado');
            }

            limpiaModal();
            $("#mdl-addComentarioCambioEstado").modal('hide');
            $("#inPrior").prop("checked",false);
            $("#accordion").addClass('hide');
            $(".destinatarios").html('').parent().attr('aria-expanded',"false").css('height','0px').removeClass('in');
            $("#inAsunto").val('');
            tinyMCE.get("inComent").setContent('');

            $(".cambiosEdo").show();
            $('#cerrarComent').addClass('hide');
            $('#funcionComentGral').addClass('hide');
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los usuarios involucrados en el proceso para enviar comentarios.
    --->  
    function getInvolucrados(){

        $.post('<cfoutput>#event.buildLink("convenios.Consulta.getUsuComentario")#</cfoutput>', {
            pkElemento: $("#inRegistro").val(),
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
    * Descripcion de la modificacion: Se agrego condicional para consultar por dependencia o UR
    * Fecha modificacion: 1 de Junio del 2017
    * Autor modificacion:  Mauricio Argueta Macías
    ********************************************************************************************
    * Descripcion:    Llena contenidoTablaConvenios con informacion listada de todos los convenios 
    * Fecha creacion: 22 de mayo de 2017
    * @author:        José Luis Granados Chávez
    --->
    function getTablaConvenios() {
        var tipo = $("#ddlTipo").val();
        var numEstado = $("#ddlEstado").val();
        var pkClasif = $("#ddlURClasificacion").val();
        var pkUR     = $("#ddlUR").val();

        $.post('<cfoutput>#event.buildLink("convenios.Consulta.cargarTablaConvenios")#</cfoutput>', {
             tipo: tipo, 
             numEstado: numEstado,
             pkClasif: pkClasif,
             pkUR:     pkUR
        }, function( dataTabla ) {
            $("#contenidoTablaConvenios").html( dataTabla );
        });
    }

    <!--- 
    * Descripcion:    Muestra las UR´s dependiendo la seleccion de su clasificacion
    * Fecha creacion: 23 de mayo de 2017
    * @author:        José Luis Granados Chávez
    --->
    function selectURClasificacion() {
        pkURClasificacion = $("#ddlURClasificacion").val();

        $("#ddlUR").html("<option value='0'>Seleccione dependencias...</option>");   
        $.post('<cfoutput>#event.buildLink("convenios.Consulta.obtenerURbyClasificacion")#</cfoutput>', {
            pkURClasificacion: pkURClasificacion
        }, function( dataUR ) {

            if ( dataUR.ROWCOUNT == 0 ) {
                $("#ddlUR").attr("disabled", true);
            }
            else {
                $("#ddlUR").attr("disabled", false);
            }

            for( var i = 0; i < dataUR.ROWCOUNT ; i++ ) {            
                $("#ddlUR").append($("<option></option>")
                           .attr("value",dataUR.DATA.PK[i])
                           .text(dataUR.DATA.NOMBRE[i]));
            }
        });
        getTablaConvenios();
    }


    /** 
    * Descripcion:    Obtiene los estados para llenar el combo select
    * Fecha creacion: Julio de 2017
    * @author:        SGS
    */
    function getSelectEstados(){
        if ($("#ddlTipo").val() > 0) {
            $.post('<cfoutput>#event.buildLink("convenios.Consulta.obtenerSelectEstados")#</cfoutput>', {
                tipoConvenio: $("#ddlTipo").val()
            }, function(data) {
                $("#ddlEstado").attr("disabled", false);
                $("#ddlEstado").html('<option value="0">Seleccione estado...</option>');
                for( var i = 0; i < data.ROWCOUNT ; i++ ) {            
                    $("#ddlEstado").append($("<option></option>")
                               .attr("value",data.DATA.NUMERO[i])
                               .text(data.DATA.NUMERO[i] +'. '+ data.DATA.NOMBRE[i]));
                }
            });
        } else {
            $("#ddlEstado").attr("disabled", true);
            $("#ddlEstado").html('<option value="0">Seleccione estado...</option>');
        }
        $("#ddlEstado").val(0);
        getTablaConvenios();
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
                getTablaConvenios();
                MuestraListado();
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
        CambiaEstadoConvenioValidar($("#hfPkConvenio").val(),$("#lblRegistro").text(),$("#tipoConvenio").val());
    }

    /** 
    * Descripcion:    Valida el Convenio seleccionado
    * Fecha creacion: Junio de 2017
    * @author:        SGS
    */
    function CambiaEstadoConvenioValidar(PKConvenio, pRegistro, tipo) {
        var responsable = existeResponsable(PKConvenio);
        var archivos = validarArchivos(PKConvenio, tipo);
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

    function validarArchivos(PKConvenio, tipo){
        var exito = $.ajax({
            type: 'POST',
            url:  '<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>',
            data: { pkRegistro: PKConvenio, tipoConvenio: tipo },
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

    // function EliminaConvenio() {
    //     CambiaEstadoConvenioEliminar($("#hfPkConvenio").val(),$("#lblRegistro").text());
    // }

    /** 
    * Descripcion:    Elimina el Convenio seleccionado
    * Fecha creacion: Noviembre de 2017
    * @author:        JLGC
    */
    function CambiaEstadoConvenioEliminar(PKConvenio, pRegistro) {
        swal({
            title:              "¿Desea eliminar el convenio?",
            text:               "Número de registro : <strong>" + pRegistro + "</strong>",
            type:               "warning",
            confirmButtonColor: "#00303F",
            confirmButtonText:  "Eliminar",
            cancelButtonText:   "Cerrar",
            showCancelButton:   true,
            closeOnConfirm:     false,
            showLoaderOnConfirm:true,
            html:               true
        }, function () {
            modalComentario(PKConvenio, 'busqueda.eliminar');
        });
    }

    function MuestraListado(){
        $("#hfPkConvenio").val(0);
        $("#PanelListado").removeClass('hide');
        $("#divPanelConsulta").addClass('hide');
        $("#divPanelControlEstados").addClass('hide');
        $("#btn-validarConvenio").addClass('hide');
        $("#btn-rechazarConvenio").addClass('hide');
        $("#btn-buscarConvenio").addClass('hide');
        $("#btn-agregarConvenio").removeClass('hide');
        $("#comentarCom").addClass('hide');
        $("#consultarCom").addClass('hide');
        $("#btn-controlEdos").addClass('hide');
        $("#informacionConvenio").html('');

        //INICIALIZA LOS TAMAÑOS DE LOS PANELES
        $("#divPanelConsulta").removeClass('col-md-8');
        $("#divPanelConsulta").addClass('col-md-12');
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

    function EditarConvenio(pkConvenio, tipo) {
        document.location = '/index.cfm/convenios/Nuevo/index?pkConvenio='+pkConvenio+'&tipo='+tipo;
    }

    function MuestraAnexo(opcion) {
        $("#divPanelAnexo").removeClass("hide");
        $("#divPanelAnexo").show();
    }   

    $(document).ready(function() {
        <!--- Llamado de funciones --->
        getTablaConvenios();

        <!--- Permite arrastrar el MODAL divModalAnexo ---> 
        $("#divModalAnexo").draggable({
            handle: ".modal-header"
        });

        /** Permite la Pantalla Completa del Panel divPanelAnexo */ 
        $(".fullscreen-link").click( function() {
            var panel = $(this).closest('div.panel');
            var liga  = $(this).find('i');
            liga.toggleClass('fa-expand').toggleClass('fa-compress');
            panel.toggleClass('panel-fullscreen');
        });
        
        /** Oculta el PANEL divPanelAnexo */ 
        $("#cierraPanelAnexo").click(function() {
            $("#divPanelAnexo").hide();
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
</script>