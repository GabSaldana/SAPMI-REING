<!---
* =========================================================================
* IPN - CSII
* Sistema: SIPEFIFE
* Modulo: Interceptor
* Sub modulo: Monitoreo de actividades de los usuarios
* Fecha: 28 de Mayo de 2015
* Descripcion: Objeto que realiza el registro de las actividades del usuario genera 
* una capa intependiente del flujo del aplicativo
* =========================================================================
--->

<cfcomponent name="monitorActividad"
	hint="Interceptor que registra los datos de las acciones realizadas en el sistema"
	output="false"
	extends="coldbox.system.Interceptor">
	
    <cffunction name="Configure" access="public" returntype="void" hint="Configura el Interceptor" output="false" >
		<cfscript>
        </cfscript>
    </cffunction>
    <cffunction name="onMonitoreaActividad" access="public" returntype="void" hint="" output="false" >
    	<cfargument name="event" required="yes" type="any">
        <cfargument name="interceptData" required="yes" type="any">
        <cfargument name="buffer" required="no" type="any">
    	<cflog text="entra al interceptor...." type="information">
        <cflog text="#interceptData.saluda#" type="information">
        <cflog text="#interceptData.ip#" type="information">
        <cflog text="#interceptData.PATH_INFO#" type="information">
        <cflog text="#interceptData.REQUEST_METHOD#" type="information">
        <cflog text="#interceptData.PATH_TRANSLATED#" type="information">
        <cflog text="#interceptData.HTTP_USER_AGENT#" type="information">
        <cflog text="#interceptData.CF_TEMPLATE_PATH#" type="information">
        <cflog text="#interceptData.EVENTO#" type="information">
        <cflog text="#interceptData.HTTP_REFERER#" type="information">
    </cffunction>

</cfcomponent>