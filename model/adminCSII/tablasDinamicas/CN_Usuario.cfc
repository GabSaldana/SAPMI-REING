<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Usuarios en Tablas Dinamicas
* Sub modulo: CN Usuario
* Fecha 28 de Marzo de 2017
* Descripcion:
* CN para el modulo de usuarios
* Autores:Jonathan Martinez
* ================================
--->
 <cfcomponent accessors="true" singleton>
	 <cfproperty name="dao" inject="adminCSII.tablasDinamicas.DAO_Usuario">
	 <cfproperty name="populator" inject="wirebox:populator">
	 <cfproperty name="wirebox" inject="wirebox">
	 <!---
	   	 *Fecha :28 de marzo de 2017
	 	 *@author Jonathan Martinez
  	 --->
	 <cffunction name="obtenerUsuariosAutorizados" hint="Crea un arreglo de Usuarios a los que es posible compartir la tabla a partir de los datos obtenidos ">
		 <cfargument name="idUsr">
		 <cfargument name="idCon">
		 <cfargument name="idTab">
		 <cfscript>	
			 var usuarios=[];
			 var usushare=[];
			 var conUsuarios=dao.obtenerUsuariosAutorizados(idUsr,idCon,idTab);
			 for(var x=1; x lte conUsuarios["usuarios"].recordcount; x++ ){
				 var usuario=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Usuario"),conUsuarios["usuarios"],x);
				 arrayAppend(usuarios, usuario);
			 }
			 var conUsuariosRep=conUsuarios["usuariosTabla"];
			 var propietarios=ValueList(conUsuariosRep.id);
			 for(var usr in usuarios){
				 if(ListFind(propietarios,usr.getId())){
					 usr.setPropietario(1);
					 usushare=dao.obtenerUsuarioShare(usr.getId(),idTab);
					 usr.setShare(usushare.nombre);
				 }
			 }
			 return usuarios;
		 </cfscript>
	 </cffunction>
 </cfcomponent>