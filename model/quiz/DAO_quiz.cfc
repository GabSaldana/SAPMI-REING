<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Principal
* Sub modulo: Login
* Fecha: Marzo 2018
* Descripcion: Objeto de acceso a datos para la obtencion de datos sobre el cuestionario
* @author GSA
* =========================================================================
--->
<cfcomponent>
	<cffunction name="getPreguntas" access="public">
		<cfquery  name="res" datasource="DS_PDIPIMP" result="query">
			SELECT  ARP.RRP_FK_FORMATO, REPORTE.TRP_PK_REPORTE
			FROM PDIPIMP.PLNRACCIONROLPREGUNTA ARP,
			   PDIPIMP.EVTTREPORTE REPORTE
			WHERE ARP.RRP_FK_FORMATO = REPORTE.TRP_FK_FORMATO
			AND ARP.RRP_FK_ESTADO > 0
		</cfquery>
		<cfreturn res>
	</cffunction>

	<!---
	* Desc.:	Se elimino filtro de ACCION, para obtener las preguntas por rol y eje
	* Fecha:	Abril 03, 2018
	* -----------------------------
	* Fecha creacion: 2018
	* @author
	--->
    <cffunction name="getPregunta" access="public" hint="Obtiene las preguntas por rol, eje y accion">
		<cfargument name="rol"		type="numeric" required="yes">
		<cfargument name="accion"	type="numeric" required="yes">
		<cfargument name="eje"		type="numeric" required="yes">
		<cfquery  name="res" datasource="DS_PDIPIMP" result="query">
              SELECT ARP.RRP_FK_FORMATO,
                     REPORTE.TRP_PK_REPORTE,
                     ARP.RRP_IMAGEN,
                     ARP.RRP_FK_ACCION,
                     ARP.RRP_FK_ROL
                FROM PDIPIMP.PLNRACCIONROLPREGUNTA ARP,
                     PDIPIMP.EVTTREPORTE REPORTE,
                     PDIPIMP.PLNCACCION ACCI
               WHERE     ARP.RRP_FK_FORMATO = REPORTE.TRP_FK_FORMATO
                     AND ACCI.CAC_PK_ACCION = ARP.RRP_FK_ACCION
                     AND ARP.RRP_FK_ESTADO > 0
                     AND ARP.RRP_FK_ROL = <cfqueryparam value="#arguments.rol#" cfsqltype="cf_sql_numeric">
                     AND ACCI.CAC_NUMERO = <cfqueryparam value="#arguments.accion#" cfsqltype="cf_sql_numeric">
                     AND ACCI.CAC_FK_EJE = <cfqueryparam value="#arguments.eje#" cfsqltype="cf_sql_numeric">
            ORDER BY ARP.RRP_ORDEN
		</cfquery>
		<cfreturn res>
	</cffunction>
</cfcomponent>