<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_cubos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-search-accent-neutralise="true">
    <thead>
        <th class="text-center" data-formatter="getIndex">#</th>
        <th data-sortable='true'>Nombre</th>    
        <th data-sortable='true' class="text-center">Prefijo</th>
        <th class="text-center">Clasificar</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.cubos">
            <cfset i++>
            <tr>
                <td>#i#</td>

                <td>#NOMBRECUBO#</td>

                <td>#PREFCUBO#</td>
                <td>
                    <button class="btn btn-primary fa fa-search" onclick="getEncabezado(#PKCUBO#);"></button>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</table>

 <script type="text/javascript">

    function getIndex(value, row, index) {
        return index+1;
    }

    $(document).ready(function(){
        $("#tabla_cubos").bootstrapTable();
    });

 </script>

