<cfprocessingdirective pageEncoding="utf-8">
<!--- <cfinclude template="/views/utils/comentarios/comentarios.cfm"> --->
<!--- <cfinclude template="/views/utils/historial/historial.cfm"> --->

<table id="tabla-formatos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id" data-search="true" data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="pkformato">PkFormato</th>
            <th data-field="pkperiodo">PkPeriodo</th>
            <th data-field="check" data-checkbox="true" data-formatter="stateFormatter" data-tooltip="tooltip" title="Marcar todos">Marcar todos</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
            <th data-field="clave" data-sortable="true">Clave</th>
            <th class="text-center" data-field="version" data-sortable="true">Versión</th>
            <th class="text-center" data-field="estado" data-sortable="true">Estado</th>
            <th class="text-center" data-field="acceso" data-events="actionEvents">Acceso</th>
            <th class="text-center" data-field="accion" data-sortable="true" data-events="actionEvents">Acciones</th>
            <th class="text-center" data-field="ruta">Ruta</th>
            
        </tr>
    </thead>

    <cfoutput query="prc.Formatos.formatosAcciones">
        <tr>
            <td> </td>
            <td>#PK#</td>
            <td>#PKPERIODO#</td>
            <td> </td>
            <td>#NOMBRE#</td>
            <td>#CLAVE#</td>
            <td>
                <span class="badge badge-primary">
                    #VERSION#
                </span>
            </td>
            <td>
                <a title="Consultar historial" onclick="consultaHistorial(#pkregistro#);">
                    <span class="fa-stack text-success" style="font-size:15px">
                        <i class="fa fa-circle-o fa-stack-2x"></i>
                        <strong class="fa-stack-1x guiaHistorial">#ESTADO#</strong>
                    </span>
                </a>
            </td>
            <td>
                <button class="btn btn-success btn-sm vistaformato btn-outline dim" data-tooltip="tooltip" title="Vista del formato"><i class="fa fa-pencil-square-o"></i></button>
            </td>
            <td>
                <cfif listFind(ACCIONESCVE,'CapturaFT.Validacion','$')>
                    <button class=" btn btn-sm btn-success guiaValidar"  title="Validar Formato" onclick="cambiarEstadoRT('CapturaFT.Validacion','Validar Formato', #pkregistro#, '#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#');">
                        <i class="fa fa-thumbs-o-up "></i> 
                    </button>
                </cfif>
                
                <cfif listFind(ACCIONESCVE,'CapturaFT.Rechazo','$')>
                    <button class=" btn btn-sm btn-warning guiaRechazar"  title="Rechazar Formato" onclick="cambiarEstadoRT('CapturaFT.Rechazo','Rechazar Formato', #pkregistro#, '#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#');">
                        <i class="fa fa-thumbs-o-down "></i> 
                    </button> 
                </cfif>
                
                <cfif listFind(ACCIONESCVE,'CapturaFT.Eliminar','$')>
                    <button class="btn btn-sm btn-danger guiaEliminar"  title="Eliminar Formato" onclick="cambiarEstadoRT('CapturaFT.Eliminar','Eliminar Formato', #pkregistro#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#');">
                        <i class="fa fa-trash"></i> 
                    </button> 
                </cfif>

                <button class="btn btn-info ml5 fa fa-server guiaComentarios" title="Comentarios" onclick="consultarComenReg(#pkregistro#);"></button>

            </td>
            <td> #CESRUTA# </td>
            
        </tr>    
    </cfoutput>

    <cfoutput query="prc.Formatos.FORMATOSNL">
        <tr>
            <td> </td>
            <td>#PK#</td>
            <td>#PKPERIODO#</td>
            <td>  </td>
            <td>#NOMBRE#</td>
            <td>#CLAVE#</td>
            <td> 
                <span class="badge badge-primary">
                    #VERSION#
                </span>
            </td>
            <td>#ESTADO#</td>
            <td> 
                <button class="btn btn-warning btn-sm validarformato btn-outline dim" data-tooltip="tooltip" title="Crear formato"><i class="fa fa-pencil"></i></button>
            </td>
            <td> </td>
            <td>#CESRUTA#</td>
            
        </tr>
    </cfoutput> 
    
</table>


<div id="mdl-coments" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg contnido"> </div>
    
</div>



<div id="mdl-addComentario" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="mail-box-header">
                <h2>Motivo del rechazo</h2>
            </div>
            <div class="mail-body">
                <input id="inRegistro" type="hidden" value="">
                <input id="inAccion"   type="hidden" value="">
                <input id="edoDesti"   type="hidden" value="">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Destinatarios</h5>
                                <div class="ibox-tools">
                                    <a data-toggle="collapse" data-target=".collapse">
                                        <i class="fa fa-chevron-down"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content collapse">
                                <div class="wrapper destinatarios"> </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="space-25"></div>
                <div class="space-25"></div>

                <div class="form-group"><label class="col-sm-1 control-label pull-left"><h4>Asunto:</h4></label>
                    <div class="col-sm-10"><input id="inAsunto" type="text" class="form-control" value=""></div>
                </div><br><br><br>
                <div id="check" class="checkbox">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="checkbox" data-toggle="toggle" data-on="<i class='fa fa-exclamation'></i> Prioritario" data-off="No" data-width="115" data-onstyle="danger" checked>
                </div>
            </div>
                
            <textarea id="inComent" name="inComent" rows="15" cols="80" style="width: 80%"> </textarea>

            <div class="mail-body text-right tooltip-demo">
                <button type="button" class="btn btn-success btn-lg ml5" onclick="registrarComentario();">Guardar comentario</button>
            </div>
        </div>
    </div>
</div>




<script>

    function getIndex(value, row, index) {
        return index+1;
    }


    function stateFormatter(value, row, index) {
        if ($(row.estado).text() != '') {
            return {disabled:true,checked:true};
        }
    }

    $(document).ready(function() {    
        $('#tabla-formatos').bootstrapTable();
        $('#tabla-formatos').bootstrapTable('togglePagination');
        $('#tabla-formatos').bootstrapTable('togglePagination');
        $('#tabla-formatos').bootstrapTable('hideColumn', 'pkformato');
        $('#tabla-formatos').bootstrapTable('hideColumn', 'pkperiodo');
        $('#tabla-formatos').bootstrapTable('hideColumn', 'ruta');



        tinymce.init({
            selector: "textarea#inComent",
            theme: "modern",
            plugins: [
                "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "save table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker codesample"
            ],
            external_plugins: {
                //"moxiemanager": "/moxiemanager-php/plugin.js"
            },
            content_css: "",
            add_unload_trigger: false,
            autosave_ask_before_unload: false,

            toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
            toolbar2: "cut copy paste pastetext | bullist numlist | outdent indent blockquote | undo redo | image | insertdatetime | forecolor backcolor",
            toolbar3: "table | hr removeformat | subscript superscript | charmap | spellchecker | insertfile insertimage",
            menubar: false,
            toolbar_items_size: 'small',

            style_formats: [
                {title: 'Bold text', inline: 'b'},
                {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
                {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
                {title: 'Example 1', inline: 'span', classes: 'example1'},
                {title: 'Example 2', inline: 'span', classes: 'example2'},
                {title: 'Table styles'},
                {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
            ],

            templates: [
                {title: 'My template 1', description: 'Some fancy template 1', content: 'My html'},
                {title: 'My template 2', description: 'Some fancy template 2', url: 'development.html'}
            ],

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