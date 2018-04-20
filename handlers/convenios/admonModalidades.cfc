<!----
* ================================
* IPN – CSII
* Sistema:     SIIIP (Sistema Institucional de Información de Investigación y Posgrado)
* Modulo:      Convenios
* Fecha:       6 de febrero de 2017
* Descripcion: Handler para el modulo de Convenios/administracion de Instituciones
* Autor:       Juan Carlos Hernández
* ================================
---->

<cfcomponent>
	
	<cfproperty name="CN" inject="convenios.Administracion.CN_Instituciones">

	<cffunction name="index" access="remote" returntype="void" output="false" hint="Carga informacion inicial">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("convenios/Administracion/V_admonModalidades");
		</cfscript>
	</cffunction>

	<cffunction name="getModalidades" access="remote" hint="obtiene la lista de las modalidades">
		<cfargument name="event" type="any">
		<cfscript>
			prc.modalidades = CN.getModalidades();
			event.setView("convenios/Administracion/V_tablaModalidad").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="agregarModalidad" access="remote" hint="Agrega un nuevo registro al catalogo de modalidades">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.agregarModalidad(rc.nombre);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="consultarModalidad" access="remote" hint="Consulta la informacion de una modalidad">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.consultarModalidad(rc.pkMod);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarModalidad" access="remote" hint="Edita un registro del catalogo de modalidades">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.editarModalidad(rc.pk, rc.nombre);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarModalidad" access="remote" hint="Actualiza el estado del registro de una modalidad">
		<cfargument name="event" type="any">
		<cfscript>
			var rc 	  = event.getCollection();
			resultado = CN.actualizarModalidad(rc.pk, rc.estado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

</cfcomponent>