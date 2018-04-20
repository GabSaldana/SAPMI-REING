<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de estado de los investigadores
* Fecha:       11 de diciembre de 2017
* Descripcion: Tabla de los investigadores
* Autor:       JLGC    
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_inv" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="pk" data-search-accent-neutralise="true">
    <thead>
        <th class="text-ceter" dta-formatter="getIndex">#</th>
        <th data-field="pk">PKEDOPER</th>
        <th data-sortable="true">Nombre</th>
        <th>Estado</th>
    </thead>
    <tbody>
        <cfset i = 0>
        <cfoutput query="prc.tablaInvestigadores">
            <cfset i++>
                <tr>
                    <td>#i#</td>
                    <td><strong>#PKEDOPER#</strong></td>
                    <td><strong>#INNOMBRE# #INPATERNO# #INMATERNO#</strong></td>
                    <td class="text-center">
                        <select id="ddlEstado#PKEDOPER#" name="ddlEstado#PKEDOPER#" class="form-control" onchange="guardaEstado(#PKEDOPER#);">
                            <cfloop query="prc.Estados">
                                <option value="#PK#" <cfif prc.tablaInvestigadores.PKESTADO eq PK>selected</cfif>>#NOMBRE#</option>
                             </cfloop>
                        </select>
                    </td>
                </tr>
        </cfoutput>
    </tbody>
</table>

<script type="text/javascript">
    $(document).ready(function() {    
        $('#tabla_inv').bootstrapTable(); 
        $('#tabla_inv').bootstrapTable('hideColumn', 'pk');
    });

    <!---- Crea el valor indice de la tabla ---->
    function getIndex(value, row, index) {
        return index+1;
    }
</script>

