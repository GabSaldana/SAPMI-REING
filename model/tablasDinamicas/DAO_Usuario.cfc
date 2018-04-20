<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Fecha : 28 de marzo del 2017
* Descripcion: 
* Objeto de acceso a datos para los Usuarios . 
* Autor:Jonathan Martinez 
* ================================
--->
 <cfcomponent accessors="true" singleton>	
	 <!---
	   	 *Fecha :28 de marzo de 2017
	 	 *@author Jonathan Martinez
  	 --->
	 <cffunction name="init">
		 <cfscript>
			 return this;
		 </cfscript>
	 </cffunction>
	 <!---
	   	 *Fecha :28 de marzo de 2017
	 	 *@author Jonathan Martinez
  	 --->
	<cffunction name="obtenerUsuariosAutorizados" hint="Obtiene los datos de los usuarios a los que es posible compartir una Tabla">
		 <cfargument name="idUsuario">
		 <cfargument name="idCon">
		 <cfargument name="idTab">
		 <cfscript>
			 var spTab = new storedproc(); 
			 spTab.setDatasource("DS_PDIPIMP"); 
			 spTab.setProcedure("P_TABLASDINAMICAS.OBTENER_USUARIOS"); 
		   		
			 spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idUsuario);
			 spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idCon);
			 spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idTab);
		   
		     spTab.addProcResult(name="usuarios",resultset=1); 
		     spTab.addProcResult(name="usuariosTabla",resultset=2); 
		  
			 var result = spTab.execute(); 
					
			 var repConsultas={};
			 repConsultas["usuarios"]=result.getProcResultSets().usuarios;
			 repConsultas["usuariosTabla"]=result.getProcResultSets().usuariosTabla;
			 return repConsultas;
		 </cfscript>
	 </cffunction>
	 <!---
	   	 *Fecha :28 de marzo de 2017
	 	 *@author Jonathan Martinez
  	 --->
	 <cffunction name="obtenerUsuarioShare" hint="Obtiene los datos del usuario que compartio por ultima vez">
		 <cfargument name="idUsuario">
		 <cfargument name="idTab">
		 <cfquery  name="obtenerUsuShare" datasource="DS_PDIPIMP">
			 SELECT 
				  US.TUS_USUARIO_NOMBRE	 		||'  '||
				  US.TUS_USUARIO_PATERNO		AS nombre
			 FROM USRTUSUARIO US, TDITTABLAUSUARIO TU
			 WHERE US.TUS_PK_USUARIO = TU.TTU_FK_USUARIOSHARE 
			 AND   TU.TTU_FK_USUARIO  = #idUsuario#
			 AND   TU.TTU_FK_TABLA = #idTab#
			 ORDER BY nombre
		 </cfquery>
		 <cfreturn obtenerUsuShare>
	 </cffunction>

</cfcomponent>	