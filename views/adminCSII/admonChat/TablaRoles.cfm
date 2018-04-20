 <!---
* =========================================================================
* IPN - CSII
* Sistema:SII
* Modulo:Administrador Procesos
* Fecha:06-07-2017
* Descripcion:
* Autor: Alejandro Rosales
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
 
<table id="tabla-procesos" >
    <thead>
        <tr>
            <th data-field="id" data-sortable='true' >PK</th>
            <th data-field="gr" data-formatter="getIndex" class="text-center">#</th>
            <th data-field="nombre">Nombre </th>            
            <cfset rolant = '' >
            <cfloop from="1" to="#prc.rolesProcesos.recordcount#" index="i">      
                <cfif rolant neq prc.rolesProcesos.ROL[i]>
                    <cfoutput><th data-events="commonEvents" data-field="#prc.rolesProcesos.ROL[i]#" >#prc.rolesProcesos.ROL[i]# </th>
                </cfoutput>  
                </cfif>
                <cfset rolant = prc.rolesProcesos.ROL[i] >
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
                    <cfloop from="1" to="#prc.rolesProcesos.recordcount#" index="numColumna">      
                        <cfif rolant2 neq prc.rolesProcesos.ROL[numColumna]>
                            <cfset existe = 0 >
                    
                            <cfloop from="1" to="#prc.rolesProcesos.recordcount#" index="j">      
                                 <cfif  prc.rolesProcesos.ROL[numColumna] eq prc.rolesProcesos.ROL[j] AND prc.rolesProcesos.PKPROCESO[j] EQ #prc.columnan.ID[numfila]#>
                                        <cfset existe ++ >
                                </cfif>
                            </cfloop>
                            <cfif existe gt 0>
                                <td><button class="btn btn-primary fa fa-dot-circle-o bt-seleccionAccion" data-tooltip="tooltip" title="general" 
                                onclick="bajaProceso(#prc.columnan.ID[numfila]#,#prc.rolesProcesos.ROLPK[numColumna]#)"></button> Si</td>
                            <cfelse>
                                <td><button class="btn btn-primary fa fa-circle-o  bt-seleccionAccion" data-tooltip="tooltip" title="Activar"  onclick="altaProceso(#prc.columnan.ID[numfila]#,#prc.rolesProcesos.ROLPK[numColumna]#)"></button> No</td>
                            </cfif>
                        </cfif>
                        <cfset rolant2 = prc.rolesProcesos.ROL[numColumna] >
                    </cfloop>
                    </cfoutput>  
                </tr>
        </cfloop>
    </tbody>
</table>

<script type="text/javascript">
 
 function bajaProceso(proceso,rol){
       $.post('/index.cfm/adminCSII/admonChat/admonChat/bajaProcesosRol',{proceso:proceso, rol:rol} ,function(data){    
           if (data>0){
                 consultaProcesoRol();
           }
     });
 }

 function altaProceso(proceso,rol){
      $.post('/index.cfm/adminCSII/admonChat/admonChat/altaProcesosRol',{proceso:proceso, rol:rol} ,function(data){    
           if(data>0){
                 consultaProcesoRol();
           }
     });
   
 }
 function getIndex(value, row, index) {
    return index+1;
 }
 function consultaProcesoRol(){
        $.post('/index.cfm/adminCSII/admonChat/admonChat/mostrarProcesosRol', function(data){    
            $('#tablaR').html(data);
     });
 }

$(document).ready(function(){
        $("#tabla-procesos").bootstrapTable();
        $('#tabla-procesos').bootstrapTable('hideColumn', 'id');
        $('#tabla-procesos').bootstrapTable('hideColumn', 'gr');  
        $('[data-toggle="tooltip"]').tooltip();
});

</script>   
        
