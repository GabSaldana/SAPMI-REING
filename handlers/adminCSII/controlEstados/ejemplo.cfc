<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: funciones principales de la máquina de estados
* Fecha : octubre de 2016
* Descripcion: handler 
* =========================================================================
--->

<cfcomponent>
	<cfproperty name="maquinaEstados" 	inject="utils.maquinaEstados.CN_maquinaEstados">
	<cfproperty name="cnEjemplo"  		inject="adminCSII.controlEstados.CN_ejemplo">
	<cfproperty name="cnGrafo" 	 		inject="adminCSII.admonEdos.CN_estados">


    <cffunction name="index" returntype="void" output="false">
        <cfargument name="event" type="any">
        <cfscript>
            Request.procedimiento = cnEjemplo.getProcedimiento();
			Request.rol = cnEjemplo.getRol();
            event.setView("adminCSII/controlEstados/funcionesPrincipales");
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Se obtienen los registros con sus respectivas acciones.
    --->  
	<cffunction name="getRegistro" hint="Cambia el estado del registro indicado al siguiente de la ruta">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();

			if (rc.registro NEQ 'NA') {
				resultado = cnEjemplo.getRegistro(rc.procedimiento, rc.registro, rc.rol); 
				event.renderData(type="json", data=resultado);
			}else {
				prc.part = cnEjemplo.getRegistro(rc.procedimiento, rc.registro, rc.rol);
				event.setView("adminCSII/controlEstados/tablaejemplo").noLayout();
			}			

		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que cambia el estado del registro en cuestión a partir de la accion que se realiza.
    --->
	<cffunction name="cambiarEstado" hint="Cambia el estado del registro indicado al siguiente de la ruta">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();

			var destin = deserializeJSON(rc.destinatarios);
			var resultado = cnEjemplo.cambiarEstado(rc.pkRegistro, rc.pkAccion, rc.pkProced, rc.pkRol, rc.asunto, rc.comentario, rc.prioridad, destin);

			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que obtiene los cambios de estado a partir de una ruta, y lo representa en un grafo.
    --->  
	<cffunction name="getDatoGrafo" hint="Obtiene la vista para mostrar la vista del grafo">
        <cfargument name="Event" type="any">
        <cfscript>
            var rc = Event.getCollection();
            prc.rutas = cnGrafo.setRelaciones(rc.pkRuta);
            event.setView("adminCSII/admonEdos/Rutas/grafo").noLayout();
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que obtiene los comentarios hechos sobre un registro.
    --->  
	<cffunction name="getComentariosReg" hint="Obtiene comentarios de un registro">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.coment = cnEjemplo.getComentariosReg(rc.pkRegistro);
			event.setView("adminCSII/controlEstados/tablaComentReg").noLayout();

		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que obtiene el contenido de un comentario en especifico.
    --->  
	<cffunction name="getContenidoComent" hint="Obtiene contenido de comentario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado  = cnEjemplo.getContenidoComent(rc.pkComent);
			event.renderData(type="json", data=resultado);

		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que obtiene los usuarios para enviar comentario.
    --->
	<cffunction name="getUsuComentario" hint="Usuarios que pueden recibir un comentario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEjemplo.getUsuComentario();
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que obtiene el asunto del tipo de comentario
    --->
	<cffunction name="asuntoComentario" hint="Usuarios que pueden recibir un comentario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEjemplo.asuntoComentario(rc.pkTipoComent);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene el historial de validacion.
    --->  
	<cffunction name="getHistorial" hint="Obtiene el historial de validacion">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.historial = maquinaEstados.historialObjeto(rc.pkRegistro);
			event.setView("adminCSII/controlEstados/tablaHistorial").noLayout();
		</cfscript>
	</cffunction>

</cfcomponent>