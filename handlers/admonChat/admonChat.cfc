<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Administración Chat
* Fecha : 06 Agosto 2017
* Autores: Alejandro Rosales 
* Descripcion: Administrador Chat.
* =========================================================================
--->

 <cfcomponent>
 <cfproperty name="CN" inject="chat/CN_Chat">
	 
	<!---
	* Fecha : 06 de Agosto de 2017
	* Autor : Alejandro Rosales
	--->	
	<cffunction name="index" hint="Inicio">
		<cfargument name="event" type="any">
		<cfscript>
		 	prc.procesos = CN.obtenerAProcesos();
			event.setView("admonChat/admonChat");
		</cfscript>
	</cffunction>


	<!---
	* Fecha : 06 de Agosto de 2017
	* Autor : Alejandro Rosales
	 --->	
	<cffunction name="agregarProceso" hint="Agrega un nuebo proceso">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.agregarProceso(rc.name,rc.desc);
		 	event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha : 06 de Agosto de 2017
	* Autor : Alejandro Rosales
	--->	
	<cffunction name="eliminarProceso" hint="Eliminación de proceso">
		<cfargument name="event" type="any">
	 	<cfscript>
			resultado = CN.eliminarProceso(rc.pk);
		 	event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha : 06 de Agosto de 2017
	* Autor : Alejandro Rosales
	--->	
	<cffunction name="mostrarProcesosRol" hint="Procesos Rol">
		<cfargument name="event" type="any">
		<cfscript>
		 	prc.columnan = CN.mostrarProcesos();	
			prc.rolesProcesos = CN.consultaTotalGral();						
			event.setView("admonChat/TablaRoles").noLayout();
		</cfscript>
	</cffunction>


	<!---
	* Fecha : 07 de Agosto de 2017
	* Autor : Alejandro Rosales
	--->	
	<cffunction name="altaProcesosRol" hint="Dar de alta un proceso a partir del rol">
		<cfargument name="event" type="any">
		<cfscript>
		 	resultado = CN.altaProcesosRol(rc.proceso,rc.rol);
		 	event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha : 07 de Agosto de 2017
	* Autor : Alejandro Rosales
	--->	
	<cffunction name="bajaProcesosRol" hint="Dar de baja un proceso a partir del rol">
		<cfargument name="event" type="any">
		<cfscript>
		 	resultado = CN.bajaProcesosRol(rc.proceso,rc.rol);
		 	event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha : 14 de Agosto de 2017
	* Autor : Alejandro Rosales
	--->	
	<cffunction name="editarProceso" hint="Edicion de proceso">
		<cfargument name="event" type="any">
		<cfscript>
		 	resultado = CN.editarProceso(rc.pk,rc.name,rc.desc);
		 	event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha : 15 de Agosto de 2017
	* Autor : Jonathan Martinez
	--->	
	<cffunction name="inicializarProceso" hint="Inicializacion de proceso">
		<cfargument name="event" type="any">
		<cfscript>
		 	resultado = CN.inicializarProceso(rc.pk);
		 	event.renderData( type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent>