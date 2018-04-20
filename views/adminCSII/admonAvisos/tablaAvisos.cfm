<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-avisos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-search-accent-neutralise="true">
    <thead>
        <th class="text-center" data-formatter="getIndex">#</th>
        <th data-sortable='true'>Nombre</th>
        <th data-sortable='true'>Descripción</th>
        <th data-sortable='true'>Redireccion</th>
        <th data-sortable='true' class="text-center">Fecha Inicio</th>
        <th data-sortable='true' class="text-center">Fecha Fin</th>
        <th class="text-center">Acciones</th>
    </thead>
    <tbody>
        <cfset i = 0> 
        <cfoutput query="prc.avisos">
            <tr>
                <cfset i++>
                <td>#i#</td>
                <td>#NOMBRE_AVISO#</td>
                <td>#NOMBRE_DESC#</td>
                <td>#REDIRECCION#</td>
                <td>#FECHA_INICIO#</td>
                <td>#FECHA_FIN#</td>
                <td>
                    <button class="btn btn-primary fa fa-pencil" data-tooltip="tooltip" title="editar" onclick="editarAviso(#PK_AVISO#);"></button>
                    <button class="btn btn-primary fa fa-trash"  data-tooltip="tooltip" title="Eliminar" onclick="eliminarAviso(#PK_AVISO#);"></button>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</table>

<script>

    function getIndex(value, row, index) {
        return index+1;
    }

    $(document).ready(function() {
        $('#tabla-avisos').bootstrapTable();
    });

</script>
