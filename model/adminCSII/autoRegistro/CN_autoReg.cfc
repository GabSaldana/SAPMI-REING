<cfcomponent>
    <cfproperty name="DAO" inject="adminCSII.autoRegistro.DAO_autoReg">
    <cfproperty name="cnUsuarios" inject="adminCSII.usuarios.CN_usuarios">
    <cfproperty name="cnUtils"    inject="utils.CN_utilities">
    <cfproperty name="cnEmail"    inject="utils.email.CN_service">


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: Muesta la vista con los cursos disponibles de las vertientes
    --->
    <cffunction name="getOfertaCursos" hint="Muesta la vista con los cursos disponibles de las vertientes.">
        <cfargument name="pkVertiente" hint="pk de la vertiente">
        <cfscript>
            return DAO.getOfertaCursos(pkVertiente);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: Registra un participante
    --->
    <cffunction name="registraParticipante" hint="Registra un participante">
        <cfargument name="acr"  type="numeric" required="yes" hint="Acronimo del usuario">
        <cfargument name="nom"  type="string"  required="yes" hint="Nombre del usuario">
        <cfargument name="pat"  type="string"  required="yes" hint="Apellido paterno del usuario">
        <cfargument name="mat"  type="string"  required="yes" hint="Apellido materno del usuario">
        <cfargument name="gen"  type="numeric" required="yes" hint="Genero del usuario">
        <cfargument name="rfc"  type="string"  required="yes" hint="Telefono del usuario">
        <cfargument name="hom"  type="string"  required="yes" hint="Telefono del usuario">
        <cfargument name="pro"  type="numeric" required="yes" hint="Rol del usuario">
        <cfargument name="tel"  type="string"  required="yes" hint="Telefono del usuario">
        <cfargument name="ext"  type="string"  required="yes" hint="Extension del usuario">
        <cfargument name="mail" type="string"  required="yes" hint="Nombre de usuario">
        <cfargument name="emp"  type="string"  required="yes" hint="Nombre de usuario">
        <cfargument name="pwd"  type="string"  required="yes" hint="Nombre de usuario">
        <cfargument name="rol"  type="numeric" required="yes" hint="Rol del usuario">
        <cfscript>
            // se forma el nombre de usuario
            var prefijo = DAO.getPrefijo(rol).PREF[1];
            var posArroba = find("@", mail);
            var nombre = mid(mail, 1, (posArroba - 1));
            var usr = UCase(prefijo&nombre);

            var pkUsuaro = DAO.guardarUsuario('9', rol, gen, acr, nom, pat, mat, usr, pwd, mail, tel, ext);
            var pkPartic = DAO.registraParticipante(acr,nom ,pat ,mat, gen, rfc ,hom , pro, tel ,ext ,mail ,emp, pkUsuaro);

            return this.enviaCuenta(mail, usr);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene el catalogo de acronimos
    ---> 
    <cffunction name="getAcronimo" hint="Obtiene el catalogo de acronimos">
        <cfscript>
            return DAO.getAcronimo();
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: obtiene el catalogo de genero
    ---> 
    <cffunction name="getGenero" hint="obtiene el catalogo de genero">
        <cfscript>
            return DAO.getGenero();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: obtiene el catalogo de procedencia
    ---> 
    <cffunction name="getProcedencia" hint="obtiene el catalogo de procedencia">
        <cfscript>
            return DAO.getProcedencia();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Envia la cuenta de usuario y contrasela al usuario
    ---> 
    <cffunction name="enviaCuenta" hint="Envia la cuenta de usuario y contrasela al usuario">
        <cfargument name="email" type="string" required="yes" hint="Pk de la clave UR">
        <cfargument name="usr"   type="string" required="yes" hint="Pk de la clave UR">
        <cfscript>
            var userData = DAO.getPwd(email, 2, usr);
            var user = cnUtils.queryToArray(userData);
            var fechaEmail = 'Ciudad de M&eacute;xico a ' & LSDateFormat(now() ,"long", "Spanish (Standard)");

            // El nombre de los elementos deben ser los mismo que los nombres de las etiquetas del correo que se va a enviar (pkCorreo)
            var datos = {contrasena: user[1].PSW, fecha: fechaEmail, usuario: user[1].NOMBRE};

            var asunto = 'Cuenta de usuario';
            var emailOrigen = ''; // emailOrigen puede ir vacio y por default se enviara mediante el e-mail del CSII 
            var emailDestino = user[1].EMAIL;
            var pkCorreo = 5; // RECUPERACION_CUENTA
            var etiquetas = datos;
            return cnEmail.enviarCorreoByPkPlantilla(asunto, emailOrigen, emailDestino, pkCorreo, etiquetas);
        </cfscript>
    </cffunction>



</cfcomponent>