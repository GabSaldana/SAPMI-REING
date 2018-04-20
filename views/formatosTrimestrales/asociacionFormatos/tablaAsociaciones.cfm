<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_asociaciones" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-search-accent-neutralise="true">
    <thead>
        <th class="text-center" data-formatter="getIndex">#</th>
        <th data-sortable='true'>Nombre</th>
        <th class="text-center">Acciones</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.asociaciones">
            <cfset i++>
            <tr>
                <td>#i#</td>

                <td>#NOMBRE#</td>

                <td>
                    <button class="btn btn-primary fa fa-pencil" data-tooltip="tooltip" title="Editar asociación" onclick="editarColumnas(#PKNOMBRE#);"></button>
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
        $("#tabla_asociaciones").bootstrapTable();
    });


    function editarColumnas(pkAsociacion){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getTabla")#</cfoutput>', {
            pkColumnaOrigen: 0,
            pkAsociacion: pkAsociacion
        },
            function(data){
                $("#box-asociaciones").hide();
                $("#box-asociaColumnas").show();
                $('#tabla').html(data);
            }
        );
    }

 </script>
