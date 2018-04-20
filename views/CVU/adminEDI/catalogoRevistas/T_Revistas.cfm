<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de catalogo de revistas
* Fecha:       13 de diciembre de 2017
* Descripcion: Tabla de las revistas
* Autor:       JLGC    
* ================================
---->
<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_revistas" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="pk" data-search-accent-neutralise="true">
    <thead>
        <th class="text-ceter" dta-formatter="getIndex">#</th>
        <th data-field="pk">PK</th>
        <th data-sortable="pk">ISSN</th>
        <th data-sortable="true">Nombre</th>
        <th data-sortable="true">Editorial</th>
        <th data-sortable="true">Pais</th>
        <th>Acciones</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.tablaRevistas">
            <cfset i++>
                <tr>
                    <td>#i#</td>
                    <td><strong>#PK#</strong></td>
                    <td><strong>#ISSN#</strong></td>
                    <td><strong>#NOMBRE#</strong></td>
                    <td>#EDITORIAL#</td>
                    <td>#PAIS#</td>
                    <td class="text-center">
                        <button class="btn btn-info ml5 btn-editar-tr" data-tooltip="tooltip" title="Editar" id_revista="#PK#" data-toggle="modal" href="##mdl-admon-revista">
                            <i class="fa fa-pencil"></i>
                        </button> 

                        <button class="btn btn-info ml5 btn-niveles-tr" data-tooltip="tooltip" title="Niveles" id_revista="#PK#" data-toggle="modal" href="##mdl-niveles">
                            <i class="fa fa-plus"></i>
                        </button> 
                    </td>
                </tr>
        </cfoutput>
    </tbody>
</table>

<script type="text/javascript">
    $(document).ready(function() {    
        $(".form-control").removeClass('error');

        $('#tabla_revistas').bootstrapTable(); 
        $('#tabla_revistas').bootstrapTable('hideColumn', 'pk');

        $(".btn-editar-tr").on("click", function() {   
            $(".form-control").removeClass('error');
            $("#mdl-admon-revista .modal-title").text("Editar revista");
            $("#btn-admon-revista").html('<span class="fa fa-check"></span> Actualizar');
            $("#hfPkRevista").val($(this).attr('id_revista'));

            $.post('<cfoutput>#event.buildLink("CVU.productos.getRevistabyPKRevista")#</cfoutput>', { 
                    pkRevista: $(this).attr('id_revista')
                }, function(data){
                    if(data.ROWCOUNT > 0){
                        $("#inISSN").val(data.DATA.ISSN.toString());
                        $("#inNombre").val(data.DATA.NOMBRE.toString());
                        $("#inEditorial").val(data.DATA.EDITORIAL.toString());
                    
                        $("#ddlInPais option:selected" ).text(data.DATA.PAIS.toString());
                       }
                    else
                        toastr.error('Hubo un problema al realizar la consulta de la revista');
                });
        });

        $(".btn-niveles-tr").on("click", function() {   
            $("#hfPkRevista").val($(this).attr('id_revista'));
            limpiaModal();
            getTablaNiveles($(this).attr('id_revista'));
            refrescaAnios($(this).attr('id_revista'), 0, 0, 1);
        });
    });

    <!---- Crea el valor indice de la tabla ---->
    function getIndex(value, row, index) {
        return index+1;
    }
</script>

