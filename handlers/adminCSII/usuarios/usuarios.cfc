<!---
========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: administración de usuarios
* Sub modulo: 
* Fecha: agosto/2016
* Descripcion: handler 
* Autor: Yareli Andrade
=========================================================================
--->

<cfcomponent>

	<cfproperty name="cnAdmonUsuarios" inject="adminCSII.usuarios.CN_usuarios">

	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>
			Request.rol = cnAdmonUsuarios.obtenerRoles();			
			Request.ur = cnAdmonUsuarios.getUr();
			Request.acron = cnAdmonUsuarios.getAcron();
		</cfscript>
		<cfset event.setView("adminCSII/usuarios/usuarios")>
	</cffunction>

	<!---
	* Fecha creación: agosto, 2016
	* @author: Yareli Andrade
	--->	
	<cffunction name="obtenerUsuarios" hint="Obtiene la lista de usuarios del sistema">
		<cfargument name="event" type="any">	
		<cfscript>
			var UR = 'U30000';
			prc.usuarios = cnAdmonUsuarios.obtenerUsuarios(UR);
			event.setView("adminCSII/usuarios/tablaUsuarios").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: agosto, 2016
	* @author: Yareli Andrade
	--->
	<cffunction name="generarPsw" hint="Genera contrasenia de usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonUsuarios.generarPsw();
			event.renderData(type="text", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->
	<cffunction name="agregarUsuario" hint="Agrega un usuario en la BD">
		<cfargument name="Event" type="any">
		<cfscript>		
			var rc = Event.getCollection();
			// var pkClaveUR	= Session.cbstorage.usuario.CLAVE_UR;	
			var pkClaveUR = 'U30000';
			var psw = cnAdmonUsuarios.generarPsw();
			var resultado = cnAdmonUsuarios.guardarUsuario(rc.ur, rc.rol, rc.genero, rc.acronimo, rc.nombre, rc.apaterno, rc.amaterno, rc.usr, psw, rc.email, rc.tel, rc.ext);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: agosto, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="eliminaUsuario" hint="Actualiza el campo obligatorio de acuerdo al valor">
		<cfscript>
			res= cnAdmonUsuarios.eliminaUsuario(rc.pkUsu);
			event.renderData(type="json", data=res);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: agosto, 2016
	* @author: Yareli Andrade
	--->
	<cffunction name="actualizarUsuario" hint="Cambia el registro del usuario al estado indicado">
		<cfscript>
			resultado = cnAdmonUsuarios.cambiarEstado(rc.pkUsu, rc.estado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->
	<cffunction name="consultarUsuario" hint="Consulta datos del usuario seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonUsuarios.consultarUsuario(rc.pkUsuario);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->
	<cffunction name="editarUsuario" hint="Edita datos del usuario seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = 0;
			if(rc.genero eq 1)
				rc.genero = 3;
			else
				rc.genero = 4;
			if (StructKeyExists(Session.cbstorage.usuario, "PSW")) {
				if (rc.psw eq Session.cbstorage.usuario.PSW)
					resultado = -1;
				else {
					var pkUsuario = Session.cbstorage.usuario.PK;
					var rol 	  = Session.cbstorage.usuario.ROL;
					var usr       = Session.cbstorage.usuario.USR;
					var resultado = cnAdmonUsuarios.editarUsuario(pkUsuario, rc.nombre, rc.apaterno, rc.amaterno, rc.genero, rc.tel, rc.ext, rc.email, rol, usr, rc.acr, rc.psw);
				}
			} else {
				var resultado = cnAdmonUsuarios.editarUsuario(rc.pkUsuario, rc.nombre, rc.apaterno, rc.amaterno, rc.genero, rc.tel, rc.ext, rc.email, rc.rol, rc.usr, rc.acr);
			}
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Agosto, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="getClaveRol" hint="Obtiene pk del rol seleccionado">
		<cfscript>
			res= cnAdmonUsuarios.getClaveRol(rc.rol);
			event.renderData(type="json", data=res);
		</cfscript>
	</cffunction>	

	<!---
	* Fecha creacion: agosto, 2016
	* @author Alejandro Tovar
	--->
	<cffunction name="recuperarPwd" hint="Envia un correo a con la contraseña del usuario especificado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var usuario = cnAdmonUsuarios.recuperarPwd(rc.nomUsuario, rc.email);
			event.renderData(type="json", data=usuario);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: agosto, 2016
	* @author Alejandro Tovar
	--->
	<cffunction name="getEmail" hint="Obtiene el email del usuario especificado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var usuario = cnAdmonUsuarios.getEmail(rc.userName);
			event.renderData(type="json", data=usuario);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: agosto, 2016
	* @author: Yareli Andrade
	--->
	<cffunction name="desactivarCuenta" hint="Desactiva la cuenta de usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var res = cnAdmonUsuarios.desactivarCuenta(Session.cbstorage.usuario.PK);
			event.renderData(type="json", data=res);
		</cfscript>	
	</cffunction>

	<!---
	* Fecha creacion: Septiembre, 2016
	* @author Alejandro Tovar
	--->
	<cffunction name="cambiarPwd" hint="Edita datos del usuario seleccionado">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc 		  = Event.getCollection();
			var cn 		  = getModel("adminCSII.usuarios.CN_usuarios");
			var resultado = 0;
			var pkUsuario = Session.cbstorage.usuario.PK;

			if (StructKeyExists(Session.cbstorage.usuario, "PSW")) {
				if (rc.psw eq Session.cbstorage.usuario.PSW){
					resultado = -1;
				}else {
					resultado = cn.cambiarPwd(pkUsuario, rc.psw);
				}
			}
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>	

<!--- --------------------------- Edición de usuarios --------------------------- !--->

	<!---
	* Descripcion:	Función para que el usuario pueda editar sus datos. 
	* Fecha: 		4 Abril 2017.
	* Autor:		Roberto Cadena.
	--->
	<cffunction name="getUsuariosMain" access="remote" >
		<cfargument name="event" type="any">
		<cfscript>
			Request.datos = cnAdmonUsuarios.datosUsuario();
			event.setView("adminCSII/usuarios/modalUsr").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Función para que el usuario pueda editar sus datos. 
	* Fecha: 		4 Abril 2017.
	* Autor:		Roberto Cadena.
	--->
	<cffunction name="editarUsr" access="remote">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var pkUsuario = Session.cbstorage.usuario.PK;			
			var res = cnAdmonUsuarios.editarUsr(Session.cbstorage.usuario.PK, rc.inUsuarioNombre, rc.inUsuarioPaterno, rc.inUsuarioMaterno, rc.inUsuarioGenero,rc.inUsuarioTel, rc.inUsuarioExt ,rc.inUsuarioEmail, rc.inUsuarioUser);			
			event.renderData(type="json", data=res);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:	Función para que el usuario pueda editar sus datos. 
	* Fecha: 		4 Abril 2017.
	* Autor:		Roberto Cadena.
	--->
	<cffunction name="getUsr" access="remote">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var res = cnAdmonUsuarios.getUsr(rc.inUsuarioUser, Session.cbstorage.usuario.PK);		
			event.renderData(type="json", data=res.usr);
		</cfscript>
	</cffunction>

	<cffunction name="getPass" access="remote">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var pkUsuario = Session.cbstorage.usuario.PK;
			var res = cnAdmonUsuarios.getPass(Session.cbstorage.usuario.PK, rc.pass);			
			event.renderData(type="json", data=res.PKUSUARIO);
		</cfscript>
	</cffunction>

	<cffunction name="editarPass" access="remote">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var pkUsuario = Session.cbstorage.usuario.PK;
			var res = cnAdmonUsuarios.editarPass(Session.cbstorage.usuario.PK, rc.pass);			
			event.renderData(type="json", data=res);
		</cfscript>
	</cffunction>

</cfcomponent>