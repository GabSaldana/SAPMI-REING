<!----
* ================================
* IPN – CSII
* Sistema:     SIIIP (Sistema Institucional de Información de Investigación y Posgrado)
* Modulo:      Convenios
* Fecha:       1 de febrero de 2017
* Descripcion: Handler para el modulo de Convenios/administracion de Instituciones
* Autor:       Juan Carlos Hernández
* ================================
---->
<cfcomponent>
	
	<cfproperty name="CN" inject="convenios.Administracion.CN_Instituciones">

	<cffunction name="index" access="remote" returntype="void" output="false" hint="Carga informacion inicial">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("convenios/Administracion/V_admonInstituciones");
		</cfscript>
	</cffunction>

	<cffunction name="getInstituciones" access="remote" hint="obtiene la lista de las instituciones">
		<cfargument name="event" type="any">
		<cfscript>
			prc.instituciones = CN.getInstituciones();
			event.setView("convenios/Administracion/V_tablaInstitucion").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="agregarInstitucion" access="remote" hint="Agrega un nuevo registro al catalogo de instituciones">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.agregarInstitucion(rc.nombre, rc.ubicacion, rc.descripcion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarInstitucion" access="remote" hint="Edita un registro del catalogo de instituciones">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.editarInstitucion(rc.pk, rc.nombre, rc.ubicacion, rc.descripcion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="consultarInstitucion" access="remote" hint="Consulta la informacion de una institucion">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.consultarInstitucion(rc.pkIns);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarInstitucion" access="remote" hint="Actualiza el estado del registro de una institucion">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.actualizarInstitucion(rc.pk, rc.estado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

</cfcomponent>