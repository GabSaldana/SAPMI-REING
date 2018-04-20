<cfprocessingdirective pageEncoding="utf-8">
    <cfinclude template="admonGral_js.cfm">
<table id="tabla-accion" class="table table-striped grid" <!--- data-show-columns="true" data-minimum-count-columns="4" --->>
    <thead>
        <tr>
            <th data-field="id" data-sortable='true' >PK</th>
            <th data-formatter="getIndex" class="text-center">#</th>
            <th data-field="nombre">Nombre</th>            
            <cfset rolant = '' >
            <cfloop from="1" to="#prc.rolesAcciones.recordcount#" index="i">      
                <cfif rolant neq prc.rolesAcciones.ROL[i]>
                    <cfoutput><th   data-events="commonEvents"   data-field="#prc.rolesAcciones.ROL[i]#" >#prc.rolesAcciones.ROL[i]# </th>
                </cfoutput>  
                </cfif>
                <cfset rolant = prc.rolesAcciones.ROL[i] >
            </cfloop>
        </tr>
    </thead>
    <tbody> 
        <cfset i = 0>
        <cfloop from="1" to="#prc.columnan.recordcount#" index="numfila">  
                <tr>
                    <cfoutput> 
                    <td>#prc.columnan.ID[numfila]#</td>     
                    <td>#numfila#</td>
                    <td>#prc.columnan.NOMBRE[numfila]#</td>   

                    <cfset rolant2 = '' >
                    <cfloop from="1" to="#prc.rolesAcciones.recordcount#" index="numColumna">      
                        <cfif rolant2 neq prc.rolesAcciones.ROL[numColumna]>
                            <cfset existe = 0 >
                    
                            <cfloop from="1" to="#prc.rolesAcciones.recordcount#" index="j">      
                                 <cfif  prc.rolesAcciones.ROL[numColumna] eq prc.rolesAcciones.ROL[j] AND prc.rolesAcciones.PKACCION[j] EQ #prc.columnan.ID[numfila]#>
                                        <cfset existe ++ >
                                </cfif>
                            </cfloop>
                            <cfif existe gt 0>
                                <td><button class="btn btn-primary fa fa-dot-circle-o bt-seleccionAccion guiaBtnDesAccionRol" data-tooltip="tooltip" title="general" 
                                onclick="degradarAccion(#prc.columnan.ID[numfila]#,#prc.rolesAcciones.ROLPK[numColumna]#)"></button>Si</td>
                            <cfelse>
                                <td><button class="btn btn-primary fa fa-circle-o  bt-seleccionAccion guiaBtnActAccionRol" data-tooltip="tooltip" title="Activar"  onclick="agregaAccion(#prc.columnan.ID[numfila]#,#prc.rolesAcciones.ROLPK[numColumna]#)"></button> No</td>
                            </cfif>
                        </cfif>
                        <cfset rolant2 = prc.rolesAcciones.ROL[numColumna] >
                    </cfloop>
                    </cfoutput>  
                </tr>
        </cfloop>
    </tbody>
</table>

<script type="text/javascript">
 
function getIndex(value, row, index) {
    return index+1;
}

$(document).ready(function(){

    // $(function () {
    //     $('#table').bootstrapTable({
    //         data: data
    //     });
    // });

    // function commonFormatter(value) {
    // return '<div data-field="' + this.field + '">' + value + '</div>';
    // }

    // window.commonEvents = {
    // 'click div': function (e) {
    //     alert('You click field: ' + $(e.target).attr('data-field'));
    //  }
    // }
     




    $("#tabla-accion").bootstrapTable();
    // $('#tabla-accion').bootstrapTable('hideColumn', 'id');
           
    $('[data-toggle="tooltip"]').tooltip();

    

    $('.selectVisibles').change(function(){
        var columna = $(this).val();
                
        if( $(this).prop('checked') ){
            $('#tabla-accion').bootstrapTable('showColumn', columna);
        }else{  
            $('#tabla-accion').bootstrapTable('hideColumn', columna);
        }
    });
});





</script>   
            