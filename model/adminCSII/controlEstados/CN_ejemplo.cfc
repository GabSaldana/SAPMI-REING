<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: ejemplo de implementacion de control de estados
* Fecha: octubre/2016
* Autor: Alejandro Tovar
============================================================================================
--->

<cfcomponent>
    <cfproperty name="daoEjemplo" inject="adminCSII.controlEstados.DAO_ejemplo">
    <cfproperty name="cnMes"      inject="utils.maquinaEstados.CN_maquinaEstados">
    <cfproperty name="cnCom"      inject="adminCSII.comentarios.CN_comentarios">


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los procedimientos disponibles en el catálogo
    ---> 
    <cffunction name="getProcedimiento" hint="Obtiene los procedimientos disponibles en la máquina de estados">
        <cfscript>
            return daoEjemplo.obtenerProcedimiento();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los roles disponibles en el catálogo.
    ---> 
    <cffunction name="getRol" hint="Obtiene los roles disponibles">
        <cfscript>
            return daoEjemplo.getRol();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los registros con sus respectivas acciones.
    ---> 
    <cffunction name="getRegistro" hint="Obtiene las acciones disponibles de acuerdo al rol de usuario">
        <cfargument name="procedimiento" type="numeric" required="yes" hint="Pk del procedimiento que sigue el registro a modificar.">
        <cfargument name="registro"      type="any"     required="no"  hint="Pk del registro">
        <cfargument name="rol"           type="numeric" required="yes" hint="Pk del rol">
        <cfscript>
            var participantes = daoEjemplo.getTablaEjemplo(registro);
            return cnMes.getQueryAcciones(procedimiento, participantes, rol);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Se cambia el estado del registro en cuestión a partir de la accion que se realiza.
    --->
    <cffunction name="cambiarEstado" hint="Obtiene las acciones disponibles de acuerdo al rol de usuario">
        <cfargument name="pkRegistro"    type="numeric" required="yes" hint="Pk del registro que se va a modificar">
        <cfargument name="pkAccion"      type="numeric" required="yes" hint="Pk de la acción">
        <cfargument name="pkProced"      type="numeric" required="yes" hint="Pk del procedimiento">
        <cfargument name="pkRol"         type="numeric" required="yes" hint="Pk del rol">
        <cfargument name="asunto"        type="string"  required="no"  hint="asunto">
        <cfargument name="comentario"    type="string"  required="no"  hint="comentario">
        <cfargument name="prioridad"     type="numeric" required="yes" hint="prioridad del comentario">
        <cfargument name="destinatarios" type="array"   required="yes" hint="arreglo de destinatarios">
        <cfscript>

            respuesta = StructNew();
            resPreoperacion   = StructNew();
            postPreoperacion  = StructNew();
            respuesta.exito   = true;
            respuesta.mensaje = '';
            
            //OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
            pkEdoAccion = cnMes.getEdoSigBypkAccion(pkAccion, pkRol);

            //OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
            //EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)
            resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1]);

            //SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
            if (resPreoperacion.exito){
                //CAMBIO DE ESTADO EN LA TABLA A MODIFICAR (TMPTPRUEBACES)
                registroBitacora = cnMes.cambiarEstado(pkRegistro, pkAccion, pkRol, pkProced, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

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
                    cnCom.registraComentario(asunto, comentario, prioridad, registroBitacora.edoOrigen, pkRegistro, destinatarios);
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
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los comentarios hechos sobre un registro.
    ---> 
    <cffunction name="getComentariosReg" hint="Obtiene comentarios de un registro">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="Pk del registro">
        <cfscript>
            return cnCom.getComentariosReg(pkRegistro);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el contenido de un comentario en especifico.
    --->
    <cffunction name="getContenidoComent" hint="Obtiene comentarios de un registro">
        <cfargument name="pkComent" type="numeric" required="yes" hint="pk de tabla COMTCOMENTARIO">
        <cfscript>
            return cnCom.getContenidoComent(pkComent);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los usuarios para enviar comentario.
    --->
    <cffunction name="getUsuComentario" hint="Usuarios que pueden recibir un comentario">
        <cfscript>
            return cnCom.getUsuComentario();
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene asuntos de tipo de comentario.
    --->
    <cffunction name="asuntoComentario" hint="obtiene el asunto del comentario">
        <cfargument name="pkTipoComent" type="numeric" required="yes" hint="pk tipo de comentario">
        <cfscript>
            return cnCom.asuntoComentario(pkTipoComent);
        </cfscript>
    </cffunction>

</cfcomponent>