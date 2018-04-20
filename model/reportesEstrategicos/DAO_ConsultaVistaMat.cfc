<!---
* ============================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Principal
* Sub modulo: Pruebas
* Fecha: 11 de agosto de 2015
* Descripcion: Acceso a datos para la contrucción de reportes estratégicos.
* ============================================================================
--->

<cfcomponent>

  <!---
  * Modificación 28 de septiembre
  * Fecha creacion: 11 de agosto de 2015
  * @author Yareli Andrade
  ---> 
  <cffunction name="getTipoCol" access="public" returntype="query">
      <cfargument name="pkConjunto" type="numeric" required="yes">
      <cfquery name="respuesta" datasource="DS_PDIPIMP">

        SELECT TCO_PK_COLUMNA VAL,
                 TCO.TCO_NOMBREGENERAL GRAL,
                 TCO.TCO_NOMBRE NOM, 
                 TCO.TCO_DESCRIPCION DES,
                 CTC.CTC_PK_TIPOCOLUMNA TIPO, 
                 TCC.TCC_FK_PRIORIDADCOLUMNA PRI,
                 TCC.TCC_OBLIGATORIO OBL,
                 CONNECT_BY_ROOT(TCO.TCO_PK_COLUMNA) ROOT
            FROM PDIPIMP.MEDTCONJUNTOCOLUMNA  TCC,
                 PDIPIMP.MEDTCOLUMNA          TCO,
                 PDIPIMP.MEDTCONJUNTODATOS    TCD,
                 PDIPIMP.MEDTVISTACONJUNTO    TVI,
                 PDIPIMP.MEDCTIPOCOLUMNA      CTC,
                 PDIPIMP.MEDCVISTA            CVI
            WHERE TCC.TCC_FK_COLUMNA  = TCO.TCO_PK_COLUMNA
                  AND TCC.TCC_FK_VISTACONJUNTO = TVI.TVI_PK_VISTACONJUNTO
                  AND TCD.TCD_PK_CONJUNTODATOS =TVI.TVI_FK_CONJUNTODATOS
                  AND CVI.CVI_PK_VISTA = TVI.TVI_FK_VISTA
                  AND TCO.TCO_FK_TIPOCOLUMNA = CTC.CTC_PK_TIPOCOLUMNA
                  AND TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#
                  AND TCC.TCC_FK_ESTADO = 2
            START WITH TCC.TCC_FK_PADRE IS NULL 
            CONNECT BY PRIOR TCC.TCC_PK_CONJUNTOCOLUMNA = TCC.TCC_FK_PADRE
            ORDER BY TCC_ORDEN, VAL, GRAL

      </cfquery>
      <cfreturn respuesta>
  </cffunction>

  

 <!---
  * Modificación 03 Marzo 2017
  * Autor de modificacion: Alejandro Rosales
  * Modificación 29 de septiembre
  * Fecha creacion: 14 de agosto de 2015
  * @author Yareli Andrade
  ---> 
<cffunction name="getEltosCampo" access="public" returntype="query">
      <cfargument name="vista" type="string" required="yes">
      <cfargument name="columna" type="string" required="yes">
      <cfargument name="filtro" type="string" required="yes">
      <cfscript>
        
        var query = "SELECT "&columna&" C FROM "&vista&" "&filtro&" GROUP BY " &columna& " ORDER BY " &columna;
        var resultado = ejecutaConsulta(query);
        return resultado;
    
      </cfscript>

</cffunction>

  <!---
  * Modificación 28 de septiembre
  * Fecha creacion: 21 de agosto de 2015
  * @author Yareli Andrade
  ---> 
  <cffunction name="getNombre" access="public" returntype="query">
      <cfargument name="pkConjunto" type="numeric" required="yes">
      <cfargument name="pkCampo" type="numeric" required="yes">
      <cfquery name="respuesta" datasource="DS_PDIPIMP">
          SELECT TCO.TCO_COLUMNAREF N, 
                 LEVEL ORD                    
          FROM MEDTCOLUMNA TCO  
            INNER JOIN MEDTCONJUNTOCOLUMNA  TCC ON TCC.TCC_FK_COLUMNA  = TCO.TCO_PK_COLUMNA
            INNER JOIN MEDTVISTACONJUNTO            TVI ON TCC.TCC_FK_VISTACONJUNTO = TVI.TVI_PK_VISTACONJUNTO
            INNER JOIN MEDTCONJUNTODATOS    TCD ON TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS             
          WHERE TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#
          AND TCO.TCO_PK_COLUMNA = #pkCampo#   
            START WITH TCC.TCC_FK_PADRE IS NULL 
            CONNECT BY PRIOR TCC.TCC_PK_CONJUNTOCOLUMNA = TCC.TCC_FK_PADRE   

      </cfquery>
      <cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha creacion: 31 de agosto de 2015
  * @author Yareli Andrade
  ---> 
  <cffunction name="getTipoCol2" access="public" returntype="query">
      <cfargument name="pkConjunto" type="numeric" required="yes">
      <cfargument name="tipo" type="numeric" required="yes">
      <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT TCO_PK_COLUMNA VAL,             
                 TCO.TCO_DESCRIPCION DES,                
                 CTC.CTC_PK_TIPOCOLUMNA TIPO               
            FROM MEDTCOLUMNA TCO  
              INNER JOIN MEDTCONJUNTOCOLUMNA  TCC ON TCC.TCC_FK_COLUMNA  = TCO.TCO_PK_COLUMNA
              INNER JOIN MEDTVISTACONJUNTO            TVI ON TCC.TCC_FK_VISTACONJUNTO = TVI.TVI_PK_VISTACONJUNTO
              INNER JOIN MEDTCONJUNTODATOS    TCD ON TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
              INNER JOIN MEDCVISTA            CVI ON CVI.CVI_PK_VISTA = TVI.TVI_FK_VISTA
              INNER JOIN MEDCTIPOCOLUMNA      CTC ON TCO.TCO_FK_TIPOCOLUMNA = CTC.CTC_PK_TIPOCOLUMNA              
            WHERE TCD.TCD_PK_CONJUNTODATOS = #pkConjunto# 
                  AND CTC.CTC_PK_TIPOCOLUMNA = #tipo# 
                  AND TCC.TCC_FK_ESTADO = 2
      </cfquery>
      <cfreturn respuesta>
  </cffunction>

 
  <!---
  * Modificacion: 06 de Marzo de 2017
  * @author Alejandro Rosales
  * Fecha creacion: 31 de agosto de 2015
  * @author Yareli Andrade
  --->
   <cffunction name="getEltosCampo2" access="public" returntype="query">      
      <cfargument name="campo" type="string" required="yes">
      <cfargument name="filtro" type="string" required="yes">
      <cfargument name="vista" type="string" required="yes">
      <cfargument name="filtroUR" type="string" required="yes">
      <cfscript>
      
      var query = "SELECT DISTINCT "&campo&" C FROM "&vista&" WHERE "&PreserveSingleQuotes(filtro)&"  "&filtroUR&" ORDER BY "&campo;
      var resultado = ejecutaConsulta(query);
      return resultado;
  
      </cfscript>      
      
  </cffunction> 




  <!---
  * Fecha : 29 de septiembre de 2015
  * Autor : Yareli Andrade
  --->  
  <cffunction name="getNombreConjuntoDatos" access="public" returntype="query">
    <cfargument name="pkConjunto" type="numeric" required="yes">
    <cfquery name="respuesta" datasource="DS_PDIPIMP">
          SELECT TCD.TCD_NOMBRE TIT, 
                 CVI.CVI_NOMBRE REF,
                 TCD.TCD_DESCRIPCION DES                 
            FROM PDIPIMP.MEDTCONJUNTODATOS    TCD,
                 PDIPIMP.MEDTVISTACONJUNTO            TVI,
                 PDIPIMP.MEDCVISTA             CVI
            WHERE TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
                  AND CVI.CVI_PK_VISTA = TVI.TVI_FK_VISTA
                  AND TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#          
      </cfquery>
      <cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha : 09 de octubre de 2015
  * Autor : Yareli Andrade
  --->  
  <cffunction name="getOperacion" access="public" returntype="query">
    <cfargument name="pkColumna" type="numeric" required="yes">
    <cfquery name="respuesta" datasource="DS_PDIPIMP">
      SELECT CAT.COP_PK_OPERACION PK,
             CAT.COP_TITULO NOMBRE, 
             CAT.COP_DESCRIPCION DES,
             CAT.COP_TITULO TITULO
        FROM MEDTCOLUMNAOPERACION REL 
        INNER JOIN MEDCOPERACION CAT
        ON REL.TCP_FK_OPERACION = CAT.COP_PK_OPERACION 
        WHERE TCP_FK_COLUMNA = #pkColumna# 
        AND TCP_FK_ESTADO = '2'
      </cfquery>
      <cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha : 09 de octubre de 2015
  * Autor : Yareli Andrade
  --->  
  <cffunction name="getAggregateFunction" access="public" returntype="query">
      <cfargument name="pkOperacion" type="numeric" required="yes">
      <cfquery name="respuesta" datasource="DS_PDIPIMP">
        SELECT CAT.COP_REPRESENTACION PRE
          FROM MEDCOPERACION CAT
          WHERE CAT.COP_PK_OPERACION = #pkOperacion#
      </cfquery>
      <cfreturn respuesta>
  </cffunction> 

  <!---
  * Modificación: 19 de octubre
  * Fecha : 14 de octubre de 2015
  * Autor : Yareli Andrade
  --->
  <cffunction name="getRelacion" returntype="query">
      <cfargument name="pkColumna" type="numeric" required="yes">
      <cfargument name="pkConjunto" type="numeric" required="yes">
      <cfargument name="tipo" type="numeric" required="yes">
      <cfquery name="respuesta" datasource="DS_PDIPIMP">
        SELECT TCO_PK_COLUMNA VAL,
            TCO.TCO_DESCRIPCION DES, 
            CTC.CTC_PK_TIPOCOLUMNA TIPO, 
            LEVEL ORD 
        FROM MEDTCONJUNTOCOLUMNA TCC 
            INNER JOIN MEDTCOLUMNA TCO ON TCO.TCO_PK_COLUMNA =  TCC.TCC_FK_COLUMNA
            INNER JOIN MEDCTIPOCOLUMNA CTC ON TCO.TCO_FK_TIPOCOLUMNA = CTC.CTC_PK_TIPOCOLUMNA
        WHERE
        CONNECT_BY_ROOT(TCC.TCC_PK_CONJUNTOCOLUMNA) = (SELECT CONNECT_BY_ROOT(TCC_PK_CONJUNTOCOLUMNA) ROOT 
                                                           FROM MEDTCONJUNTOCOLUMNA CC
                                                           INNER JOIN MEDTVISTACONJUNTO VI ON CC.TCC_FK_VISTACONJUNTO = VI.TVI_PK_VISTACONJUNTO
                                                           INNER JOIN MEDTCONJUNTODATOS CD ON CD.TCD_PK_CONJUNTODATOS = VI.TVI_FK_CONJUNTODATOS
                                                           WHERE TCC_FK_COLUMNA = #pkColumna# AND CD.TCD_PK_CONJUNTODATOS = #pkConjunto#
                                                           START WITH TCC_FK_PADRE IS NULL
                                                           CONNECT BY PRIOR TCC_PK_CONJUNTOCOLUMNA = TCC_FK_PADRE)
            AND TCC.TCC_FK_ESTADO = 2 
        START WITH TCC.TCC_FK_PADRE IS NULL 
        CONNECT BY PRIOR TCC.TCC_PK_CONJUNTOCOLUMNA = TCC.TCC_FK_PADRE

      </cfquery>
      <cfreturn respuesta>
  </cffunction>


  <!---
  * Fecha : 16 de febrero de 2017
  * Autor : Alejandro Rosales
  --->
  <cffunction name="ejecutaConsulta" access="remote" hint="retorno de una query">
  <cfargument name = "consulta" type = "string" required = "yes">  
   <cfscript>
      excQuery = new query();
      excQuery.setDatasource("DS_PDIPIMP"); 
      excQuery.setName("datos"); 
      var resultado = excQuery.execute(sql=consulta).getResult(); 
      return resultado;  
   </cfscript> 
   </cffunction>


  <!---
  * Fecha : 17 de febrero de 2017
  * Autor : Alejandro Rosales
  --->  
  <cffunction name="getDatosTablaEtiqueta" access="remote" hint = "Obtencion datos de grafica">
    <cfargument name="ejeY" type="any" required="yes">
    <cfargument name="ejeX" type="any" required="yes">
    <cfargument name="etiqueta" type="any" required="yes">
    <cfargument name="conjuntoNombre" type="any" required="yes">
    <cfargument name="funcOperacion" type="any" required="yes">
    <cfargument name="filtro" type="any" required="yes">
    <cfscript>
      var operation = "";
      if(len(ejeY.N))
          operation =  "(" & ejeY.N &")";       
       if(compare(ejeY.N, "LINK")){ 
      var query = "SELECT X.AGRUPACION, X.TIPO, NVL(Q,0) TOTAL
                    FROM 
                        (SELECT NVL(TO_CHAR(" & ejeX.N & "), 'null') AGRUPACION, NVL(TO_CHAR(" & etiqueta.N & "), 'null') TIPO 
                            FROM (SELECT DISTINCT " & ejeX.N & " 
                                    FROM " & conjuntoNombre & filtro & ")
                            CROSS JOIN 
                                 (SELECT DISTINCT " & etiqueta.N & " 
                                    FROM " & conjuntoNombre & filtro & ")
                            ) X LEFT OUTER JOIN 
                        (SELECT NVL(TO_CHAR(" & ejeX.N & "), 'null') AGRUPACION, NVL(TO_CHAR(" & etiqueta.N & "), 'null') TIPO, " &  funcOperacion.PRE & operation & " Q 
                            FROM " & conjuntoNombre & filtro & " 
                            GROUP BY " & ejeX.N & ", " & etiqueta.N & "
                            ) Y 
                    ON X.AGRUPACION = Y.AGRUPACION AND X.TIPO = Y.TIPO ORDER BY X.TIPO, X.AGRUPACION";
       }
       else{
        var query = "SELECT " & ejeY.N & " LIGA FROM  " & Session.cbstorage.conjunto.NOMBRE & filtro;
        query = query & " GROUP BY " & ejeY.N & " ORDER BY LIGA";
       }
      var resultado = ejecutaConsulta(query);
      return resultado;
    </cfscript>
   
    <!---<cfdump var="#resultado#" abort="true">  --->
  </cffunction>

  <!---
  * Fecha : 17 de febrero de 2017
  * Autor : Alejandro Rosales
  --->  
  <cffunction name="getDatosTabla" access="remote" hint = "Obtencion datos de grafica">
    <cfargument name="ejeY" type="any" required="yes">
    <cfargument name="ejeX" type="any" required="yes">
    <cfargument name="conjuntoNombre" type="any" required="yes">
    <cfargument name="funcOperacion" type="any" required="yes">
    <cfargument name="filtro" type="any" required="yes">
    <cfscript>
        if(len(ejeY.N))
          operation =  "(" & ejeY.N &")";
        
         if(compare(ejeY.N, "LINK")){
           var query = "SELECT " & ejeX.N & " TIPO, " & funcOperacion.PRE & operation & " TOTAL FROM  " & Session.cbstorage.conjunto.NOMBRE & filtro;
           query = query & " GROUP BY " & ejeX.N  & " ORDER BY TIPO";
         }
         else{
           var query = "SELECT " & ejeX.N & " TIPO, " & ejeY.N & " LIGA FROM  " & Session.cbstorage.conjunto.NOMBRE & filtro;
           query = query & " AND LINK IS NOT NULL ORDER BY TIPO";
         }
        var resultado = ejecutaConsulta(query);
        return resultado;
  </cfscript>  
  </cffunction>

  <!---
  * Fecha : 21 de febrero de 2017
  * Autor : Alejandro Rosales
  --->  
  
  <cffunction name="getTipoDato" access="remote" hint="Obtiene tipo de dato de la columna">
    <cfargument name="pkConjunto" type="numeric" required="yes">
    <cfargument name="ejeY" type="any" required="yes">
    <cfscript>
   var query="SELECT CTI.CTI_MASCARA,
                 CTI.CTI_ICONO,
                 CTI.CTI_MODIFICADOR,
                 CTI.CTI_REMPLAZO
            FROM PDIPIMP.MEDTCONJUNTODATOS    TCD,
                 PDIPIMP.MEDTVISTACONJUNTO    TVI,
                 PDIPIMP.MEDTCONJUNTOCOLUMNA TCC,
                 PDIPIMP.MEDTCOLUMNA TCO,
                 PDIPIMP.MEDCTIPODATO CTI
            WHERE TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
                AND TVI.TVI_PK_VISTACONJUNTO = TCC.TCC_FK_VISTACONJUNTO
                AND TCO.TCO_PK_COLUMNA = TCC.TCC_FK_COLUMNA
                AND CTI.CTI_PK_TIPODATO = TCO.TCO_FK_TIPODATO
                AND TCD.TCD_PK_CONJUNTODATOS = " & pkConjunto
                & " AND TCO.TCO_COLUMNAREF = '"& ejeY & "'";
    var resultado = ejecutaConsulta(query);
    return resultado;
    </cfscript>

  </cffunction>


   <!--- 
    *Fecha creacion: 31 de marzo 2017
    *@author Alejandro Rosales
    --->
    <cffunction name="getReportRelated" access="remote" hint = "Obtiene el reporte relacionado">
        <cfargument name="pkReporte" type="numeric" required="yes" hint="pkReporte a consultar">
        <cfquery name = "resultado" datasource="DS_PDIPIMP">
            SELECT FK_RELACIONREPORTE R FROM PDIPIMP.RESTCONFIGURACION WHERE PK_CONFIGURACION = #pkReporte#
        </cfquery>
    </cffunction>
    <!---
 * Fecha creacion: 4 de abril de 2017
 * @author Jonathan Martinez
 ---> 
 <cffunction name="getColumnas" access="public" returntype="query">
     <cfargument name="pkConjunto" type="numeric" required="yes">
     <cfquery name="respuesta" datasource="DS_PDIPIMP">
         SELECT C.TCO_PK_COLUMNA   IDCOL, 
                C.TCO_NOMBRE       NOMBRE                    
         FROM MEDTCOLUMNA C, MEDTCONJUNTOCOLUMNA CC
         WHERE C.TCO_PK_COLUMNA = CC.TCC_FK_COLUMNA
         AND   CC.TCC_FK_VISTACONJUNTO = '#pkConjunto#'
         ORDER BY CC.TCC_ORDEN
     </cfquery>
     <cfreturn respuesta>
 </cffunction>

</cfcomponent>
