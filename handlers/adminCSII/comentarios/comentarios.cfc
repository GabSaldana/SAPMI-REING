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
	<cfproperty name="cnComent" inject="adminCSII.comentarios.CN_comentarios">


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que obtiene los comentarios hechos sobre un registro.
    --->  
	<cffunction name="getComentariosReg" hint="Obtiene comentarios de un registro">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.coment = cnComent.getComentariosReg(rc.pkRegistro, rc.pkTipoComent);
			event.setView("adminCSII/Comentarios/tablaComentReg").noLayout();
		</cfscript>
	</cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene los comentarios dirigidos al usuario.
    --->  
	<cffunction name="getComentariosByUsuario" hint="Obtiene los comentarios dirigidos al usuario.">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.comentUsu = cnComent.getComentariosByUsuario(rc.pkUsuario, rc.filtro, rc.pkTipoComent);
			prc.noVistos = cnComent.getComentariosNoVistos(rc.pkUsuario);
			event.setView("adminCSII/comentarios/tablaComentarios").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que obtiene la cantidad de comentarios no vistos.
    --->  
	<cffunction name="getComentariosNoVistos" hint="Obtiene los comentarios dirigidos al usuario.">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			resultado = cnComent.getComentariosNoVistos(rc.pkUsuario);
			event.renderData(type="json", data=resultado);

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
			var resultado = cnComent.getContenidoComent(rc.pkComent);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Funcion que establece un comentario como visto.
    --->  
	<cffunction name="setVisto" hint="Establece comentario como visto">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnComent.setVisto(rc.pkComentRel);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Mayo de 2017
    * @author Alejandro Tovar
	* Descripcion: Funcion que guarda comentarios.
    --->  
	<cffunction name="registraComentario" hint="Registra un comentario">
		<cfargument name="Event" type="any">
		<cfscript>
			var destin = deserializeJSON(rc.destinatarios);
			var resultado = cnComent.registraComentario(rc.asunto, rc.comentario, rc.prioridad, rc.estado, rc.pkRegistro, destin, rc.tipoComent);
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
			var resultado = cnComent.getUsuComentario(rc.pkElemento,rc.tipoElemento);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent>