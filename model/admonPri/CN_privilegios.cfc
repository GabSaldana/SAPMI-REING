<cfcomponent>
	
    <cfproperty name="cnPri" inject="admonPri.DAO_privilegios">
    <cffunction name="obtenerModulos" hint="Obtiene los modulos del sistema">
        <cfscript>
            return cnPri.obtenerModulos();
        </cfscript>
    </cffunction>

    <cffunction name="obtenerLista" hint="Obtiene los usuarios del sistema">
        <cfargument name="pkUR" type="string" required="yes" hint="Clave de la unidad responsable">
        <cfscript>
            return cnPri.obtenerLista(pkUR);
        </cfscript>
    </cffunction>

     <cffunction name="guardarRol" hint="Guarda nuevo registro en la BD">        
        <cfargument name="nombre"  type="string" required="yes" hint="Titulo del rol">
        <cfargument name="clave" type="string" required="yes" hint="Clave para referirse al rol">
        <cfargument name="descripcion" type="string" required="yes" hint="descripción de las funciones del rol">
        <cfargument name="prefijo" type="string" required="yes" hint="prefijo identificador del rol"> 
        <cfargument name="modulo" type="numeric" required="yes" hint="Modulo en que el rol inicia sesion">  
        <cfargument name="vertiente" type="numeric" required="yes" hint="pk de la vertiente">       
        <cfscript>
           	return cnPri.guardarRol(nombre, clave, descripcion, prefijo, modulo, vertiente);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerRoles" hint="Obtiene los usuarios del sistema">        
        <cfscript>
            return cnPri.obtenerRoles();
        </cfscript>
    </cffunction>

     <cffunction name="cambiarEstado" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkUsu" hint="Clave de usuario">
        <cfargument name="pkEdo" hint="Estado al que se quiere actualizar">
        <cfscript>
            return cnPri.cambiarEstado(pkUsu, pkEdo);
        </cfscript>
    </cffunction>

    <cffunction name="consultarUsuario" hint="Consulta datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del Rol">
        <cfscript>
            return cnPri.consultarUsuario(pkUsuario);
        </cfscript>
    </cffunction>

     <cffunction name="editarUsuario" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del ROL">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del usuario">
        <cfargument name="clave" type="string" required="yes" hint="Apellido paterno del usuario">
        <cfargument name="descripcion" type="string" required="yes" hint="Apellido materno del usuario">
        <cfargument name="prefijo" type="string" required="yes" hint="Genero del usuario">
        <cfargument name="modulo" type="numeric" required="yes" hint="Modulo en que el rol inicia sesion"> 
        <cfscript>
            return cnPri.editarUsuario(argumentCollection=arguments);
        </cfscript>
     </cffunction>

    <cffunction name="bajaRol" access="public" >
        <cfargument name="pkUsu" hint="Cambiar e estado de un rol a [1]">
        <cfscript>
            return cnPri.bajaRol(pkUsu);
        </cfscript>
    </cffunction>

<!--- ------------------------------------------------------------------------------



        Acciones



    ----------------------------------------------------------------------------------->   



    
    <cffunction name="mostrarAcciones" access="remote" hint="Obtiene los temas de una acción formativa específica">
        <cfargument name="modulo" type="numeric" required="yes" hint="Clave de la acción formativa">
        <cfscript>            
            return cnPri.mostrarAcciones(modulo);
        </cfscript>
    </cffunction>

    <cffunction name="mostrarMod" access="remote" hint="Obtiene los módulos que integran el sistema">
        <cfscript>            
            return cnPri.mostrarMod();
        </cfscript>
    </cffunction>

    <cffunction name="mostrarAcc" access="remote" hint="Obtiene los módulos que integran el sistema">
        <cfscript>            
            return cnPri.mostrarAcc();
        </cfscript>
    </cffunction>

    <cffunction name="guardarAccion" hint="Guarda nuevo registro en la BD">        
        <cfargument name="modulo"  type="numeric" required="yes" hint="Módulo de la acción">
		<cfargument name="estado"  type="numeric" required="yes" hint="Estado de la acción">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la acción">
        <cfargument name="descripcion" type="string" required="yes" hint="descripción de las funciones de la acción">
        <cfargument name="orden" type="numeric" required="yes" hint="identificador">
        <cfargument name="clave" type="string" required="yes" hint="identificador de la acción">
        <cfargument name="icono" type="string" required="yes" hint="imagen que representa a la acción">        
        <cfscript>
			return cnPri.guardarAccion( modulo, estado, nombre, descripcion, orden, clave, icono);		           
        </cfscript>
    </cffunction>

    <cffunction name="consultarInfoAcciones" hint="Consulta datos del usuario seleccionado">
        <cfargument name="pkAccion" type="numeric" required="yes" hint="Pk del Rol">
        <cfscript>
            return cnPri.consultarInfoAcciones(pkAccion);
        </cfscript>
    </cffunction>

    <cffunction name="cambiarEstadoAcc" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkUsu" hint="Clave de usuario">
        <cfargument name="pkEdo" hint="Estado al que se quiere actualizar">
        <cfscript>
            return cnPri.cambiarEstadoAcc(pkUsu, pkEdo);
        </cfscript>
    </cffunction>

    <cffunction name="editarAccion" hint="Edita datos de la acción seleccionada">
        <cfargument name="pkAccion" type="numeric" required="yes" hint="Pk de la acción">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la acción">
        <cfargument name="descripcion" type="string" required="yes" hint="descripción de las funciones de la acción">
        <cfargument name="orden" type="numeric" required="yes" hint="identificador">
        <cfargument name="clave" type="string" required="yes" hint="identificador de la acción">         
        <cfargument name="icono" type="string" required="yes" hint="imagen que representa a la acción">
        <cfscript>
            return cnPri.editarAccion(argumentCollection=arguments);
        </cfscript>
     </cffunction> 


     <!---------------------------------------------------------------


        GENERAL


    ---------------------------------------------------------------->

    <cffunction name="getNumeroAccionesRol" access="remote" hint="Obtiene roles que tienen acceso al módulo seleccionado ">
        <cfargument name="pkModulo" type="numeric" required="yes" hint="Clave del módulo con el que se realiza la busqueda">
        <cfscript>
            var pkVertiente = cnPri.getVertienteByModulo(pkModulo).VERT[1];
            return cnPri.getNumeroAccionesRol(pkModulo, pkVertiente);
        </cfscript>
    </cffunction>

    <cffunction name="consultaTotalGral" access="remote" hint="Obtiene roles que tienen acceso al módulo seleccionado ">
         <cfargument name="pkModulo" type="numeric" required="yes" hint="Clave del módulo con el que se realiza la busqueda">
        <cfscript>
            var pkVertiente = cnPri.getVertienteByModulo(pkModulo).VERT[1];           
            return cnPri.consultaTotalGral(pkModulo, pkVertiente);
        </cfscript>
    </cffunction>

    <cffunction name="consultarUsuarioNombre" hint="Consulta datos del usuario seleccionado">
        <cfargument name="nombreUsr" type="string" required="yes" hint="Nombre del Rol">
        <cfscript>
            return cnPri.consultarUsuarioNombre(nombreUsr);
        </cfscript>
    </cffunction>

    <cffunction name="bajaAccrol" hint="degrado el valor del estado del registro en la BD"> 
        <cfargument name="edo"  type="numeric" required="yes" hint="Estado de la acción"> 
        <cfargument name="rol"  type="numeric" required="yes" hint="Rol que utiliza de la acción">
        <cfargument name="accion" type="numeric" required="yes" hint="Nombre de la acción">
                       
        <cfscript>
            return cnPri.bajaAccrol(edo, rol, accion );
        </cfscript>
    </cffunction>

    <cffunction name="altaAccionRol" hint="Evalua e inserta nuevo registro en la BD o asigna el valor de estado 2 al registro existente"> 
        <cfargument name="edo"  type="numeric" required="yes" hint="Estado de la acción">
        <cfargument name="rol"  type="numeric" required="yes" hint="Rol que utiliza de la acción">
        <cfargument name="accion" type="numeric" required="yes" hint="Nombre de la acción">
        <cfscript>
            return cnPri.altaAccionRol(edo, rol, accion);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: Agosto 2017
    * @author: Alejandro Tovar
    --->
    <cffunction name="obtieneVertientes" hint="Obtiene las vertientes del sistema">        
        <cfscript>
            return cnPri.obtieneVertientes();
        </cfscript>
    </cffunction>


</cfcomponent>