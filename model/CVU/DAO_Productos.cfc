<!---
========================================================================
* IPN - CSII
* Sistema: CRUD 
* Modulo: Consultar los productos del catalogo
* Sub modulo: -
* Fecha: 17/octubre/2017
* Descripcion: Model DAO
* Autor: Gabriela Saldaña
=========================================================================
--->

<cfcomponent>


	<!---
    * Descripcion:    Trae las clasifiaciones de los productos
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->
	<cffunction name="obtenerClasificacion" hint="Trae las clasifiaciones de los productos">    
		<cfquery name="qClasificacion" datasource="DS_CVU">

			SELECT  CPD_CPRODUCTO       AS CLASIFICACION, 
					CPD_PK_CPRODUCTO    AS PKCLASIFICACION,
					CPD_DESCRIPCION     AS DESCRIPCION,
					CPD_REVISTA_ISSN    AS REVISTAISSN,
					CPD_PRODUCTO_ICONO  AS ICONO
			 FROM   CVUCCPRODUCTO
			WHERE   CPD_FK_PADRE IS NULL
			ORDER BY CPD_NUMEROPRODUCTO			
		</cfquery>
        <cfreturn qClasificacion>
	</cffunction>

	<!---
    * Descripcion:    Trae las subclasifiaciones de  un producto padre
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->
	<cffunction name="obtenerSubclasificacion" hint="Trae las subclasifiaciones de los productos">    
		<cfargument name="pkPadre" hint ="">
		<cfquery name="qClasificacion" datasource="DS_CVU">

			SELECT  CPD.CPD_PK_CPRODUCTO     AS PKPRODUCTO,
        			CPD.CPD_CPRODUCTO        AS PRODUCTO,
        			CPD.CPD_DESCRIPCION      AS DESCRIPCION,
        			CPD.CPD_PRODUCTO_ICONO   AS ICONO,
        			CPD.CPD_FK_REPORTE       AS PKREPORTE,
        			CPD.CPD_REVISTA_ISSN     AS REVISTAISSN
  			 FROM   CVUCCPRODUCTO    CPD
 			WHERE   CPD.CPD_FK_PADRE = <cfqueryparam value="#pkPadre#" cfsqltype="cf_sql_numeric">
            ORDER BY CPD_NUMEROPRODUCTO			
		</cfquery>
        <cfreturn qClasificacion>
	</cffunction>

	<!---
    * Descripcion:    Trae las subclasifiaciones de  un producto padre
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->
	<cffunction name="obtenerFiltros" hint="Trae los filtros de un producto dado">    
		<cfargument name="pkPadre" hint ="">
		<cfquery name="qClasificacion" datasource="DS_CVU">

			select CPD_PK_CPRODUCTO AS PKFILTRO,
			          CPD_CPRODUCTO AS FILTRO,
			          CPD_REVISTA_ISSN AS REVISTAISSN,
			         CPD_FK_REPORTE AS REPORTE,level
 			from CVUCCPRODUCTO
			start with CPD_PK_CPRODUCTO = <cfqueryparam value="#pkPadre#" cfsqltype="cf_sql_numeric">
			CONNECT BY NOCYCLE  prior CPD_FK_PADRE = CPD_PK_CPRODUCTO  
			order by level desc
			
		</cfquery>
		<!--cfdump var="#qClasificacion#"--><!--cfabort-->
        <cfreturn qClasificacion>
	</cffunction>


   <!---
    * Descripcion:    Trae el pk del reporte y del formato perteneciente a un producto :]
    * Fecha creacion: 30 de octubre de 2017
    * @author:        Ana B J M
    ** comentarios 
    --->
	<cffunction name="getReporteFormato" hint="Trae el pk del reporte y del formato perteneciente a un producto">    
		<cfargument name="pkProducto" hint ="">
		<cfquery name="qClasificacion" datasource="DS_CVU">

			SELECT NVL(CPD.CPD_FK_REPORTE, 0) AS PKREPORTE,
	        NVL(TFR.TFR_FK_CFORMATO, 0) AS PKFORMATO,        
	        NVL(TRP.TRP_FK_PERIODO, 0) AS PERIODO 

			FROM CVUCCPRODUCTO CPD,
			     EVTTREPORTE TRP,
			     EVTTFORMATO TFR

			WHERE CPD.CPD_FK_REPORTE = TRP.TRP_PK_REPORTE
			  AND TRP.TRP_FK_FORMATO = TFR.TFR_PK_FORMATO
			  AND CPD.CPD_PK_CPRODUCTO = <cfqueryparam value="#pkProducto#" cfsqltype="cf_sql_numeric">
			
		</cfquery>
        <cfreturn qClasificacion>
	</cffunction>


   <!---
    * Descripcion:    Trae el pk del producto correspondiente al tipo de revista asignada al issn :]
    * Fecha creacion: 30 de octubre de 2017
    * @author:        Ana B J M
    ** comentarios 
    --->
	<cffunction name="traeTipoRevista" hint="rae el pk del producto correspondiente al tipo de revista asignada al issn">    
		<cfargument name="issn" hint ="">
		<cfquery name="qClasificacion" datasource="DS_CVU">

		SELECT TAR.TAR_FK_PRODUCTO AS PRODUCTOA,
					TAR.TAR_ANIO AS ANIO 
			FROM CVUCREVISTA CRE,
				 CVUTANIOREVISTA TAR
			WHERE CRE.CRE_PK_REVISTA = TAR.TAR_FK_REVISTA
			  AND CRE.CRE_ISSN = '#issn#'
			
		</cfquery>
        <cfreturn qClasificacion>
	</cffunction>

    <!---
    * Descripcion:    Edita el nombre del producto
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarProductoNombre" access="public" returntype="numeric" hint="Edita el nombre del producto">
        <cfargument name="pkProducto"     type="numeric" required="yes" hint="Pk del producto">
        <cfargument name="productoNombre" type="string"  required="yes" hint="Nombre del producto">
        <cfstoredproc procedure="CVU.P_CVUPRODUCTOS.UPDATEPRODUCTO_NOMBRE" datasource="DS_CVU">
            <cfprocparam value="#pkProducto#"      cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#productoNombre#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam variable="resultado"      cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Edita la descripcion del producto
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarProductoDescripcion" access="public" returntype="numeric" hint="Edita la descripcion del producto">
        <cfargument name="pkProducto"          type="numeric" required="yes" hint="Pk del producto">
        <cfargument name="productoDescripcion" type="string"  required="yes" hint="Descripcion del producto">
        <cfstoredproc procedure="CVU.P_CVUPRODUCTOS.UPDATEPRODUCTO_DESCRIPCION" datasource="DS_CVU">
            <cfprocparam value="#pkProducto#"           cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#productoDescripcion#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam variable="resultado"           cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion: Obtiene las revistas y llena la tabla de la vista
    * Fecha:       13 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaRevistas" access="public" returntype="query" hint="Obtiene las revistas y llena la tabla de la vista">
        <cfargument name="pais"      type="string" required="true" hint="Nombre del pais"> 
        <cfargument name="editorial" type="string" required="true" hint="Nombre de la editorial"> 
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT REVISTA.CRE_PK_REVISTA AS PK,
                   REVISTA.CRE_ISSN       AS ISSN,
                   REVISTA.CRE_REVISTA    AS NOMBRE,
                   REVISTA.CRE_EDITORIAL  AS EDITORIAL,
                   REVISTA.CRE_DESC_PAIS  AS PAIS
              FROM CVU.CVUCREVISTA REVISTA
             WHERE REVISTA.CRE_DESC_PAIS = <cfqueryparam value="#pais#"      cfsqltype="cf_sql_string">
               AND REVISTA.CRE_EDITORIAL = <cfqueryparam value="#editorial#" cfsqltype="cf_sql_string">
          ORDER BY NOMBRE
        </cfquery>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la informacion de la revista seleccionada
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    * @param:         pkRevista
    --->
    <cffunction name="getRevistabyPKRevista" access="public" returntype="query" hint="Obtiene la informacion de la revista seleccionada">
        <cfargument name="pkRevista" type="numeric" required="true" hint="PK de la revista"> 
        <cfquery name="result" datasource="DS_CVU">
            SELECT REVISTA.CRE_PK_REVISTA AS PK,
                   REVISTA.CRE_ISSN       AS ISSN,
                   REVISTA.CRE_REVISTA    AS NOMBRE,
                   REVISTA.CRE_EDITORIAL  AS EDITORIAL,
                   REVISTA.CRE_DESC_PAIS  AS PAIS
              FROM CVU.CVUCREVISTA REVISTA
             WHERE REVISTA.CRE_PK_REVISTA = <cfqueryparam value="#pkRevista#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn result>
    </cffunction>


    <!---
    * Descripcion:    Obtiene la informacion clasificada por pais
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getPais" access="public" returntype="query" hint="Obtiene la informacion clasificada por pais">
        <cfquery name="result" datasource="DS_CVU">
            SELECT COUNT(REVISTA.CRE_DESC_PAIS) AS TOTPAIS, 
                   REVISTA.CRE_DESC_PAIS        AS PAIS
              FROM CVU.CVUCREVISTA REVISTA
          GROUP BY REVISTA.CRE_DESC_PAIS
          ORDER BY PAIS, TOTPAIS DESC
        </cfquery>
        <cfreturn result>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la informacion clasificada por editorial
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getEditorial" access="public" returntype="query" hint="Obtiene la informacion clasificada por editorial">
        <cfargument name="pais" type="string" required="true" hint="Nombre del pais"> 
        <cfquery name="result" datasource="DS_CVU">
            SELECT COUNT(REVISTA.CRE_EDITORIAL) AS TOTEDITORIAL, 
                   REVISTA.CRE_EDITORIAL        AS EDITORIAL
              FROM CVU.CVUCREVISTA REVISTA
            WHERE REVISTA.CRE_DESC_PAIS = <cfqueryparam value="#pais#" cfsqltype="cf_sql_string">
          GROUP BY REVISTA.CRE_EDITORIAL
          ORDER BY EDITORIAL, TOTEDITORIAL DESC  
        </cfquery>
        <cfreturn result>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nueva revista
    * Fecha creacion: 14 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarRevista" access="public" returntype="numeric" hint="Guarda nueva revista">
        <cfargument name="Nombre"    type="string" required="yes" hint="Titulo de la revista">
        <cfargument name="Editorial" type="string" required="yes" hint="Editorial de la revista">
        <cfargument name="Pais"      type="string" required="yes" hint="País de la revista">
        <cfargument name="ISSN"      type="string" required="yes" hint="ISSN de la revista">
        <cfstoredproc procedure="CVU.P_CVUREVISTA.ADDREVISTA" datasource="DS_CVU">
            <cfprocparam value="#Nombre#"     cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#Editorial#"  cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#Pais#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#ISSN#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Edita revista seleccionada
    * Fecha creacion: 14 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarRevista" access="public" returntype="numeric" hint="Edita revista seleccionada">
        <cfargument name="PkRevista" type="numeric" required="yes" hint="PK de la revista">
        <cfargument name="Nombre"    type="string"  required="yes" hint="Titulo de la revista">
        <cfargument name="Editorial" type="string"  required="yes" hint="Editorial de la revista">
        <cfargument name="Pais"      type="string"  required="yes" hint="País de la revista">
        <cfargument name="ISSN"      type="string"  required="yes" hint="ISSN de la revista">
        <cfstoredproc procedure="CVU.P_CVUREVISTA.UPDATEREVISTA" datasource="DS_CVU">
            <cfprocparam value="#PkRevista#"  cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#Nombre#"     cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#Editorial#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#Pais#"       cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#ISSN#"       cfsqltype="cf_sql_string"  type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion: Obtiene los niveles de la revista seleccionada y llena la tabla
    * Fecha:       18 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaNivelesByRevista" access="public" returntype="query" hint="Obtiene los niveles de la revista seleccionada y llena la tabla">
        <cfargument name="PkRevista" type="numeric" required="yes" hint="PK de la revista">
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT NIVEL.TAR_PK_ANIOREVISTA AS PK,
                   NIVEL.TAR_ANIO           AS ANIO,
                   NIVEL.TAR_NIVEL          AS NIVEL
              FROM CVU.CVUTANIOREVISTA NIVEL
             WHERE NIVEL.TAR_FK_REVISTA = <cfqueryparam value="#PkRevista#" cfsqltype="cf_sql_numeric">
          ORDER BY ANIO
        </cfquery>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nuevo nivel para la revista
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarNivel" access="public" returntype="numeric" hint="Guarda nuevo nivel para la revista">
        <cfargument name="PkRevista" type="numeric" required="yes" hint="PK de la revista">
        <cfargument name="Nivel"     type="string"  required="yes" hint="Nivel de la revista">
        <cfargument name="Anio"      type="numeric" required="yes" hint="Año de la revista">
        <cfargument name="Producto"  type="numeric" required="yes" hint="Producto asociado">
        <cfstoredproc procedure="CVU.P_CVUREVISTA.ADDANIOREVISTA" datasource="DS_CVU">
            <cfprocparam value="#PkRevista#"  cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#Nivel#"      cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#Anio#"       cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#Producto#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Edita el nivel de la revista seleccionada
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarNivel" access="public" returntype="numeric" hint="Edita el nivel de la revista seleccionada">
        <cfargument name="PkNivel"   type="numeric" required="yes" hint="PK del nivel">
        <cfargument name="Nivel"     type="string"  required="yes" hint="Nivel de la revista">
        <cfargument name="Anio"      type="numeric" required="yes" hint="Año de la revista">
        <cfargument name="Producto"  type="numeric" required="yes" hint="Producto asociado">
        <cfstoredproc procedure="CVU.P_CVUREVISTA.UPDATEANIOREVISTA" datasource="DS_CVU">
            <cfprocparam value="#PkNivel#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#Nivel#"      cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#Anio#"       cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#Producto#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Obtiene los años registrados de los niveles en la revista
    * Fecha creacion: 19 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getAnios" access="public" returntype="query" hint="Obtiene la informacion clasificada por editorial">
        <cfargument name="pkRevista" type="numeric" required="true" hint="PK de la revista"> 
        <cfquery name="result" datasource="DS_CVU">
            SELECT NIVEL.TAR_ANIO      AS ANIO
              FROM CVU.CVUTANIOREVISTA NIVEL
             WHERE TAR_FK_REVISTA = <cfqueryparam value="#pkRevista#" cfsqltype="cf_sql_numeric">
          ORDER BY ANIO DESC 
        </cfquery>
        <cfreturn result>
    </cffunction>

    <!--- 
    * Descripcion:    Elimina el nivel de la revista seleccionada
    * Fecha creacion: 26 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="eliminarNivel" access="public" returntype="numeric" hint="Elimina el nivel de la revista seleccionada">
        <cfargument name="PkNivel" type="numeric" required="yes" hint="PK del nivel">
        <cfstoredproc procedure="CVU.P_CVUREVISTA.DELETEANIOREVISTA" datasource="DS_CVU">
            <cfprocparam value="#PkNivel#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

</cfcomponent>