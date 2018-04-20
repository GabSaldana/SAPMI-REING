<cfcomponent>

	<cfproperty name="CN" inject="adminCSII.admonAvisos.CN_avisos">

	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>		
			prc.vertiente = CN.getVertiente();
			event.setView("adminCSII/admonAvisos/avisos");
		</cfscript>
	</cffunction>


	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="getRolesByVertiente" hint="Obtiene la lista de roles por vertiente">
		<cfargument name="event" type="any">	
		<cfscript>
			var resultado = CN.getRolesByVertiente(rc.pkVert);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="getAvisos" hint="Obtiene el listado de avisos">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.avisos = CN.getAvisos();
			event.setView("adminCSII/admonAvisos/tablaAvisos").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="guardaAviso" hint="Guardar un aviso">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = CN.guardaAviso(rc.nombre, rc.mensaje, rc.fecIni, rc.fecFin, rc.redir, rc.vert, rc.pkRoles);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="cambiaEdoAviso" hint="Cambiar el estado de un aviso">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = CN.cambiaEdoAviso(rc.pkAviso);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="getAvisoByPk" hint="Consulta un aviso por su pk">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = CN.getAvisoByPk(rc.pkAviso);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
	<cffunction name="editarAviso" hint="actualizar un aviso">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = CN.editarAviso(rc.pkAviso, rc.nombre, rc.mensaje, rc.fecIni, rc.fecFin, rc.redir, rc.vert, rc.pkRoles);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent>