<cfcomponent>

	<cfproperty name="dao" 			inject="SAPMI.Planeacion.Indicadores.DAO_Indicadores">
    <cfproperty name="cnMes"      	inject="utils.maquinaEstados.CN_maquinaEstados">

    <cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getIndicadores" hint="">
		<cfscript>
			var rol = session.cbstorage.usuario.ROL;
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'Indicadores.verTodos')){
				pkUsuario = session.cbstorage.usuario.PK;
			}

			var formatos =dao.getIndicadores();
			/*getQueryAcciones trae aquellos registros en los que el usuaio puede realizar alguna accion*/
			/*writeDump(formatos);writedump(cnMes.getQueryAcciones(115, formatos, rol));abort;*/
			return cnMes.getQueryAcciones(115, formatos, rol);
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	* Descripcion : Particularizacion del cambio de estado a la configuracion de formatos
------------------------------------------------ 
	Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="cambiarEstadoFT" hint="Se cambia el estado del registro en cuestión a partir de la accion que se realiza.">
        <cfargument name="pkRegistro"    type="numeric" required="yes" hint="Pk del registro que se va a modificar">
        <cfargument name="accion"      type="string" required="yes" hint="Pk de la acción">
        <cfscript>

            respuesta = StructNew();
            //resPreoperacion   = StructNew();
            //postPreoperacion  = StructNew();
            respuesta.exito   = true;
            respuesta.mensaje = '';

            var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.EVALUACION_INDICADORES#;
            var ROL = session.cbstorage.usuario.ROL;
             
            //OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
            estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);

            pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, ROL,estadoactual.ESTADO[1]);

            //CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
            registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

            //VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
            if (registroBitacora.fallo){
                //obtiene el estado actual del registro y lo muestra en el mensaje de salida.
                respuesta.exito = false;
                respuesta.fallo = true;
                respuesta.mensaje = estadoactual.NOM_EDO[1];
                return respuesta;
            }
            
            return respuesta;
        </cfscript>
    </cffunction>
	
</cfcomponent>