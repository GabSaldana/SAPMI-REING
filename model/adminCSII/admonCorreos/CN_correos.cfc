<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Administración de correos
* Fecha: Enero de 2017
* Descripcion: Componente del administrador de correos para agregar, eliminar y editar datos de correos, plantillas y etiquetas.
* Autor: SGS
============================================================================================
--->

<cfcomponent>
    <cfproperty name="DAO" inject="adminCSII.admonCorreos.DAO_correos">
    <cfproperty name="cnEnvios" inject="utils.email.CN_service">
 
    <cffunction name="obtenerCorreos" hint="Obtiene correos para la tabla de correos">
        <cfscript>
            return DAO.obtenerCorreos();
        </cfscript>
    </cffunction>

    <cffunction name="obtenerVistaCorreo" hint="Obtiene vista previa de un correo">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfscript>
            return DAO.obtenerVistaCorreo(pkCorreo);
        </cfscript>
    </cffunction>

    <cffunction name="cambiarEstadoCorreo" hint="Cambia el estado de un correo">
        <cfargument name="pk" type="numeric" required="yes" hint="pk del correo">
        <cfscript>
            return DAO.cambiarEstadoCorreo(pk);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerBody" hint="Obtiene el cuerpo del correo">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfscript> 
            return DAO.obtenerBody(pkCorreo);
        </cfscript>
    </cffunction>

    <cffunction name="agregarCorreo" hint="Agrega un nuevo correo">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del correo">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion del correo">
        <cfargument name="nombreContenido" type="string" required="yes" hint="Nombre del cuerpo del contenido">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido del correo">
        <cfargument name="pkHead" type="numeric" required="yes" hint="pk de la cabecera">
        <cfargument name="pkFoot" type="numeric" required="yes" hint="pk del pie de pagina">
        <cfscript>
            return DAO.agregarCorreo(nombre,desc,nombreContenido,contenido,pkHead,pkFoot);
        </cfscript>
    </cffunction>

    <cffunction name="editarCorreo" hint="Edita un correo">
        <cfargument name="pk" type="numeric" required="yes" hint="pk del correo">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del correo">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion del correo">
        <cfargument name="nombreContenido" type="string" required="yes" hint="Nombre del cuerpo del contenido">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido del correo">
        <cfargument name="pkHead" type="numeric" required="yes" hint="pk de la cabecera">
        <cfargument name="pkFoot" type="numeric" required="yes" hint="pk del pie de pagina">
        <cfscript>
            return DAO.editarCorreo(pk,nombre,desc,nombreContenido,contenido,pkHead,pkFoot);
        </cfscript>
    </cffunction>

     <cffunction name="obtieneHeader" hint="Obtiene las plantillas header para la tabla de plantillas">
        <cfscript>
            return DAO.obtieneHeader();
        </cfscript>
    </cffunction>

    <cffunction name="obtieneFooter" hint="Obtiene las plantillas footer para la tabla de plantillas">
        <cfscript>
            return DAO.obtieneFooter();
        </cfscript>
    </cffunction>

    <cffunction name="agregarHeader" hint="Agrega una nueva plantilla header">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido de la plantilla">
        <cfscript>
            return DAO.agregarHeader(nombre,desc,contenido);
        </cfscript>
    </cffunction>

    <cffunction name="agregarFooter" hint="Agrega una nueva plantilla footer">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido de la plantilla">
        <cfscript>
            return DAO.agregarFooter(nombre,desc,contenido);
        </cfscript>
    </cffunction>

    <cffunction name="editarHeader" hint="Edita una plantilla header">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido de la plantilla">
        <cfscript>
            return DAO.editarHeader(pk,nombre,desc,contenido);
        </cfscript>
    </cffunction>

    <cffunction name="editarFooter" hint="Edita una plantilla footer">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido de la plantilla">
        <cfscript>
            return DAO.editarFooter(pk,nombre,desc,contenido);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerVistaHeader" hint="Obtiene vista previa de una plantilla header">
        <cfargument name="pkPlant" type="numeric" required="yes" hint="pk de la plantilla">
        <cfscript>
            return DAO.obtenerVistaHeader(pkPlant);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerVistaFooter" hint="Obtiene vista previa de una plantilla footer">
        <cfargument name="pkPlant" type="numeric" required="yes" hint="pk de la plantilla">
        <cfscript>
            return DAO.obtenerVistaFooter(pkPlant);
        </cfscript>
    </cffunction>

    <cffunction name="cambiarEstadoHeader" hint="Cambia el estado de una plantilla header">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
        <cfscript>
            var headerUsado = DAO.headerEstaEnUso(pk);
            var respuesta = (headerUsado.BODY > 0) ? -1 : DAO.cambiarEstadoHeader(pk);
            return respuesta;
        </cfscript>
    </cffunction>

    <cffunction name="cambiarEstadoFooter" hint="Cambia el estado de una plantilla footer">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
        <cfscript>
            var footerUsado = DAO.footerEstaEnUso(pk);
            var respuesta = (footerUsado.BODY > 0) ? -1 : DAO.cambiarEstadoFooter(pk);
            return respuesta;
        </cfscript>
    </cffunction>

    <cffunction name="obtieneHeaderCarrusel" hint="Obtiene las plantillas header del carrusel">
        <cfscript>
            return DAO.obtieneHeaderCarrusel();
        </cfscript>
    </cffunction>

    <cffunction name="obtieneFooterCarrusel" hint="Obtiene las plantillas footer del carrusel">
        <cfscript>
            return DAO.obtieneFooterCarrusel();
        </cfscript>
    </cffunction>

    <cffunction name="obtieneEtiquetas" hint="Obtiene las etiquetas disponibles para el correo">
        <cfargument name="pkBody" type="numeric" required="yes" hint="pk del correo">
        <cfscript>
            return DAO.obtieneEtiquetas(pkBody);
        </cfscript>
    </cffunction>

    <cffunction name="agregarEtiqueta" hint="Agrega una nueva etiqueta al correo">
        <cfargument name="pkBody" type="numeric" required="yes" hint="pk del correo al que pertenece">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la etiqueta">
        <cfargument name="descripcion" type="string" required="yes" hint="Descripcion de la etiqueta">
        <cfscript>
            return DAO.agregarEtiqueta(pkBody,nombre,descripcion);
        </cfscript>
    </cffunction>

    <cffunction name="cambiarEstadoEtiqueta" hint="Cambia el estado de una etiqueta">
        <cfargument name="pkEti" type="numeric" required="yes" hint="pk de la etiqueta">
        <cfscript>
            return DAO.cambiarEstadoEtiqueta(pkEti);
        </cfscript>
    </cffunction>

    <cffunction name="getHistorialCorreos" hint="Cambia el estado de una etiqueta">
        <cfargument name="fechaInicio"  type="string" required="yes" hint="Fecha de inicio">
        <cfargument name="fechaFin"     type="string" required="yes" hint="Fecha de fin">
        <cfscript>
            return DAO.getHistorialCorreos(fechaInicio, fechaFin);
        </cfscript>
    </cffunction>

    <cffunction name="getCorreo" hint="Obtiene el contenido del correo">
        <cfargument name="pkHistorial" type="numeric"  required="yes" hint="pk del historial">
        <cfscript>
            return DAO.getCorreo(pkHistorial);
        </cfscript>
    </cffunction>

</cfcomponent>