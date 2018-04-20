<!---
* =============================================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: máquina de estados
* Fecha: octubre de 2016
* Descripcion: componente de negocio para la admnistración de la funciones básicas de la máquina de estados
* =============================================================================================================
--->

<cfcomponent>
    <cfproperty name="populator" inject="wirebox:populator">
    <cfproperty name="wirebox"   inject="wirebox">
    <cfproperty name="cache"     inject="cachebox:default">
	<cfproperty name="dao"       inject="utils.maquinaEstados.DAO_maquinaEstados">


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene las acciones, y hace el join con el query de registros recibidos.
    --->
	<cffunction name="getQueryAcciones" hint="Cambia el estado de un registro que sigue un procedimiento específico.">
    	<cfargument name="procedimiento" type="numeric" required="yes" hint="pk del procedimiento">
    	<cfargument name="queryOrigen" 	 type="query" 	required="yes" hint="query con los registros de la tabla TMPTPRUEBACES">
    	<cfargument name="rol" 			 type="numeric" required="yes" hint="pk del rol">
		<cfargument name="getEliminados" type="boolean" required="false" default="false" hint="filtra los elemento en estado 0">
       	<cfset	queryAcciones = this.getAllAccionesCached(procedimiento, rol,getEliminados)>
		<!---JOIN ENTRE LOS REGISTROS OBTENIDOS, Y LAS ACCIÓNES DISPONIBLES EN EL PROCEDIMIENTO.--->
		<cfquery name="registroAcciones" dbtype="query">
			SELECT 	*
			FROM  	queryOrigen, queryAcciones
			WHERE 	queryOrigen.CESESTADO =  queryAcciones.EDOACT
					AND queryOrigen.CESRUTA = queryAcciones.RUTA_PK
		</cfquery>
		<cfreturn registroAcciones>
	</cffunction>
	
	<cffunction name="getAllAccionesCached" hint="Cambia el estado de un registro que sigue un procedimiento específico.">
    	<cfargument name="procedimiento" type="numeric" required="yes" hint="pk del procedimiento">
    	<cfargument name="rol" 			 type="numeric" required="yes" hint="pk del rol">
		<cfargument name="getEliminados" type="boolean" required="false" default="false" hint="filtra los elemento en estado 0">
		<cfscript>
       		var queryAcciones = cache.get("getAllAcciones"&procedimiento&'_'&rol&'_'&getEliminados );
			if (!isNull(queryAcciones)){
				return queryAcciones;
			}else {
				 var queryAcciones = dao.getAllAcciones(procedimiento, rol,getEliminados);
				 cache.set("getAllAcciones"&procedimiento&'_'&rol&'_'&getEliminados,queryAcciones,120,20);
				 return queryAcciones;
			}
       	</cfscript>
	</cffunction>

	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que cambia el estado del registro en cuestión a partir de la accion que se realiza, y registra el cambio en la bítacora.
    --->
	<cffunction name="cambiarEstado" hint="Cambia el estado de un registro que sigue un procedimiento específico.">
        <cfargument name="pkRegistro"   type="numeric" required="yes" hint="pk del registro afectado">
        <cfargument name="Accion"     	type="STRING" required="yes" hint="clave de la accion ejecutada">
        <cfargument name="pkRol" 	    type="numeric" required="no"  hint="pk del rol">
        <cfargument name="pkProced"     type="numeric" required="yes" hint="pk del procedimiento">
        <cfargument name="nombreAccion" type="string"  required="yes" hint="nombre de la accion ejecutada">
        <cfargument name="iconoAccion"  type="string"  required="yes" hint="icono de la accion ejecutada">
		<cfscript>

            respuesta = StructNew();
            respuesta.retroceso = false;
            //OBTENER EL ESTADO ACTUAL
            estadoActual = dao.obtenerEstadoActual(pkProced, pkRegistro);

			// OBTIENE EL ESTADO SIGUIENTE DE ACUERDO A LA ACCIÓN REALIZADA.
            //COMO EJEMPLO SE ESTA UTILIZANDO EL PK DEL ROL ENVIADO POR EL USUARIO, PERO DEBE UTILIZARSE EL DE LA SESION (Session.cbstorage.usuario.ROL)
			cambio = dao.getEdoSigBypkAccion(Accion, pkRol,estadoActual.ESTADO[1]);

            //VERIFICAR SI EL ESTADO ACTUAL CORRESPONDE A LA ACCION QUE SE QUIERE EJECUTAR

            if (estadoActual.ESTADO[1] EQ cambio.EDOACTUAL[1]){

    			// CAMBIA EL ESTADO DEL REGISTRO.
    			dao.cambiarEstado(pkRegistro, cambio.CAMBIOEDO[1],pkProced);

    			// REGISTRA EL CAMBIO DE ESTADO EN LA TABLA CESBHISTORIAL.
    			registro =  dao.registrarCambioEstado(pkProced, cambio.EDOACTUAL[1], cambio.CAMBIOEDO[1], pkRegistro, Session.cbstorage.usuario.PK, nombreAccion,iconoAccion);

                if (cambio.NOM_EDO_SIG[1] LT estadoActual.NOM_EDO[1]){
                    respuesta.retroceso = true;
                }

                respuesta.pkBitacora = registro;
                respuesta.edoOrigen  = cambio.EDOACTUAL[1];
                respuesta.edoDestino = cambio.CAMBIOEDO[1];
                respuesta.fallo      = false; 
            }else {
                respuesta.fallo = true; 
            }

            return respuesta;

		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que registra el cambio de estado en la bitácora.
    --->
	<cffunction name="mensajeBitacora" hint="registra cambio en bitacora">
        <cfargument name="pkBitacora" required="yes" hint="pk de la tabla CESBHISTORIAL">
        <cfargument name="mensaje"    required="yes" hint="mensaje de error">
		<cfscript>
			return dao.mensajeBitacora(pkBitacora, mensaje);
		</cfscript>
	</cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene las operaciones a realizar al ejecutar una acción.
    --->
    <cffunction name="getOperaciones" hint="Obtiene los datos de la tabla a modificar.">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfargument name="tipoOper"    type="numeric" required="yes" hint="pk del tipo de operacion">
        <cfscript>
            operaciones = ArrayNew(1);

            preOperaciones = dao.getOperaciones(pkEdoAccion, tipoOper);

        	for (i=1; i LTE preOperaciones.recordcount; i = i +1){
                ArrayPrepend(operaciones, preOperaciones.OPER_NOMBRE[i]);
            }

        </cfscript>
        <cfreturn operaciones>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el estado siguiente de acuerdo a la acción realizada y el rol.
    --->
    <cffunction name="getEdoSigBypkAccion" hint="Obtiene el estado siguiente de una accion">
        <cfargument name="accion" type="string" required="yes" hint="clave de la accion de la tabla USRTACCION">
        <cfargument name="pkRol"    type="numeric" required="yes" hint="pk del rol">
        <cfargument name="estadoActual"    type="numeric" required="yes" hint="pk del estado actual del registro">
        <cfscript>
	        return dao.getEdoSigBypkAccion(accion , pkRol,estadoActual);
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los estados por los que ha pasado el objeto.
	* -------------------------------
    * Descripcion de la modificacion: Agregar un nuevo argumento. Este argumento es el pk del procedimiento.
    * Fecha de la modificacion: 22/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    --->
    <cffunction name="historialObjeto" hint="Obtiene estados y acciones del objeto">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del usuario">
		<cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk del procedimiento">
        <cfscript>
			var estado =DAO.obtenerEstadoActual(pkProcedimiento,pkRegistro);
			var pkRuta = estado.RUTA[1];
            var consultaEstados = DAO.getEstadosObjeto(pkRegistro, pkRuta);
            var consultaCambios = DAO.getHistorialCambios(pkRegistro, pkRuta);
            historial    = this.creaBaseHistorial(consultaEstados);
            cambios      = this.creaArrayCambios(consultaCambios);
            cambiosLinks = this.creaArrayCambiosLinks(consultaCambios);

            for (cambio in cambios){
                historial.setCambios(cambio);
            }

            for (cambioLink in cambiosLinks){
                historial.setCambiosLink(cambioLink);
            }

            var colores = this.setColores(pkRegistro);

            for (k=1; k LTE ArrayLen(historial.getestados()); k = k+1){
                for (l=1; l LTE ArrayLen(colores); l = l+1){
                    if ( historial.getestados()[k].getNUM_EDO() EQ colores[l].estado ){
                        historial.getestados()[k].setESTILO_ESTADO(colores[l].color);
                    }
                }
            }

        </cfscript>
        <cfreturn historial>
    </cffunction>


    <cffunction name="historialObjetoVal" hint="Obtiene el historial de validaciones del objeto">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del usuario">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk del procedimiento">
        <cfscript>
            var estado = DAO.obtenerEstadoActual(pkProcedimiento,pkRegistro);
            var pkRuta = estado.RUTA[1];
            var consultaCambios = DAO.getHistorialCambiosObjeto(pkRegistro, pkRuta);
            cambios = this.creaArrayCambios(consultaCambios);

            for(i=1; i LTE ArrayLen(cambios); i++){
                if(i eq 1)
                    cambios[i].setESTILO_ESTADO('estadoActual');
                else if(cambios[i].getNOM_EDO_ACTUAL() LT cambios[i].getNOM_EDO_ANTERIOR())
                    cambios[i].setESTILO_ESTADO('estadoRetroceso');
                else
                    cambios[i].setESTILO_ESTADO('estadoAntiguo');
            }
        </cfscript>
        <cfreturn cambios>
    </cffunction>

    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene la fecha de creacion del objeto.
    --->
    <cffunction name="setColores" hint="">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del registro">
        <cfscript>
            var colores = [];
            var colorFuerte    = 'estadoActual';    //CLASE DEFINIDA EN LA VISTA
            var colorClaro     = 'estadoAntiguo';   //CLASE DEFINIDA EN LA VISTA
            var colorNaranja   = 'estadoRetroceso'; //CLASE DEFINIDA EN LA VISTA
            var ultimosEstados = DAO.ultimosEstados(pkRegistro);
            var lenCambios     = ultimosEstados.recordcount;

            pkColor = StructNew();
            pkColor.estado = 0;
            pkColor.color = colorClaro;
            colores[1] = pkColor;

            for (i=1; i LTE (lenCambios)-1; i = i+1){
                pkColor = StructNew();
                if ( ultimosEstados.PKACTU[i] lt ultimosEstados.PKACTU[i+1] ){
                    pkColor.estado = ultimosEstados.ESTADO[i];
                    pkColor.color = colorClaro;
                    colores[i+1] = pkColor;
                }else {
                    pkColor.estado = ultimosEstados.ESTADO[i];
                    pkColor.color = colorNaranja;
                    colores[i+1] = pkColor;
                }
            }

            pkColor = StructNew();
            pkColor.estado = ultimosEstados.ESTADO[lenCambios];
            pkColor.color = colorFuerte;
            colores[ArrayLen(colores) + 1] = pkColor;
        </cfscript>
        <cfreturn colores>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que crea la estructura base del historial de cambios de estado.
    --->
    <cffunction name="creaBaseHistorial" hint="Obtiene estructura base">
        <cfargument name="consultaEstados">
        <cfscript>
            var estados=[];

            for (var x=1; x lte consultaEstados.recordcount; x++){
                var estado = populator.populateFromQuery(wirebox.getInstance("utils/maquinaEstados/B_Estado"),consultaEstados,x);
                arrayAppend(estados, estado);
            }

            historial = wirebox.getInstance("utils/maquinaEstados/B_Historial");
            historial.setestados(Estados);
        </cfscript>
        <cfreturn historial>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que crea el arreglo con los cambios de estado en el origen.
    --->
    <cffunction name="creaArrayCambios" hint="">
        <cfargument name="consultaCambios">
        <cfscript>
            var cambios=[];

            for (var x=1; x lte consultaCambios.recordcount; x++){
                var cambio = populator.populateFromQuery(wirebox.getInstance("utils/maquinaEstados/B_Cambio"),consultaCambios,x);
                cambio.setfecha(cambio.getfecha());
                arrayAppend(cambios, cambio);
            }
           
        </cfscript>
        <cfreturn cambios>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que crea el arreglo con los cambios de estado en el destino.
    --->
    <cffunction name="creaArrayCambiosLinks" hint="">
        <cfargument name="consultaCambios">
        <cfscript>
            var cambios=[];

            for (var x=1; x lte consultaCambios.recordcount; x++){
                var cambio = populator.populateFromQuery(wirebox.getInstance("utils/maquinaEstados/B_Cambio"),consultaCambios,x);
                cambio.setfecha(cambio.getfecha());
                arrayAppend(cambios, cambio);
            }
        </cfscript>
        <cfreturn cambios>
    </cffunction>


    <!---
    * Fecha: diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el estado actual del registro.
    --->
    <cffunction name="getEdoActual" hint="Obtiene el estado siguiente de una accion">
        <cfargument name="pkProced"   type="numeric" required="yes" hint="pk del procediemiento">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del registro">
        <cfscript>
            return dao.obtenerEstadoActual(pkProced, pkRegistro);
        </cfscript>
    </cffunction>



    <!---
    * Fecha: Febrero de 2017
    * @author SGS
    * Descripcion: Función que obtiene el rol siguiente mediante el pk de la accion.
    --->
    <cffunction name="getRolSigByClaveAccion" hint="Obtiene el estado siguiente de una accion">
        <cfargument name="accion" type="string"  required="yes" hint="clave de la accion de la tabla USRTACCION">
        <cfargument name="estado" type="numeric" required="yes" hint="estado de la accion">
        <cfscript>
            return dao.getRolSigByClaveAccion(accion, estado);
        </cfscript>
    </cffunction>


    <!---
    * Fecha:    Diciembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getPrimerEstado" hint="Obtiene el primer estado de una ruta">
        <cfargument name="ruta" type="numeric"  required="yes" hint="pk de la ruta">
        <cfscript>
            return dao.getPrimerEstado(ruta);
        </cfscript>
    </cffunction>


</cfcomponent>