<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Objeto de Acceso a Datos para el modulo convenios7revision
* ================================
---->
<cfcomponent>

    <!---
    * Descripcion:    Obtiene el listado de las clasificaciones y depenedencias con o sin convenios por revisar
    * Fecha creacion: junio 2017
    * @author:        aaron quintana gomez
    --->
    <cffunction name="getClasificacionesUr" access="public" returntype="query" hint="Obtiene las clasificaciones con o sin convenios">
    <cfargument name="ARG_TIPO_CONVENIO" type="numeric" required="yes" hint="tipo de convenio 1(ELEC),2(ELEC),3(MEXUS)"> 
        <cfquery name="result" datasource="DS_CONINV">
          SELECT UPPER(REPLACE(TURIPN.TUR_SIGLA,'"')) AS NOMBRE_UR, 
                 UPPER(CCLA.CLA_CLASIFICACION)        AS CLASIFICACION_UR,
                 UPPER(TCON.TCON_CLAVE)               AS CLAVE_CONVENIO,
                 TCON.TCON_PK_CONVENIO                AS PK_CONVENIO ,
                 TURIPN.TUR_PK_UR
            FROM CONINV.CINVTCONVENIO        TCON,
                 UR.CUR_CLASIFICACION@DBL_UR CCLA,
                 UR.TURIPN@DBL_UR            TURIPN
           WHERE CCLA.CLA_PK_CLASIFICACION = TURIPN.CLASE
             AND TURIPN.FK_DWFINVIGENCIA   IS NULL    
             AND TURIPN.TUR_PK_UR          = TCON.TCON_FK4_UR
             AND TCON.TCON_FK1_ESTADO     <> 141
             AND TCON.TCON_FK1_ESTADO     <> 152
            <cfif ARG_TIPO_CONVENIO NEQ 0>
                AND TCON.BTIP_FK1_TIPO  = <cfqueryparam value="#ARG_TIPO_CONVENIO#" cfsqltype="CF_SQL_INTEGER">
            </cfif> 
            ORDER BY PK_CONVENIO DESC, CLASIFICACION_UR, NOMBRE_UR
        </cfquery>
    <cfreturn result>
    </cffunction>    

</cfcomponent>