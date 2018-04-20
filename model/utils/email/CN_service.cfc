<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: administración de usuarios
* Fecha: agosoto/2016
* Descripcion: componente de negocio para envío de correos.
* Autor: 
============================================================================================
--->

<cfcomponent> 

    <cfproperty name="cnUtils"   inject="utils.CN_utilities">
    <cfproperty name="DAO"       inject="utils.email.DAO_service">
    <cfproperty name="daoCorreo" inject="adminCSII.admonCorreos.DAO_correos">

    <!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
    <cffunction name="enviarCorreoByPkPlantilla" hint="Genera el correo que sera enviado">
        <cfargument name="asunto" type="string" required="yes" hint="Asunto del correo que sera enviado">
        <cfargument name="emailOrigen" type="string" required="yes" hint="E-mail del cual se enviara el correo">
        <cfargument name="emailDestino" type="string" required="yes" hint="E-mail al cual el correo llegara">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfargument name="etiquetas" type="struct" required="yes" hint="Valores con los que seran remplazadas las etiquetas">
        <cfscript>
            mail=StructNew();
            var datos = etiquetas;

            var correoData = DAO.obtenerCorreo(pkCorreo);
            var correo = cnUtils.queryToArray(correoData);

            var etiData = DAO.obtenerEtiquetas(correo[1].PKBODY);
            var eti = cnUtils.queryToArray(etiData);

            var sizeEti = StructCount(datos);

            for(var i = 1; i <= sizeEti; i++){
                correo[1].BODY = correo[1].BODY.replace('##' & eti[i].ETIQUETA & '##', datos[eti[i].ETIQUETA],'all');
            }

            var contenido = correo[1].HEADER & '<br>' & correo[1].BODY & '<br>' & correo[1].FOOTER;
                
            mail.from = emailOrigen; 
            mail.content = contenido;
            mail.subject = asunto;
            mail.cc = '';
            mail.bcc = '';
            mail.to = emailDestino;
			
            
            var existenceUsuario = StructKeyExists(Session, "cbstorage");
            if (existenceUsuario)
            	existenceUsuario = StructKeyExists(Session.cbstorage, "usuario");

            pkUsuario = (existenceUsuario EQ 'NO')? application.SIIIP_CTES.CORREOS.PKADMIN : Session.cbstorage.usuario.PK;
            
            var hist = daoCorreo.guardar_historial(pkCorreo, pkUsuario, emailDestino, contenido);

            return this.sendMail(mail);
        </cfscript>
    </cffunction>
   
    <cffunction name="sendMail" access="public" hint="Realiza el envio del correo">
        <cfargument name="mail" required="true" type="any" hint="Objeto que contiene la informacion del correo a enviar">
        <cfscript>

            if (mail.from eq '') {
                mail.from = "siiip@ipn.mx";
            }
            var copia = ''; //E-mail al que se envia copia
            if (mail.bcc neq '') {
                copia = copia & ' ' & mail.bcc;
            }
        </cfscript>
           <cfmail server="smtp.ipn.mx" type="html" from="#mail.from#" to="#mail.to#" cc="#mail.cc#" bcc="#copia#" subject="#mail.subject#" failto="#mail.from#" >
                #mail.content#    
            </cfmail>
            <cfreturn 1>
    </cffunction>

</cfcomponent>