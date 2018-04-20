<cfprocessingdirective pageEncoding="utf-8">

<!--- <input type="hidden" id="existe<cfoutput>#prc.archivo.PKDOC#</cfoutput>" value="<cfoutput>#prc.existe#</cfoutput>"> --->
<div class="panel panel-default">
    <div class="panel-heading" style="padding: 20px; border-bottom: 0px;">
        <h5 class="panel-title">
            <span class="pull-right" style="margin-top: -10px;">
                <span onclick="lanzaModal('PK<cfoutput>#prc.archivo.PKDOC#</cfoutput>_2');" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Seleccionar Archivo"><i class="fa fa-upload"></i></span>
            </span>
            <a data-toggle="tooltip" title="Puede subir varios archivos si se requiere"><b><cfoutput>#prc.archivo.NOMBRE#</cfoutput></b>&nbsp;&nbsp;<i class="fa fa-info-circle text-success"></i></a>
        </h5>
    </div>
</div>

<div class="modal inmodal fade modaltext adjArch" id="PK<cfoutput>#prc.archivo.PKDOC#</cfoutput>_2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Adjuntar <cfoutput>#LCase(prc.archivo.NOMBRE)#</cfoutput></h4>
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
                    <input id="<cfoutput>#prc.archivo.PKDOC#</cfoutput>_2" name="upload_files" type="file" multiple class="file-loading">
                </div>
            </div>
            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
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

        <!---
        * Descripcion: sube un archivo previamente seleccionado
        * Fecha: julio de 2017
        * @author: Alejandro Tovar
        --->
        $("#<cfoutput>#prc.archivo.PKDOC#</cfoutput>_2").fileinput({
            uploadUrl: '<cfoutput>#event.buildLink('adminCSII.ftp.archivo.subirArchivoAnexo')#</cfoutput>',
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
            $("#<cfoutput>#prc.archivo.PKDOC#</cfoutput>").fileinput('clear');
            $('#desc<cfoutput>#prc.archivo.PKDOC#</cfoutput>').val('');
            $('.adjArch').modal('hide');
            <cfoutput>#prc.archivo.FUNCION#</cfoutput>///
        });

        $(".btn-add-file").on("click", function() {
            $('#subirArchivo').fileinput('clear');
        });
    });

    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Lanza la modal correspondiente al archivo para cargar archivos.
    --->
    function lanzaModal(pkModal){
        $('#'+pkModal+'').appendTo('body').modal();
    }
    

</script>

