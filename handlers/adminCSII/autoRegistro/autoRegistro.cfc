<cfcomponent>

	<cfproperty name="CN" inject="adminCSII.autoRegistro.CN_autoReg">

	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
	* Descripcion: Muestra la vista para capturar un participante
    --->
	<cffunction name="registrar" hint="Muestra la vista para capturar un participante">
		<cfscript>
			event.setLayout("Registro");
			prc.acron  = CN.getAcronimo();
			prc.genero = CN.getGenero();
			prc.proced = CN.getProcedencia();
			event.setView("/adminCSII/autoRegistro/autoRegistro");
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
	* Descripcion: Muesta la vista con los cursos disponibles de las vertientes
    --->
	<cffunction name="getOferta" hint="Muesta la vista con los cursos disponibles de las vertientes">
		<cfscript>
			var sicreo  = 1;
			var sisemec = 22;
			prc.sicreo  = CN.getOfertaCursos(sicreo);
			prc.sisemec = CN.getOfertaCursos(sisemec);
			event.setLayout("Registro");
			event.setView("/adminCSII/autoRegistro/ofertaCursos");
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
	* Descripcion: Registra un participante
    ---> 
	<cffunction name="registraParticipante" hint="Guarda nuevo estado relacionado a un prodedimiento">
		<cfargument name="Event" type="any">
		<cfscript>
			resultado = CN.registraParticipante(rc.acr, rc.nom,rc.pat, rc.mat, rc.gen, rc.rfc, rc.hom, rc.proc, rc.tel, rc.ext, rc.mail, rc.emp, rc.pwd, rc.rol);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
	* Descripcion: Obtiene el captcha
    ---> 
	<cffunction name="getCaptcha" hint="Obtiene procedimientos">
		<cfscript>
			event.setLayout("Registro");
			event.setView("/adminCSII/autoRegistro/captcha");
		</cfscript>
	</cffunction>


</cfcomponent>