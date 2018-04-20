<cfprocessingdirective pageEncoding="utf-8">

<cfoutput query="prc.archivo">
    
    <input type="hidden" id="existe<cfoutput>#prc.archivo.PKDOC#</cfoutput>" value="<cfoutput>#prc.existe#</cfoutput>">
    <div class="panel panel-default" style="margin: 0px 15px 10px">
        <div class="panel-heading" style="padding: 20px; border-bottom: 0px;">
            <div class="panel-title text-success">                
                <span class="pull-right">
                    <span onclick="lanzaModal('PK#PKDOC#_#PKARCHIVO#');" class="btn btn-sm btn-primary subirOtros" data-toggle="tooltip" data-placement="top" title="Seleccionar Archivo"><i class="fa fa-upload"></i></span>

                    <span onclick="descargarAnexo(#PKARCHIVO#, #CONVENIO#, #TIPODOC#);" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" title="Descargar Archivo"><i class="fa fa-download"></i></span>

                    <span onclick="mostrar(#PKDOC#, #CONVENIO#);" class="btn btn-sm btn-success" data-toggle="tooltip" data-placement="top" title="Ver Archivo"><i class="fa fa-eye"></i></span>

                    <cfif listFind(#ACCIONESCVE#,'ftp.valid','$')>
                        <span class="btn btn-primary btn-sm" data-tooltip="tooltip" title="#acciones#" onclick="cambiarEstado(#PKARCHIVO#, 'ftp.valid')"><i class="#iconos#"></i></span>
                    </cfif>

                    <cfif listFind(#ACCIONESCVE#,'ftp.rechazo','$')>
                        <span class="btn btn-primary btn-sm" data-tooltip="tooltip" title="#acciones#" onclick="cambiarEstado(#PKARCHIVO#, 'ftp.rechazo')"><i class="#iconos#"></i></span>
                    </cfif>

                    <span onclick="comentarDocumento(#PKARCHIVO#, #EDOACT#);" class="btn btn-sm btn-warning comentaOtros" data-toggle="tooltip" data-placement="top" title="Comentar Archivo"><i class="fa fa-comment-o"></i></span>

                    <span onclick="cargarModalComentarios('#PKARCHIVO#',0);" class="btn btn-sm btn-default comentarioOtros" data-toggle="tooltip" data-placement="top" title="Consultar comentario"><i class="fa fa-comment"></i></span>

                    <span onclick="eliminarAnexo('#PKARCHIVO#');" class="btn btn-sm btn-danger eliminaOtros" data-toggle="tooltip" data-placement="top" title="Eliminar archivo"><i class="fa fa-trash"></i></span>
                </span>
                <a data-toggle="collapse" data-parent="##otrosAdjuntos" href="##descrDoc#PKARCHIVO#" aria-expanded="false" class="collapsed btn-link">
                    <b>#NOMBRECAT# ( </b>
                        <cfif Len(#NOMBRE#) gt 15> #Mid(NOMBRE,1,14)#...
                        <cfelse> #NOMBRE# </cfif>
                    <b> )</b>
                </a>
            </div>
        </div>
        <div id="descrDoc#PKARCHIVO#" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
            <div class="panel-body">
                <b>Nombre:</b> #NOMBRE#<br>
                <b>Descripción:</b>
                <cfif Len(#DESCRIPCION#) neq 0> #DESCRIPCION#
                <cfelse> Archivo sin descripción </cfif>
            </div>
        </div>
    </div>


    <div class="modal inmodal fade modaltext adjArch" id="PK#PKDOC#_#PKARCHIVO#" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Adjuntar #LCase(NOMBRECAT)#</h4>
                </div>
                <div class="modal-body">
                    <div class="row mb15" id="agregar">
                    </div>
                    <div class="form-group">
                        <div class="input-group">   
                            <span class="input-group-addon">
                                <span class="fa fa-font"></span>
                            </span>
                            <input type="text" id="desc#PKDOC#" class="form-control" placeholder="Descripción" maxlength="100"/>
                        </div>
                    </div>
                    <div class="row" id="subirArchivos">
                        <input id="#PKDOC#_#PKARCHIVO#" name="upload_files" type="file" multiple class="file-loading">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
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
                                    <a data-toggle="collapse" data-parent="##accordion" href="##collapseOne" aria-expanded="false" class="collapsed" style="color: ##333;">
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

    <style type="text/css">
        .requeridos{
            border-color: red;
        }
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

            otrosAdjuntosN();

            <!---
            * Descripcion: sube un archivo previamente seleccionado
            * Fecha: julio de 2017
            * @author: Alejandro Tovar
            --->
            $("#IDPKDOC#_#PKARCHIVO#").fileinput({
                uploadUrl: '#event.buildLink('adminCSII.ftp.archivo.actualizaOtros')#',
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
                        desc:       $('##desc#PKDOC#').val(),
                        pkRegistro: '#CONVENIO#',
                        pkArchivo:  '#PKARCHIVO#',
                        pkCatalogo: '#TIPODOC#'
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
                        message: "El nombre del documento no debe contener espacios ni caracteres especiales"
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
                $("#IDPKDOC#").fileinput('clear');
                $('##desc#PKDOC#').val('');
                $(".adjArch").modal('hide');
                #FUNCION#;///
            });

            $(".btn-add-file").on("click", function() {
                $('##subirArchivo').fileinput('clear');
            });

            if ($("body").children("##mdl-addComentario").length>0){
                $("##componenteFTP").remove();
            } else {
                $("##componenteFTP").children("##mdl-addComentario").after().appendTo("body");
                $("##componenteFTP").remove();
            }

        });

    </script>

</cfoutput>


<div class="modal inmodal fade modaltext" id="mdl-coments" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg contnido"> </div>
</div>


<cfoutput>
    <form id="descargaArchivoAnexo" action="#event.buildLink('adminCSII.ftp.archivo.descargarArchivoAnexo')#" method="post" target="_blank">
        <input type="hidden" id="pkArchivoAnexo" name="pkArchivoAnexo">
        <input type="hidden" id="pkObjeto" name="pkObjeto">
        <input type="hidden" id="pkCatalogo" name="pkCatalogo">
    </form>
</cfoutput>



<script>

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
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Limpia la modal de agregar comentario
    ---> 
    function limpiaModal(){
        $("#mdl-addComentario").modal('hide');
	$(".destinatarios").html('').parent().attr('aria-expanded',"false").css('height','0px').removeClass('in');
        tinyMCE.activeEditor.setContent('');
        $("#inAsunto").val('');
        $("#inPrior").prop("checked",false);
    }


    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Descarga archivo considerando el pk del registro.
    --->
    function descargarAnexo(pkArchivo, pkObjeto, pkCatalogo){
        $("#descargaArchivoAnexo > #pkArchivoAnexo").val(pkArchivo);
        $("#descargaArchivoAnexo > #pkObjeto").val(pkObjeto);
        $("#descargaArchivoAnexo > #pkCatalogo").val(pkCatalogo);
        $('#descargaArchivoAnexo')[0].submit();
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
        getInvolucrados(pkDoc);

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
    function cambiarEstado(pkReg, accion){
        $('#funcionComent').attr('onclick','ejecutarCambiarEstado()');
        $("#mdl-addComentario").modal();
        $("#pkRegistro").val(pkReg);
        $("#accion").val(accion);
        getInvolucradosDocumento(pkReg);
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función cambia el estado de un registro de la tabla en cuestion(TMPTPRUEBACES).
    --->
    function ejecutarCambiarEstado() {

        var checkDestin = new Array();

        $("#mdl-addComentario").modal('hide');
        
        $('input[name="destinatarios"]:checked').each(function() {
           checkDestin.push($(this).val());
        });

        var prioridad = (!($("#check").children().hasClass('off'))) ? 1 : 0;

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
            
            $("#inAsunto").val(''),
            tinyMCE.activeEditor.setContent('');
            limpiaModal();
        });
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
    * Fecha : Julio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Cambia el estado del archivo
    --->  
    function eliminarAnexo(pkArchivo){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.eliminarArchivo")#</cfoutput>', {
            pkArchivo: pkArchivo
        },
        function(data){
            if(data > 0){
                toastr.success('','Archivo eliminado exitosamente');
                <cfoutput>#prc.archivo.FUNCION#</cfoutput>;///
                $("#otrosAdjuntosN").empty();
            }
        });
    }



</script>


