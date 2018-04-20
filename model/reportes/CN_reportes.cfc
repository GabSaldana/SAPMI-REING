<!---
* =========================================================================
* IPN - CSII
* Sistema: PIMP
* Modulo: Consulta de reportes generados
* Fecha : septiembre 2017
* Descripcion: CN de reportes
* Autor: Alejandro Rosales 
* =========================================================================
--->
<cfcomponent accessors="true" singleton  threadSafe="true">
	<cfproperty name="daoReportes" inject="reportes/DAO_reportes">  
 	<cfset children = []>
 <cfset leafs = []>
 <cfset spans = []>
 <cfset treeFila = []>
     <!---
         * Modificacion: 21 de marzo de 2017
         * Fecha creacion: 17 de marzo de 2017
         * @author Alejandro Rosales 
     --->        
     <cffunction name="getLeafs" access="remote" hint="Obtencion hojas/ruta de arbol de consultas">
         <cfargument name="level" type="any" hint="Nivel de profundidad">
         <cfargument name="tope" type="any" hint="Profundidad limite">
         <cfargument name="raiz" type="any" hint="Raiz">
         <cfargument name="nombres" type="any" hint="Nombres columnas">
         <cfargument name="filtro" type="any" hint="Crecimiento de filtro consulta">        
         <cfargument name="vista" type="any" hint="Vista a consultar">           
         <cfscript>
             if(level !=2)
                 filtro = filtro & "  AND  ";
             filtro = filtro & " "& nombres[level-1] & " = '" & raiz & "'  ";   
             if(level EQ tope){
                 var leaf = structNew();
                 leaf["values"] = QueryToArray(daoReportes.getValoresNombre(nombres[level],vista,filtro));
                 leaf["filtro"] = filtro;
                 arrayAppend(leafs, leaf,true);
                 var datFila = structNew();
                 datFila["name"] = raiz;
                 datFila["filtro"] = filtro;
                 datFila["level"] = level-1;
                 arrayAppend(treeFila, datFila);
                 for(i = 1; i <= arrayLen(leaf["values"]) ; i++){
                     var node = structNew();
                     node["level"] = level; node["value"] = leaf["values"][i];  node["len"] = 1; 
                     node["filtro"] = filtro & " AND "& nombres[level] & " = '" & leaf["values"][i] & "'  "; 
                     arrayAppend(spans, node);
                     var datFila = structNew();
                     datFila["name"] = leaf["values"][i];
                     datFila["filtro"] = filtro & " AND "& nombres[level] & " = '" & leaf["values"][i] & "'  ";;
                     datFila["level"] = level;
                     arrayAppend(treeFila, datFila);
                 }
                 var node = structNew();
                 node["level"] = level-1;  node["value"] = raiz;  node["len"] = arrayLen(leaf["values"]);
                 arrayAppend(spans, node);
                 return arrayLen(leaf["values"]);     
             }
             else{
                 var datFila = structNew();
                 datFila["name"] = raiz;
                 datFila["filtro"] = filtro;
                 datFila["level"] = level-1;
                 arrayAppend(treeFila, datFila);
                 cont = 0;
                 children[level-1] = QueryToArray(daoReportes.getValoresNombre(nombres[level],vista,filtro));
                 for(var i = 1 ; i<= arrayLen(children[level-1]);i++){
                     var val = getLeafs(level + 1, tope, children[level-1][i], nombres, filtro, vista);
                     if(isNumeric(val))  cont = cont + val;
                 }
                 var node = structNew();  node["level"] = level-1;   node["value"] = raiz;  node["len"] = cont;
                 arrayAppend(spans, node);
             }
         </cfscript>
     </cffunction>

     <!---
         * Fecha creacion: 21 de marzo de 2017
         * @author Alejandro Rosales
     --->
     <cffunction name="getColumnaLen" access="remote" hint="Obtencion de encabezados"> 
         <cfargument name="columnas" type="any" hint="Arreglo con las columnas en el Encabezado">
         <cfscript>
             var column = deserializeJSON(columnas);
             return arrayLen(column);          
         </cfscript>
     </cffunction>

    <!---
    * Fecha creacion: 15 de marzo de 2017
    * @author Jonathan Martinez
    --->        
     <cffunction name="obtenerDatos" access="remote" hint="Obtencion de encabezados">
         <cfargument name="pkConjunto" type="any" hint="Arreglo con las columnas en el Encabezado">
         <cfargument name="vista" type="any" hint="Vista a consultar">
         <cfargument name="columnas" type="any" hint="Arreglo con las columnas en el Encabezado">
         <cfargument name="filtros" type = "any" hint = "Filtros seleccionados">
         <cfargument name="flag" type="any" hint="Conjunto columna o conjunto fila">
         <cfscript>
             leafs = [];
             spans = [];
             treeFila = [];
             var column = deserializeJSON(columnas);
             var nombres = [];
             //Obtencion de nombres
             for(i = 1; i <= arrayLen(column);i++){
                 arrayAppend(nombres, daoReportes.getNombre(pkConjunto,column[i]).N);
             }     
             if(arrayLen(nombres) > 0){
                 if(filtros == "")
                     var raices = QueryToArray(daoReportes.getValoresNombre(nombres[1],vista,""));
                 else
                     var raices = QueryToArray(daoReportes.getValoresNombre(nombres[1],vista," WHERE "&filtros &" "));          
                 if(arrayLen(nombres) GT 1){
                     for(i = 1 ; i<=  arrayLen(raices); i++){
                         if(filtros == "")
                             getLeafs(2,arrayLen(column),raices[i],nombres, "  WHERE  ", vista);
                         else
                             getLeafs(2,arrayLen(column),raices[i],nombres, "  WHERE  " &filtros & " AND " , vista);
                     }
                 }
                 else{
                     var leaf =  structNew();
                     leaf["filtro"] = "";
                     leaf["values"] = raices;
                     arrayAppend(leafs, leaf);   
                     for(i = 1; i <= arrayLen(leaf["values"]) ; i++){
                         var node = structNew();
                         node["level"] = 1;
                         node["value"] = leaf["values"][i];
                         node["len"] = 1;
                         if(filtros == "")
                             node["filtro"] =  " WHERE "& nombres[1] & " = '" & leaf["values"][i] & "'   ";
                         else
                             node["filtro"] =  " WHERE "& nombres[1] & " = '" & leaf["values"][i] & "'  AND "&filtros;
                         arrayAppend(spans, node);  
                         var datFila = structNew();
                         datFila["name"] = leaf["values"][i];
                         datFila["filtro"] = " WHERE "& nombres[1] & " = '" & leaf["values"][i] & "'  ";
                         datFila["level"] = 1;
                         arrayAppend(treeFila, datFila);
                     }         
                 }
             }
             if(flag == 1)
                 return spans;
             else 
                 return treeFila;
         </cfscript>
     </cffunction>

     <!---
         * Fecha creacion: 23 de mayo de 2017
         * @author Alejandro Rosales
     --->    
     <cffunction name="getValueEn" access="remote" hint="Obtencion del enesimo valor">
        <cfargument name="vista" type="any" required="true" hint="Nombre de la vista del conjunto">
        <cfargument name="columna" type="any" required="true" hint="Nombre de la columnas">
        <cfargument name="limite" type="any" required="true" hint="Nombre de la columnas">
        <cfscript>
            var respuesta = QueryToArray( daoReportes.getListColumna(vista,columna) );
            if(limite >= arrayLen(respuesta))
                return respuesta[arrayLen(respuesta)];
            return respuesta[limite];
        </cfscript>
    </cffunction>
     <!---
         * Fecha creacion: 27 de marzo de 2017
         * @author Alejandro Rosales
     --->    
     <cffunction name="getFiltroConsulta" access="remote" hint="Obtiene el filtro para consulta arboles">
         <cfargument name="pkConjunto" type="any" required="yes" hint="pk del Conjunto">
         <cfargument name="filtros" type="any" required="yes" hint="Arreglo de filtros seleccionados">
         <cfargument name="vista" type="any" required="yes" hint="Vista a consultar">
         <cfscript>
            var resultado = "";
            var conjuntoFiltro = [];
            filtros = deserializeJSON(filtros);
            /*Eliminacion*/
             var auxFiltros = filtros;
             var filtroUlt = "";
             filtros = [];
             for(i = 1; i<= arrayLen(auxFiltros);i++){
               if(auxFiltros[i].idFlt == 3){
                    //continue;
                    if(filtroUlt != ""){
                      filtroUlt = filtroUlt & " OR ";
                    }
                    filtroUlt = filtroUlt & daoReportes.getNombre(pkConjunto, auxFiltros[i].idCol ).N & " >= " & getValueEn(vista, daoReportes.getNombre(pkConjunto, auxFiltros[i].idCol).N , auxFiltros[i].val) &" " ; 
                }
                else{
                 arrayAppend(filtros, auxFiltros[i]);
                } 
            }
             if(arrayLen(filtros) EQ 0){

                 return filtroUlt;
             }else if(filtroUlt != ""){
                resultado = resultado &" ( " &filtroUlt & ") AND ";
            }

             arraySort(
                 filtros,
                 function (e1, e2){
                     return compare(e1.idCol, e2.idCol);
                 }
             );
             var piv = filtros[1].idCol;
             var st = "( ";
             var cont = 0;
             for(i = 1; i<= arrayLen(filtros);i++){
                 if( piv != filtros[i].idCol  ){
                     st = st & " ) ";
                     arrayAppend(conjuntoFiltro, st);
                     piv = filtros[i].idCol;
                     st = "( ";
                 }
                 column = daoReportes.getColumnaFiltro(pkConjunto, filtros[i].idCol, filtros[i].idFlt);
                 st = st & column.N &" " & column.F &" '"&filtros[i].val & "' ";
                 if(i < arrayLen(filtros))
                     if(filtros[i].idCol == filtros[i+1].idCol)
                         st = st & " OR ";
             }
             st = st & " ) ";
             arrayAppend(conjuntoFiltro, st);
             for(i = 1 ; i<=arrayLen(conjuntoFiltro); i++){
                 resultado = resultado & conjuntoFiltro[i];
             if(i < arrayLen(conjuntoFiltro))
                 resultado = resultado & " AND ";
             }    
             return resultado;
         </cfscript>
    </cffunction>
     <!---
         * Fecha creacion: 23 de marzo de 2017
         * @author Alejandro Rosales
     --->    
     <cffunction name="getValoresFiltro" access="remote" hint="Obtencion de valores tabla">
         <cfargument name="pkConjunto" type="any" required="yes" hint="Filtros columnas"> 
         <cfargument name="valoresColumna" type="any" required="yes" hint="Filtros columnas">
         <cfargument name="nivelColumna" type="any" required="yes" hint="Nivel columna"> 
         <cfargument name="valoresFila" type="any" required="yes" hint="Filtros filas"> 
         <cfargument name="vista" type="any" required="yes" hint="Tabla a consultar"> 
         <cfargument name="valorC" type="any" required="yes" hint="Nombre columna"> 
         <cfscript>
             var arrayVal = [];
             var conjunto = [];
             var renglon = [];
           //  var filtroURS  = getFiltroUR();
             var filtroURS  = ""; 
             /*Valores columna*/
             for(i = 1; i<=arrayLen(valoresColumna);i++){
                 if( valoresColumna[i].level EQ nivelColumna){
                     var pos =  structNew();
                     pos["name"] = valoresColumna[i].value;
                     pos["filtro"] = valoresColumna[i].filtro;
                     arrayAppend(arrayVal, pos);
                 }
             }
             valoresColumna = arrayVal;
             if(arrayLen(valoresFila) GT 0){
                 for(j = 1 ;  j <=  arrayLen(valoresFila); j++){
                     renglon = [];
                     for(i =1; i<= arrayLen(valoresColumna); i++){
                         arrayAppend(renglon, daoReportes.getValoresFiltro(daoReportes.getNombre(pkConjunto,valorC).N,vista,valoresColumna[i].filtro,replace(valoresFila[j].filtro,"WHERE","AND","ONE"),filtroURS).S);
                     }
                     arrayAppend(conjunto, renglon);
                 }
             }
             else{
                 renglon = [];
                 for(i =1; i<= arrayLen(valoresColumna); i++){
                     arrayAppend(renglon, daoReportes.getValoresFiltro(daoReportes.getNombre(pkConjunto,valorC).N,vista,valoresColumna[i].filtro,"",filtroURS).S);
                 }
                 arrayAppend(conjunto, renglon);
             }
             return conjunto;

         </cfscript>
     </cffunction>    
     
     <!---
         *Fecha de creacion: 23 de marzo de 2017
         * @author Alejandro Rosales
     --->
     <cffunction name="getConjuntoTabla" access="remote" hint="Obtencion del conjunto total de datos">
         <cfargument name="pkConjunto" type="any" required="yes" hint="Filtros columnas"> 
         <cfargument name="valoresColumna" type="any" required="yes" hint="Filtros columnas">
         <cfargument name="nivelColumna" type="any" required="yes" hint="Nivel columna"> 
         <cfargument name="valoresFila" type="any" required="yes" hint="Filtros filas"> 
         <cfargument name="vista" type="any" required="yes" hint="Tabla a consultar"> 
         <cfargument name="vals" type="any" required="yes" hint="Nombre columna"> 
         <cfscript>
             var conjunto = [];
             for(xn = 1; xn <= arrayLen(vals); xn++){
                 var ConjuntoValor = structNew();
                 ConjuntoValor["name"] = daoReportes.getNombreValores(pkConjunto,vals[xn]).N;
                 ConjuntoValor["value"] = getValoresFiltro(pkConjunto,valoresColumna,nivelColumna,valoresFila,vista,vals[xn]);
                 arrayAppend(conjunto, ConjuntoValor);      
            }
             return conjunto;
        </cfscript>
     </cffunction> 
     <!---
         * Fecha creacion: 16 de marzo de 2017
         * @author Alejandro Rosales
     --->    
     <cffunction name="QueryToArray" access="public" returntype="array" output="false" hint="Converir un query en un array">
         <cfargument name="Data" type="query" required="yes" />
         <cfscript>
             var LOCAL = StructNew();
             LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );
             LOCAL.QueryArray = ArrayNew( 1 );
             for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){       
                 for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
                     LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
                     value = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
                 }
                 ArrayAppend( LOCAL.QueryArray, value );
             }
             return( LOCAL.QueryArray );
         </cfscript>
     </cffunction>

 	<!---
	 	 *Fecha :18 de septiembre de 2017
	 	 *@author Alejandro Rosales 
     --->
 	<cffunction name="obtenerReportes" hint="Obtiene los reportes del conjunto de datos">
 		<cfscript>
 			reportUsuario = daoReportes.obtenerReportePK();	
 			var reportes = [];
 			for(var rep in reportUsuario){
                 var reporte=daoReportes.obtenerTablaPorId(rep.idRep);
                 arrayAppend(reportes, reporte);   
             }
             return reportes;
 		</cfscript>
 	</cffunction>


 	<!---
         * Fecha creacion: 16 de marzo de 2017
         * @author Alejandro Rosales
     --->    
     <cffunction name="getNombreConjuntoDatos" access="public" returntype="struct" hint="Obtiene el nombre de un conjunto de datos">
         <cfargument name="pkConjunto" type="numeric" required="yes" hint="Pk del conjunto de datos">
         <cfscript>
             resultado = structNew();            
             conjunto = daoReportes.getNombreConjuntoDatos(pkConjunto);
             if (conjunto.RECORDCOUNT GT 0){
                 resultado.ID = pkConjunto;
                 resultado.NOMBRE = conjunto.REF;
                 resultado.TITULO = conjunto.TIT;
                 resultado.DESC = conjunto.DES;
                // resultado.URD = daoReportess.getExisteURCLAVE("'" &conjunto.REF&"'").VAL;
             }
             return resultado;
         </cfscript>
     </cffunction>

      <!---
         * Fecha creacion: 23 de marzo de 2017
         * @author Jonathan Martinez
     --->
     <cffunction name="obtenerTablaPorId" hint="Obtiene una Tabla por medio de su Id">
         <cfargument name="idRep">
         <cfscript>
             var reporte=daoReportes.obtenerTablaPorId(idRep);
             return reporte;
         </cfscript>
     </cffunction>    


</cfcomponent>