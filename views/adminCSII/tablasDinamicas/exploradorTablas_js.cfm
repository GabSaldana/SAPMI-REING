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
             $.post('#event.buildLink("adminCSII.tablasDinamicas.creacionTabla.getTabla")#',{
                 columnas : JSON.stringify(tabla.columnas),  filas : JSON.stringify(tabla.filas),  valores : JSON.stringify(tabla.valores), filtros: JSON.stringify(filtros)
             }, function(data){
                 $('.chart-table').html(data);
                 for(var i=0 ; i < tabla.columnas.length ; i++){
                     $(".chart-canvas-col").append('<h5><span class="label label-primary" style="margin-left: 10px;">'+ tabla.columnasn[i]+'</span></h5>');
                 }
                 for(var i=0 ; i < tabla.filas.length ; i++){
                     $(".chart-canvas-fil").append('<h5><span class="label label-success" style="margin-left: 10px;">'+tabla.filasn[i]+'</span></h5>');
                 }
                 for(var i=0 ; i < tabla.valores.length ; i++){
                     $(".chart-canvas-val").append('<h5><span class=" label label-warning" style="margin-left: 10px;">'+tabla.valoresn[i]+'</span></h5>');
                 }
                 for(var i=0 ; i < filtros.length ; i++){
                     $(".btn-toolbar").append('<h5><span class=" label label-danger" style="margin-left: 10px;">'+ filtros[i].nomCol+' '+' '+filtros[i].nomFlt+' '+filtros[i].val+'</span></h5>');
                 }
             });
         });
     </script>
 </cfoutput>