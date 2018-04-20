<!---
* =========================================================================
* IPN - CSII
* Sistema:		CVU
* Modulo:		Asignaci�n de Responsables
* Fecha:		Marzo de 2017
* Descripcion:	CN para la asignaci�n de responsables.
* Autor: 		Roberto Cadena
* =========================================================================
--->
<cfcomponent <!--- accessors="true" singleton --->>

	<cfproperty name="DAO_P" 	inject="formatosTrimestrales.asignacionResponsables.DAO_AsignacionResponsables">
	<cfproperty name="populator"inject="wirebox:populator">
	<cfproperty name="wirebox"	inject="wirebox">
	<cfproperty name="cache" 	inject="cachebox:default">
	
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

<!--- *********************** Inicio de funciones de Analistas *********************** --->

	<!---
	* Descripcion:	Funci�n para poblar la vista "asignacioAnalistas". 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="getAllFormatosAnalistas" access="public">
		<cfargument name="dependencia" type="string" required="yes">
		<cfargument name="val" type="numeric" required="yes">
		<cfscript>
			relacion.checkbox = val;
			relacion.dependencia = dependencia;
			relacion.analistas = DAO_P.getAllAnalistas();
			relacion.Formato = DAO_P.getFormatos(dependencia);
			relacion.usrFor = DAO_P.usrFor(dependencia);
			relacion.analistaCheck = arrayNew(2);
			relacion.analistaCheck = checkAllUsuarios(relacion.analistaCheck, relacion.Formato, relacion.analistas, relacion.usrFor);
			relacion.formatosNull = DAO_P.formatoNull(dependencia);
			return relacion;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Funci�n para establacer si todds los formatos pertenecen a un analista. 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="checkAllUsuarios" access="public">
		<cfargument name="analista" 		type="array" required="yes">
		<cfargument name="comparar"			type="query" required="yes">
		<cfargument name="relacionAnalistas"type="query" required="yes">
		<cfargument name="relacionFormatos"	type="query" required="yes">
		<cfscript>
			for( var j = 1; j lte relacionAnalistas.recordcount; j++){
				analista[j][1] = relacionAnalistas.PKUSUARIO[j];
				analista[j][2] = 0;
			}
			for(var j = 1; j lte relacionFormatos.recordcount; j++)
				for( var i = 1; i lte relacionAnalistas.recordcount; i++)
					if(relacionAnalistas.PKUSUARIO[i] eq relacionFormatos.PKUSUARIO[j])
						analista[i][2]++;
			for(var j = 1; j lte ArrayLen(analista); j++)
				analista[j][2] = (analista[j][2] eq comparar.recordcount) ? 1 : 0;
			return analista;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Inserta un Analista a un formato. 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="insertarAsociacionAnalistas" access="public">
		<cfargument name="idFormato"	type="numeric" required="yes">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfscript>
			return DAO_P.insertarAsociacionAnalistas(idFormato, idAnalista);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Elimina un Analista a un formato. 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="eliminarAsociacionAnalistas" access="public" >
		<cfargument name="idFormato"	type="numeric" required="yes">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfscript>
			return DAO_P.eliminarAsociacionAnalistas(idFormato, idAnalista);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Elimina todos los analistas de un formato. 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="eliminarTodosAnalistas" access="public">
		<cfargument name="idAnalista" type="numeric" required="yes">
		<cfscript>
			return DAO_P.eliminarTodosAnalistas(idAnalista);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion: 	Elimina todos los analistas de un formato. 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="insertarTodosAnalistas" access="public">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfscript>				
			return DAO_P.insertarTodosAnalistas(idAnalista, idDependencia);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion: 	Elimina todos los analistas de un formato. 
	* Fecha: 		10 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="insertarTodosAnalistasNull" access="public">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfscript>				
			return DAO_P.insertarTodosAnalistasNull(idAnalista, idDependencia);
		</cfscript>
	</cffunction>

	<!--- *********************** Inicio de funciones de Responsables *********************** --->

	<!---
	* Descripcion:	Muestra las dependencias existentes. 
	* Fecha:		24 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="getDependencias" access="public">
		<cfscript>
			var pkUsuario = '';
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos'))
				pkUsuario = session.cbstorage.usuario.PK;
			relacion.dependencia = DAO_P.getDependenciasAsociadas(pkUsuario);
			return relacion;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Muestra todos los Formatos y Responsables respecto a una dependencia. 
	* Fecha:		24 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="getAllFormatosResponsables" access="public">
		<cfargument name="dependencia"	type="string" required="yes">
		<cfscript>
			var pkUsuario = '';
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos'))
				pkUsuario = session.cbstorage.usuario.PK;
			relacion.dependencia = dependencia;
			relacion.formatos = DAO_P.getFormatosResponsables(dependencia, pkUsuario);
			relacion.usuarios = DAO_P.getAllFormatosUsuarios(dependencia, pkUsuario);
			relacion.usrFor = DAO_P.usrForDependencia(dependencia, pkUsuario);
			relacion.Flag = (relacion.usuarios.recordcount > 0) ? 1 : 0;
			relacion.usuariosUnicos = DAO_P.getAllDependenciasUsuarios(dependencia);
			relacion.usuarioCheck =arrayNew(2);
			relacion.usuarioCheck = checkAllUsuarios(relacion.usuarioCheck, relacion.formatos, relacion.UsuariosUnicos, relacion.usrFor);
			return relacion;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Inserta todos los responsables a una dependencia en espec�fico. 
	* Fecha:		24 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="insertarTodosResponsables" access="public" >
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfscript>
			var pkUsuario = 0;
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos'))
				pkUsuario = session.cbstorage.usuario.PK;
			return DAO_P.insertarTodosResponsables(idAnalista, idDependencia, pkUsuario);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Elimina todos los responsables de una dependencia en espec�fico. 
	* Fecha:		24 marzo 2017.
	* Autor:		Roberto Cadena.
	---> 
	<cffunction name="eliminarTodosResponsables" access="public" >
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfscript>
			var pkUsuario = 0;
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos'))
				pkUsuario = session.cbstorage.usuario.PK;
			return DAO_P.eliminarTodosResponsables(idAnalista, idDependencia, pkUsuario);
		</cfscript>
	</cffunction>

</cfcomponent>
