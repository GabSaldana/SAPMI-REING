<cfprocessingdirective pageEncoding="utf-8">

<div class="form-group">
    <div class="row">
        <div class="ibox">
            <div class="ibox-title">
                <h5>CARTAS TRAMITADAS POR EL USUARIO</h5>
            </div>
            <div class="ibox-content">  
                <table id="tabla_cartas" class="table table-responsive" data-pagination="true" data-page-size="10" data-search-accent-neutralise="true" data-search="true">
                    <thead>
                        <th class="text-center" data-formatter="getIndex">#</th>
                        <th class="text-center" data-sortable="true">ID</th>
                        <th class="text-center" data-sortable="true">AÑO</th>
                        <th class="text-center" data-sortable="true">FOLIO</th>
                        <th class="text-center" data-sortable="true">CONVOCATORIA</th>
                        <th class="text-center" data-sortable="true">NOMBRE</th>
                        <th class="text-center" data-sortable="true">ESTADO</th>
                        <th class="text-center" data-sortable="true">FECHA</th>
                        <th class="text-center" data-sortable="true">USUARIO CAI</th>
                        <th class="text-center">ARCHIVO</th>
                    </thead>
                    <tbody>
                        <cfoutput>
                            <cfif #arrayLen(deserializeJSON(prc.cartas))#>
                                <cfset arreglo = #deserializeJSON(prc.cartas)#>
                                <cfloop index='i' from='1' to='#arrayLen(arreglo)#'>
                                    <tr>
                                        <td>#i#</td>
                                        <td>#arreglo[i]["ID"]#</td>
                                        <td>#arreglo[i]["AÑO"]#</td>
                                        <td>#arreglo[i]["FOLIO"]#</td>
                                        <td>#arreglo[i]["ID CONVOCATORIA"]#</td>
                                        <td>#arreglo[i]["NOMBRE CONVOCATORIA"]#</td>
                                        <td>#arreglo[i]["ESTADO"]#</td>
                                        <td>#arreglo[i]["FECHA"]#</td>
                                        <td>#arreglo[i]["USUARIO CAI"]#</td>
                                        <td>
                                            <a class="btn btn-primary fa fa-file" target="_blank" href='#arreglo[i]["ARCHIVO"]#'></a>
                                        </td>
                                    </tr>
                                </cfloop>
                            </cfif>
                        </cfoutput>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>

    function getIndex(value, row, index) {
        return index+1;
    }

    $(document).ready(function() {
        $('#tabla_cartas').bootstrapTable();
    });

</script>