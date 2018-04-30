<cfcomponent>
 
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="getIndicadores">
		<cfquery name="respuesta" datasource="DS_GRAL">
			SELECT MV.TMV_NOMBRE AS NOMBRE,
			       MV.TMV_PK_MIONVISIONSAPM AS PK,
			       MV.TMV_FK_CESTADO AS CESESTADO,
			       MV.TMV_VALOR AS VALOR,
			       MV.TMV_FK_RUTA AS CESRUTA
			FROM GRAL.TMIONVISIONSAPMI MV
			WHERE MV.TMV_ESTADO > 0
			ORDER BY MV.TMV_PK_MIONVISIONSAPM
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

</cfcomponent>