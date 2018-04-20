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

	<cffunction name="getEje" access="public">
		<cfargument name="eje" type="string" required="yes">
		<cfquery  name="res" datasource="DS_PDIPIMP" result="query">
			SELECT CEJ_DESCRIPCION
			FROM PLNCEJE
			WHERE CEJ_NOMBRE = <cfqueryparam value="#arguments.eje#" cfsqltype="cf_sql_string">
			AND CEJ_FK_ESTADO > 0
		</cfquery>
		<cfreturn res>
	</cffunction>

	<cffunction name="getNumeroAcciones" access="public">
		<cfargument name="eje" type="numeric" required="yes">
		<cfargument name="rol" type="numeric" required="yes">
		<cfquery  name="res" datasource="DS_PDIPIMP" result="query">
			SELECT COUNT(CAC_NUMERO) as NUM
			FROM (
					SELECT 	CAC_FK_EJE,
							CAC_NUMERO
					FROM 	PLNCACCION CAC,
		                	PDIPIMP.PLNRACCIONROLPREGUNTA ARP
					WHERE   ARP.RRP_FK_ACCION = CAC.CAC_PK_ACCION
		                    AND CAC_FK_EJE = <cfqueryparam value="#arguments.eje#" cfsqltype="cf_sql_numeric">
		                    AND ARP.RRP_FK_ROL = <cfqueryparam value="#arguments.rol#" cfsqltype="cf_sql_numeric">
		                    AND ARP.RRP_FK_ESTADO > 0
							AND CAC_FK_ESTADO > 0
					GROUP BY CAC_FK_EJE,
					CAC_NUMERO 
				)
		</cfquery>
		<cfreturn res>
	</cffunction>

	<cffunction name="getDatosAcciones" access="public">
		<cfargument name="eje" type="numeric" required="yes">
		<cfargument name="rol" type="numeric" required="yes">
		<cfquery  name="res" datasource="DS_PDIPIMP" result="query">
			SELECT CAC_FK_EJE AS EJE,
			    	CAC_NUMERO AS ACCION,
			    	CAC_NOMBRE AS NOMBRE,
			    	CAC_IMAGEN AS IMAGEN,
					CAC_NUMERO AS NUMERO
			FROM 	PLNCACCION CAC,
                	PDIPIMP.PLNRACCIONROLPREGUNTA ARP
			WHERE   ARP.RRP_FK_ACCION = CAC.CAC_PK_ACCION
                    AND CAC_FK_EJE = <cfqueryparam value="#arguments.eje#" cfsqltype="cf_sql_numeric">
                    AND ARP.RRP_FK_ROL = <cfqueryparam value="#arguments.rol#" cfsqltype="cf_sql_numeric">
					AND CAC_FK_ESTADO > 0
                    AND ARP.RRP_FK_ESTADO > 0
			
			GROUP BY CAC_FK_EJE ,
				    CAC_NUMERO ,
				    CAC_NOMBRE,
				    CAC_IMAGEN,
					CAC_NUMERO
			ORDER BY CAC_NUMERO
		</cfquery>
		<cfreturn res>
	</cffunction>

	<!---
	* Fecha creacion: Abril 02, 2018
	* @author Javier Morales Rangel
	--->
    <cffunction name="getAccionesEjesPorRol" access="public" hint="Obtiene la cantidad de acciones registradas por eje, de acuerdo al rol proporcionado" returntype="query">
		<cfargument name="rol" type="string" required="yes">
		<cfquery  name="resAcciones" datasource="DS_PDIPIMP" result="query">
              SELECT CEJES.CEJ_PK_EJE AS PK_EJE, COUNT (A.PK_NUMERO) AS CANTIDAD_ACCIONES
                FROM PDIPIMP.PLNCEJE CEJES,
                     (  SELECT CAC.CAC_FK_EJE AS PK_EJE, CAC.CAC_NUMERO AS PK_NUMERO
                          FROM PDIPIMP.PLNCACCION CAC, PDIPIMP.PLNRACCIONROLPREGUNTA ARP
                         WHERE     ARP.RRP_FK_ACCION = CAC.CAC_PK_ACCION
                               AND ARP.RRP_FK_ROL = <cfqueryparam value="#arguments.rol#" cfsqltype="cf_sql_numeric">
                               AND ARP.RRP_FK_ESTADO > 0
                               AND CAC.CAC_FK_ESTADO > 0
                      GROUP BY CAC.CAC_FK_EJE, CAC.CAC_NUMERO) A
               WHERE CEJES.CEJ_PK_EJE = A.PK_EJE(+)
            GROUP BY CEJES.CEJ_PK_EJE
            ORDER BY CEJES.CEJ_PK_EJE
		</cfquery>
		<cfreturn resAcciones>
	</cffunction>
</cfcomponent>