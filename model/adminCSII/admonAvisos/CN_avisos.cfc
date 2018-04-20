<cfcomponent>

    <cfproperty name="DAO" inject="adminCSII.admonAvisos.DAO_avisos">

    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getVertiente" hint="Obtiene los usuarios del sistema">
        <cfscript>
            return DAO.getVertiente();
        </cfscript>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getRolesByVertiente" hint="Obtiene la lista de roles por vertiente">
        <cfargument name="pkVertiente" type="numeric" required="yes" hint="Pk de la vertiente">
        <cfscript>
            return DAO.getRolesByVertiente(pkVertiente);
        </cfscript>
    </cffunction> 


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getAvisos" hint="Obtiene el listado de avisos">
        <cfscript>
            return DAO.getAvisos();
        </cfscript>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="guardaAviso" hint="Guarda nuevo registro de un aviso">
        <cfargument name="nombre"  type="string"  required="yes" hint="nombre del aviso">
        <cfargument name="mensaje" type="string"  required="yes" hint="contenido del aviso">
        <cfargument name="fecIni"  type="string"  required="yes" hint="fecha de inicio del aviso">
        <cfargument name="fecFin"  type="string"  required="yes" hint="fecha fin del aviso">
        <cfargument name="redir"   type="string"  required="yes" hint="modulo al que redirige">
        <cfargument name="vert"    type="numeric" required="yes" hint="pk de la vertiente">
        <cfargument name="pkRoles" type="string"  required="yes" hint="cadena con arreglo de roles">
        <cfscript>
            var rol = deserializeJSON(pkRoles);

            var pkAviso = DAO.guardaAviso(nombre, mensaje, fecIni, fecFin, redir, vert);

            for(i = 1; i lte ArrayLen(rol); i++){
                DAO.relacionaRolAviso(pkAviso, rol[i]);
            }

            return pkAviso;
        </cfscript>
    </cffunction>


    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="cambiaEdoAviso" access="remote" hint="Cambiar el estado de un aviso">
        <cfargument name="pkAviso" type="numeric" required="yes" hint="nombre del aviso">
        <cfscript>
            return DAO.cambiaEdoAviso(pkAviso);
        </cfscript>
    </cffunction>


    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getAvisoByPk" access="remote" hint="Consulta un aviso por su pk">
        <cfargument name="pkAviso" type="numeric" required="yes" hint="pk del aviso">
        <cfscript>
            return DAO.getAvisoByPk(pkAviso);
        </cfscript>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="editarAviso" hint="Guarda nuevo registro de un aviso">
        <cfargument name="pkAviso" type="string"  required="yes" hint="pk del aviso">
        <cfargument name="nombre"  type="string"  required="yes" hint="nombre del aviso">
        <cfargument name="mensaje" type="string"  required="yes" hint="contenido del aviso">
        <cfargument name="fecIni"  type="string"  required="yes" hint="fecha de inicio del aviso">
        <cfargument name="fecFin"  type="string"  required="yes" hint="fecha fin del aviso">
        <cfargument name="redir"   type="string"  required="yes" hint="modulo al que redirige">
        <cfargument name="vert"    type="numeric" required="yes" hint="pk de la vertiente">
        <cfargument name="pkRoles" type="string"  required="yes" hint="cadena con arreglo de roles">
        <cfscript>
            var rol = deserializeJSON(pkRoles);

            var pkAvisos = DAO.editarAviso(pkAviso, nombre, mensaje, fecIni, fecFin, redir, vert);

            for(i = 1; i lte ArrayLen(rol); i++){
                DAO.relacionaRolAviso(pkAviso, rol[i]);
            }

            return pkAvisos;
        </cfscript>
    </cffunction>


    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getAvisoByRol" access="remote" hint="Obtiene avisos por el pk del rol">
        <cfargument name="pkRol" type="numeric" required="yes" hint="pk del rol">
        <cfscript>
            return DAO.getAvisoByRol(pkRol);
        </cfscript>
    </cffunction>


</cfcomponent> 