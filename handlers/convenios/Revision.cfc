<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Handler para el modulo de Convenios/Revision
* ================================
---->
<cfcomponent >
	<cfproperty name="cn" inject="convenios.Revision.CN_Revision">
	<cfproperty name="cnConsulta" inject="convenios.Consulta.CN_Consulta">
	 <cfproperty name="cnNuevo" inject="convenios.Nuevo.CN_Nuevo">
	
	<!---
	* Descripcion:    Carga informacion inicial para la vista de Revision
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="index" access="public" returntype="void" output="false" hint="Carga informacion inicial para la vista de Revision">
		<cfscript>
			prc.jsonArbol = cn.getClasificacionesUr(rc.tc);
			prc.tipo      = rc.tc;
			Event.setView("convenios/Revision/V_Revision");
		</cfscript>
	</cffunction>
	
	<!---
	* Descripcion:    obtiene las clasificaciones, dependecias o convenios si los hay
	* Fecha creacion: junio 2017
	* @author:        aaron quintana gomez
	--->
	<cffunction name="getClasificacionesUr" access="public"  hint="Obtiene los convenios y llena una tabla">
	<cfargument name="Event" type="any">
		<cfscript>
		  jsonArbol = cn.getClasificacionesUr(ARG_TIPO_CONVENIO);
		 
		 return jsonArbol;
		</cfscript>
	</cffunction>

	 <!---
	* Descripcion:    Obtiene la informacion del convenio por PK de convenio y su responsable
	* Fecha creacion: junio 2017
	* @author:        aaron quintana gomez 
	--->
	<cffunction name="getVistabyPKConvenioTipo" hint="Obtiene la informacion del convenio por PK de convenio y su responsable">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.Documentos = cnNuevo.obtenerDocumentosConvenio();
			switch(rc.pkTipo) {
			   case 1: // Firma electronica
					 prc.InfoConvenio = cnConsulta.getVistaFEbyPKConvenio(rc.pkConvenio);
					 Event.setView("convenios/Consulta/V_ConsultaFE").noLayout();
					 break;
				case 2: // Firma autografa
					 prc.InfoConvenio = cnConsulta.getVistaFAbyPKConvenio(rc.pkConvenio);
					 Event.setView("convenios/Consulta/V_ConsultaFA").noLayout();
					 break;
				case 3: // UC-Mexus
					 prc.InfoConvenio = cnConsulta.getVistaUCbyPKConvenio(rc.pkConvenio);
					 Event.setView("convenios/Consulta/V_ConsultaUC").noLayout();
					 break;
			}
		</cfscript>
	</cffunction>

</cfcomponent>
