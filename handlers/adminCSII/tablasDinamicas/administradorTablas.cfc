<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Administración de Tablas
* Fecha : 23 de Marzo de 2017
* Autores: Alejandro Rosales 
		   Jonathan Martinez
* Descripcion: Manejador para la administración de Tablas.
* =========================================================================
--->
 <cfcomponent>
     <cfproperty name="cnConjuntos" inject="adminCSII.tablasDinamicas.CN_ConjuntosDatos">
	 <cfproperty name="cn" inject="adminCSII.tablasDinamicas.CN_Tabla">
	 <cfproperty name="cnUsr" inject="adminCSII.tablasDinamicas.CN_Usuario">
  	 <!---
	   	 *Fecha :23 de marzo de 2017
	 	 *@author Jonathan Martinez
  	 --->
	 <cffunction name="crearTabla" hint="Redireciona a la pagina para la creación de una tabla">
		 <cfscript>
			 var conjuntoDatos = cn.getNombreConjuntoDatos(rc.idCon);	
			 getPlugin("SessionStorage").setVar("conjunto", conjuntoDatos);							
			 prc.conjunto=cnConjuntos.obtenerConjuntoPorId(rc.idCon);
			 event.setView("adminCSII/tablasDinamicas/creacionTabla");
		 </cfscript>
	 </cffunction>
     <!---
	 	 *Fecha :23 de marzo de 2017
	 	 *@author Jonathan Martinez
     --->
	 <cffunction name="eliminarTabla" hint="Elimina una tabla especifica">
		 <cfscript>
			 var resultado=cn.eliminarTabla(rc.idTab);
			 event.renderData( type="json", data=resultado);
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :28 de marzo de 2017
	 	 *@author Jonathan Martinez
     --->
	 <cffunction name="eliminarTablaC" hint="Elimina una tabla compartida especifica">
		 <cfscript>
			 var resultado=cn.eliminarTablaC(rc.idTab,getPlugin("SessionStorage").getVar("usuario").PK);
			 event.renderData( type="json", data=resultado);
		 </cfscript>
	 </cffunction>
     <!---
	     *Fecha :23 de marzo de 2017
	     *@author Jonathan Martinez
     --->
	 <cffunction name="explorarTabla" hint="">
		 <cfscript>
			 prc.conjunto=cnConjuntos.obtenerConjuntoPorId(rc.idCon);
			 prc.tabla=cn.obtenerTablaPorId(rc.idTab);
			 event.setView("adminCSII/tablasDinamicas/exploradorTablas");
		 </cfscript>		
	 </cffunction>
	 <!---
	     *Fecha :24 de marzo de 2017
	     *@author Jonathan Martinez
     --->
	<cffunction name="editarTabla" hint="">
		 <cfscript>
			 prc.conjunto=cnConjuntos.obtenerConjuntoPorId(rc.idCon);
			 prc.tabla=cn.obtenerTablaPorId(rc.idTab);
			 event.setView("adminCSII/tablasDinamicas/editorTabla");
		 </cfscript>	
	 </cffunction>
	 <!---
	     *Fecha :27 de marzo de 2017
	     *@author Jonathan Martinez
     --->
	 <cffunction name="copiarTabla" hint="">
		 <cfscript>
			 prc.conjunto=cnConjuntos.obtenerConjuntoPorId(rc.idCon);
			 prc.tabla=cn.copiarTabla(rc.idTab,getPlugin("SessionStorage").getVar("usuario").PK,prc.conjunto);
			 event.renderData(data=renderView("adminCSII/tablasDinamicas/tabla"));
		 </cfscript>
	 </cffunction>
	 <!---
		 *Fecha :28 de marzo de 2017
	     *@author Jonathan Martinez
  	 --->
	 <cffunction name="obtenerUsuariosAutorizados" hint="">
		 <cfscript>
			 prc.usuarios=cnUsr.obtenerUsuariosAutorizados(getPlugin("SessionStorage").getVar("usuario").PK,rc.idCon,rc.idTab);
			 event.renderData(data=renderView("adminCSII/tablasDinamicas/listaUsuarios"));
		 </cfscript>
	 </cffunction>
	 <!---
		 *Fecha :28 de marzo de 2017
	     *@author Jonathan Martinez
  	 --->
	 <cffunction name="compartirTabla" hint="">
		 <cfscript>
			 var resultado=cn.compartirTabla(rc.idTab,getPlugin("SessionStorage").getVar("usuario").PK,rc.usuarios);
			 event.renderData(type="json",data=resultado);
		 </cfscript>
	 </cffunction>
 </cfcomponent>