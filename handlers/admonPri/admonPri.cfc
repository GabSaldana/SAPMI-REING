<cfcomponent>
	<cfproperty name="cnPri" inject="admonPri.CN_privilegios">
	
	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>
			prc.modulos    = cnPri.obtenerModulos();
			prc.vertientes = cnPri.obtieneVertientes();
		</cfscript>
		<cfset event.setView("admonPri/admonPri")>
	</cffunction>

	<cffunction name="obtenerLista" hint="Obtiene la lista de usuarios del sistema">
		<cfargument name="event" type="any">	
		<cfscript>
			var UR = 'U30000';
			prc.roles = cnPri.obtenerLista(UR);
			event.setView("admonPri/tablaRol").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="agregarRol" hint="Agrega un usuario en la BD">
		<cfargument name="Event" type="any">
		<cfscript>					
			var resultado = cnPri.guardarRol(rc.nombre, rc.clave, rc.descripcion, rc.prefijo, rc.modulo, rc.vertiente);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<cffunction name="actualizarUsuario" hint="Cambia el registro del usuario al estado indicado">
		<cfscript>
			resultado = cnPri.cambiarEstado(rc.pkUsu, rc.estado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="consultarUsuario" hint="Consulta datos del usuario seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnPri.consultarUsuario(rc.pkUsuario);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarUsuario" hint="Edita datos del usuario seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnPri.editarUsuario(rc.pkUsuario, rc.nombre, rc.clave, rc.descripcion, rc.prefijo, rc.modulo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<cffunction name="cargarAcciones" hint="Muestra la ventana de Administración de Acciones">
		<cfscript>	
			var cn	= getModel("admonPri.CN_privilegios");
			request.roles = cnPri.obtenerRoles();
			request.modulos = cnPri.mostrarMod();
			request.acciones = cnPri.mostrarAcc();				
			event.setView("admonPri/admonAcc");
		</cfscript>
	</cffunction>

	<cffunction name="mostrarAcciones" access="remote" returntype="void" output="false" hint="Obtiene los temas de una acción formativa específica">
		<cfargument name="event" type="any">	
		<cfscript>
			var cn	= getModel("admonPri.CN_privilegios");
			prc.modulos = cnPri.mostrarAcciones(rc.curso);						
			event.setView("admonPri/tablaAccion").noLayout();

		</cfscript>
	</cffunction>

	<cffunction name="agregarAccion" hint="Agrega un usuario en la BD">
		<cfargument name="Event" type="any">
		<cfscript>					
			var resultado = cnPri.guardarAccion(rc.modulo, rc.estado, rc.nombre, rc.descripcion, rc.orden, rc.clave, rc.icono);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarAccion" hint="Edita datos de la acción seleccionada">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnPri.editarAccion(rc.pkAccion, rc.nombre, rc.descripcion, rc.orden, rc.clave, rc.icono);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="consultarInfoAcciones" hint="Consulta datos de la acción seleccionada">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnPri.consultarInfoAcciones(rc.pkAccion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarAccion" hint="Cambia el registro del usuario al estado indicado">
		<cfscript>
			resultado = cnPri.cambiarEstadoAcc(rc.pkUsu, rc.estado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="vistaGeneral" hint="Muestra la ventana de Administración general del módulo">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>	
			var cn	= getModel("admonPri.CN_privilegios");
			request.modulos = cnPri.mostrarMod();				
			event.setView("admonPri/admonGral");
		</cfscript>
	</cffunction>

	<cffunction name="desplegarInfo" access="remote" returntype="void" output="false" hint="Obtiene los temas de una acción formativa específica">
		<cfargument name="event" type="any">	
		<cfscript>
			var cn	= getModel("admonPri.CN_privilegios");
			prc.recuadros = cnPri.getNumeroAccionesRol(rc.Modulo);
									
			event.setView("admonPri/tablaCheckbox").noLayout();
			
		</cfscript>
	</cffunction>

	<cffunction name="mostrarAccionesRol" access="remote" returntype="void" output="false" hint="Obtiene los temas de una acción formativa específica">
		<cfargument name="event" type="any">	
		<cfscript>
			var cn	= getModel("admonPri.CN_privilegios");
			prc.columnan = cnPri.mostrarAcciones(rc.pkModulo);	
			prc.rolesAcciones = cnPri.consultaTotalGral(rc.pkModulo);					
			event.setView("admonPri/tablaAccionRol").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="bajaAccrol" hint="Cambia el registro del usuario al estado indicado">
		<cfscript>
			//resultado = cnPri.bajaAccrol( rc.edo, rc.rol, rc.accion);
			resultado = cnPri.bajaAccrol( 0, rc.rol, rc.accion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="altaAccionRol" hint="Cambia el registro del usuario al estado indicado">
		<cfscript>
			resultado = cnPri.altaAccionRol( rc.edo, rc.rol, rc.accion );
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

		
</cfcomponent>