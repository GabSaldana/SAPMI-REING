
<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha :14 de agosto de 2015
* Descripcion: 
* Objeto de acceso a datos para los conjuntos. 
* Autor:Arturo Christian Santander Maya 
* ================================
--->




<cfcomponent accessors="true" singleton>
	
	
	
	
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	

	<!---
		*Fecha Creacion :14 de agosto de 2015
		*@author Arturo Christian Santander Maya
		 
		*Fecha Modificacion :8 de Marzo de 2017
		*Descripcion Modificacion: Adapta la consulta para obtener los datos de la nueva tabla "usrtconjuntodatos"
		*@author: Jonathan Martinez
	--->
	<cffunction name="obtenerConjuntosUsuario" hint="Obtiene los identificadores de los datos asociados a un usuario">
		<cfargument name="idUsuario">
		<cfquery  name="obtenerConUsr" datasource="DS_PDIPIMP">
		    SELECT TCD.TCD_PK_CONJUNTODATOS AS IDCONJUNTO
		      FROM  PDIPIMP.BITRCUBOFORMATO CF,
		            PDIPIMP.MEDTCONJUNTODATOS TCD,
		            PDIPIMP.EVTRUSUARIOFORMATO RUF
		      WHERE CF.RCF_FK_FORMATO = RUF.TRU_FK_FORMATO
		            AND TCD.TCD_FK_CUBO = CF.RCF_FK_CUBO
		            AND TCD.TCD_FK_ESTADO > 0
		            AND RUF.TRU_ESTADO > 0
		            <cfif NOT arraycontains(session.cbstorage.grant,'configFT.verTodos')>
			            AND RUF.TRU_FK_USUARIO = #idUsuario#
		            </cfif>
		 GROUP BY TCD.TCD_PK_CONJUNTODATOS

		 UNION 

			  SELECT 
					  UC.TCO_FK_CONJUNTO	 		AS idConjunto
				 FROM USRTCONJUNTODATOS UC, MEDTCONJUNTODATOS MC
				 WHERE UC.TCO_FK_CONJUNTO = MC.TCD_PK_CONJUNTODATOS 
				 AND   UC.TCO_FK_USUARIO  = #idUsuario#
				 AND   MC.TCD_FK_ESTADO  IN (1,2)
				 ORDER BY idConjunto
		</cfquery>
		<cfreturn obtenerConUsr>
	</cffunction>

	
	<!---
		*Fecha :26 de octubre de 2015
		* @author Arturo Christian Santander Maya 
	--->


	<cffunction name="obtenerConjuntoPorId" hint="Obtiene los datos para crear un conjunto ">
		<cfargument name="idCon">
				
		<cfscript>
			var spCon = new storedproc(); 
			spCon.setDatasource("DS_PDIPIMP"); 
			spCon.setProcedure("P_TABLASDINAMICAS.obtenerConjunto"); 
		    	
		    spCon.addParam(cfsqltype="cf_sql_numeric",type="in",value=idCon);
		  
		    		
		    spCon.addProcResult(name="conjunto",resultset=1); 
		    spCon.addProcResult(name="columnas",resultset=2); 
		    spCon.addProcResult(name="datos",resultset=3); 
					
			var result = spCon.execute(); 
				
			var conjuntoConsultas={};
			conjuntoConsultas["conjunto"]=result.getProcResultSets().conjunto;
			conjuntoConsultas["columnas"]=result.getProcResultSets().columnas;
			conjuntoConsultas["datos"]=result.getProcResultSets().datos;

			return conjuntoConsultas;
		</cfscript>
	</cffunction>



</cfcomponent>