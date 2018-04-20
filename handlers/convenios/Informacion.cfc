<cfcomponent >
	
	<!---
	* Descripcion:    Vista principal del usuario
	* Fecha creacion: 14/11/2017
	* @author:        Alejandro Tovar
	--->
	<cffunction name="index" access="public" returntype="void" output="false" hint="Vista principal del usuario">
		<cfscript>
			ws = CreateObject("java","testws.TestWS");
			dir = "http://www.cai.ipn.mx/php/api.php/" & #session.cbstorage.investigador.username# &"/" & #session.cbstorage.investigador.domain# & "/" & #session.cbstorage.investigador.password#;
			prc.datos = ws.getRequest(dir);

			event.setView("convenios/Informacion/V_Informacion");
		</cfscript>
	</cffunction>


	<!---
	* Descripcion:    Obtiene cartas solicitadas por el usuario
	* Fecha creacion: 14/11/2017
	* @author:        Alejandro Tovar
	--->
	<cffunction name="getTablaCartas" access="public" returntype="void" output="false" hint="Obtiene cartas solicitadas por el usuario">
		<cfscript>
			ws = CreateObject("java","testws.TestWS");
			dir = "http://www.cai.ipn.mx/php/api.php/cartas/" & rc.pkUsuario;
			prc.cartas = ws.getRequest(dir);

			event.setView("convenios/Informacion/T_Cartas").noLayout();
		</cfscript>
	</cffunction>


	<!---
	* Descripcion:    Obtiene cartas solicitadas por el usuario
	* Fecha creacion: 14/11/2017
	* @author:        Alejandro Tovar
	--->
	<cffunction name="getInfoGeneral" access="public" returntype="void" output="false" hint="Obtiene cartas solicitadas por el usuario">
		<cfscript>
			ws = CreateObject("java","testws.TestWS");
			dir = " http://www.cai.ipn.mx/php/api.php/usuarios/" & rc.pkUsuario;
			prc.usuario = ws.getRequest(dir);

			event.setView("convenios/Informacion/V_datosGenerales").noLayout();
		</cfscript>
	</cffunction>


	<!---
	* Descripcion:    Obtiene nombramientos sni del usuario
	* Fecha creacion: 14/11/2017
	* @author:        Alejandro Tovar
	--->
	<cffunction name="getInfoSni" access="public" returntype="void" output="false" hint="Obtiene nombramientos sni del usuario">
		<cfscript>
			ws = CreateObject("java","testws.TestWS");
			dir = "http://www.cai.ipn.mx/php/api.php/sni/" & rc.pkUsuario;
			prc.sni = ws.getRequest(dir);

			event.setView("convenios/Informacion/V_Sni").noLayout();
		</cfscript>
	</cffunction>


</cfcomponent>
