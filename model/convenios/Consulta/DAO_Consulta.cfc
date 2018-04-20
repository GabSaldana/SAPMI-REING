<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Objeto de Acceso a Datos para el modulo convenios/consulta
* ================================
---->
<cfcomponent>

	<!---
	* @author: Mauricio Argueta Macías
	* Modificación : Reescritura de sentencia
	*Fecha: 06 de junio del 2017
	*********************************************************
	* Descripcion:    Obtiene el listado de los convenios
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkEstado, PK del Estado 
	*                 pkClasif, PK de la clasificacion
	*                 pkUR, PK de la UR   
	--->
	<cffunction name="getTablaConvenios" access="public" returntype="query" hint="Obtiene el listado de los convenios">
		<cfargument name="tipo"      type="numeric" required="true" hint="Tipo de convenio"> 
		<cfargument name="numEstado" type="numeric" required="true" hint="Numero del Estado"> 
		<cfargument name="pkClasif"  type="string"  required="true" hint="PK de la clasificacion"> 
		<cfargument name="pkUR"      type="string"  required="true" hint="PK de la UR"> 
		<cfquery name="result" datasource="DS_CONINV">
			SELECT TURCL.TUC_FK_CLASIFICACION                                 AS PKCL, 
						 TCONV.TCON_CLAVE                                           AS REGISTRO,
						 TCONV.TCON_PK_CONVENIO                                     AS PK,
						 TCONV.BTIP_FK1_TIPO                                        AS FKTIPO,
						 TCONV.TRES_FK2_RESPONSABLE                                 AS FKRESPONSABLE,
						 TCONV.TINS_FK3_INSTITUCION                                 AS FKINSTITUCION,
						 TCONV.TCON_NOMBRE                                          AS NOMBRE,
						 TCONV.TCON_DESCRIPCION                                     AS DESCRIPCION,
						 (SYSDATE - TCONV.TCON_FECHA_CREACION) * 24 * 60            AS TIEMPOACTIVO,
						 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD.MON.YYYY' )          AS CONFECHAVIGINI,
						 TO_CHAR( TCONV.TCON_FECHA_FIN,    'DD.MON.YYYY' )          AS CONFECHAVIGFIN,
						 TO_CHAR( TCONV.TCON_MONTO_TOTAL,  'FM$999,999,999,999.00') AS CONMONTOTOTAL,
						 TCONV.TCON_FK4_UR                                          AS FKUR,
						 BTIPO.BCON_NOMBRE                                          AS NOMBRETIPO,
						 TCONV.TCON_FK1_ESTADO                                      AS CESESTADO,
						 TCONV.TCON_FK5_RUTA                                        AS CESRUTA,
						 ESTAD.CER_NUMERO_ESTADO                                    AS NUMEROESTADO,
						 ESTAD.CER_NOMBRE                                           AS NOMBREESTADO,
						 TCONV.TCON_REGISTRO_SIP									AS REGISTRO_SIP
				FROM CONINV.CINVCTIPOCONVENIO        BTIPO,
						 CONINV.CINVTCONVENIO            TCONV,
						 UR.TUR_TURCLASIFICACION@DBL_UR  TURCL,
						 GRAL.CESCESTADO                 ESTAD
			 WHERE TURCL.TUC_FK_UR(+)    = TCONV.TCON_FK4_UR 
				 AND TCONV.BTIP_FK1_TIPO   = BTIPO.BTIP_PK_TIPO
				 AND TCONV.TCON_FK1_ESTADO = ESTAD.CER_PK_ESTADO
				 AND TCONV.TCON_FK1_ESTADO <> 141
				 AND TCONV.TCON_FK1_ESTADO <> 152
				<cfif tipo NEQ 0>
						AND TCONV.BTIP_FK1_TIPO        = <cfqueryparam value="#tipo#" cfsqltype="cf_sql_numeric">
				</cfif>
				<cfif numEstado NEQ 0>
						AND ESTAD.CER_NUMERO_ESTADO    = <cfqueryparam value="#numEstado#" cfsqltype="cf_sql_numeric">
				</cfif>
				<cfif pkClasif NEQ 0>
						AND TURCL.TUC_FK_CLASIFICACION = <cfqueryparam value="#pkClasif#" cfsqltype="cf_sql_string">
				</cfif>
				<cfif pkUR NEQ 0>
						AND TCONV.TCON_FK4_UR          = <cfqueryparam value="#pkUR#"     cfsqltype="cf_sql_string">
				</cfif>
			ORDER BY TCONV.TCON_PK_CONVENIO DESC, TCONV.TCON_FK1_ESTADO 
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	--->
	<cffunction name="getVistaFEbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK de convenio">
		<cfquery name="qfkInstitucion" datasource="DS_CONINV">
			SELECT  NVL(CONVENIO.TINS_FK3_INSTITUCION,0) AS FKINSTITUCION
			FROM    CONINV.CINVTCONVENIO CONVENIO
			WHERE   CONVENIO.TCON_PK_CONVENIO = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
		</cfquery>

		<cfquery name="result" datasource="DS_CONINV">
				SELECT TCONV.TCON_CLAVE                                             AS CONREGISTRO,
							 TCONV.TCON_PK_CONVENIO                                       AS CONPK,
							 TCONV.TCON_NOMBRE                                            AS CONNOMBRE,
							 TCONV.TCON_DESCRIPCION                                       AS CONDESCRIPCION,
							 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD.MON.YYYY' )            AS CONFECHAVIGINI,
							 TO_CHAR( TCONV.TCON_FECHA_FIN,    'DD.MON.YYYY' )            AS CONFECHAVIGFIN,
							 TO_CHAR( TCONV.TCON_MONTO_EFECTIVO, 'FM$999,999,999,999.00') AS CONMONTOLIQUIDO,
							 TO_CHAR( TCONV.TCON_MONTO_ESPECIE,  'FM$999,999,999,999.00') AS CONMONTOESPECIE,
							 TO_CHAR( TCONV.TCON_MONTO_CONACYT,  'FM$999,999,999,999.00') AS CONMONTOCONACYT,
							 TO_CHAR( TCONV.TCON_MONTO_TOTAL,    'FM$999,999,999,999.00') AS CONMONTOTOTAL,
							 TO_CHAR( TCONV.TCON_MONTO_ESPFISICO,'FM$999,999,999,999.00') AS CONMONTOESPACIO,
							 TCONV.TCON_MODALIDAD                                         AS CONMODALIDAD,
							 TTCON.BCON_NOMBRE                                            AS CONNOMBRETIPO,
							 <cfif qfkInstitucion.FKINSTITUCION NEQ 0>
							 	TINST.TINS_NOMBRE                                            AS CONNOMBREINSTITUCION,
							 </cfif>
							 TMODA.TMOD_NOMBRE                                            AS CONNOMBREMODALIDAD,
							 TRESP.TRES_PK_RESPONSABLE                                    AS RESPK,
							 TRESP.TEMP_FK5_NUM_EMPLEADO                                  AS RESNUMEMPLEADO,
							 TRESP.TRESP_NOMBRE                                           AS RESNOMBRE,
							 TRESP.TRES_AP_PATERNO                                        AS RESPATERNO,
							 TRESP.TRES_AP_MATERNO                                        AS RESMATERNO,
							 TRESP.TRESP_NOMBRE|| ' ' ||TRESP.TRES_AP_PATERNO|| ' ' ||TRESP.TRES_AP_MATERNO AS RESNOMBRECOMPLETO,
							 TRESP.TRES_EXTENSION                                         AS RESEXTENSION,
							 TRESP.TRESP_MAIL                                             AS RESMAIL,
							 CGRAD.CAC_ACRONIMO                                           AS RESGRADO,
							 CCARR.CCAR_NOMBRE                                            AS RESCARRERA,
							 CSEXO.CGE_GENERO_NOMBRE                                      AS RESSEXO,
							 TURDE.TUR_NOMBRE                                             AS RESDEPENDENCIA,
							 TCONV.BTIP_FK1_TIPO                                          AS CONTIPO,
							 TCONV.TCON_FK1_ESTADO                                        AS CESESTADO,
							 TCONV.TCON_FK5_RUTA                                          AS CESRUTA,
							 TCONV.TCON_FK_TIPOCONCURRENCIA 							  AS CONCURRENCIA,
						 	 TCONV.TCON_REGISTRO_SIP									  AS REGISTRO_SIP
					FROM GRAL.GRALCACRONIMO       CGRAD,
							 CONINV.CINVCCARRERA      CCARR,
							 GRAL.GRALCGENERO         CSEXO,
							 UR.TURIPN@DBL_UR         TURDE, 
							 CONINV.CINVCTIPOCONVENIO TTCON,
							 <cfif qfkInstitucion.FKINSTITUCION NEQ 0>
							 	CONINV.CINVTINSTITUCION  TINST,		 	
							 </cfif>
							 CONINV.CINVTMODALIDAD    TMODA,
							 CONINV.CINVTRESPONSABLE  TRESP,
							 CONINV.CINVTCONVENIO     TCONV
				 WHERE CGRAD.CAC_PK_ACRONIMO(+)      = TRESP.CGRA_FK1_GRADO
					 AND CCARR.CCAR_PK_CARRERA(+)      = TRESP.CCAR_FK2_CARRERA
					 AND CSEXO.CGE_PK_GENERO(+)        = TRESP.CSEX_FK4_SEXO
					 AND TURDE.TUR_PK_UR(+)            = TRESP.TUR_FK6_UR
					 AND TTCON.BTIP_PK_TIPO            = TCONV.BTIP_FK1_TIPO
					 <cfif qfkInstitucion.FKINSTITUCION NEQ 0>
					 	AND TCONV.TINS_FK3_INSTITUCION    = TINST.TINS_PK_INSTITUCION
					 </cfif>
					 AND TCONV.TCON_MODALIDAD		   = TMODA.TMOD_PK_MODALIDAD
					 AND TCONV.TRES_FK2_RESPONSABLE    = TRESP.TRES_PK_RESPONSABLE(+)
					 AND TCONV.TCON_FK1_ESTADO         <> 141
					 AND TCONV.TCON_FK1_ESTADO         <> 152
					 AND TCONV.TCON_PK_CONVENIO        = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	--->
	<cffunction name="getVistaFAbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio">
			<cfargument name="pkConvenio" type="numeric" required="true" hint="PK de convenio"> 
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TCONV.TCON_CLAVE                                             AS CONREGISTRO,
								 TCONV.TCON_PK_CONVENIO                                       AS CONPK,
								 TCONV.TCON_NOMBRE                                            AS CONNOMBRE,
								 TCONV.TCON_DESCRIPCION                                       AS CONDESCRIPCION,
								 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD.MON.YYYY' )            AS CONFECHAVIGINI,
								 TO_CHAR( TCONV.TCON_FECHA_FIN,    'DD.MON.YYYY' )            AS CONFECHAVIGFIN,
								 TO_CHAR( TCONV.TCON_MONTO_EFECTIVO, 'FM$999,999,999,999.00') AS CONMONTOLIQUIDO,
								 TO_CHAR( TCONV.TCON_MONTO_ESPECIE,  'FM$999,999,999,999.00') AS CONMONTOESPECIE,
								 TO_CHAR( TCONV.TCON_MONTO_CONACYT,  'FM$999,999,999,999.00') AS CONMONTOCONACYT,
								 TO_CHAR( TCONV.TCON_MONTO_TOTAL,    'FM$999,999,999,999.00') AS CONMONTOTOTAL,
								 TCONV.TCON_MODALIDAD                                         AS CONMODALIDAD,
								 TTCON.BCON_NOMBRE                                            AS CONNOMBRETIPO,
								 TINST.TINS_NOMBRE                                            AS CONNOMBREINSTITUCION,
								 TMODA.TMOD_NOMBRE                                            AS CONNOMBREMODALIDAD,
								 TRESP.TRES_PK_RESPONSABLE                                    AS RESPK,
								 TRESP.TEMP_FK5_NUM_EMPLEADO                                  AS RESNUMEMPLEADO,
								 TRESP.TRESP_NOMBRE                                           AS RESNOMBRE,
								 TRESP.TRES_AP_PATERNO                                        AS RESPATERNO,
								 TRESP.TRES_AP_MATERNO                                        AS RESMATERNO,
								 TRESP.TRESP_NOMBRE|| ' ' ||TRESP.TRES_AP_PATERNO|| ' ' ||TRESP.TRES_AP_MATERNO AS RESNOMBRECOMPLETO,
								 TRESP.TRES_EXTENSION                                         AS RESEXTENSION,
								 TRESP.TRESP_MAIL                                             AS RESMAIL,
								 CGRAD.CAC_ACRONIMO                                           AS RESGRADO,
								 CCARR.CCAR_NOMBRE                                            AS RESCARRERA,
								 CSEXO.CGE_GENERO_NOMBRE                                      AS RESSEXO,
								 TURDE.TUR_NOMBRE                                             AS RESDEPENDENCIA,
								 TCONV.BTIP_FK1_TIPO                                          AS CONTIPO,
								 TCONV.TCON_FK1_ESTADO                                        AS CESESTADO,
								 TCONV.TCON_FK5_RUTA                                          AS CESRUTA,
								 TCONV.TCON_FK_TIPOCONCURRENCIA								  AS CONCURRENCIA,
							 	 TCONV.TCON_REGISTRO_SIP									  AS REGISTRO_SIP
						FROM GRAL.GRALCACRONIMO       CGRAD,
								 CONINV.CINVCCARRERA      CCARR,
								 GRAL.GRALCGENERO         CSEXO,
								 UR.TURIPN@DBL_UR         TURDE, 
								 CONINV.CINVCTIPOCONVENIO TTCON,
								 CONINV.CINVTINSTITUCION  TINST,
								 CONINV.CINVTMODALIDAD    TMODA,
								 CONINV.CINVTRESPONSABLE  TRESP,
								 CONINV.CINVTCONVENIO     TCONV
					 WHERE CGRAD.CAC_PK_ACRONIMO(+)      = TRESP.CGRA_FK1_GRADO
						 AND CCARR.CCAR_PK_CARRERA(+)      = TRESP.CCAR_FK2_CARRERA
						 AND CSEXO.CGE_PK_GENERO(+)        = TRESP.CSEX_FK4_SEXO
						 AND TURDE.TUR_PK_UR(+)            = TRESP.TUR_FK6_UR
						 AND TTCON.BTIP_PK_TIPO            = TCONV.BTIP_FK1_TIPO
						 AND TCONV.TINS_FK3_INSTITUCION    = TINST.TINS_PK_INSTITUCION
						 AND TCONV.TCON_MODALIDAD		   = TMODA.TMOD_PK_MODALIDAD
						 AND TCONV.TRES_FK2_RESPONSABLE    = TRESP.TRES_PK_RESPONSABLE(+)
						 AND TCONV.TCON_FK1_ESTADO         <> 141
						 AND TCONV.TCON_FK1_ESTADO         <> 152
						 AND TCONV.TCON_PK_CONVENIO        = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
			</cfquery>
			<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	--->
	<cffunction name="getVistaUCbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio">
			<cfargument name="pkConvenio" type="numeric" required="true" hint="PK de convenio"> 
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TCONV.TCON_CLAVE                                             AS CONREGISTRO,
								 TCONV.TCON_PK_CONVENIO                                       AS CONPK,
								 TCONV.TCON_NOMBRE                                            AS CONNOMBRE,
								 TCONV.TCON_DESCRIPCION                                       AS CONDESCRIPCION,
								 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD.MON.YYYY' )            AS CONFECHAVIGINI,
								 TO_CHAR( TCONV.TCON_FECHA_FIN,    'DD.MON.YYYY' )            AS CONFECHAVIGFIN,
								 TO_CHAR( TCONV.TCON_MONTO_EFECTIVO, 'FM$999,999,999,999.00') AS CONMONTOLIQUIDO,
								 TO_CHAR( TCONV.TCON_MONTO_ESPECIE,  'FM$999,999,999,999.00') AS CONMONTOESPECIE,
								 TO_CHAR( TCONV.TCON_MONTO_CONACYT,  'FM$999,999,999,999.00') AS CONMONTOCONACYT,
								 TO_CHAR( TCONV.TCON_MONTO_TOTAL,    'FM$999,999,999,999.00') AS CONMONTOTOTAL,
								 TCONV.TCON_MODALIDAD                                         AS CONMODALIDAD,
								 TTCON.BCON_NOMBRE                                            AS CONNOMBRETIPO,
								 TINST.TINS_NOMBRE                                            AS CONNOMBREINSTITUCION,
								 TRESP.TRES_PK_RESPONSABLE                                    AS RESPK,
								 TRESP.TEMP_FK5_NUM_EMPLEADO                                  AS RESNUMEMPLEADO,
								 TRESP.TRESP_NOMBRE                                           AS RESNOMBRE,
								 TRESP.TRES_AP_PATERNO                                        AS RESPATERNO,
								 TRESP.TRES_AP_MATERNO                                        AS RESMATERNO,
								 TRESP.TRESP_NOMBRE|| ' ' ||TRESP.TRES_AP_PATERNO|| ' ' ||TRESP.TRES_AP_MATERNO AS RESNOMBRECOMPLETO,
								 TRESP.TRES_EXTENSION                                         AS RESEXTENSION,
								 TRESP.TRESP_MAIL                                             AS RESMAIL,
								 CGRAD.CAC_ACRONIMO                                           AS RESGRADO,
								 CCARR.CCAR_NOMBRE                                            AS RESCARRERA,
								 CSEXO.CGE_GENERO_NOMBRE                                      AS RESSEXO,
								 TURDE.TUR_NOMBRE                                             AS RESDEPENDENCIA,
								 TCONV.BTIP_FK1_TIPO                                          AS CONTIPO,
								 TCONV.TCON_FK1_ESTADO                                        AS CESESTADO,
								 TCONV.TCON_FK5_RUTA                                          AS CESRUTA,
							 	 TCONV.TCON_REGISTRO_SIP									  AS REGISTRO_SIP
						FROM GRAL.GRALCACRONIMO       CGRAD,
								 CONINV.CINVCCARRERA      CCARR,
								 GRAL.GRALCGENERO         CSEXO,
								 UR.TURIPN@DBL_UR         TURDE, 
								 CONINV.CINVCTIPOCONVENIO TTCON,
								 CONINV.CINVTINSTITUCION  TINST,
								 CONINV.CINVTRESPONSABLE  TRESP,
								 CONINV.CINVTCONVENIO     TCONV
					 WHERE CGRAD.CAC_PK_ACRONIMO(+)      = TRESP.CGRA_FK1_GRADO
						 AND CCARR.CCAR_PK_CARRERA(+)      = TRESP.CCAR_FK2_CARRERA
						 AND CSEXO.CGE_PK_GENERO(+)        = TRESP.CSEX_FK4_SEXO
						 AND TURDE.TUR_PK_UR(+)            = TRESP.TUR_FK6_UR
						 AND TTCON.BTIP_PK_TIPO            = TCONV.BTIP_FK1_TIPO
						 AND TCONV.TINS_FK3_INSTITUCION    = TINST.TINS_PK_INSTITUCION
						 AND TCONV.TRES_FK2_RESPONSABLE    = TRESP.TRES_PK_RESPONSABLE(+)
						 AND TCONV.TCON_FK1_ESTADO         <> 141
						 AND TCONV.TCON_FK1_ESTADO         <> 152
						 AND TCONV.TCON_PK_CONVENIO        = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
			</cfquery>
			<cfreturn result>
	</cffunction>
		 
	<!---
	* Descripcion:    Obtiene el empleado por el numero de empleado
	* Fecha creacion: 06 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         numEmpleado, Numero de empleado
	--->
	<cffunction name="obtenerEmpleadoByNumEmpleado" access="public" returntype="query" hint="Obtiene el empleado por el numero de empleado">
			<cfargument name="numEmpleado" type="numeric" required="yes" hint="Numero de empleado"> 
			<cfquery name="result" datasource="DS_CONINV">
					SELECT DISTINCT PERSONA.TPE_PK_PERSONA  AS PK,
								 PERSONA.TPE_NUM_EMPLEADO         AS NUMEMPLEADO,
								 PERSONA.TPE_PATERNO              AS PATERNO,
								 PERSONA.TPE_MATERNO              AS MATERNO,
								 PERSONA.TPE_NOMBRE               AS NOMBRE,
								 LURS.TUR_PK_UR                   AS FKUR,
								 LURS.TUR_SIGLA                   AS SIGLAS,
								 LURS.TUR_NOMBRE                  AS DEPENDENCIA,
								 PERSONA.TPE_FK_SEXO              AS FKSEXO,
								 ''                               AS EMAIL,
								 ''                               AS EXTENSION,
								 ''                               AS PKGRADO,
								 ''                               AS PKCARRERA
						FROM SIGADGCH.TPERSONA@DBL_SIGADGCH       PERSONA,
								 SIGADGCH.TPERSONA_PLAZA@DBL_SIGADGCH PLAZA,
								 UR.TUR_TZONAPAGO@DBL_UR              ZONA,
								 UR.TUR@DBL_UR                        LURS,
								 GRAL.GRALCGENERO                     GEN
					WHERE PERSONA.TPE_FK_ESTATUS > 0
						 AND PERSONA.TPE_FK_TIPO_EMPLEADO = 1
						 AND PERSONA.TPE_NUM_EMPLEADO = <cfqueryparam value="#numEmpleado#" cfsqltype="cf_sql_numeric">
						 --AND ZONA.TZP_FECHAFIN IS NULL
						 --AND LURS.TUR_FK_TIMEFINVIGENCIA IS NULL
						 --AND LURS.TUR_FINVIGENCIA IS NULL
						 AND LURS.TUR_PK_UR = LURS.TUR_FK_UR_PADRE
						 AND PERSONA.TPE_PK_PERSONA = PLAZA.TPI_FK_PERSONA
						 AND PLAZA.TPI_FK_ZONAPAGO = ZONA.TZP_CLAVE
						 AND ZONA.TZP_FK_UR = LURS.TUR_PK_UR
						 --AND GEN.CGE_PK_GENERO = PERSONA.TPE_FK_SEXO
						 --AND PERSONA.TPE_FK_UR_CAPTURA = LURS.TUR_PK_UR
			</cfquery>
			<cfreturn result>
	</cffunction>

	<!---
	* Descripcion de la modificacion: Se agrego una condicional, para filtrar clasificaciones vigentes
	* Fecha modificacion: 1 de Junio del 2017
	* Autor modificacion:  Mauricio Argueta Macías
	* -------------------------------------
	* Descripcion:    Obtiene clasificacion UR
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerURClasificacion" access="public" returntype="query" hint="Obtiene clasificacion UR">
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TURCL.CLA_PK_CLASIFICACION AS PK, 
								 TURCL.CLA_CLASIFICACION    AS NOMBRE
						FROM UR.CUR_CLASIFICACION@DBL_UR TURCL
					 WHERE TURCL.CLA_PK_CLASIFICACION IN (
												 SELECT UNIQUE(TUC_FK_CLASIFICACION) 
													 FROM UR.TUR_TURCLASIFICACION@DBL_UR
													WHERE TUC_FK_TIMEFINVIGENCIA IS NULL)
				ORDER BY TURCL.CLA_CLASIFICACION
			</cfquery>
			<cfreturn result>
	</cffunction>

	<!---
	* Descripcion de la modificacion: Se agrego una condicional, para filtrar UR vigentes
	* Fecha modificacion: 1 de Junio del 2017
	* Autor modificacion:  Mauricio Argueta Macías
	* -------------------------------------
	* Descripcion:    Obtiene UR's por clasificacion
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkURClasificacion, PK de clasificacion UR  
	--->
	<cffunction name="obtenerURbyClasificacion" access="remote" returntype="query" hint="Obtiene UR's por clasificacion">
			<cfargument name="pkURClasificacion" type="string" required="yes" hint="PK de clasificacion UR"> 
			<cfquery name="result" datasource="DS_CONINV">
		SELECT  TURDE.TUR_PK_UR  AS PK,
						TURDE.TUR_NOMBRE AS NOMBRE, 
						TURDE.CLASE      AS CLASIFICACION
			FROM  UR.TURIPN@DBL_UR TURDE
		 WHERE  TURDE.FK_DWFINVIGENCIA IS NULL
			 AND  TURDE.CLASE = <cfqueryparam value="#pkURClasificacion#" cfsqltype="cf_sql_varchar">
	ORDER BY  TURDE.TUR_NOMBRE
			</cfquery>
			<cfreturn result>
	</cffunction>
 
	<!---
	* Descripcion:    Obtiene lista de estados
	* Fecha creacion: 12 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerEstados" access="public" returntype="query" hint="Obtiene lista de estados">
			<cfargument name="rutaConvenio" type="numeric" required="yes" hint="Ruta del convenio"> 
			<cfquery name="result" datasource="DS_CONINV">
						SELECT EDOS.CER_NUMERO_ESTADO AS NUMERO, 
									 EDOS.CER_NOMBRE        AS NOMBRE
							FROM GRAL.CESCESTADO EDOS
						 WHERE EDOS.CER_NUMERO_ESTADO > 0
							 AND EDOS.CER_FK_RUTA = <cfqueryparam value="#rutaConvenio#" cfsqltype="cf_sql_numeric">
					ORDER BY EDOS.CER_NUMERO_ESTADO
			</cfquery>
			<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Edita un convenio existente de la tabla CONINV.CINVTCONVENIO
	* Fecha creacion: 25 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarConvenio" access="public" returntype="numeric" hint="Edita un convenio existente de la tabla CONINV.CINVTCONVENIO">
			<cfargument name="PK"            type="numeric" required="yes" hint="Campo: TCON_PK_CONVENIO">
			<cfargument name="FKTIPO"        type="numeric" required="yes" hint="Campo: BTIP_FK1_TIPO">
			<cfargument name="FKINSTITUCION" type="numeric" required="yes" hint="Campo: TINS_FK3_INSTITUCION">
			<cfargument name="NOMBRE"        type="string"  required="yes" hint="Campo: TCON_NOMBRE">
			<cfargument name="DESCRIPCION"   type="string"  required="yes" hint="Campo: TCON_DESCRIPCION">
			<cfargument name="FECHAVIGINI"   type="string"  required="yes" hint="Campo: TCON_FECHA_INICIO">
			<cfargument name="FECHAVIGFIN"   type="string"  required="yes" hint="Campo: TCON_FECHA_FIN">
			<cfargument name="MONTOLIQUIDO"  type="numeric" required="yes" hint="Campo: TCON_MONTO_EFECTIVO">
			<cfargument name="MONTOESPECIE"  type="numeric" required="yes" hint="Campo: TCON_MONTO_ESPECIE">
			<cfargument name="MONTOCONACYT"  type="numeric" required="yes" hint="Campo: TCON_MONTO_CONACYT">
			<cfargument name="MONTOTOTAL"    type="numeric" required="yes" hint="Campo: TCON_MONTO_TOTAL">

			<cfstoredproc procedure="CONINV.P_CONVENIO.UPDATECONVENIO" datasource="DS_CONINV">
					<cfprocparam value="#PK#"            cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#FKTIPO#"        cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#FKINSTITUCION#" cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#NOMBRE#"        cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#DESCRIPCION#"   cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#FECHAVIGINI#"   cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#FECHAVIGFIN#"   cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#MONTOLIQUIDO#"  cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#MONTOESPECIE#"  cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#MONTOCONACYT#"  cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#MONTOTOTAL#"    cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam variable="P_RESULTADO"  cfsqltype="cf_sql_numeric"  type="out">
					</cfstoredproc>
			<cfreturn P_RESULTADO>
	</cffunction>

	<!---
	* Descripcion:       Edita un responsable existente de la table CONINV.CINVTRESPONSABLE
	* Fecha creacion:     30 de mayo de 2017
	* Fecha modificacion: 06 de junio de 2017
	*                     Se incluye a la edicion el NOMBRE, PATERNO y MATERNO   
	* @author:            Jose Luis Granados Chavez
	--->
	<cffunction name="editarResponsable" access="public" returntype="numeric" hint="Edita un responsable existente de la table CONINV.CINVTRESPONSABLE">
			<cfargument name="PK"        type="numeric" required="yes" hint="Campo: TRES_PK_RESPONSABLE">
			<cfargument name="NOMBRE"    type="string"  required="yes" hint="Campo: TRESP_NOMBRE">
			<cfargument name="PATERNO"   type="string"  required="yes" hint="Campo: TRES_AP_PATERNO">
			<cfargument name="MATERNO"   type="string"  required="yes" hint="Campo: TRES_AP_MATERNO">
			<cfargument name="EXTENSION" type="numeric" required="yes" hint="Campo: TRES_EXTENSION">

			<cfstoredproc procedure="CONINV.P_CONVENIO.UPDATERESPONSABLE" datasource="DS_CONINV">
					<cfprocparam value="#PK#"            cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#NOMBRE#"        cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#PATERNO#"       cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#MATERNO#"       cfsqltype="cf_sql_string"   type="in">
					<cfprocparam value="#EXTENSION#"     cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam variable="P_RESULTADO"  cfsqltype="cf_sql_numeric"  type="out">
					</cfstoredproc>
			<cfreturn P_RESULTADO>
	</cffunction>

	<!---
	* Descripcion:    Edita el responsable existente en el convenio de la tabla CONINV.CINVTCONVENIO
	* Fecha creacion: 30 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarConvenioConResponsable" access="public" returntype="numeric" hint="Edita el responsable existente en el convenio de la tabla CONINV.CINVTCONVENIO">
			<cfargument name="PK"            type="numeric" required="yes" hint="Campo: TRES_PK_RESPONSABLE">
			<cfargument name="FKRESPONSABLE" type="string" required="yes" hint="Campo: TEMP_FK5_NUM_EMPLEADO">

			<cfstoredproc procedure="CONINV.P_CONVENIO.UPDATECONVENIORESPONSABLE" datasource="DS_CONINV">
					<cfprocparam value="#PK#"            cfsqltype="cf_sql_numeric"  type="in">
					<cfprocparam value="#FKRESPONSABLE#" cfsqltype="cf_sql_string"   type="in">
					<cfprocparam variable="P_RESULTADO"  cfsqltype="cf_sql_numeric"  type="out">
					</cfstoredproc>
			<cfreturn P_RESULTADO>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	<cffunction name="getEditarFEbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio">
			<cfargument name="pkConvenio" type="numeric" required="true" hint="PK de convenio"> 
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TCONV.TCON_CLAVE                                             AS CONREGISTRO,
								 TCONV.TCON_PK_CONVENIO                                       AS CONPK,
								 TCONV.TCON_NOMBRE                                            AS CONNOMBRE,
								 TCONV.TCON_DESCRIPCION                                       AS CONDESCRIPCION,
								 TCONV.TCON_MODALIDAD                                         AS CONMODALIDAD,
								 TCONV.TINS_FK3_INSTITUCION                                   AS CONINSTITUCION,
								 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD/MM/YYYY' )             AS CONFECHAVIGINI,
								 TO_CHAR( TCONV.TCON_FECHA_FIN, 'DD/MM/YYYY' )                AS CONFECHAVIGFIN,
								 TCONV.TCON_MONTO_EFECTIVO                                    AS CONMONTOLIQUIDO,
								 TCONV.TCON_MONTO_ESPECIE                                     AS CONMONTOESPECIE,
								 TCONV.TCON_MONTO_CONACYT                                     AS CONMONTOCONACYT,
								 TCONV.TCON_MONTO_TOTAL                                       AS CONMONTOTOTAL,
								 TRESP.TRES_PK_RESPONSABLE                                    AS RESPK,
								 TRESP.TEMP_FK5_NUM_EMPLEADO                                  AS RESNUMEMPLEADO,
								 TRESP.TRESP_NOMBRE                                           AS RESNOMBRE,
								 TRESP.TRES_AP_PATERNO                                        AS RESAPATERNO,
								 TRESP.TRES_AP_MATERNO                                        AS RESAMATERNO,
								 TRESP.TRES_EXTENSION                                         AS RESEXTENSION,
								 TRESP.TRESP_MAIL                                             AS RESMAIL,
								 TRESP.CGRA_FK1_GRADO                                         AS RESPKGRADO,
								 CGRAD.CAC_ACRONIMO                                           AS RESGRADO,
								 TRESP.CCAR_FK2_CARRERA                                       AS RESPKCARRERA,
								 CCARR.CCAR_NOMBRE                                            AS RESCARRERA,
								 TRESP.CSEX_FK4_SEXO                                          AS RESPKSEXO,
								 CSEXO.CGE_GENERO_NOMBRE                                      AS RESSEXO,
								 TRESP.TUR_FK6_UR                                             AS RESPKUR,
								 TURDE.TUR_NOMBRE                                             AS RESDEPENDENCIA,
								 TCONV.TCON_FK_TIPOCONCURRENCIA								  AS CONCURRENCIA,
								 TCONV.TCON_MONTO_ESPFISICO									  AS CONMONTOESPACIO,
							 	 TCONV.TCON_REGISTRO_SIP									  AS REGISTRO_SIP
						FROM GRAL.GRALCACRONIMO       CGRAD,
								 CONINV.CINVCCARRERA      CCARR,
								 GRAL.GRALCGENERO         CSEXO,
								 UR.TURIPN@DBL_UR         TURDE,
								 CONINV.CINVTRESPONSABLE  TRESP,
								 CONINV.CINVTCONVENIO     TCONV
					 WHERE CGRAD.CAC_PK_ACRONIMO(+)      = TRESP.CGRA_FK1_GRADO
						 AND CCARR.CCAR_PK_CARRERA(+)      = TRESP.CCAR_FK2_CARRERA
						 AND CSEXO.CGE_PK_GENERO(+)        = TRESP.CSEX_FK4_SEXO
						 AND TURDE.TUR_PK_UR(+)            = TRESP.TUR_FK6_UR
						 AND TCONV.TRES_FK2_RESPONSABLE    = TRESP.TRES_PK_RESPONSABLE(+)
						 AND TCONV.TCON_FK1_ESTADO         <> 141
						 AND TCONV.TCON_FK1_ESTADO         <> 152
						 AND TCONV.TCON_PK_CONVENIO        = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
			</cfquery>
			<cfreturn result>
	</cffunction>

	 <!---
	* Descripcion:    Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	<cffunction name="getEditarFAbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio">
			<cfargument name="pkConvenio" type="numeric" required="true" hint="PK de convenio"> 
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TCONV.TCON_CLAVE                                             AS CONREGISTRO,
								 TCONV.TCON_PK_CONVENIO                                       AS CONPK,
								 TCONV.TCON_NOMBRE                                            AS CONNOMBRE,
								 TCONV.TCON_DESCRIPCION                                       AS CONDESCRIPCION,
								 TCONV.TCON_MODALIDAD                                         AS CONMODALIDAD,
								 TCONV.TINS_FK3_INSTITUCION                                   AS CONINSTITUCION,
								 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD/MM/YYYY' )             AS CONFECHAVIGINI,
								 TO_CHAR( TCONV.TCON_FECHA_FIN, 'DD/MM/YYYY' )                AS CONFECHAVIGFIN,
								 TCONV.TCON_MONTO_EFECTIVO                                    AS CONMONTOLIQUIDO,
								 TCONV.TCON_MONTO_ESPECIE                                     AS CONMONTOESPECIE,
								 TCONV.TCON_MONTO_CONACYT                                     AS CONMONTOCONACYT,
								 TCONV.TCON_MONTO_TOTAL                                       AS CONMONTOTOTAL,
								 TRESP.TRES_PK_RESPONSABLE                                    AS RESPK,
								 TRESP.TEMP_FK5_NUM_EMPLEADO                                  AS RESNUMEMPLEADO,
								 TRESP.TRESP_NOMBRE                                           AS RESNOMBRE,
								 TRESP.TRES_AP_PATERNO                                        AS RESAPATERNO,
								 TRESP.TRES_AP_MATERNO                                        AS RESAMATERNO,
								 TRESP.TRES_EXTENSION                                         AS RESEXTENSION,
								 TRESP.TRESP_MAIL                                             AS RESMAIL,
								 TRESP.CGRA_FK1_GRADO                                         AS RESPKGRADO,
								 CGRAD.CAC_ACRONIMO                                           AS RESGRADO,
								 TRESP.CCAR_FK2_CARRERA                                       AS RESPKCARRERA,
								 CCARR.CCAR_NOMBRE                                            AS RESCARRERA,
								 TRESP.CSEX_FK4_SEXO                                          AS RESPKSEXO,
								 CSEXO.CGE_GENERO_NOMBRE                                      AS RESSEXO,
								 TRESP.TUR_FK6_UR                                             AS RESPKUR,
								 TURDE.TUR_NOMBRE                                             AS RESDEPENDENCIA,
								 TCONV.TCON_FK_TIPOCONCURRENCIA                               AS CONCURRENCIA,
							 	 TCONV.TCON_REGISTRO_SIP									  AS REGISTRO_SIP
						FROM GRAL.GRALCACRONIMO       CGRAD,
								 CONINV.CINVCCARRERA      CCARR,
								 GRAL.GRALCGENERO         CSEXO,
								 UR.TURIPN@DBL_UR         TURDE,
								 CONINV.CINVTRESPONSABLE  TRESP,
								 CONINV.CINVTCONVENIO     TCONV
					 WHERE CGRAD.CAC_PK_ACRONIMO(+)      = TRESP.CGRA_FK1_GRADO
						 AND CCARR.CCAR_PK_CARRERA(+)      = TRESP.CCAR_FK2_CARRERA
						 AND CSEXO.CGE_PK_GENERO(+)        = TRESP.CSEX_FK4_SEXO
						 AND TURDE.TUR_PK_UR(+)            = TRESP.TUR_FK6_UR
						 AND TCONV.TRES_FK2_RESPONSABLE    = TRESP.TRES_PK_RESPONSABLE(+)
						 AND TCONV.TCON_FK1_ESTADO         <> 141
						 AND TCONV.TCON_FK1_ESTADO         <> 152
						 AND TCONV.TCON_PK_CONVENIO        = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
			</cfquery>
			<cfreturn result>
	</cffunction>
	
	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="getEditarUCbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio">
			<cfargument name="pkConvenio" type="numeric" required="true" hint="PK de convenio"> 
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TCONV.TCON_CLAVE                                             AS CONREGISTRO,
								 TCONV.TCON_PK_CONVENIO                                       AS CONPK,
								 TCONV.TCON_NOMBRE                                            AS CONNOMBRE,
								 TCONV.TCON_DESCRIPCION                                       AS CONDESCRIPCION,
								 TCONV.TCON_MODALIDAD                                         AS CONMODALIDAD,
								 TCONV.TINS_FK3_INSTITUCION                                   AS CONINSTITUCION,
								 TO_CHAR( TCONV.TCON_FECHA_INICIO, 'DD/MM/YYYY' )             AS CONFECHAVIGINI,
								 TO_CHAR( TCONV.TCON_FECHA_FIN, 'DD/MM/YYYY' )                AS CONFECHAVIGFIN,
								 TCONV.TCON_MONTO_EFECTIVO                                    AS CONMONTOLIQUIDO,
								 TCONV.TCON_MONTO_ESPECIE                                     AS CONMONTOESPECIE,
								 TCONV.TCON_MONTO_CONACYT                                     AS CONMONTOCONACYT,
								 TCONV.TCON_MONTO_TOTAL                                       AS CONMONTOTOTAL,
								 TRESP.TRES_PK_RESPONSABLE                                    AS RESPK,
								 TRESP.TEMP_FK5_NUM_EMPLEADO                                  AS RESNUMEMPLEADO,
								 TRESP.TRESP_NOMBRE                                           AS RESNOMBRE,
								 TRESP.TRES_AP_PATERNO                                        AS RESAPATERNO,
								 TRESP.TRES_AP_MATERNO                                        AS RESAMATERNO,
								 TRESP.TRES_EXTENSION                                         AS RESEXTENSION,
								 TRESP.TRESP_MAIL                                             AS RESMAIL,
								 TRESP.CGRA_FK1_GRADO                                         AS RESPKGRADO,
								 CGRAD.CAC_ACRONIMO                                           AS RESGRADO,
								 TRESP.CCAR_FK2_CARRERA                                       AS RESPKCARRERA,
								 CCARR.CCAR_NOMBRE                                            AS RESCARRERA,
								 TRESP.CSEX_FK4_SEXO                                          AS RESPKSEXO,
								 CSEXO.CGE_GENERO_NOMBRE                                      AS RESSEXO,
								 TRESP.TUR_FK6_UR                                             AS RESPKUR,
								 TURDE.TUR_NOMBRE                                             AS RESDEPENDENCIA,
							 	 TCONV.TCON_REGISTRO_SIP									  AS REGISTRO_SIP
						FROM GRAL.GRALCACRONIMO       CGRAD,
								 CONINV.CINVCCARRERA      CCARR,
								 GRAL.GRALCGENERO         CSEXO,
								 UR.TURIPN@DBL_UR         TURDE,
								 CONINV.CINVTRESPONSABLE  TRESP,
								 CONINV.CINVTCONVENIO     TCONV
					 WHERE CGRAD.CAC_PK_ACRONIMO(+)      = TRESP.CGRA_FK1_GRADO
						 AND CCARR.CCAR_PK_CARRERA(+)      = TRESP.CCAR_FK2_CARRERA
						 AND CSEXO.CGE_PK_GENERO(+)        = TRESP.CSEX_FK4_SEXO
						 AND TURDE.TUR_PK_UR(+)            = TRESP.TUR_FK6_UR
						 AND TCONV.TRES_FK2_RESPONSABLE    = TRESP.TRES_PK_RESPONSABLE(+)
						 AND TCONV.TCON_FK1_ESTADO         <> 141
						 AND TCONV.TCON_FK1_ESTADO         <> 152
						 AND TCONV.TCON_PK_CONVENIO        = <cfqueryparam value="#pkConvenio#" cfsqltype="cf_sql_numeric">
			</cfquery>
			<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Consulta si tiene un responsable asignado
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	 <cffunction name="responsableAsignado" hint="Consulta si tiene un responsable asignado">
			<cfargument name="pkRegistro"   type="numeric" required="true" hint="PK del convenio">
			<cfquery name="result" datasource="DS_CONINV">
					SELECT TCONV.TRES_FK2_RESPONSABLE AS RESPONSABLE
						FROM CONINV.CINVTCONVENIO       TCONV
					 WHERE TCONV.TCON_PK_CONVENIO     = <cfqueryparam value="#pkRegistro#" cfsqltype="cf_sql_numeric">
			</cfquery>
			<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene los registros de Carreras
	* Fecha creacion: Enero 18,2017
	* @author:        Edgar Allan Soriano Najera
	--->
	 <cffunction name="getCarreras" hint="Obtiene los registros de carreras">
		<cfquery name="result" datasource="DS_CONINV">
				SELECT CARRERAS.CCAR_PK_CARRERA AS PK_CARRERA,
						CARRERAS.CCAR_NOMBRE AS NOMBRE_CARRERA
				FROM CONINV.CINVCCARRERA       CARRERAS
				WHERE CARRERAS.CCAR_ESTADO > 0
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del responsable ya guardado
	* Fecha creacion: Enero 22,2017
	* @author:        Edgar Allan Soriano Najera
	--->
	<cffunction name="obtenerEmpleadoRegistrado" hint="Obtiene la informacion de responsables ya registrados">
		<cfargument name="numEmpleado" type="numeric" required="yes" hint="Numero de empleado"> 
		<cfquery name="result" datasource="DS_CONINV">
				SELECT  RESPONSABLE.TRES_PK_RESPONSABLE AS PKRESPONSABLE, 
						RESPONSABLE.CEST_FK3_ESTADO AS ESTADO, 
						RESPONSABLE.CSEX_FK4_SEXO AS FKSEXO, 
						RESPONSABLE.TEMP_FK5_NUM_EMPLEADO AS NUMEMPLEADO, 
						RESPONSABLE.TUR_FK6_UR AS FKUR, 
						RESPONSABLE.TRESP_NOMBRE AS NOMBRE, 
						RESPONSABLE.TRES_AP_PATERNO AS PATERNO, 
						RESPONSABLE.TRES_AP_MATERNO AS MATERNO, 
						RESPONSABLE.TRES_EXTENSION AS EXTENSION, 
						RESPONSABLE.TRESP_MAIL AS EMAIL, 
						RESPONSABLE.CGRA_FK1_GRADO AS PKGRADO,
						RESPONSABLE.CCAR_FK2_CARRERA AS PKCARRERA
				FROM CONINV.CINVTRESPONSABLE RESPONSABLE
				WHERE RESPONSABLE.TEMP_FK5_NUM_EMPLEADO = <cfqueryparam value="#numEmpleado#" cfsqltype="cf_sql_numeric">
				AND	  RESPONSABLE.CEST_FK3_ESTADO > 0
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Obtiene las dependencias del Instituto
	* Fecha creacion: Enero 22,2017
	* @author:        Edgar Allan Soriano Najera
	--->
	<cffunction name="getDependencias" hint="Obtiene las dependencias del Instituto">
		<cfquery name="result" datasource="DS_URS">
			SELECT  
			TUR_CLAVE AS CLAVE_UR, 
			TUR_NOMBRE AS NOMBRE_UR, 
			TUR_SIGLAS	AS SIGLAS_UR,  
			TUR_FK_ESTATUS AS ESTATUS_UR
			FROM URS.URSTURS
			WHERE TUR_FK_URTIMEFIN IS NULL
			AND TUR_FK_CLASIFICACION > 17
			ORDER BY NOMBRE_UR
		</cfquery>
		<cfreturn result>
	</cffunction>

	<!---
	* Descripcion:    Genera el folio de registro SIP
	* Fecha creacion: Febrero 08,2018
	* @author:        Edgar Allan Soriano Najera
	--->
	<cffunction name="generaRegistroSIP" access="public" hint="Genera el folio de registro SIP">
		<cfargument name="pkConvenio"   type="numeric" required="true" hint="PK del convenio">
		<cfstoredproc procedure="CONINV.P_CONVENIO.GENERA_REGISTRO_SIP" datasource="DS_CONINV">
			<cfprocparam value="#pkConvenio#"		cfsqltype="cf_sql_numeric"	type="in">
			<cfprocparam variable="P_RESULTADO"		cfsqltype="cf_sql_varchar"	type="out">
		</cfstoredproc>
		<cfreturn P_RESULTADO>
	</cffunction>
		
</cfcomponent>
