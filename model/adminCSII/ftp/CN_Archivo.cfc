<!---
* =====================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: FTP
* Fecha: septiembre de 2016
* Descripcion: componente de negocio para la administración de archivos
* =====================================================================================
--->

<cfcomponent>
	
	<cfproperty name="dao"   inject="model.adminCSII.ftp.DAO_Archivo">
	<cfproperty name="cnMes" inject="utils.maquinaEstados.CN_maquinaEstados">

	<!---
	* Fecha : septiembre de 2016
	* Autor : Yareli Andrade
	--->
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


    <!---
    * Fecha : septiembre de 2016
    * Autor : Yareli Andrade
    --->
    <cffunction name="registrarArchivoAnexo" hint="Guarda un registro del archivo que se subió al FTP">
        <cfargument name="pkCatalogo"  hint="Pk del archivo en el catalogo">
        <cfargument name="pkUsuario"   hint="Pk del usuario">
        <cfargument name="descripcion" hint="Descripcion del archivo">
        <cfargument name="pkEstado"    hint="Estado con el que se guarda el registro">
        <cfargument name="archivo"     hint="Nombre del archivo">
        <cfargument name="pkRegistro"  hint="pk del registro">
        <cfscript>
            return dao.registrarArchivoAnexo(pkCatalogo, pkUsuario, descripcion, pkEstado, archivo, pkRegistro);     
        </cfscript>
    </cffunction>


    <!---
    * Fecha : Julio del 2017
    * Autor : Alejandro Tovar
    --->
    <cffunction name="actualizaOtros" hint="Guarda un registro del archivo que se subió al FTP">
        <cfargument name="descripcion" hint="Descripcion del archivo">
        <cfargument name="archivo"     hint="Nombre del archivo">
        <cfargument name="pkArchivo"   hint="pk del registro">
        <cfscript>
            return dao.actualizaOtros(descripcion, archivo, pkArchivo);     
        </cfscript>
    </cffunction>


	<!---
	* Fecha : septiembre de 2016
	* Autor : Yareli Andrade
	--->
	<cffunction name="consultarNombreArchivo" hint="Obtiene el nombre de un archivo">
		<cfargument name="pkCatalogo" hint="Pk del archivo en el catalogo">
		<cfargument name="pkObjeto"   hint="Pk del objeto">
		<cfscript>
			return dao.consultarNombreArchivo(pkCatalogo, pkObjeto);
		</cfscript>
	</cffunction>


    <!---
    * Fecha : septiembre de 2016
    * Autor : Yareli Andrade
    --->
    <cffunction name="consultarNombreArchivoAnexo" hint="Obtiene el nombre de un archivo">
        <cfargument name="pkArchivo" hint="Pk del archivo en el catalogo">
        <cfscript>
            return dao.consultarNombreArchivoAnexo(pkArchivo);        
        </cfscript>
    </cffunction>


	<cffunction name="consultaDocumentos" hint="Devuelve la vista con los documentos a solicitar">
		<cfargument name="pksDocumentos" type="numeric" hint="Pks de los documentos">
		<cfargument name="requerido" 	 type="numeric" hint="Pks de los documentos">
		<cfargument name="extension" 	 type="string"  hint="Pks de los documentos">
		<cfargument name="convenio" 	 type="numeric" hint="Pks de los documentos">
        <cfargument name="recargar"      type="string"  hint="Funcion que debe recargar despues de subir un archivo">
		<cfscript>
			var est = structNew();
            
			var existe = dao.existeConvenio(convenio, pksDocumentos);

			if (existe.EXISTE GTE 1) {
				est.existe = existe.EXISTE;
				var archivo = dao.consultaArchivo(pksDocumentos, requerido, extension, convenio, recargar);
				est.documento = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.DOCUMENTOS#, archivo, Session.cbstorage.usuario.ROL);
                est.existe = 1;
			}else {
				est.existe = existe.EXISTE;
				est.documento = dao.consultaDocumentos(pksDocumentos, requerido, extension, convenio, recargar);
                est.existe = 0;
			}
			return est;
		</cfscript>
	</cffunction>


    <cffunction name="consultaOtros" hint="Devuelve la vista con los documentos a solicitar">
        <cfargument name="pksDocumentos" type="numeric" hint="Pks de los documentos">
        <cfargument name="requerido"     type="numeric" hint="Pks de los documentos">
        <cfargument name="extension"     type="string"  hint="Pks de los documentos">
        <cfargument name="convenio"      type="numeric" hint="Pks de los documentos">
        <cfargument name="recargar"      type="string"  hint="Funcion que debe recargar despues de subir un archivo">
        <cfscript>
            return dao.consultaDocumentos(pksDocumentos, requerido, extension, convenio, recargar);
        </cfscript>
    </cffunction>



    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Se cambia el estado del registro en cuestión a partir de la accion que se realiza.
    --->
    <cffunction name="cambiarEstado" hint="Obtiene las acciones disponibles de acuerdo al rol de usuario">
        <cfargument name="pkRegistro"    type="numeric" required="yes" hint="Pk del registro que se va a modificar">
        <cfargument name="accion"        type="string"  required="yes" hint="Pk de la acción">
        <cfargument name="pkProced"      type="numeric" required="yes" hint="Pk del procedimiento">
        <cfargument name="pkRol"         type="numeric" required="yes" hint="Pk del rol">
        <cfargument name="asunto"        type="string"  required="no"  hint="asunto">
        <cfargument name="comentario"    type="string"  required="no"  hint="comentario">
        <cfargument name="prioridad"     type="numeric" required="yes" hint="prioridad del comentario">
        <cfargument name="destinatarios" type="array"   required="yes" hint="arreglo de destinatarios">
        <cfargument name="tipoComent"    type="numeric" required="yes" hint="prioridad del comentario">
        <cfscript>

            respuesta = StructNew();
            resPreoperacion   = StructNew();
            postPreoperacion  = StructNew();
            respuesta.exito   = true;
            respuesta.mensaje = '';
            
            //OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
            estadoactual = cnMes.getEdoActual(pkProced, pkRegistro);
            pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, pkRol, estadoactual.ESTADO[1]);

            //OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
            //EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)
            resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1]);

            //SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
            if (resPreoperacion.exito){
                //CAMBIO DE ESTADO EN LA TABLA A MODIFICAR (TMPTPRUEBACES)
                registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, pkRol, pkProced, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

                //VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
                if (registroBitacora.fallo){
                    //obtiene el estado actual del registro y lo muestra en el mensaje de salida.
                    msjFallo = cnMes.getEdoActual(pkProced, pkRegistro);
                    respuesta.exito = false;
                    respuesta.fallo = true;
                    respuesta.mensaje = msjFallo.NOM_EDO[1];
                    return respuesta;
                }

                //OBTENER POS-OPERACIONES DE LA ACCION
                postPreoperacion  = this.ejecutaPostOperaciones(pkEdoAccion.EDOACC_PK[1]);
                respuesta.exito   = postPreoperacion.exito;
                respuesta.mensaje = postPreoperacion.mensaje;

                //ACTUALIZA LA BITÁCORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
                if (respuesta.mensaje NEQ ''){
                    cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
                }

                //REGISTRA EL COMENTARIO EN LA TABLA COMTCOMENTARIO
                if (comentario NEQ ''){
                    var cnCom  = getModel("adminCSII.comentarios.CN_comentarios");
                    cnCom.registraComentario(asunto, comentario, prioridad, registroBitacora.edoOrigen, pkRegistro, destinatarios, tipoComent);
                }

            }else {
                respuesta = resPreoperacion;
            }

            return respuesta;
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene y ejcuta las pre-operaciones.
    --->
    <cffunction name="ejecutaPreOperaciones" hint="Ejecuta pre-operaciones">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfscript>
            respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';

            fn1 = true;
            fn2 = true;
            fn3 = true;
            fn4 = true;

            preOperaciones = cnMes.getOperaciones(pkEdoAccion, #application.SIIIP_CTES.TIPOOPERACION.PRE#);

            /*Se pone a modo de ejemplo se puede poner en una funcion*/
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_EDO#)) {
                fn1 = this.VERIFICAR_ESTADO();
                if (not fn1){
                    respuesta.mensaje = 'Error al verificar estado';
                }
            }
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_DIR#)) {
                fn2 = this.VERIFICAR_DIRECTOR();
                if (not fn2){
                    respuesta.mensaje = 'Error al verificar director';
                }
            }
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_SDIR#)) {
                fn3 = this.VERIFICAR_SUBDIRECTOR();
                if (not fn3){
                    respuesta.mensaje = 'Error al verificar subdirector';
                }
            }
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_ANA#)) {
                fn4 = this.VERIFICAR_ANALISTA();
                if (not fn4){
                    respuesta.mensaje = 'Error al verificar analista';
                }
            }


            if (fn1 AND fn2 AND fn3 AND fn4){
                respuesta.exito = true;
            }else {
                respuesta.exito = false;
            }

            return respuesta;
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene y ejcuta las pos-operaciones.
    --->
    <cffunction name="ejecutaPostOperaciones" hint="Ejecuta pos-operaciones">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfscript>
            respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';

            fn1 = true;
            fn2 = true;
            fn3 = true;
            fn4 = true;

            preOperaciones = cnMes.getOperaciones(pkEdoAccion, #application.SIIIP_CTES.TIPOOPERACION.POS#);
           
            /*Se pone a modo de ejemplo se puede poner en una funcion*/
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_EDO#)) {
                fn1 = this.VERIFICAR_ESTADO();
                if (not fn1){
                    respuesta.mensaje = 'Error al verificar estado';
                }
            }
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_DIR#)) {
                fn2 = this.VERIFICAR_DIRECTOR();
                if (not fn2){
                    respuesta.mensaje = 'Error al verificar director';
                }
            }
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_SDIR#)) {
                fn3 = this.VERIFICAR_SUBDIRECTOR();
                if (not fn3){
                    respuesta.mensaje = 'Error al verificar subdirector';
                }
            }
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.V_ANA#)) {
                fn4 = this.VERIFICAR_ANALISTA();
                if (not fn4){
                    respuesta.mensaje = 'Error al verificar analista';
                }
            }

            if (fn1 AND fn2 AND fn3 AND fn4){
                respuesta.exito = true;
            }else {
                respuesta.exito = false;
            }
            return respuesta;
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: FUNCIONES DE PRUEBA
    --->
    <cffunction name="VERIFICAR_ESTADO" hint="Funcion de prueba 1">
        <cfscript>
            return true;
        </cfscript>
    </cffunction>

    <cffunction name="VERIFICAR_DIRECTOR" hint="Funcion de prueba 2">
        <cfscript>
            return true;
        </cfscript>
    </cffunction>

    <cffunction name="VERIFICAR_SUBDIRECTOR" hint="Funcion de prueba 3">
        <cfscript>
            return true;
        </cfscript>
    </cffunction>

    <cffunction name="VERIFICAR_ANALISTA" hint="Funcion de prueba 4">
        <cfscript>
            return true;
        </cfscript>
    </cffunction>


    <!---
    * Descripcion:    Consulta el numero de archivos requeridos ya cargados
    * Fecha creacion: Junio de 2017
    * @author:        SGS
    --->
    <cffunction name="archivosRequeridosCargados" hint="Consulta el numero de archivos requeridos ya cargados">
        <cfargument name="pkRegistro"   type="numeric" required="yes" hint="Pk del registro">
        <cfargument name="tipoConvenio" type="numeric" required="yes" hint="tipoConvenio">
        <cfscript>
            return dao.archivosRequeridosCargados(pkRegistro, tipoConvenio);
        </cfscript>
    </cffunction>


    <!---
    * Descripcion:    Cambia el estado del archivo
    * Fecha creacion: Julio de 2017
    * @author:        Alejandro Tovar
    --->
    <cffunction name="eliminarArchivo" hint="Elimina el archivo logicamente">
        <cfargument name="pkArchivo" type="numeric" required="yes" hint="Pk del registro">
        <cfscript>
            return dao.eliminarArchivo(pkArchivo, application.SIIIP_CTES.ESTADO.DOCUMENTOELIMINADO);
        </cfscript>
    </cffunction>

    
</cfcomponent>