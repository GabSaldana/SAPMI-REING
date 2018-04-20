<cfcomponent>
    <cfproperty name="DAO" inject="adminCSII.admonEdos.DAO_estados">


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la tabla con los procedimientos disponibles.
    ---> 
    <cffunction name="obtenerProced" hint="Obtiene procedimientos">
        <cfscript>
            return DAO.obtenerProced();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la vista principal para visualizar las rutas.
    --->
    <cffunction name="setRutas" hint="Obtiene las rutas ligadas a un procedimiento">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk del procedimiento">
        <cfscript>
            return DAO.setRutas(pkProcedimiento);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la tabla con las rutas disponibles en algún procedimiento.
    ---> 
    <cffunction name="getTablaEstadosRutas" hint="Obtiene los estados pertenecientes a una ruta">
        <cfargument name="pkRuta"   type="numeric" required="yes" hint="pk de la ruta">
        <cfargument name="pkProced" type="numeric" required="yes" hint="pk del procedimiento">
        <cfscript>
            return DAO.getTablaEstadosRutas(pkRuta, pkProced);
        </cfscript>
    </cffunction>
     

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que agrega un nuevo estado relacionado a una ruta
    ---> 
    <cffunction name="addEstado" hint="Guarda nuevo estado relacionado a un prodedimiento">        
        <cfargument name="ruta"     type="numeric" required="yes" hint="pk del procedimiento">
        <cfargument name="numero"   type="numeric" required="yes" hint="Numero del estado">
        <cfargument name="nombre"   type="string"  required="yes" hint="Nombre del estado">
        <cfargument name="descr"    type="string"  required="yes" hint="Descripcion del estado">
        <cfargument name="area"     type="numeric" required="yes" hint="Area perteneciente">
        <cfscript>
            return DAO.addEstado(ruta, numero, nombre, descr, area);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la vista principal para visualizar las relaciones con que cuenta una ruta.
    --->
    <cffunction name="setRelaciones" hint="Obtiene las relaciones rol-estados">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.setRelaciones(pkRuta);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="setRelacionesFiltros" hint="Obtiene las relaciones rol-estados con filtros">
        <cfargument name="pkRuta" type="numeric"    required="yes" hint="pk de la ruta">
        <cfargument name="roles"    type="string"   required="yes" hint="roles">
        <cfargument name="acciones" type="string"   required="yes" hint="acciones">
        <cfargument name="estados"  type="string"   required="yes" hint="estados">
        <cfscript>
            rol = listToArray(roles);
            accion = listToArray(acciones);
            estado = listToArray(estados);
            return DAO.setRelacionesFiltros(pkRuta, rol, accion, estado);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los roles disponibles en el sistema
    --->
    <cffunction name="getRoles" hint="Obtiene los roles del sistema">
        <cfscript>
            return DAO.getRoles();
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene estados con que cuenta una ruta.
    --->
    <cffunction name="getEstados" hint="Obtiene estados pertenecientes a una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.getEstados(pkRuta);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene las acciones que puede realizar algún rol.
    --->
    <cffunction name="getAcciones" hint="Obtiene las acciones del sistema">
        <cfargument name="pkRol" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.getAcciones(pkRol);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Agrega una nueva relacion entre el rol-acción, y establece sus estados.
    --->
    <cffunction name="addEdoAccion" hint="Guarda la relacion entre los estados y el rol">
        <cfargument name="accionRol" type="numeric" required="yes" hint="pk de la accion-Rol">
        <cfargument name="edoAct"    type="numeric" required="yes" hint="Estado inicial">
        <cfargument name="edoSig"    type="numeric" required="yes" hint="Estado final">
        <cfscript>
            return DAO.addEdoAccion(accionRol, edoAct, edoSig);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de la relación accion-rol.
    --->
    <cffunction name="cambiarEdoRel" hint="Cambia el estado de las relaciones">
        <cfargument name="pkRel" type="numeric" required="yes" hint="pk de la relacion">
        <cfscript>
            return DAO.cambiarEdoRel(pkRel);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los procedimientos con que cuenta el sistema.
    --->
    <cffunction name="getProced" hint="Obtiene las operaciones relacionadas de un procedimiento">
        <cfargument name="pkProced" type="numeric" required="yes" hint="pk del procedimiento">
        <cfscript>
            return DAO.getProced(pkProced);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los tipos de las operaciones.
    --->
    <cffunction name="getTipoOper" hint="Obtiene el tipo de las operaciones">
        <cfscript>
            return DAO.getTipoOper();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene las operaciones que se pueden realizar al ejecutar una acción.
    --->
    <cffunction name="setTablaAccOpe" hint="Obtiene tabla de operaciones">
        <cfargument name="pkRelacion" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.setTablaAccOpe(pkRelacion);
        </cfscript>
    </cffunction>

   
    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que relaciona operaciones con alguna acción.
    --->       
    <cffunction name="relacionaAccionOperacion" hint="Relaciona operaciones y acciones">        
        <cfargument name="pkOperacion" type="numeric" required="yes" hint="pk del procedimiento">
        <cfargument name="pkTipoOper"  type="numeric" required="yes" hint="Numero del estado">
        <cfargument name="pkRelacion"  type="numeric" required="yes" hint="Nombre del estado">
        <cfscript>
            return DAO.relacionaAccionOperacion(pkOperacion, pkTipoOper, pkRelacion);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de la relación acción-operación.
    --->
    <cffunction name="cambiarEdoOper" hint="Cambia estado de la relacion operacion accion">
        <cfargument name="pkOper" type="numeric" required="yes" hint="pk de la relacion">
        <cfscript>
            return DAO.cambiarEdoOper(pkOper);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de un estado.
    --->
    <cffunction name="eliminaEstado" hint="Cambia estado de un estado">
        <cfargument name="pkEstado" type="numeric" required="yes" hint="pk del estado">
        <cfscript>
            return DAO.eliminaEstado(pkEstado);
        </cfscript>
    </cffunction>

<!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="setTablaOpe" hint="Obtiene las operaciones para la tabla de procedimientos">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.setTablaOpe(pkProcedimiento);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="addOperacion" hint="Guarda la operacion">
        <cfargument name="oper" type="string"  required="yes" hint="Nombre de la operacion">
        <cfargument name="desc"  type="string"  required="yes" hint="Descripcion de la operacion">
        <cfargument name="proced" type="numeric" required="yes" hint="Procedimento">
        <cfscript>
            return DAO.addOperacion(oper, desc, proced);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="addRuta" hint="Guarda la ruta">
        <cfargument name="ruta" type="string"  required="yes" hint="Nombre de la ruta">
        <cfargument name="proced" type="numeric" required="yes" hint="Procedimento">
        <cfscript>
            return DAO.addRuta(ruta, proced);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="cambiarEdoRuta" hint="Cambia el estado de las rutas">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.cambiarEdoRuta(pkRuta);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Julio 2017
    * @author Roberto Cadena
    --->
    <cffunction name="getDependencias" hint="obtiene las dependencias">
        <cfscript>
            return DAO.getDependencias();
        </cfscript>
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getOperaciones" hint="Obtiene las operaciones de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            var operaciones = arrayNew(2);
            var data = [];
            var pk = [];
            var tipos = [];
            var operacion = [];
            datos = DAO.getOperaciones(pkRuta);
            filas = DAO.getSelectOperaciones(pkRuta);

            for( j = 1; j lte filas.recordcount; j++ ){
                for( i = 1; i lte datos.recordcount; i++ ){
                    if(filas.PKOPERACION[j] eq datos.PKOPERACION[i]){
                        data[1] = datos.PKOPERACION[i];
                        data[2] = datos.NOMBREOPERACION[i];
                        data[3] = datos.DESCRIPCIONOPERACION[i];
                        arrayAppend(tipos, datos.PKTIPOOPERACION[i]);
                        arrayAppend(operacion, datos.TIPOOPERACION[i]);
                        arrayAppend(pk, datos.pk[i]);
                        operaciones[j][1] = data;
                        operaciones[j][2] = tipos;
                        operaciones[j][3] = operacion;
                        operaciones[j][4] = pk;
                    }
                }
                tipos = [];
                operacion = [];
                pk = [];
                data = [];
            }
            return operaciones;
        </cfscript>
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getAllAcciones" hint="Obtiene las acciones de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.getAllAcciones(pkRuta);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getAllEstados" hint="Obtiene los estados de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.getAllEstados(pkRuta);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getAllRoles" hint="Obtiene los roles de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfscript>
            return DAO.getAllRoles(pkRuta);
        </cfscript>
    </cffunction>

</cfcomponent>