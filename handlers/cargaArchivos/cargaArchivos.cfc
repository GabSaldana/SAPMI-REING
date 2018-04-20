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

    <cfproperty name="CN" inject="model.cargaArchivos.CN_CargaArchivos">
    <cfproperty name="fileManager"    inject="model.utils.filetransfer.FileManager">

    <cffunction name="consultarArchivoExistente" hint="Verifica si ya existe un archivo">
        <cfargument name="Event" type="any">
        <cfscript>
            var rc = Event.getCollection();
            var resultado = CN.consultarArchivoExistente(rc.pkCatalogo, rc.pkRegistro);
            event.renderData(type = "json", data = resultado);
        </cfscript>
    </cffunction>

    <cffunction name="subirArchivo" hint="Sube el archivo al servidor FTP">
        <cfargument name="Event" type="any">
        <cfscript>
            var resultado = 0;
            rc = Event.getCollection();

            attachResult = fileManager.attachFile("upload_files", "sero.listas", session.cbstorage.usuario.rol & "\");

            if (attachResult.SUCCESS) {
                var archivo = CN.registrarArchivo(rc.pkCatalogo, rc.pkRegistro, ''/*Descripcion*/, 2, attachResult.FILENAME, rc.pkRegistro);
                resultado = 1;
            }
        </cfscript>
        <cfreturn resultado>
    </cffunction>

    <cffunction name="obtenerDocumento" hint="Descarga un archivo del FTP">
        <cfargument name="Event" type="any">
        <cfscript>
            var rc = Event.getCollection();
            var datosDoc = CN.consultarNombreArchivo(rc.pkDoc);
            var fileNameDownload = datosDoc.NOMBRE[1];
            var path = datosDoc.ROL[1] & "\";
            var fileResult = fileManager.downloadFile(fileNameDownload, "sero.listas", path);
            event.renderData(data = toBase64(fileResult.FILE2));
        </cfscript>
    </cffunction>

</cfcomponent>

