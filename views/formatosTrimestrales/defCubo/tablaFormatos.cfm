<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_formatos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-search-accent-neutralise="true">               
    <thead>
        <th class="text-center" data-formatter="getIndex">#</th>
        <th data-sortable='true'>Formato</th>    
        <th class="text-center">Clave</th>
        <th class="text-center">Cubo</th>
        <th class="text-center">Prefijo</th>
        <th class="text-center">Acceder</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.clasificacion">
            <cfset i++>
            <tr>
                <td>#i#</td>

                <td>#NOMBREFORMATO#</td>

                <td>#CLAVEFORMATO#</td>

                <td>#NOMBRECUBO#</td>

                <td>#PREFIJOCUBO#</td>
                <td>
                    <button class="btn btn-primary fa fa-cogs" onclick="verifClasif(#PKFORMATO#);"></button>
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
        $("#tabla_formatos").bootstrapTable();
    });

 </script>

