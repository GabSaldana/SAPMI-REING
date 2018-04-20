<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-formatos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id" data-search="true" data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
            <th class="text-center" data-field="accion">Acciones</th>
            
        </tr>
    </thead>

    <cfoutput query="prc.Formatos">
        <tr>
            <td> </td>
            <td>#NOMBREFORMATO#</td>
            <td> 
                <button class="btn btn-primary btn-sm btn-outline dim" data-tooltip="tooltip" title="Crear formato" onclick="verAcumulado(#PKFORMATO#);"><i class="fa fa-newspaper-o"></i></button>
            </td>
        </tr>    
    </cfoutput>

</table>

<script>

    function getIndex(value, row, index) {
        return index+1;
    }

    $(document).ready(function() {    
        $('#tabla-formatos').bootstrapTable();
    });

</script>