<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Objeto de Acceso a Datos para el modulo convenios
* ================================
---->
<cfcomponent>

	<!---
	* Descripcion:    Obtiene los tipos de convenio
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerTiposConvenio" access="remote" returntype="query" hint="Obtiene los tipos de convenio">
		<cfquery name="result" datasource="DS_CONINV">
			SELECT TTCON.BTIP_PK_TIPO       AS PK, 
				   TTCON.BCON_NOMBRE        AS NOMBRE 
			  FROM CONINV.CINVCTIPOCONVENIO TTCON
		  ORDER BY TTCON.BCON_NOMBRE
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene Instituciones
	* Fecha creacion: 24 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerInstituciones" access="remote" returntype="query" hint="Obtiene Instituciones">
		<cfquery name="result" datasource="DS_CONINV">
			SELECT TINST.TINS_PK_INSTITUCION    AS PK, 
				   TINST.TINS_NOMBRE            AS NOMBRE,
				   TINST.TINS_UBICACION         AS UBICACION,
				   TINST.TINS_DESCRIPCION       AS DESCRIPCION
			  FROM CONINV.CINVTINSTITUCION      TINST
			  WHERE TINST.TINS_ESTADO = 2
		  ORDER BY TINST.TINS_NOMBRE
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene Modalidades
	* Fecha creacion: 6 de Febrero de 2018
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerModalidades" access="remote" returntype="query" hint="Obtiene Modalidades">
		<cfquery name="result" datasource="DS_CONINV">
			SELECT TMODA.TMOD_PK_MODALIDAD    	AS PK, 
				   TMODA.TMOD_NOMBRE            AS NOMBRE
			  FROM CONINV.CINVTMODALIDAD 	TMODA
			  WHERE TMODA.TMOD_ESTADO = 2
		  ORDER BY TMODA.TMOD_NOMBRE
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene lista del catalogo de documentos
	* Fecha creacion: 05 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerDocumentosConvenio" access="remote" returntype="query" hint="Obtiene lista del catalogo de documentos">
		<cfquery name="result" datasource="DS_CONINV">
			SELECT CDOCT.CAR_PK_ARCHIVO  AS PK, 
				   CDOCT.CAR_NOMBRE      AS NOMBRE 
			  FROM GRAL.DOCCARCHIVO      CDOCT
		  ORDER BY CDOCT.CAR_NOMBRE
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Guarda el convenio de tipo Firma Autografa
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioFirmaAutografa" access="public" returntype="numeric" hint="Guarda el convenio de tipo Firma Autografa">
		<cfargument name="tipoConvenio"     type="numeric" required="yes" hint="Tipo del convenio">
		<cfargument name="claveRegistro"    type="string"  required="yes" hint="Numero de registro del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="ur"               type="string"  required="yes" hint="Ur del convenio">
		<cfargument name="tipoConcurrencia" type="numeric" required="yes" hint="Tipo de concurrencia en el convenio">
		<cfstoredproc procedure="CONINV.P_CONVENIO.INSERTCONVENIO_FIRM_AUT" datasource="DS_CONINV">
			<cfprocparam value="#tipoConvenio#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#claveRegistro#"    cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#descripcion#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#modalidad#"        cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#instituto#"        cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#fechaInicio#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#fechaFin#"         cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#montoIpn#"         cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConcurrente#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConacyt#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoTotal#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#ur#"               cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#tipoConcurrencia#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo Firma Electronica
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioFirmaElectronica" access="public" returntype="numeric" hint="Guarda el convenio de tipo Firma Electronica">
		<cfargument name="tipoConvenio"     type="numeric" required="yes" hint="Tipo del convenio">
		<cfargument name="claveRegistro"    type="string"  required="yes" hint="Numero de registro del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="ur"               type="string"  required="yes" hint="Ur del convenio">
		<cfargument name="tipoConcurrencia" type="numeric" required="yes" hint="Tipo de concurrencia en el convenio">
		<cfargument name="montoEspacio"   	type="numeric" required="yes" hint="Monto Espacio fisico">
		<cfstoredproc procedure="CONINV.P_CONVENIO.INSERTCONVENIO_FIRM_ELEC" datasource="DS_CONINV">
			<cfprocparam value="#tipoConvenio#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#claveRegistro#"    cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#descripcion#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#modalidad#"        cfsqltype="cf_sql_string"   type="in">
			<cfif instituto gte 1>
				<cfprocparam value="#instituto#" cfsqltype="cf_sql_numeric" type="in">
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_numeric" type="in" null="yes">
			</cfif>
			<cfprocparam value="#fechaInicio#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#fechaFin#"         cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#montoIpn#"         cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConcurrente#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConacyt#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoTotal#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#ur#"               cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#tipoConcurrencia#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoEspacio#"   	cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo UCMexus
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioUCMexus" access="public" returntype="numeric" hint="Guarda el convenio de tipo UCMexus">
		<cfargument name="tipoConvenio"     type="numeric" required="yes" hint="Tipo del convenio">
		<cfargument name="claveRegistro"    type="string"  required="yes" hint="Numero de registro del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="ur"               type="string"  required="yes" hint="Ur del convenio">
		<cfstoredproc procedure="CONINV.P_CONVENIO.INSERTCONVENIO_UCMEXUS" datasource="DS_CONINV">
			<cfprocparam value="#tipoConvenio#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#claveRegistro#"    cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#descripcion#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#instituto#"        cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#fechaInicio#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#fechaFin#"         cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#montoTotal#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#ur#"               cfsqltype="cf_sql_string"   type="in">
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	* Descripcion:    Inserta la creación del convenio en el historial
	* Fecha creacion: Noviembre de 2017
	* @author:        JLGC se copio la funcionalidad de SIIIS
	--->
	<cffunction name="agregarConvenio_historial" hint="Inserta la creación del convenio en el historial">
		<cfargument name="pkConvenio"   type="numeric"  required="yes" hint="pk del convenio">
		<cfargument name="pkUsuario"    type="numeric"  required="yes" hint="pk del usuario">
		<cfargument name="nombre"       type="string"   required="yes" hint="descripcion de la accion">
		<cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.NUEVO_CONVENIO_HISTORIAL" datasource="DS_GRAL">                                       
				<cfprocparam value="#pkConvenio#"   cfsqltype="cf_sql_string"   type="in">                      
				<cfprocparam value="#pkUsuario#"    cfsqltype="cf_sql_string"   type="in">
				<cfprocparam value="#nombre#"       cfsqltype="cf_sql_string"   type="in">          
				<cfprocparam variable="respuesta"   cfsqltype="cf_sql_string"   type="out">
			</cfstoredproc>     
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Descripcion:    Edita el convenio de tipo Firma Autografa
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioFirmaAutografa" access="public" returntype="numeric" hint="Edita el convenio de tipo Firma Autografa">
		<cfargument name="pkConvenio"       type="numeric" required="yes" hint="Pk del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="concurrencia"     type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente">
		<cfstoredproc procedure="CONINV.P_CONVENIO.UPDATECONVENIO_FIRM_AUT" datasource="DS_CONINV">
			<cfprocparam value="#pkConvenio#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#descripcion#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#modalidad#"        cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#instituto#"        cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#fechaInicio#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#fechaFin#"         cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#montoIpn#"         cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConcurrente#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConacyt#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoTotal#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#concurrencia#"     cfsqltype="cf_sql_numeric"  type="in">	
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>


	<!--- 
	* Descripcion:    Edita el convenio de tipo Firma Electronica
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioFirmaElectronica" access="public" returntype="numeric" hint="Edita el convenio de tipo Firma Electronica">
		<cfargument name="pkConvenio"       type="numeric" required="yes" hint="Pk del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="tipoConcurrencia" type="numeric" required="yes" hint="Tipo de concurrencia en el convenio">
		<cfargument name="montoEspacio"   	type="numeric" required="yes" hint="Monto Espacio fisico">

		<cfstoredproc procedure="CONINV.P_CONVENIO.UPDATECONVENIO_FIRM_ELEC" datasource="DS_CONINV">
			<cfprocparam value="#pkConvenio#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#descripcion#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#modalidad#"        cfsqltype="cf_sql_string"   type="in">
			<cfif instituto gte 1>
				<cfprocparam value="#instituto#" cfsqltype="cf_sql_numeric" type="in">
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_numeric" type="in" null="yes">
			</cfif>
			<cfprocparam value="#fechaInicio#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#fechaFin#"         cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#montoIpn#"         cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConcurrente#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoConacyt#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoTotal#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#tipoConcurrencia#" cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#montoEspacio#"     cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	* Descripcion:    Edita el convenio de tipo UCMexus
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioUCMexus" access="public" returntype="numeric" hint="Edita el convenio de tipo UCMexus">
		<cfargument name="pkConvenio"       type="numeric" required="yes" hint="Pk del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfstoredproc procedure="CONINV.P_CONVENIO.UPDATECONVENIO_UCMEXUS" datasource="DS_CONINV">
			<cfprocparam value="#pkConvenio#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#descripcion#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#instituto#"        cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#fechaInicio#"      cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#fechaFin#"         cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#montoTotal#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	* Descripcion:    Agrega un responsable
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarResponsable" access="public" returntype="numeric" hint="Agrega un responsable">
		<cfargument name="numEmpleado"      type="numeric"  required="yes" hint="Numero de empleado">
		<cfargument name="nombre"           type="string"   required="yes" hint="Nombre de responsable">
		<cfargument name="paterno"          type="string"   required="yes" hint="Apellido paterno del responsable">
		<cfargument name="materno"          type="string"   required="yes" hint="Apellido materno del responsable">
		<cfargument name="correo"           type="string"   required="yes" hint="Correo del respnsable">
		<cfargument name="extension"        type="numeric"  required="yes" hint="Extensio del responsable">
		<cfargument name="pkGrado"          type="numeric"  required="yes" hint="pk del grado del responsable">
		<cfargument name="pkCarrera"        type="numeric"  required="yes" hint="pk de la carrera del responsable">
		<cfargument name="sexo"             type="numeric"  required="yes" hint="sexo del responsable">
		<cfargument name="pkUR"             type="string"   required="yes" hint="UR del responsable">
		<cfargument name="pkConvenio"       type="numeric"  required="yes" hint="pk del convenio">
		<cfstoredproc procedure="CONINV.P_CONVENIO.INSERTNUEVO_RESPONSABLE" datasource="DS_CONINV">
			<cfprocparam value="#numEmpleado#"      cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#nombre#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#paterno#"          cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#materno#"          cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#correo#"           cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#extension#"        cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#pkGrado#"          cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#pkCarrera#"        cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#sexo#"             cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam value="#pkUR#"             cfsqltype="cf_sql_string"   type="in">
			<cfprocparam value="#pkConvenio#"       cfsqltype="cf_sql_numeric"  type="in">
			<cfprocparam variable="resultado"       cfsqltype="cf_sql_numeric"  type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

</cfcomponent>