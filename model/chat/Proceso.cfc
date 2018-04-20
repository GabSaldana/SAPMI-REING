<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Chat
* Sub modulo: Proceso
* Fecha 28 de Junio de 2017
* Descripcion: Plantilla para el modulo de Chat
* Autores:Jonathan Martinez
* ================================
--->
 <cfcomponent accessors="true" >
	 <cfproperty name="id">
	 <cfproperty name="nombre">
	 <cfproperty name="subcanal">
	 <cfproperty name="entrada">
	 <cffunction name="init">
		 <cfscript>
		     entrada=[];
			 return this;
		 </cfscript>
	 </cffunction>
 </cfcomponent>
