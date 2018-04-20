<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Chat
* Sub modulo: Administrador de eventos 
* Fecha 12 de junio del 2017
* Descripcion: Handler para el manejo de los eventos del modulo de chat
* Autores: Alejandro Rosales 
		   Jonathan Martinez 
* ================================
--->
 <cfcomponent>
	 <cfproperty name="cn" inject="adminCSII/chat/CN_Chat">
	 <!---
	 	 *Fecha :12 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="guardarChat" hint="Funcion para guardar conversaciones">
		 <cfscript>
			 resultado=cn.guardarChat(rc.user,rc.texto,rc.hora,rc.proceso);
			 event.renderData( type="json", data=resultado);
			 //return resultado;
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :14 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="guardarBuzon" hint="Funcion para guardar en el buzon de mensajes">
		 <cfscript>
			 resultado=cn.guardarBuzon(rc.username,rc.nombre);
			 return resultado;
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :15 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="eliminarBuzon" hint="Funcion para eliminar de el buzon de mensajes">
		 <cfscript>
			 resultado=cn.eliminarBuzon(rc.username,rc.nombre);
			 return resultado;
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :12 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="obtenerChat" hint="Funcion para obtener conversaciones">
		 <cfscript>
			 resultado=cn.obtenerChat(rc.canal);
			 event.renderData( type="json", data=resultado);
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :13 de junio de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="obtenerProcesos" hint="Funcion para obtener procesos">
	 	 <cfargument name="rol" type="numeric" hint="Rol del Usuario">
		 <cfscript>
			 resultado=cn.obtenerProcesos(rol);
			 event.renderData( type="json", data=resultado);
		 </cfscript>
	 </cffunction>

	  <!--- 
	    * Fecha: 09 de Junio de 2017
	    * Autor: Alejandro Rosales
	 --->
	 <cffunction name="saveFile" hint="Funcion encargada de almacenar un archivo">
	 	<cfargument name="event" type="any">
		<cfscript>
			var url = cn.saveFile(image);
			return url;
		</cfscript>
	 </cffunction>
 </cfcomponent>