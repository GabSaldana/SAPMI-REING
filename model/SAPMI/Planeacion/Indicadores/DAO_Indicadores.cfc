<cfcomponent>
 
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getFormatos" hint=""> 
   		<cfargument name="pkUsuario">
		<cfargument name="UR" default="">
		<cfquery  name="res" datasource="DS_CVU" >
		    SELECT  CFT.CFT_NOMBRE      AS NOMBRE,
                    TFT.TFR_PK_FORMATO  AS PK,
                    CFT.CFT_CLAVE       AS CLAVE,        
                    TFT.TFR_VERSION     AS VERSION,            
					TFT.TFR_FK_CESTADO	AS CESESTADO,
					TFT.TFR_RUTA		AS CESRUTA
   			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT
					<cfif pkusuario neq ''>
                    ,CVU.EVTRUSUARIOFORMATO UFT
					</cfif>
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    <cfif pkusuario neq ''>
						AND TFT.TFR_PK_FORMATO = UFT.TRU_FK_FORMATO
	                    AND UFT.TRU_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
	                    AND UFT.TRU_ESTADO = 1
					</cfif>
					
					<cfif UR neq ''>
                    	AND TFT.TFR_FK_UR = <cfqueryparam value="#arguments.UR#" cfsqltype="CF_sql_char">
                    </cfif>
		  ORDER BY	TFT.TFR_PK_FORMATO  DESC 

		</cfquery>
		<cfreturn res>
	</cffunction>

	<cffunction name="getIndicadores">
		<cfquery name="respuesta" datasource="DS_GRAL">
			SELECT TES.TEST_NOMBRE AS NOMBRE,
			       TES.TEST_PK_OBJETO AS PK,
			       TES.TEST_CLAVE AS CLAVE,
			       TES.TEST_FK_CESTADO AS CESESTADO,
			       TES.TEST_RUTA AS CESRUTA
			FROM GRAL.TEST TES
			WHERE TES.TEST_ESTADO > 0
			ORDER BY TES.TEST_PK_OBJETO
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

</cfcomponent>