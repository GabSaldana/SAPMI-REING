<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas dinámicas
* Sub modulo: Creación tabla dinámica
* Fecha 24 de marzo de 2017
* Descripcion:
* Vista correspondiente al submodulo de tabla dinámica
* Autor: Alejandro Rosales
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <script src="/includes/bootstrap/bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
 <script src="/includes/js/tableExport/tableExport.js"></script>
 <cfinclude template="tablaContenidos_js.cfm">
 <table id="tabla-accion" class="table  table-responsive" data-pagination="true" data-page-size="50" data-search="true"  data-search-accent-neutralise="true" data-show-export="true" data-export-types =  "['excel']" data-show-columns="true" >
     <cfset classColor = ArrayNew(1)>
     <cfset classColor[1] = "azulSumaCol">
     <cfset classColor[2] = "azulSumaFil">
     <cfset classColor[3] = "azulSumaSeccion">
     <cfset classColor[4] = "warning">
     <cfset classColor[5] = "danger">
         
     <cfset lenVal = 1>
     <cfset lenSon = 0>
     <cfif isDefined('prc.valores')>
         <cfset lenVal = arrayLen(prc.valores)>
     </cfif>
     <thead class="thead-inverse">
         <cfloop index="x" from="1" to="#prc.lenColumna#">
             <tr>
                 <th> </th>
                 <cfloop index = "i" from = "1" to="#arrayLen(prc.encabezados)#">
                     <cfif x EQ prc.encabezados[i].level >
                         <cfif prc.lenColumna EQ x>
                             <cfset lenSon = lenSon + 1>
                         </cfif>
                         <cfoutput>
                             <th data-field="#i#" data-sortable='true' colspan="#prc.encabezados[i].len * lenVal#">
                                 #prc.encabezados[i].value#
                             </th>
                         </cfoutput>        
                     </cfif>
                 </cfloop>
             </tr>
         </cfloop>
         <!--- Fila Valores --->
         <cfif isDefined('prc.valores')>
             <tr>
                 <th></th>
                 <cfloop index = "xn" from = "1" to="#lenSon#">
                     <cfloop index="yn" from = "1" to =#arrayLen(prc.valores)#>
                         <cfoutput>
                             <th colspan="1">
                                 #prc.valores[yn].name#
                             </th>
                         </cfoutput>
                     </cfloop>
                 </cfloop>
             </tr>
         </cfif>
     </thead>
     <tbody>
         <cfset maxLevel = 0>
         <cfloop index="x" from="1" to="#arrayLen(prc.filas)#">
             <cfif maxLevel LT prc.filas[x].level>
                 <cfset maxLevel = prc.filas[x].level>
             </cfif>
         </cfloop>
         <cfif isDefined('prc.valores')>
         <!--- Inicializa Valores Totales --->
             <cfset totales = ArrayNew(1) >
             <cfloop index="r" from="1" to="#arrayLen(prc.valores[1]["value"][1])* arrayLen(prc.valores)#">
                 <cfset totales[r] = 0>
             </cfloop>       
             <cfif #arrayLen(prc.filas)# GT 0 >
                 <cfloop index="x" from="1" to="#arrayLen(prc.filas)#">
                     <cfoutput> 
                         <cfif maxLevel NEQ prc.filas[x].level> 
                             <tr class=#classColor[prc.filas[x].level]#>
                         <cfelse>
                             <tr>
                         </cfif>
                     </cfoutput>
                     <cfset a = 1>
                     <cfoutput> 
                         <td>
                             #prc.filas[x].name#
                         </td>
                     </cfoutput>    
                     <cfloop index="y" from="1" to="#arrayLen(prc.valores[1]["value"][x])#">
                         <cfloop index = "z" from="1" to = #arrayLen(prc.valores)#>    
                             <cfoutput>
                                 <td>
                                     #prc.valores[z]["value"][x][y]#
                                 </td>
                             </cfoutput>
                             <cfif prc.filas[x].level EQ 1 AND isNumeric(prc.valores[z]["value"][x][y])>
                                 <cfset totales[a] = totales[a] + prc.valores[z]["value"][x][y]>
                             </cfif>
                             <cfset a = a+1>
                         </cfloop>
                     </cfloop>
                 </tr>
                 </cfloop>
             <cfelse>
                 <tr>
                     <td></td>
                     <cfset a = 1>
                     <cfloop index="x" from="1" to="#arrayLen(prc.valores[1]["value"][1])#">
                         <cfloop index = "y" from = "1" to ="#arrayLen(prc.valores)#">
                             <cfoutput><td>#prc.valores[y]["value"][1][x]#</td></cfoutput>
                             <cfif isNumeric(prc.valores[y]["value"][1][x])>
                                 <cfset totales[a] = totales[a] + prc.valores[y]["value"][1][x]>
                             </cfif>
                             <cfset a = a+1>
                         </cfloop>
                     </cfloop>
                 </tr>
             </cfif>
             <tr class="azulSumaFilUltima">
                 <td>
                     Total
                 </td>
                 <cfloop index="r" from="1" to="#arrayLen(totales) #">
                     <cfoutput><td>#totales[r]#</td></cfoutput>
                 </cfloop>
             </tr>
         <cfelse>
             <cfloop index="x" from="1" to="#arrayLen(prc.filas)#">
                 <cfoutput>
                     <cfif maxLevel NEQ prc.filas[x].level> 
                         <tr class=#classColor[prc.filas[x].level]#>
                     <cfelse>
                         <tr>
                     </cfif>
                 </cfoutput>
                     <cfoutput>
                         <td>
                             #prc.filas[x]["name"]#
                         </td>
                     </cfoutput>
                 </tr>
             </cfloop>
         </cfif>
     </tbody>
 </table>

