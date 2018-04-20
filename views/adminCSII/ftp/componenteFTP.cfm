<cfprocessingdirective pageEncoding="utf-8">

<cfoutput>
    <cfif #prc.archivo.REQUERIDO# EQ 1>
        <div class="panel panel-default REQUERIDO">
    <cfelse>
        <div class="panel panel-default OPCIONAL">
    </cfif>
</cfoutput>
    <input type="hidden" id="existe<cfoutput>#prc.archivo.PKDOC#</cfoutput>" value="<cfoutput>#prc.existe#</cfoutput>">
    <div class="panel-heading" style="padding: 20px; border-bottom: 0px;">
        <div class="panel-title text-success">            
            <span class="pull-right">
                <span onclick="lanzaModal('PK<cfoutput>#prc.archivo.PKDOC#</cfoutput>');" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Seleccionar Archivo"><i class="fa fa-upload"></i></span>

                <span onclick="descargar(<cfoutput>#prc.archivo.PKDOC#, #prc.archivo.CONVENIO#</cfoutput>);" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" title="Descargar Archivo"><i class="fa fa-download"></i></span>

                <span onclick="mostrar(<cfoutput>#prc.archivo.PKDOC#, #prc.archivo.CONVENIO#</cfoutput>);" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" title="Ver Archivo"><i class="fa fa-eye"></i></span>

                <cfoutput>
                    <cfif listFind(prc.archivo.ACCIONESCVE,'ftp.valid','$')>
                        <span class="btn btn-primary btn-sm" data-tooltip="tooltip" title="#prc.archivo.acciones#" onclick="cambiarEstadoConvenio(#prc.archivo.PKARCHIVO#, 'ftp.valid')"><i class="#prc.archivo.iconos#"></i></span>
                    </cfif>

                    <cfif listFind(prc.archivo.ACCIONESCVE,'ftp.rechazo','$')>
                        <span class="btn btn-primary btn-sm" data-tooltip="tooltip" title="#prc.archivo.acciones#" onclick="cambiarEstadoConvenio(#prc.archivo.PKARCHIVO#, 'ftp.rechazo')"><i class="#prc.archivo.iconos#"></i></span>
                    </cfif>
                </cfoutput>

                <span onclick="comentarDocumento(<cfoutput>#prc.archivo.PKARCHIVO#, #prc.archivo.EDOACT#</cfoutput>);" class="btn btn-sm btn-warning" data-toggle="tooltip" data-placement="top" title="Comentar Archivo"><i class="fa fa-comment-o"></i></span>

                <span onclick="cargarModalComentarios('<cfoutput>#prc.archivo.PKARCHIVO#</cfoutput>',0);" class="btn btn-sm btn-default" data-toggle="tooltip" data-placement="top" title="Consultar comentario"><i class="fa fa-comment"></i></span>

                <span onclick="eliminarArchivo('<cfoutput>#prc.archivo.PKARCHIVO#</cfoutput>');" class="btn btn-sm btn-danger" data-toggle="tooltip" data-placement="top" title="Eliminar archivo"><i class="fa fa-trash"></i></span>
            </span>
            <a data-toggle="collapse" data-parent="#accordion" href="#descrDoc<cfoutput>#prc.archivo.PKARCHIVO#</cfoutput>" aria-expanded="false" class="collapsed btn-link">
                <b><cfoutput>#prc.archivo.NOMBRECAT#</cfoutput> <br>( </b>
                    <cfoutput>
                        <cfif Len(#prc.archivo.NOMBRE#) gt 15> #Mid(prc.archivo.NOMBRE,1,14)#...
                        <cfelse> #prc.archivo.NOMBRE# </cfif>
                    </cfoutput>
                <b> )</b>
            </a>
        </div>
    </div>
    <div id="descrDoc<cfoutput>#prc.archivo.PKARCHIVO#</cfoutput>" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
        <div class="panel-body">
            <b>Nombre:</b> <cfoutput>#prc.archivo.NOMBRE#</cfoutput><br>
            <b>Descripción:</b> 
            <cfif Len(#prc.archivo.DESCRIPCION#) neq 0> <cfoutput>#prc.archivo.DESCRIPCION#</cfoutput>
            <cfelse> Archivo sin descripción </cfif>          
        </div>
    </div>
</div>


<div class="modal inmodal fade modaltext adjArch" id="PK<cfoutput>#prc.archivo.PKDOC#</cfoutput>" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <span type="button" class="close" data-dismiss="modal" aria-hidden="true">×</span>
                <h4 class="modal-title">Adjuntar <cfoutput>#LCase(prc.archivo.NOMBRECAT)#</cfoutput></h4>
            </div>
            <div class="modal-body">
                <div class="row mb15" id="agregar">
                </div>
                <div class="form-group">
                    <div class="input-group">   
                        <span class="input-group-addon">
                            <span class="fa fa-font"></span>
                        </span>
                        <input type="text" id="desc<cfoutput>#prc.archivo.PKDOC#</cfoutput>" class="form-control" placeholder="Descripción" maxlength="100"/>
                    </div>
                </div>
                <div class="row" id="subirArchivos">
                    <input id="<cfoutput>#prc.archivo.PKDOC#</cfoutput>" name="upload_files" type="file" multiple class="file-loading">
                </div>
            </div>
            <div class="modal-footer">
                <span type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</span>
            </div>
        </div>
    </div>
</div>


<div id="componenteFTP">
    <div id="mdl-addComentario" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="padding: 10px 30px 70px;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -20px;"><h1><strong>&times;</strong></h1></button>
                    <h2 class="pull-left">Agregar comentario</h2>
                </div>
                <div class="modal-body">

                    <input type="hidden" id="comentDoc">
                    <input type="hidden" id="comentEdo">

                    <input type="hidden" id="pkRegistro">
                    <input type="hidden" id="accion">
                    <input type="hidden" id="pkConvenio">

                    <div class="panel-group" id="accordion" style="display: none;">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" class="collapsed" style="color: #333;">
                                    <h5 class="panel-title">Destinatarios<i class="fa fa-chevron-down pull-right"></i></h5>
                                </a>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body destinatarios"></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label pull-left"><h4>Asunto:</h4></label>
                        <div class="col-sm-11"><input id="inAsunto" type="text" class="form-control" value=""></div>
                    </div>
                    <br><br>
                    <div class="checkbox checkbox-danger">&nbsp;&nbsp;&nbsp;
                        <input id="inPrior" class="styled" type="checkbox">
                        <label for="inPrior">
                            <i class='fa fa-exclamation'></i> Prioritario
                        </label>
                    </div>
                    <textarea id="inComentario" name="inComentario" rows="15" cols="80" style="width: 80%"> </textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-lg ml5" onclick="limpiaModal()">Cerrar</button>
                    <button id="funcionComent" type="button" class="btn btn-success btn-lg pull-right ml5">Comentar</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal inmodal fade modaltext" id="mdl-coments" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg contnido"> </div>
</div>


<form id="downloadForm" action="<cfoutput>#event.buildLink('adminCSII.ftp.archivo.descargarArchivo')#</cfoutput>" method="post" target="_blank">
    <input type="hidden" id="pkCatalogo" name="pkCatalogo">
    <input type="hidden" id="pkObjeto" name="pkObjeto">
</form>


<style type="text/css">
    .mce-tooltip{
        z-index: 9999999 !important;
    }
    .mce-floatpanel{
        z-index: 9999999 !important;
    }
    .file-upload-indicator{
        display: none;
    }
    .kv-file-upload{
        display: none;
    }
    .kv-file-remove{
        display: none;
    } 
</style>

<script type="text/javascript">

    $(document).ready(function() {        

        <!---
        * Descripcion: sube un archivo previamente seleccionado
        * Fecha: septiembre de 2016
        * @author: Yareli Andrade
        --->
        $("#<cfoutput>#prc.archivo.PKDOC#</cfoutput>").fileinput({
            uploadUrl: '<cfoutput>#event.buildLink('adminCSII.ftp.archivo.subirArchivo')#</cfoutput>',
            maxFileCount: 1,
            maxFileSize: 10000,
            msgSizeTooLarge: '"{name}" excede el tamaño máximo, <b>10 MB</b> permitidos!',
            overwriteInitial: false,
            uploadAsync: true,
            browseClass: "btn btn-primary",
            removeClass: "btn btn-danger",
            uploadClass: "btn btn-success",
            showRemove: true,
            showUpload: true,
            uploadExtraData: function (previewId, index){
                var info = {
                    pkCatalogo: '<cfoutput>#prc.archivo.PKDOC#</cfoutput>',
                    desc:       $("#desc<cfoutput>#prc.archivo.PKDOC#</cfoutput>").val(),
                    pkUsuario:  '<cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>',
                    pkRegistro: '<cfoutput>#prc.archivo.CONVENIO#</cfoutput>'
                };

                return info;
            },
            slugCallback: function(filename) {
                return filename;
            }
        })
        .on('filebatchpreupload', function(event, data) {

            var ext         = (data.filenames[0]).substring((data.filenames[0]).lastIndexOf(".")+1).toString();
            var puntos      = (data.filenames[0]).split('.').length;
            var extensiones = JSON.parse('<cfoutput>#prc.archivo.EXTENSION#</cfoutput>');

            /*Verifica que la extension del documento sea la permitida*/
            if(!validarExtension(ext, extensiones)){
                return {
                    message: "Extension del documento no permitida, solo se aceptan las siguientes extensiones ["+JSON.parse('<cfoutput>#prc.archivo.EXTENSION#</cfoutput>') +"]"
                };
            }

            /*Verifica que el nombre del documento no tenga caracteres especiales*/
            if (caracteresEspeciales(data.filenames[0])) {
                return {
                    message: "El nombre del documento no debe contener espacios ni los siguientes caracteres ^<>@!\#$%^&*()+[]{}?:;|ñÑáéíóúÁÉÍÓÚ'\"\\,/~`-=!"
                };
            }

            /*Verifica que el nombre del documento no tenga dos puntos*/
            if (puntos > 2){
               return {
                    message: "El nombre del documento no puede tener dos puntos."
                };
            }

            /*Verifica la longitud del nombre del documento*/
            if (data.filenames[0].length > 24) {
                return {
                    message: "El nombre del documento no debe exceder 20 caracteres!"
                };
            }
        })
        .on('fileuploaded', function(event, files) {
            $("#<cfoutput>#prc.archivo.PKDOC#</cfoutput>").fileinput('clear');
            $('#desc<cfoutput>#prc.archivo.PKDOC#</cfoutput>').val('');
            $(".adjArch").modal('hide');
            <cfoutput>#prc.archivo.FUNCION#</cfoutput>;///
        });

        $(".btn-add-file").on("click", function() {
            $('#subirArchivo').fileinput('clear');
        });

        if ($("body").children("#mdl-addComentario").length>0){
            $("#componenteFTP").remove();
        } else {
            $("#componenteFTP").children("#mdl-addComentario").after().appendTo("body");
            $("#componenteFTP").remove();
        }

    });


    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Muestra el documeto pdf en un div.
    --->
    function mostrar(pkCatalogo, pkObjeto){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
            pkCatalogo: pkCatalogo,
            pkObjeto:   pkObjeto
        }, function(data) {
            cargarDocumento(data);
        });
    }


    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Descarga archivo considerando el pk del registro.
    --->
    function descargar(pkCatalogo, pkObjeto){
        $("#downloadForm > #pkCatalogo").val(pkCatalogo);
        $("#downloadForm > #pkObjeto").val(pkObjeto);
        $('#downloadForm')[0].submit();
    }


    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Lanza la modal correspondiente al archivo para cargar archivos.
    --->
    function lanzaModal(pkModal){
        $('#'+pkModal+'').appendTo('body').modal();
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función cambia el estado de un registro de la tabla en cuestion.
    --->
    function comentarDocumento(pkDoc, pkDocEdo) {
        $('#funcionComent').attr('onclick','comentaDoc()');
        getInvolucradosDocumento(pkDoc);
        $("#mdl-addComentario").modal('show');
        $("#comentDoc").val(pkDoc);
        $("#comentEdo").val(pkDocEdo);
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función cambia el estado de un registro de la tabla en cuestion(TMPTPRUEBACES).
    --->
    function comentaDoc() {
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
            tipoComent:    '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.DOCUMENTO#</cfoutput>'
        }, function(data) {
            if(data > 0){
                toastr.success("", "Comentario registrado");
            }

            limpiaModal();
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los usuarios involucrados en el proceso para enviar comentarios.
    --->  
    function getInvolucradosDocumento(pkDoc){        
        $("#accordion").hide();
        $(".destinatarios").empty();        

        $.ajax({
            url: '<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getUsuComentario")#</cfoutput>',
            type: 'POST',           
            data: {
                pkElemento: pkDoc,
                tipoElemento: 21
            },
        })
        .done(function(data) {
            if (data.ROWCOUNT > 0){
            var list = $(".destinatarios").append('<ol type="none"></ol>').find('ol');
            for (var i = 0; i < data.ROWCOUNT; i++){
                list.append("<li><div class='checkbox checkbox-primary'><input id='checkboxDestin"+i+"' name='destinatarios' type='checkbox' value=" + data.DATA.USU_PK[i] + "><label for='checkboxDestin"+i+"'>" + data.DATA.USU_NAME[i] + "</label></div></li>");
            }
            $("#accordion").show();
            }
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->  
    function cambiarEstadoConvenio(pkReg, accion){
        $('#funcionComent').attr('onclick','ejecutarCambiarEstadoConvenio()');
        $("#mdl-addComentario").modal();
        $("#pkRegistro").val(pkReg);
        $("#pkConvenio").val(pkReg);
        $("#accion").val(accion);
        getInvolucradosDocumento(pkReg);
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función cambia el estado de un registro de la tabla en cuestion(TMPTPRUEBACES).
    --->
    function ejecutarCambiarEstadoConvenio() {

        var checkDestin = new Array();

        $("#mdl-addComentario").modal('hide');
        
        $('input[name="destinatarios"]:checked').each(function() {
           checkDestin.push($(this).val());
        });

        var prioridad   = ($('#inPrior').prop('checked')) ? 1 : 0;

        var comentario = tinyMCE.activeEditor.getContent();
        comentario = comentario.substring(44, comentario.length -15).trim();

        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.cambiarEstado")#</cfoutput>', {
            pkRegistro:    $("#pkRegistro").val(), 
            accion:        $("#accion").val(),
            asunto:        $("#inAsunto").val(),
            comentario:    comentario,
            prioridad:     prioridad,
            destinatarios: JSON.stringify(checkDestin),
            tipoComent:    '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.DOCUMENTO#</cfoutput>'
        }, function(data) {

            if (data.EXITO){
                toastr.success("exitosamente", "Acción ejecutada");
            }else if (data.FALLO){
                toastr.error("El registro ya había sido modificado.", "El estado actual es: " + data.MENSAJE);
            }else {
                toastr.error(data.MENSAJE, "Acción ejecutada erróneamente");
            }

            <cfoutput>#prc.archivo.FUNCION#</cfoutput>;///
            $("#inAsunto").val(''),
            tinyMCE.activeEditor.setContent('');
            limpiaModal();
        });
    }



    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Limpia la modal de agregar comentario
    ---> 
    function limpiaModal(){
        $("#mdl-addComentario").modal('hide');
	$(".destinatarios").html('').parent().attr('aria-expanded',"false").css('height','0px').removeClass('in');
        tinyMCE.get("inComentario").setContent('');
        $("#inAsunto").val('');
        $("#inPrior").prop("checked",false);
    }

    tinymce.init({
        selector: "textarea#inComentario",
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


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios realizados sobre el documento.
    --->
    function consultarComenReg(pkRegistro){
        $("#pkRegistroComentario").val(pkRegistro);
        var tipoComentario = '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.DOCUMENTO#</cfoutput>';
        $("#pkTipoComentario").val(tipoComentario);

        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getComentariosReg")#</cfoutput>', {
            pkRegistro: pkRegistro,
            pkTipoComent: tipoComentario
        },
        function(data){
            $('#mdl-coments').appendTo('body').modal('show');
            $('#mdl-coments .contnido').html(data);
            $("#mdl-coments .mail-comentarios").show();
            $("#mdl-coments .mail-contenido").hide();
        });
    }


    <!---
    * Fecha : Julio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Cambia el estado del archivo
    --->  
    function eliminarArchivo(pkArchivo){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.eliminarArchivo")#</cfoutput>', {
            pkArchivo: pkArchivo
        },
        function(data){
            if(data > 0){
                toastr.success('','Archivo eliminado exitosamente');
                <cfoutput>#prc.archivo.FUNCION#</cfoutput>;///
            }
        });
    }

</script>

