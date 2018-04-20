<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Usuarios en Tablas Dinamicas
* Sub modulo: Usuario
* Fecha 28 de Marzo de 2017
* Descripcion:
* Plantilla para el modulo de Usuarios
* Autores:Jonathan Martinez
* ================================
--->
 <cfcomponent accessors="true" >
	 <cfproperty name="id">
	 <cfproperty name="nombre">
	 <cfproperty name="aPaterno">
	 <cfproperty name="aMaterno">
	 <cfproperty name="propietario">
	 <cfproperty name="rol">
	 <cfproperty name="share">
	 <cfproperty name="email">
	 <cffunction name="init">
		 <cfscript>
			 propietario=0;
			 share="";
			 return this;
		 </cfscript>
	 </cffunction>
 </cfcomponent>