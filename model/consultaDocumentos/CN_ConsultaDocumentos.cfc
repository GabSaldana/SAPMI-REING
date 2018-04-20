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

    <cfproperty name="DAO" inject="model.consultaDocumentos.DAO_ConsultaDocumentos">

    <cffunction name="documentosComplementarios" hint="Obtiene los documentos complementarios de las encuestas">
        <cfscript>
            return DAO.documentosComplementarios();
        </cfscript>
    </cffunction>

    

</cfcomponent>