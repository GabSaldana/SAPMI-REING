<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Explorar Tabla
* Fecha 23 de Marzo de 2017
* Descripcion:
* Script  para el submodulo de exploracion de tablas
* Autor: Jonathan Martinez
* ================================
--->
 <cfoutput>
     <script type="text/javascript">
         var tabla=new Object();
         tabla.columnas=[];
         tabla.columnasn=[];
         tabla.filas=[];
         tabla.filasn=[];
         tabla.valores=[];
         tabla.valoresn=[];
         var filtros = [];
         <cfif isDefined('prc.tabla') >
             <cfloop index='i' from='1' to='#prc.tabla['columnas'].RECORDCOUNT#'>
                 <cfoutput>
                     tabla.columnas.push('#prc.tabla['columnas'].IDCOL[i]#');
                     tabla.columnasn.push('#prc.tabla['columnas'].NOMBRE[i]#');
                 </cfoutput>
             </cfloop>
             <cfloop index='i' from='1' to='#prc.tabla['filas'].RECORDCOUNT#'>
                 <cfoutput>
                     tabla.filas.push('#prc.tabla['filas'].IDCOL[i]#');
                     tabla.filasn.push('#prc.tabla['filas'].NOMBRE[i]#');
                 </cfoutput>
             </cfloop>
             <cfloop index='i' from='1' to='#prc.tabla['valores'].RECORDCOUNT#'>
                 <cfoutput>
                     tabla.valores.push('#prc.tabla['valores'].IDCOL[i]#');
                     tabla.valoresn.push('#prc.tabla['valores'].NOMBRE[i]#');
                 </cfoutput>
             </cfloop>
             <cfloop index='i' from='1' to='#prc.tabla['filtros'].RECORDCOUNT#'>
                 var filtroA = new Object();
                 <cfoutput>
                     filtroA.idCol='#prc.tabla['filtros'].IDCOL[i]#';
                     filtroA.nomCol='#prc.tabla['filtros'].NOMBRECOL[i]#';
                     filtroA.idFlt='#prc.tabla['filtros'].IDFILT[i]#';
                     filtroA.nomFlt='#prc.tabla['filtros'].NOMBREFILT[i]#';
                     filtroA.val='#prc.tabla['filtros'].VALOR[i]#';
                     filtros.push(filtroA);
                 </cfoutput>
             </cfloop>
         </cfif>
         $( document ).ready(function() {      
            
             $.post('#event.buildLink("reportes.reportes.getReporte")#',{
                 columnas : JSON.stringify(tabla.columnas),  filas : JSON.stringify(tabla.filas),  valores : JSON.stringify(tabla.valores), filtros: JSON.stringify(filtros)
             }, function(data){
                 $('.chart-table').html(data);
                 
                
             });
         });
     </script>
 </cfoutput>