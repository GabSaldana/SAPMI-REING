<!---
* =========================================================================
* IPN - CSII
* Sistema: Planeación 2018
* Modulo: Carga de archivos
* Fecha : abril de 2018
* Descripcion: handler 
* =========================================================================
--->

<cfcomponent>

    <cfproperty name="CN" inject="model.consultaDocumentos.CN_ConsultaDocumentos">

    <cffunction name="index" hint="Vista principal del modulo">
        <cfargument name="event" type="any">
        <cfscript>
            prc.docs = CN.documentosComplementarios();
            event.setView("consultaDocumentos/consultaDocumentos");
        </cfscript>
    </cffunction>

</cfcomponent>