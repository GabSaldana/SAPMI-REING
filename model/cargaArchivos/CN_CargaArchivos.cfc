<!---
* =====================================================================================
* IPN - CSII
* Sistema: Planeación 2018
* Modulo: Carga de archivos
* Fecha: abril de 2018
* Descripcion: componente de negocio para la administración de archivos
* =====================================================================================
--->

<cfcomponent>
    
    <cfproperty name="DAO"   inject="cargaArchivos.DAO_CargaArchivos">

    <cffunction name="consultarArchivoExistente" hint="Verifica si ya existe un archivo">
        <cfargument name="pkCatalogo"   hint="Pk del archivo en el catalogo">
        <cfargument name="pkRegistro"   hint="Pk del registro al que esta asociado">
        <cfscript>
            return DAO.consultarArchivoExistente(pkCatalogo, pkRegistro);
        </cfscript>
    </cffunction>

    <cffunction name="registrarArchivo" hint="Guarda un registro del archivo que se subió al FTP">
        <cfargument name="pkCatalogo"  hint="Pk del archivo en el catalogo">
        <cfargument name="pkUsuario"   hint="Pk del usuario">
        <cfargument name="descripcion" hint="Descripcion del archivo">
        <cfargument name="pkEstado"    hint="Estado con el que se guarda el registro">
        <cfargument name="archivo"     hint="Nombre del archivo">
        <cfargument name="pkRegistro"  hint="pk del registro">
        <cfscript>
            return dao.registrarArchivo(pkCatalogo, pkUsuario, descripcion, pkEstado, archivo, pkRegistro);     
        </cfscript>
    </cffunction>

    <cffunction name="consultarNombreArchivo" hint="Obtiene el nombre de un archivo">
        <cfargument name="pkDoc"        hint="Pk del documento">
        <cfscript>
            return DAO.consultarNombreArchivo(pkDoc);
        </cfscript>
    </cffunction>

</cfcomponent>