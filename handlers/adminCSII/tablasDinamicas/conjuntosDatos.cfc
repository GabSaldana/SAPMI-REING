<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 14 de marzo del 2017
* Descripcion: 
* Controlador para el submodulo de exploracion de conjunto de datos.
* Autores: Alejandro Rosales 
		   Jonathan Martinez 
* ================================
--->
 <cfcomponent>
	 
	 <cfproperty name="cnConjuntos" inject="adminCSII.tablasDinamicas.CN_ConjuntosDatos">
	 <cfproperty name="cn" inject="adminCSII.tablasDinamicas.CN_Tabla">
	 	 

	 <!---
	 	 *Fecha :14 de marzo de 2017
	 	 *@author Jonathan Martinez 
     --->
	 <cffunction name="index" hint="Funcion llamada por defecto al cargar el modulo ">
		 <cfscript>
		//	 prc.conjuntos=cnConjuntos.obtenerConjuntosUsuario(getPlugin("SessionStorage").getVar("usuario").PK);
			 prc.conjuntos=cnConjuntos.obtenerConjuntosUsuario(getPlugin("SessionStorage").getVar("usuario").PK);
	
			 event.setView("adminCSII/tablasDinamicas/conjuntosDatos");
             
		 </cfscript>
	 </cffunction>
	 <!---
	 	 *Fecha :14 de marzo de 2017
	 	 *@author Jonathan Martinez
	 	 *Fecha Modificacion: 23 de marzo de 2017
	 	 *@author Jonathan Martinez  
     --->
     
	<cffunction name="cargarConjunto" hint="Carga los componentes creados con el conjunto de datos">
		 <cfscript>
			 var conjuntoDatos = cn.getNombreConjuntoDatos(rc.idCon);	
			 getPlugin("SessionStorage").setVar("conjunto", conjuntoDatos);							
			 prc.conjunto=cnConjuntos.obtenerConjuntoPorId(rc.idCon);
			 prc.tablas=cn.obtenerTablasUsrCon(getPlugin("SessionStorage").getVar("usuario").PK,duplicate(prc.conjunto));
			 prc.tablasC=cn.obtenerTablasCompartidas(getPlugin("SessionStorage").getVar("usuario").PK,duplicate(prc.conjunto));
			 event.setView("adminCSII/tablasDinamicas/administradorTablas");
		 </cfscript>
	 </cffunction>
	 
 </cfcomponent>