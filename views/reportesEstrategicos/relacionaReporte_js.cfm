<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Estrategicos
* Sub modulo: Relación de Reportes
* Fecha 3 de Abril de 2017
* Descripcion:
* Script correspondiente a la relacion de un reportes
* Autor:Jonathan Martinez
* ================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfoutput>
<script>
    <!--- Inicializacion de variables --->
    var datos = [];
    var reportes=[];
    var filas;
    var columnas ;
    var relacion=0;
    reportes.push({id:'0'});
     <cfif isDefined('prc.reportes') >
        <cfloop index='i' from='1' to='#prc.reportes.recordCount#'>
        <cfset config=deserializeJSON(prc.reportes.CONFIG[i])>
        filas="-";
        columnas="-";
        <cfloop index='j' from='1' to='#prc.columnas.recordCount#'>
            <cfif prc.columnas.IDCOL[j] eq config.parametros[3].value>
                filas='#prc.columnas.NOMBRE[j]#';
            </cfif>
            <cfif prc.columnas.IDCOL[j] eq config.parametros[4].value>
                 columnas='#prc.columnas.NOMBRE[j]#';
            </cfif>
        </cfloop>
        <cfif prc.reportes.IDREP[i] eq prc.relacion.IDREP>
            relacion=#i#;
        </cfif>
           <cfoutput>
                   reportes.push({
                        id: #prc.reportes.IDREP[i]#,
                        nombre: '#prc.reportes.NOMBRE[i]#',
                        desc: '#prc.reportes.DES[i]#',
                        filas: filas,
                        columnas: columnas,
                        fecha : '#prc.reportes.FECHA[i]#'   
                   });
           </cfoutput>
       </cfloop>
     </cfif>
    <!--- Inicia Cuerpo del Script --->
    $(document).ready(function() {    
        $('##table_report').bootstrapTable(); 
        $('##table_report').bootstrapTable('hideColumn', 'id');
        $('##table_report').bootstrapTable('load', datos);
        $('##reportes > option[value="'+relacion+'"]').attr('selected', 'selected');
        Cargartable();
    
     });

    function Cargartable(){
        datos = [];
        index=$('[name="reportes"]').val();
        datos.push(reportes[index]);
        $('##table_report').bootstrapTable('load', datos);
    }    
</script>
</cfoutput>
