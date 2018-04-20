<cfprocessingdirective pageEncoding="utf-8">

<div class="form-group">
    <div class="row">
        <div class="ibox">
            <div class="ibox-title">
                <h5>NOMBRAMIENTOS SNI</h5>
            </div>
            <div class="ibox-content">  
                <table id="tabla_cartas" class="table table-responsive" data-pagination="true" data-page-size="10" data-search-accent-neutralise="true" data-search="true">
                    <thead>
                        <th class="text-center" data-formatter="getIndex">#</th>
                        <th class="text-center" data-sortable="true">ID</th>
                        <th class="text-center" data-sortable="true">NIVEL SNI</th>
                        <th class="text-center" data-sortable="true">EXPEDIENTE SNI</th>
                        <th class="text-center" data-sortable="true">INICIO</th>
                        <th class="text-center" data-sortable="true">VENCIMIENTO</th>
                        <th class="text-center" data-sortable="true">INVESTIGADOR</th>
                        <th class="text-center" data-sortable="true">NO EMPLEADO</th>
                        <th class="text-center" data-sortable="true">USUARIO CAI</th>
                    </thead>
                    <tbody>
                        <cfoutput>
	                        <cfif #arrayLen(deserializeJSON(prc.sni))#>
	                            <cfset arreglo = #deserializeJSON(prc.sni)#>
	                            <cfloop index='i' from='1' to='#arrayLen(arreglo)#'>
	                                <tr>
	                                    <td>#i#</td>
	                                    <td>#arreglo[i]["ID"]#</td>
	                                    <td>#arreglo[i]["NIVEL SNI"]#</td>
	                                    <td>#arreglo[i]["EXPEDIENTE SNI"]#</td>
	                                    <td>#arreglo[i]["INICIO"]#</td>
	                                    <td>#arreglo[i]["VENCIMIENTO"]#</td>
	                                    <td>#arreglo[i]["INVESTIGADOR"]#</td>
	                                    <td>#arreglo[i]["NO. EMPLEADO"]#</td>
	                                    <td>#arreglo[i]["USUARIO CAI"]#</td>
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