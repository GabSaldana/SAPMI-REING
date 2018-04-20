<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de registro de solicitudes al comite
* Fecha:       28 de diciembre de 2017
* Descripcion: Tabla de las solicitudes al comite
* Autor:       JLGC    
* ================================
---->
<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_comites" class="table table-striped table-responsive tabla_comitesEva" data-pagination="true" data-page-size="10" data-search="false" data-unique-id="pk" data-search-accent-neutralise="true">
    <thead>
        <th class="text-ceter" dta-formatter="getIndex">#</th>
        <th data-field="pk">PK</th>
        <th data-sortable="true">Tipo</th>
        <th data-sortable="true">Aspirante</th>
        <th data-sortable="true">Solicitud</th>
        <th>Acciones</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.tablaComite">
            <cfset i++>
                <tr>
                    <td>#i#</td>
                    <td><strong>#PK#</strong></td>
                    <td><strong>#TIPO#</strong></td>
                    <td><strong>#NOMBRE# #PATERNO# #MATERNO#</strong></td>
                    <td><strong>#DESCRIPCION#</strong></td>
                    <td class="text-center">
                        <button class="btn btn-info ml5 btn-editar-modal" data-tooltip="tooltip" title="Editar" id_comite="#PK#" id_tipo="#IDTIPO#" descripcion="#DESCRIPCION#" data-toggle="modal" href="##mdl-admon-comite">
                            <i class="fa fa-pencil"></i>
                        </button> 

                        <button class="btn btn-danger ml5 btn-borrar" data-tooltip="tooltip" title="Eliminar" id_comite="#PK#" tipo="#TIPO#">
                            <i class="fa fa-trash"></i>
                        </button> 

                        <button class="btn btn-success ml5 btn-verDocto" data-tooltip="tooltip" title="Comprobantes" id_comite="#PK#">
                            <i class="fa fa-file"></i>
                        </button> 
                    </td>
                </tr>
        </cfoutput>
    </tbody>
</table>

<script type="text/javascript">
    $(document).ready(function() {    
        $(".form-control").removeClass('error');

        $('.tabla_comitesEva').bootstrapTable(); 
        $('.tabla_comitesEva').bootstrapTable('hideColumn', 'pk');

        $(".btn-editar-modal").on("click", function() {   
            $("#hfPkComite").val($(this).attr('id_comite'));
            docComite($(this).attr('id_comite'));

            $("#mdl-admon-comite .modal-title").text("Actualizar solicitud");
            $("#btn-admon-comiteEdi").html('<span class="glyphicon glyphicon-floppy-disk"></span> Actualizar solicitud');

            $("#ddlTipoEdi").val($(this).attr('id_tipo')); 
            $("#inDescripcionEdi").val($(this).attr('descripcion')); 
        });

        $(".btn-borrar").on("click", function() {   
            pkComite =$(this).attr('id_comite');
            tipo =$(this).attr('tipo');
            
            swal({
                title:              "¿Desea eliminar la solicitud?",
                text:               "Tipo : <strong>" + tipo + "</strong>",
                type:               "warning",
                confirmButtonColor: "#B40431",
                confirmButtonText:  "Eliminar",
                cancelButtonText:   "Cerrar",
                showCancelButton:   true,
                closeOnConfirm:     false,
                showLoaderOnConfirm:true,
                html:               true
            }, function () {
                eliminarComite(pkComite);
            });
        });

        $(".btn-verDocto").on("click", function() {   
            var pkObjeto = $(this).attr('id_comite');
            $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
                pkCatalogo: 881,
                pkObjeto:   pkObjeto
            }, function(data) {
                cargarDocumento(data);
            });
        });
    });

    <!---- Crea el valor indice de la tabla ---->
    function getIndex(value, row, index) {
        return index+1;
    }
</script>

