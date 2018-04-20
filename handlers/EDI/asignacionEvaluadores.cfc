<cfcomponent>	
	<cfproperty name="CN"				inject="EDI.CN_EDI">
	<cfproperty name="CNSol"			inject="EDI.solicitud.CN_Solicitud">
	<cfproperty name="cnAdmonUsuarios"	inject="adminCSII.usuarios.CN_usuarios">
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Ana Belem Juarez Mendez
	--->
	<cffunction name="index" hint="Muestra la vista para la evaluacion al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("EDI/asignacion/index");
		</cfscript>
	</cffunction>


	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Ana Belem Juarez Mendez
	--->
	<cffunction name="asignacionEvaluadores" hint="Muestra la vista para la evaluacion al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("EDI/asignacion/asignacionEvaluadores").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Ana Belem Juarez Mendez
	--->
	<cffunction name="asignacionInvestigadores" hint="Muestra la vista para la evaluacion al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CNSol.getProcesosEDI().getPKPROCESO();
			prc.evaluadores = CN.getAllEvaluadores(proceso);
			event.setView("EDI/asignacion/asignacionInvestigadores").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="gestionEvaluadores" hint="Muestra la vista para la gestión de evaluadores de EDI">
		<cfargument name="event" type="any">
		<cfscript>		
			prc.procesos = CN.getProcesos();			
			Request.rol = cnAdmonUsuarios.obtenerRoles();			
			Request.ur = cnAdmonUsuarios.getUr();
			Request.acron = cnAdmonUsuarios.getAcron();
			event.setView("EDI/asignacion/gestionEvaluadores").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Ana Belem Juarez Mendez
	--->
	<cffunction name="getEvaluadores" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="event" type="any">
		<cfscript>
			prc.evaluadores = CN.getEvaluadores(rc.proceso);
			prc.proceso = rc.proceso;
			event.setView("EDI/asignacion/tablaEvaluador").noLayout();
		</cfscript>
	</cffunction>


	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Ana Belem Juarez Mendez
	--->
	<cffunction name="getAsignarEvalInv" hint="Muestra todos los evaluadores">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CNSol.getProcesosEDI().getPKPROCESO();
			prc.personas = CN.getPersonasSolicitudEDI(proceso);
			event.setView("EDI/asignacion/tablaAsignarEvalInv").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Ana Belem Juarez Mendez
	--->
	<cffunction name="getAsignarInvEval" hint="Muestra todos las evaluaciones que se le pueden hacer a un investigador con base en un evaluador">
		<cfargument name="event" type="any">
		<cfscript>
			prc.tipoInvest		= deserializeJSON(rc.tipoInvest);
			prc.pkTipoInvest	= deserializeJSON(rc.pkTipoInvest);
			var proceso			= CNSol.getProcesosEDI().getPKPROCESO();
			prc.personas		= CN.getInvestigadoresConEvaluacion(rc.pkEvaluador, prc.tipoInvest, prc.pkTipoInvest, proceso);
			event.setView("EDI/asignacion/tablaAsignarInvEval").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setTipoEvaluador" hint="Asigna un tipo de evaluacion a un evaluador">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.setTipoEvaluador(rc.pkUsuario, rc.pkTipoEval, rc.pkProceso, rc.estado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEvaluador" hint="Elimina al evaluador que va a evaluar los productos de un investigador">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CNSol.getProcesosEDI().getPKPROCESO();
			resultado = CN.eliminarEvaluador(rc.pkPersona, rc.pkEvaluador, rc.pkTipoEval, proceso);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresTipo" hint="Muestra todos los usuarios para asignar a evaluar con base a un tipo de evaluacion">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CNSol.getProcesosEDI().getPKPROCESO();

			if ( rc.pkTipoEval EQ application.SIIIP_CTES.TIPOEVALUACION.RI){

				var inconformidades = CN.tieneInconformidad(rc.pkTipoEval, rc.pkPersona, proceso).PRODUCTOS[1];

				if ( inconformidades GT 0 ){
					prc.evaluadores	= CN.getEvaluadoresTipo(rc.pkTipoEval, proceso);
					prc.pkPersona	= rc.pkPersona;
					prc.pkTipoEval	= rc.pkTipoEval;
					event.setView("EDI/asignacion/modalAsignarEvalInv").noLayout();
				}else {
					event.renderData(type="json", data = 1);
				}
			}else {
				prc.evaluadores	= CN.getEvaluadoresTipo(rc.pkTipoEval, proceso);
				prc.pkPersona	= rc.pkPersona;
				prc.pkTipoEval	= rc.pkTipoEval;
				event.setView("EDI/asignacion/modalAsignarEvalInv").noLayout();
			}
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setEvaluadorInvestigador" hint="Asigna un evaluador a un investigador">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso	= CNSol.getProcesosEDI().getPKPROCESO();
			resultado	= CN.setEvaluadorInvestigador(rc.pkPersona, rc.pkEvaluador, rc.pkTipoEval, proceso);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="enviarCorreoEvaluaciones" hint="Asigna un evaluador a un investigador">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.enviarCorreoEvaluaciones(rc.pkEvaluador, rc.correo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getCorreoUsuario" hint="Asigna un evaluador a un investigador">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.getCorreoUsuario(rc.pkEvaluador);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

</cfcomponent>