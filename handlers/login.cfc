<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: administración de usuarios
* Sub modulo: 
* Fecha: agosto/2016
* Descripcion: handler para la autenticacion del usuario
* Autor: Yareli Andrade
* =========================================================================
--->

<cfcomponent>
	<cfprocessingdirective pageEncoding="utf-8">

	<!---
	* Mod: se considera el caso de personalización de cuentas	
	* Fecha: septiembre, 2016
	* @author Yareli Andrade
	-------------------------------------
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	-------------------------------------
	* Fecha creacion: Mayo de 2017
	* @author SGS
	--->
	<cffunction name="autenticacion" hint="Valida los datos de acceso del usuario">
		<cfargument name="Event" type="any">	
		<cfscript>
			var rc = Event.getCollection();
			if ( NOT Len(rc.user) OR NOT Len(rc.password) ) {
				getPlugin("MessageBox").setMessage("error2", "Favor de llenar los campos de usuario y contraseña.");
				setNextEvent("main");
			} else {
				var cnLogin = getModel("login.CN_login");
				var usuario = cnLogin.validarUsuario(rc.user, rc.password);
				if ( usuario.validado EQ 1 ) {
					var cnUsr = getModel("adminCSII.usuarios.CN_usuarios");
					getPlugin("SessionStorage").setVar("usuario", usuario);
					// variable de sesion persona solo se utiliza en CVU (no es propio de SERO)
					var persona = cnUsr.getPersona(Session.cbstorage.usuario.PK);
					getPlugin("SessionStorage").setVar("persona", persona);
					if (StructKeyExists(usuario, "PSW")) { //Completar el registro del usuario
						Request.acron = cnUsr.getAcron();
						Request.rol   = cnUsr.obtenerRoles();	
						Request.ur 	  = cnUsr.getUr();
						event.setView("adminCSII/usuarios/registro").noLayout();
					} else {

						/*Solamente para usuarios de convenios de investigación*/
						if (findoneof('@' , rc.user)){
							var dominio  = Mid(rc.user, findoneof('@' , rc.user) +1, Len(rc.user));
							var username = Mid(rc.user, 1, findoneof('@' , rc.user) -1);
							var inv      = QueryNew("username, domain, password", "VarChar, VarChar, VarChar"); 
							var newRow   = QueryAddRow(inv, 1);
							QuerySetCell(inv, "username", username, 1);
							QuerySetCell(inv, "domain", dominio, 1);
							QuerySetCell(inv, "password", rc.password, 1);
							getPlugin("SessionStorage").setVar("investigador", inv);
						}

						this.variablesSesion();
						setNextEvent(usuario.modulo_inicial);
					}
				} else if ( usuario.validado EQ 2 ) {
					getPlugin("MessageBox").setMessage("error2", "Esta cuenta de usuario fue desactivada.");
					setNextEvent("main");
				} else { 
					getPlugin("MessageBox").setMessage("error2", "Nombre de usuario o contraseña incorrecto.");
					setNextEvent("main");
				}
			}
		</cfscript>
	</cffunction>

	<!---
	* Fecha creacion: agosto, 2016
	* @author: Yareli Andrade
	--->
	<cffunction name="cerrarSesion" hint="Finaliza la sesión de usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			getPlugin("SessionStorage").clearAll();
			setNextEvent("main");
		</cfscript>	
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Funcion que obtiene la cantidad de comentarios no vistos.
    --->  
	<cffunction name="getComentariosNoVistos" hint="Obtiene la cantidad de comentarios no vistos">
		<cfargument name="pkUsuario"  type="numeric" required="yes" hint="pk del usuario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado  = cnComent.getComentariosNoVistos(rc.pkUsuario);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Mayo de 2017
    * @author SGS
	* Descripcion: Funcion que obtiene la variables de sesion
    ---> 
	<cffunction name="variablesSesion" hint="Variables de sesion">
		<cfargument name="event" type="any">
		<cfscript>			
			var cn	       = getModel("login.CN_menu");
			var cnComent   = getModel("adminCSII.comentarios.CN_comentarios");
			var cnChat     = getModel("adminCSII.chat.CN_Chat");
			var cnAvisos   = getModel("adminCSII.admonAvisos.CN_avisos");
			var rol		   = Session.cbstorage.usuario.ROL;
			var modulos    = cn.getMenu(rol);
			var permisos   = cn.getPrivilegios(rol);
			var msjsNuevos = cnComent.getComentariosNoVistos(Session.cbstorage.usuario.PK);
			var subcanales = cnChat.getSubcanales(rol);
			var avisos     = cnAvisos.getAvisoByRol(rol);
			getPlugin("SessionStorage").setVar("menu", modulos);
			getPlugin("SessionStorage").setVar("grant", permisos);
			getPlugin("SessionStorage").setVar("nuevos", msjsNuevos.REL_NOVISTO[1]);
			getPlugin("SessionStorage").setVar("subcanales", subcanales);
			getPlugin("SessionStorage").setVar("avisos", avisos);
		</cfscript>
	</cffunction>

</cfcomponent>