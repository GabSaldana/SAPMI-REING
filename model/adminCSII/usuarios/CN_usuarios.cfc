<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: administración de usuarios
* Fecha: agosoto/2016
* Descripcion: componente de negocio para agregar, eliminar y editar datos de los usuarios.
* Autor: Yareli Andrade
============================================================================================
--->

<cfcomponent>

    <cfproperty name="cnUtils" inject="utils.CN_utilities">
    <cfproperty name="cnEmail" inject="utils.email.CN_service">
    <cfproperty name="daoUsuarios" inject="adminCSII.usuarios.DAO_usuarios">

    <!---
    * Fecha creación: agosto, 2016
    * @author: Yareli Andrade
    --->  
    <cffunction name="obtenerUsuarios" hint="Obtiene los usuarios del sistema">
        <cfargument name="pkUR" type="string" required="yes" hint="Clave de la unidad responsable">
        <cfscript>
            return daoUsuarios.obtenerUsuarios(pkUR);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->  
    <cffunction name="obtenerRoles" hint="Funcion que obtiene los roles de usuario y sus claves">    
        <cfscript>
            return daoUsuarios.obtenerRoles();
        </cfscript>
    </cffunction> 

    <!---
    * Fecha creación: agosto, 2016
    * @author: Yareli Andrade
    --->  
    <cffunction name="generarPsw" hint="Genera contrasenia de usuario">    
        <cfscript>
            return daoUsuarios.generarPsw();
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->        
    <cffunction name="guardarUsuario" hint="Guarda nuevo registro en la BD">        
        <cfargument name="ur"  type="string" required="yes" hint="Pk de la clave UR">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfargument name="genero" type="numeric" required="yes" hint="Genero del usuario">
        <cfargument name="acronimo" type="string" required="no" hint="Acronimo del usuario">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del usuario">
        <cfargument name="apaterno" type="string" required="yes" hint="Apellido paterno del usuario">
        <cfargument name="amaterno" type="string" required="yes" hint="Apellido materno del usuario">
        <cfargument name="usr"  type="string" required="yes" hint="Nombre de usuario del nuevo registro">
        <cfargument name="psw"  type="string" required="yes" hint="Contrasenia del nuevo registro">        
        <cfargument name="email" type="string" required="yes" hint="Correo electronico del usuario">
        <cfargument name="tel" type="string" required="yes" hint="Telefono del usuario">
        <cfargument name="ext" type="string" required="yes" hint="Extension del usuario">
        <cfscript>
            return daoUsuarios.guardarUsuario(ur, rol, genero, acronimo, nombre, apaterno, amaterno, usr, psw, email, tel, ext);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: agosto, 2016
    * @author: Alejandro Tovar
    ---> 
    <cffunction name="eliminaUsuario" access="public" >
        <cfargument name="pkUsu" hint="">
        <cfscript>
            return daoUsuarios.eliminaUsuario(pkUsu);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: agosto, 2016
    * @author: Yareli Andrade
    ---> 
    <cffunction name="cambiarEstado" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkUsu" hint="Clave de usuario">
        <cfargument name="pkEdo" hint="Estado al que se quiere actualizar">
        <cfscript>
            return daoUsuarios.cambiarEstado(pkUsu, pkEdo);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->        
    <cffunction name="consultarUsuario" hint="Consulta datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfscript>
            return daoUsuarios.consultarUsuario(pkUsuario);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->        
    <cffunction name="editarUsuario" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del usuario">
        <cfargument name="apaterno" type="string" required="yes" hint="Apellido paterno del usuario">
        <cfargument name="amaterno" type="string" required="yes" hint="Apellido materno del usuario">
        <cfargument name="genero" type="numeric" required="yes" hint="Genero del usuario">
        <cfargument name="tel" type="string" required="yes" hint="Telefono del usuario">
        <cfargument name="ext" type="string" required="yes" hint="Extension del usuario">
        <cfargument name="email" type="string" required="yes" hint="Correo electronico del usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfargument name="user" type="string" required="yes" hint="Nombre de usuario">
        <cfargument name="acronimo" type="numeric" required="yes" hint="Acronimo del usuario">
        <cfargument name="psw" type="string" required="no" hint="Nueva contraseña">
        <cfscript>
            return daoUsuarios.editarUsuario(argumentCollection=arguments);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->  
    <cffunction name="getUr"access="remote"hint="Funcion que obtiene los roles de usuario y sus claves">    
        <cfscript>
            var resultado   = daoUsuarios.getUr();
            var unidades = structNew();
            var unidadesRes = arrayNew(1);                      
            for(var x = 1; x <= resultado.recordcount; x++){                
                var dependencia = structNew();
                dependencia.pk = resultado.PK_UR[x];
                dependencia.nombre = resultado.NOMBRE_UR[x];
                dependencia.clave = resultado.CLAVE_UR[x];
                try{                    
                    if(resultado.PK_PUR[x] eq resultado.PK_UR[x]){                        
                        structInsert(unidades,"SIN CLASIFICACIÓN",[]);
                        arrayAppend(unidades["SIN CLASIFICACIÓN"],dependencia);                
                    }else{
                        structInsert(unidades,resultado.NOMBRE_PUR[x],[]);
                        arrayAppend(unidades[resultado.NOMBRE_PUR[x]],dependencia);                    
                    }
                }catch(any e){                    
                    if(resultado.PK_PUR[x] eq resultado.PK_UR[x]){                                                
                        arrayAppend(unidades["SIN CLASIFICACIÓN"],dependencia);                    
                    }else{
                        arrayAppend(unidades[resultado.NOMBRE_PUR[x]],dependencia);                    
                    }                    
                }           
            }         
            return serializeJSON(unidades);
        </cfscript>        
    </cffunction>    

    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->  
    <cffunction name="getAcron"access="remote"hint="Funcion que obtiene los roles de usuario y sus claves">    
        <cfscript>
            var resultado   = daoUsuarios.getAcron();
            return resultado;
        </cfscript>
    </cffunction>        

    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->  
    <cffunction name="getClaveRol"access="remote"hint="Obtiene pk del rol seleccionado">   
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario"> 
        <cfscript>
            var resultado   = daoUsuarios.getClaveRol(rol);
            return resultado;
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->  
    <cffunction name="getEmail" access="remote" hint="Obtiene el email del usuario especificado">   
        <cfargument name="userName" type="string" required="yes" hint="Nombre de usuario"> 
        <cfscript>
            var resultado   = daoUsuarios.getEmail(userName);
            return resultado;
        </cfscript>
    </cffunction>    

    <!---
    * Mod: Se realiza el envio usando el correo generado en el modulo de adminisracion de correos
    * Fecha: Enero de 2017
    * @author SGS
    -------------------------------------
    * Mod: se considera el email del responsable para enviar la notificación, se incluye la fecha y se define el contenido del correo
    * Fecha: septiembre, 2016
    * @author Yareli Andrade
    -------------------------------------
    * Fecha creacion: agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="recuperarPwd" hint="Envia un correo a con la contraseña del usuario especificado">
        <cfargument name="email"  type="string" required="yes" hint="Pk de la clave UR">
        <cfscript>
            var userData = daoUsuarios.getPwd(email, 2);
            var user = cnUtils.queryToArray(userData);
            var fechaEmail = 'Ciudad de México a ' & LSDateFormat(now() ,"long", "Spanish (Standard)");

            // El nombre de los elementos deben ser los mismo que los nombres de las etiquetas del correo que se va a enviar (pkCorreo)
            var datos = {usuario: user[1].NOMBRE, contrasena: user[1].PSW, fecha: fechaEmail};

            var asunto = 'Recuperación de contraseña';
            var emailOrigen = ''; // emailOrigen puede ir vacio y por default se enviara mediante el e-mail del CSII 
            var emailDestino = user[1].EMAIL;
            var pkCorreo = #application.SIIIP_CTES.CORREOS.CONTRASENA#;
            var etiquetas = datos;
            return cnEmail.enviarCorreoByPkPlantilla(asunto, emailOrigen, emailDestino, pkCorreo, etiquetas);
        </cfscript>
    </cffunction>

    <!---
    * Mod: Se realiza el envio usando el correo generado en el modulo de adminisracion de correos
    * Fecha: Enero de 2017
    * @author SGS
    -------------------------------------
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->  
    <cffunction name="desactivarCuenta" access="remote" hint="Desactiva la cuenta de usuario y envia correo al responsable del proceso">   
        <cfargument name="pkUser" type="numeric" required="yes" hint="Pk del usuario">
        <cfscript>
            resultado = daoUsuarios.cambiarEstado(pkUser, 3);
            if (resultado neq 0) {
                var userData = daoUsuarios.getPwd(Session.cbstorage.usuario.EMAIL, 3);
                var user = cnUtils.queryToArray(userData);
                var fechaEmail = 'Ciudad de México a ' & LSDateFormat(now() ,"long", "Spanish (Standard)");

                // El nombre de los elementos deben ser los mismo que los nombres de las etiquetas del correo que se va a enviar (pkCorreo)
                var datos = {nombre: user[1].NOMBRE, password: user[1].PSW, fecha: fechaEmail};
                
                var asunto = 'Recuperación de contraseña';
                var emailOrigen = Session.cbstorage.usuario.EMAIL; // emailOrigen puede ir vacio y por default se enviara mediante el e-mail del CSII 
                var emailDestino = user[1].EMAIL; // E-mail del responsable del proceso
                var pkCorreo = #application.SIIIP_CTES.CORREOS.DESACTIVACION_CUENTA#;
                var etiquetas = datos;      
                return cnEmail.enviarCorreoByPkPlantilla(asunto, emailOrigen, emailDestino, pkCorreo, etiquetas);
            } else {
                return resultado;
            }
        </cfscript>
    </cffunction>
    <!---
    * Fecha creacion: Octubre, 2016
    * @author Alejandro Tovar
    --->        
    <cffunction name="cambiarPwd" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfargument name="psw" type="string" required="no" hint="Nueva contraseña">
        <cfscript>
            dao     = CreateObject('component','DAO_usuarios');
            return dao.cambiarPwd(argumentCollection=arguments);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:  Función para que el usuario pueda editar sus datos. 
    * Fecha:        4 Abril 2017.
    * Autor:        Roberto Cadena.
    --->
    <cffunction name="datosUsuario" hint="">
        <cfscript>
            return daoUsuarios.datosUsuario();
        </cfscript>
    </cffunction> 

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->        
    <cffunction name="editarUsr" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="nombre"       type="string"   required="yes" hint="Nombre del usuario">
        <cfargument name="apaterno"     type="string"   required="yes" hint="Apellido paterno del usuario">
        <cfargument name="amaterno"     type="string"   required="yes" hint="Apellido materno del usuario">
        <cfargument name="genero"       type="numeric"  required="yes" hint="Genero del usuario">
        <cfargument name="tel"          type="string"   required="yes" hint="Telefono del usuario">
        <cfargument name="ext"          type="string"   required="yes" hint="Extension del usuario">
        <cfargument name="email"        type="string"   required="yes" hint="Correo electronico del usuario">
        <cfargument name="user"         type="string"   required="yes" hint="Nombre de usuario">
        <cfscript>
            return daoUsuarios.editarUsr(argumentCollection=arguments);
        </cfscript>
    </cffunction>

    
    <cffunction name="getUsr" hint="Edita datos del usuario seleccionado">
        <cfargument name="usr"         type="string"   required="yes" hint="Contrasenia del usuario">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfscript>
            return daoUsuarios.getUsr(argumentCollection=arguments);
        </cfscript>
    </cffunction>

    <cffunction name="getPass" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="pass"         type="string"   required="yes" hint="Contrasenia del usuario">
        <cfscript>
            return daoUsuarios.getPass(argumentCollection=arguments);
        </cfscript>
    </cffunction>

        <cffunction name="editarPass" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="pass"         type="string"   required="yes" hint="Contrasenia del usuario">
        <cfscript>
            return daoUsuarios.editarPass(argumentCollection=arguments);
        </cfscript>
    </cffunction>


    <!---
    * Fecha : Octubre 2017
    * author : Alejandro Tovar
    --->       
    <cffunction name="getPersona" hint="obtiene los datos de la persona asociada a un usuario">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="pk del usuario">
        <cfscript>
            return daoUsuarios.getPersona(pkUsuario);
        </cfscript>
    </cffunction>

    <!---
    * Fecha : Enero del 2017
    * Autor : Ana Belem Juárez Méndez
    --->
    <cffunction name="getUsuarioContrasena" hint="obtiene el usuario y la contraseña de un usuario, el cual es identificado por su pkusuario">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="pk del usuario">
        <cfscript>
            return daoUsuarios.getUsuarioContrasena(pkUsuario);
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Febrero de 2018
    *Autor: Ana Belem Juárez Méndez
    --->
    <cffunction name="getRolDeUsuario" hint="Obtiene el rol de un usuario">
        <cfargument name="pkUsuario"     type="numeric" required="yes" hint="PK del usuario">
        <cfscript>
            return DAO.getRolDeUsuario(pkUsuario);
        </cfscript>
    </cffunction>

</cfcomponent> 