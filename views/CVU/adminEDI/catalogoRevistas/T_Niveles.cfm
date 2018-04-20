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

<table id="tabla_niveles" class="table table-striped table-responsive" data-unique-id="pk" data-search-accent-neutralise="true">
    <thead>
        <th class="text-ceter" dta-formatter="getIndex">#</th>
        <th data-field="pk">PK</th>
        <th data-sortable="pk">AÑO</th>
        <th data-sortable="true">NIVEL</th>
        <th>Acciones</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.tablaNiveles">
            <cfset i++>
                <tr>
                    <td>#i#</td>
                    <td><strong>#PK#</strong></td>
                    <td><strong>#ANIO#</strong></td>
                    <td><strong>#NIVEL#</strong></td>
                    <td class="text-center">
                        <button class="btn btn-info ml5 btn-editar-niv-tr" data-tooltip="tooltip" title="Editar" id_nivel="#PK#" anio="#ANIO#" nivel="#NIVEL#">
                            <i class="fa fa-pencil"></i>
                        </button> 

                        <button class="btn btn-danger ml5 btn-borrar-niv-tr" data-tooltip="tooltip" title="Eliminar" id_nivel="#PK#" anio="#ANIO#" nivel="#NIVEL#">
                            <i class="fa fa-trash"></i>
                        </button> 
                    </td>
                </tr>
        </cfoutput>
    </tbody>
</table>

<script type="text/javascript">
    $(document).ready(function() {    
        $(".form-control").removeClass('error');

        $('#tabla_niveles').bootstrapTable(); 
        $('#tabla_niveles').bootstrapTable('hideColumn', 'pk');

        $(".btn-editar-niv-tr").on("click", function() {   
            $("#hfPkNivel").val($(this).attr('id_nivel'));
            refrescaAnios($("#hfPkRevista").val(), $(this).attr('anio'), $(this).attr('nivel'), 2);
            $("#btn-admon-niveles").html('Actualizar nivel');
        });

        $(".btn-borrar-niv-tr").on("click", function() {   
            pkNivel =$(this).attr('id_nivel');
            anio =$(this).attr('anio');
            nivel =$(this).attr('nivel');
            
            swal({
                title:              "¿Desea eliminar el nivel?",
                text:               "Nivel : <strong>" + nivel + "</strong> Año : <strong>" + anio + "</strong>",
                type:               "warning",
                confirmButtonColor: "#B40431",
                confirmButtonText:  "Eliminar",
                cancelButtonText:   "Cerrar",
                showCancelButton:   true,
                closeOnConfirm:     false,
                showLoaderOnConfirm:true,
                html:               true
            }, function () {
                eliminarNivel(pkNivel);
        });
        });
    });

    <!---- Crea el valor indice de la tabla ---->
    function getIndex(value, row, index) {
        return index+1;
    }
</script>

