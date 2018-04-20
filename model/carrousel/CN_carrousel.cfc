<!---
* =========================================================================
* IPN - CSII
* Sistema: SII 
* Modulo: Principal
* Sub modulo: Login
* Fecha: Marzo 2018
* Descripcion: Componente de Negocio para el manejo de los cuestiionarios
* @author GSA
* =========================================================================
--->

<cfcomponent>

	<cfproperty name="dao" inject="carrousel/DAO_carrousel">

	<cffunction name="getEje" hint="Regresa el nombre del eje" returntype="any">
		<cfargument name="eje" type="string" required="yes">
		<cfscript>
		writeOutput(eje);
			var resultado = dao.getEje(eje);
			return resultado;
		</cfscript>
	</cffunction>

	<cffunction name="getNumeroAcciones" hint="Regresa el numero de Acciones de un Eje" returntype="any">
		<cfargument name="eje" type="string" required="yes">
		<cfscript>
			var ejeNum = 1;
			if(eje eq 'E1'){
				ejeNum = 1;
			} else if(eje eq 'E2'){
				ejeNum = 2;
			} else if(eje eq 'E3'){
				ejeNum = 3;
			} else if(eje eq 'E4'){
				ejeNum = 4;
			} else if(eje eq 'E5'){
				ejeNum = 5;
			} else if(eje eq 'ET1'){
				ejeNum = 6;
			} else if(eje eq 'ET2'){
				ejeNum = 7;
			}
			var rol = Session.cbstorage.usuario.ROL;

			var resultado = dao.getNumeroAcciones(ejeNum,rol);
			return resultado;
		</cfscript>
	</cffunction>

	<cffunction name="getDatosAcciones" hint="Regresa los datos de las Acciones de un Eje" returntype="any">
		<cfargument name="eje" type="string" required="yes">
		<cfscript>

			var ejeNum = 1;
			if(eje eq 'E1'){
				ejeNum = 1;
			} else if(eje eq 'E2'){
				ejeNum = 2;
			} else if(eje eq 'E3'){
				ejeNum = 3;
			} else if(eje eq 'E4'){
				ejeNum = 4;
			} else if(eje eq 'E5'){
				ejeNum = 5;
			} else if(eje eq 'ET1'){
				ejeNum = 6;
			} else if(eje eq 'ET2'){
				ejeNum = 7;
			}
			var rol = Session.cbstorage.usuario.ROL;

			var resultado = dao.getDatosAcciones(ejeNum,rol);
			return resultado;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha creacion: Abril 02, 2018
	* @author Javier Morales Rangel
	--->
    <cffunction name="getAccionesEjesPorRol" access="public" hint="Obtiene la cantidad de acciones registradas por eje, de acuerdo al rol proporcionado" returntype="query">
		<cfargument name="rol" type="string" required="yes">
		<cfscript>
			return dao.getAccionesEjesPorRol(arguments.rol);
		</cfscript>
	</cffunction>
</cfcomponent>