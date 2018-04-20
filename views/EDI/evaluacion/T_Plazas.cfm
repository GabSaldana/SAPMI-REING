<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_plazas" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="false" data-unique-id="pk" data-search-accent-neutralise="true">
    <thead>
        <th class="text-ceter" dta-formatter="getIndex">#</th>
        <th data-field="pk">PK</th>
        <th data-sortable="true">Número</th>
        <th data-sortable="true">Nombre</th>
        <th data-sortable="true">Estado</th>
        <th data-sortable="true">Horas</th>
        <th data-sortable="true">Fecha término</th>
        <th data-sortable="true">Antigüedad IPN</th>
        <th data-sortable="true">Documento</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.tablaPlazas">
            <cfset i++>
                <tr>
                    <td>#i#</td>
                    <td><strong>#PK#</strong></td>
                    <td>123</strong></td>
                    <td><strong>PROFESOR TITULAR C</strong></td>
                    <td>2</td>
                    <td>2</td>
                    <td>01/01/2018</td>
                    <td>01/01/2018</td>
                    <td class="text-center">
                        <button class="btn btn-success ml5 btn-verDoctoPlaza" data-tooltip="tooltip" title="Comprobantes" pk_plaza="#PK#">
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

        $('#tabla_plazas').bootstrapTable(); 
        $('#tabla_plazas').bootstrapTable('hideColumn', 'pk');

        $(".btn-verDoctoPlaza").on("click", function() {   
            var pkObjeto = $(this).attr('pk_plaza');
            alert(pkObjeto);
            // $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
            //     pkCatalogo: 881,
            //     pkObjeto:   pkObjeto
            // }, function(data) {
            //     cargarDocumento(data);
            // });
        });
    });

    <!---- Crea el valor indice de la tabla ---->
    function getIndex(value, row, index) {
        return index+1;
    }
</script>

