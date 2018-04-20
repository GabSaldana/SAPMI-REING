 <!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Pruebas
* Sub modulo: 
* Fecha : Junio 22, 2015
* Autor : Yareli Andrade
* Descripcion: Handler para la construcción de reportes estratégicos.
* =========================================================================
--->

<cfcomponent id="handler RE">
	<!---
	* Fecha : Junio 22, 2015
	* Autor : Yareli Andrade
	--->
	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			var conjuntoDatos = cn.getNombreConjuntoDatos(id);	
			getPlugin("SessionStorage").setVar("conjunto", conjuntoDatos);			
			event.setView("reportesEstrategicos/consultaVistaMat");
		</cfscript>					
	</cffunction>

	<!---
	* Fecha : Agosto 17, 2015
	* Autor : Yareli Andrade
	--->	
	<cffunction name="getNombre" access="public" returntype="void" output="false" hint="Obtiene el nombre de un campo">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");			
			var campos = cn.getTipoCol();
			event.renderData(type="json",data=campos);
		</cfscript>
	</cffunction>

	<!---
	* Fecha : Agosto 17, 2015
	* Autor : Yareli Andrade
	--->
	<cffunction name="getElemento" access="public" returntype="void" output="false" hint="Obtiene los elementos de cada campo">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			var eltos = cn.getEltosCampo(rc.campo);		
			event.renderData(type="json",data=eltos);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha : Agosto 19, 2015
	* Autor : Yareli Andrade
	--->
	<cffunction name="getCampo" access="public" returntype="void" output="false" hint="Obtiene la descripción, id y los elementos de una columna">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc	= event.getCollection();			
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			
			var datos = cn.getTipoCol(Session.cbstorage.conjunto.ID);			
				
			event.renderData(type="json", data=datos);
		</cfscript>
	</cffunction>


	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha : Septiembre 11, 2015
	* Autor : Yareli Andrade
	--->
	
	<cffunction name="getConteo2" access="public" returntype="void" output="false" hint="Obtiene las cifras correspondientes a los ejes y filtros definidos">
		<cfargument name="event" type="any">		
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");			
			//var opciones = deserializeJSON(rc.opcion); 
            var resultado = cn.getConteoCN2(rc);
			/*Fin de la funcion*/
            event.renderData(type="json",data=resultado);
					
		</cfscript>
    </cffunction>


    <!---
    * Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha : Agosto 31, 2015
	* Autor : Yareli Andrade
	--->	
	<cffunction name="getNombre2" access="public" returntype="void" output="false" hint="Evento que obtiene la lista de campos">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc	= event.getCollection();
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");			
			var campos = cn.getTipoCol2();
			event.renderData(type="json",data=campos);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Modificación : 23 de octubre //Reestablecer todos los combos
	* Modificación : 19 de octubre //Se considera la dependencia entre filtros considerando el Padre en vez del Orden
	* Fecha : 03 de septiembre de 2015
	* Autor : Yareli Andrade
	--->
	<cffunction name="getUR" access="public" returntype="void" output="false" hint="Evento que obtiene los elementos filtrados de un campo">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var cn	= getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			var resultado = cn.getCNUR(rc);
			event.renderData(type="json",data=resultado);

		</cfscript>
	</cffunction>
	
	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha : Agosto 09, 2015
	* Autor : Yareli Andrade
	--->	
	<cffunction name = "getOperacion" access="public" returntype="void" output="false" hint="Evento que obtiene la lista de operaciones de un campo">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			var operacion = cn.getCNOperacion(rc.num);
			event.renderData(type="json",data=operacion);

		</cfscript>
	</cffunction>
	<!--- Parte de configuracion de las vistas --->
	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha creacion: 12 de ciciembre de 2015
	* @author Yareli Licet Andrade Jimenez
	--->
	<cffunction name="agregarConfiguracion" access="remote" hint="Guarda una configuracion definida por el usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.agregarConfiguracion(Session.cbstorage.usuario.PK,Session.cbstorage.conjunto.ID,rc.nombre,rc.desc,rc.config);
			event.renderData(type="json",data = resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
	* Fecha creacion: 15 de diciembre de 2015
	* @author Yareli Licet Andrade Jimenez
	--->
	<cffunction name="cambiarConfiguracion" access="public" hint="Consulta una configuracion ">
		<cfargument name="Event" type="any">
		<cfscript>		
			var rc 		  		= Event.getCollection();
			var cn 		  		= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var configuracion 	= cn.cargarCongiguracion(Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID, rc.config);
			event.renderData(type="json",data=deserializeJSON(configuracion.CONFIG));
		</cfscript>
	</cffunction>	

	<!---   
    * Fecha creacion: 22 de enero de 2016
    * @author Yareli Andrade
    * Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
    --->
	<cffunction name="inicializaCombos" access="public" returntype="void" output="false" hint="Evento que obtiene los elementos iniciales para un tipo específico de campos">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc = event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			var datos = cn.inicializaCNCombos(rc.tipo);
			event.renderData(type="json",data=datos);
		</cfscript>
	</cffunction>

	<!---   
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
    * Fecha creacion: 26 de enero de 2016
    * @author Yareli Andrade
    --->	
	<cffunction name="eliminarReporte" access="remote" hint="Elimina el reporte estrategico seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");		
			var resultado = cn.eliminarReporte(rc.reporte,Session.cbstorage.usuario.PK,Session.cbstorage.conjunto.ID);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : 29 de enero de 2016
	* Autor : Yareli Andrade
	--->	
	<cffunction name="cosultaReporte" access="public" returntype="void" output="false" hint="Obtiene los reportes de un conjunto y usuario especifico">
		<cfargument name="event" type="any">	
		<cfscript>
			var cn	= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var reporte = cn.obtenerConfiguracion(Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID);
			event.renderData(type="json",data=reporte);
		</cfscript>
	</cffunction>

	<!---
	* Fecha : 02 de febrero de 2016
	* Autor : Yareli Andrade
	--->	
	<cffunction name="getReporte" access="remote" returntype="void" output="false" hint="Obtiene los reportes de un conjunto y usuario especifico">
		<cfargument name="event" type="any">	
		<cfscript>
			var cn	= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			prc.reporte = cn.obtenerConfiguracion(Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID);
			prc.reporte_s = cn.obtenerConfiguracionShare(Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID);
			event.setView("/reportesEstrategicos/consultaReporte").noLayout();
		</cfscript>
	</cffunction>


	<!---   
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales
    * Fecha creacion: 03 de febrero de 2016
    * @author Yareli Andrade
    --->	
	<cffunction name="editarReporte" access="remote" hint="Actualiza el reporte estrategico seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc 		  	= Event.getCollection();
			var cn 		  	= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado 	= cn.actualizarReporte(rc.num, Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID, rc.name, rc.desc, rc.config);
			event.renderData(type="json",data=resultado);
		</cfscript>
</cffunction>
	<!---
	* Descripcion de la modificacion: Limpieza del handler (CN,DAO)
	* Fecha de la modificacion: Febrero 17, 2017
	* Autor de la modificacion: Alejandro Rosales   
    * Fecha creacion: 15 de abril de 2016
    * @author Yareli Andrade
    --->	
	<cffunction name="getPDF" access="remote" hint="Obtiene los datos para el PDF">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn = getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			cn.getPDF(event.getCollection());
			event.setView("/reportesEstrategicos/codigoQR").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Inicia Funciones para el Modulo de Compartir
	* Fecha : 15 de febrero de 2017
	* Autor : Jonathan Martinez
	--->	
	<cffunction name="getShareUser" access="remote" returntype="void" output="false" hint="Obtiene los usuarios para Compartir">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc 		  	= Event.getCollection();
			var cn			= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			prc.shareuser_g = cn.obtenershareUserG(Session.cbstorage.usuario.PK);
			prc.shareuser_s = cn.obtenershareUserS(rc.idReporte);
			event.setView("/reportesEstrategicos/comparteReporte").noLayout();
		</cfscript>
	</cffunction>
	<!---
	* Inicia Funciones para el Modulo de Relacionar
	* Fecha : 31 de marzo de 2017
	* Autor : Jonathan Martinez
	--->	
	<cffunction name="getRelationReportes" access="remote" returntype="void" output="false" hint="Obtiene los reportes a los que se puede relacionar">
		 <cfargument name="event" type="any">	
		 <cfscript>
			 var rc 	  = Event.getCollection();
			 var cn		  = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			 var cnc	  = getModel("reportesEstrategicos.CN_ConsultaVistaMat");
			 prc.reportes = cn.obtenerreportes(Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID,rc.idReporte);
			 prc.relacion = cn.obtenerrelacionReport(rc.idReporte);
 			 prc.columnas = cnc.getColumnas(Session.cbstorage.conjunto.ID);
			 event.setView("/reportesEstrategicos/relacionaReporte").noLayout();
		 </cfscript>
	</cffunction>
	<cffunction name="agregarRelacion" access="remote" returntype="void" output="false" hint="Guarda la relacion del reporte">
		 <cfargument name="event" type="any">	
		 <cfscript>
			 var cn		= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			 resultado  = cn.agregarRelacion(rc.idRep,rc.idRela);
			 event.renderData(type="json",data=resultado);
		 </cfscript>
	</cffunction>
	<!---
	* Fecha : 20 de febrero de 2017
	* Autor : Jonathan Martinez
	--->	
	<cffunction name="getShareUpdate" access="remote" returntype="void" output="false" hint="Obtiene los Usuarios para Compartir, eliminandolos">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc 		  	= Event.getCollection();
			var cn			= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var shareuser   = cn.obtenershareupdate(rc.pk_reporte);
			event.renderData(type="json",data=shareuser);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: 16 de febrero de 2017
	* @author Jonathan Martinez
	--->
	<cffunction name="agregaShare" access="remote" hint="Guarda un usuario de la lista de Share">
		<cfargument name="Event" type="any">
		<cfscript>		
			var rc 		  		= Event.getCollection();
			var cn 		  		= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var pkReporte		= rc.pk_reporte;
			var pkUser			= rc.pk_user;
			var resultado = cn.agregarShare(pkUser, pkReporte);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: 16 de febrero de 2017
	* @author Jonathan Martinez
	--->
	<cffunction name="actualizaShare" access="remote" hint="Actualiza el estado de un usuario en la lista de compartir">
		<cfargument name="Event" type="any">
		<cfscript>		
			var rc 		  		= Event.getCollection();
			var cn 		  		= getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var pkReporte		= rc.pk_reporte;
			var pkUser			= rc.pk_user;
			var resultado = cn.actualizaShare(pkUser, pkReporte);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha : Febrero 21, 2017
	* Autor : Alejandro Rosales
	--->
	
	<cffunction name="getTipoDato" access="remote" hint="Obtiene tipo de dato a partir de la vista">
		<cfargument name="Event" type="any">
        <cfscript>
        	var rc = Event.getCollection();
        	var cn = getModel("reportesEstrategicos.CN_ConsultaVistaMat");
        	var resultado =  cn.getTipoDato(rc.hecho,Session.cbstorage.conjunto.ID);
			event.renderData(type="json",data=resultado);
        </cfscript>		
	</cffunction>

	<!---
	* Fecha : Marzo 07, 2017
	* Autor : Alejandro Rosales
	--->
	
	<cffunction name="copyReporte" access="remote" hint="Obtiene tipo de dato a partir de la vista">
		<cfargument name="Event" type="any">
        <cfscript>
        	var rc = Event.getCollection();
        	var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
        	var resultado =  cn.copyReporte(Session.cbstorage.usuario.PK, Session.cbstorage.conjunto.ID,rc.idReporte);
			event.renderData(type="json",data=resultado);
        </cfscript>		
	</cffunction>

	<!---
	* Fecha : Marzo 09, 2017
	* Autor : Alejandro Rosales 
	--->

	<cffunction name="setPrivilegio" access="remote" hint="Cambia el tipo de privilegio de un reporte compartido">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.setPrivilegio(rc.idRelacion, rc.state);
			event.renderData(type="json", data = resultado); 
		</cfscript>
	</cffunction>


	<!---
	* Fecha: Marzo 31, 2017
	* Autor: Alejandro Rosales
	--->

	<cffunction name="getReportRelated" access="remote" hint="Obtiene el reporte relacionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.getReportRelated(rc.pkReporte);
			event.renderData(type="json", data = resultado); 

		</cfscript>
	</cffunction>
		
	<!---
	* Fecha: Septiembre 27, 2017
	* Autor: Alejandro Rosales
	--->

	<cffunction name="altaShare" access="remote" hint="alta de un reporte compartido">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado =  cn.altaShare(rc.idReporte, rc.usuario);
			event.renderData(type="json", data = resultado); 
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha: Septiembre 27, 2017
	* Autor: Alejandro Rosales
	--->
	<cffunction name="bajaShare" access="remote" hint="baja de un reporte compartido">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado =  cn.bajaShare(rc.idReporte, rc.usuario);
			event.renderData(type="json", data = resultado); 
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Octubre 03, 2017
	* Autor: Alejandro Rosales
	--->
	<cffunction name="altaTodosShare" access="remote" hint="alta de todas las relaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc =  Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.altaTodosShare(rc.idreporte,rc.idusuarios);
			return resultado;
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Octubre 03, 2017
	* Autor: Alejandro Rosales
	--->
	<cffunction name="bajaTodosShare" access="remote" hint="alta de todas las relaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc =  Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.bajaTodosShare(rc.idreporte,rc.idusuarios);
			return resultado;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha: Octubre 03, 2017
	* Autor: Alejandro Rosales
	--->
	<cffunction name="setTodosPrivilegios" access="remote" hint="alta de todas las relaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc =  Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.setTodosPrivilegios(rc.idrelaciones,rc.state);
			return resultado;
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Octubre 03, 2017
	* Autor: Alejandro Rosales
	--->
	<cffunction name="getEstadoPrivilegio" access="remote" hint="alta de todas las relaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc =  Event.getCollection();
			var cn = getModel("reportesEstrategicos.CN_ConfiguracionVistaMat");
			var resultado = cn.getEstadoPrivilegio(rc.idrelacion);
			return resultado;
		</cfscript>
	</cffunction>


</cfcomponent>