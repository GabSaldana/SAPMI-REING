<!---
* ============================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: FTP
* Fecha: septiembre de 2016
* Descripcion: acceso a datos para la administracion de archivos
* ============================================================================
--->

<cfcomponent>

	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="registrarArchivo" hint="Guarda un registro del archivo que se subió al FTP">
		<cfargument name="pkCatalogo"    hint="Pk del archivo en el catalogo">
		<cfargument name="pkUsuario"     hint="Pk del usuario">
		<cfargument name="descripcion"   hint="Descripcion del archivo">
		<cfargument name="pkEstado"      hint="Estado con el que se guarda el registro">
		<cfargument name="nombreArchivo" hint="Nombre del archivo">
		<cfargument name="pkRegistro"    hint="pk del registro">
		<cfscript>
			spArchivo = new storedproc();
		    spArchivo.setDatasource("DS_GRAL");
		    spArchivo.setProcedure("P_ADMON_ARCHIVO.SUBIR_ARCHIVO");
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkCatalogo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkRegistro);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkUsuario);
		    spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=descripcion);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkEstado);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=application.SIIIP_CTES.ESTADO.DOCUMENTOELIMINADO);
		    spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=nombreArchivo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
		    result = spArchivo.execute();
			var success = result.getprocOutVariables().resultado;
			return success;
		</cfscript>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="registrarArchivoAnexo" hint="Guarda un registro del archivo que se subió al FTP">
		<cfargument name="pkCatalogo"    hint="Pk del archivo en el catalogo">
		<cfargument name="pkUsuario"     hint="Pk del usuario">
		<cfargument name="descripcion"   hint="Descripcion del archivo">
		<cfargument name="pkEstado"      hint="Estado con el que se guarda el registro">
		<cfargument name="nombreArchivo" hint="Nombre del archivo">
		<cfargument name="pkRegistro"    hint="pk del registro">
		<cfscript>
			spArchivo = new storedproc();
			spArchivo.setDatasource("DS_GRAL");
		    spArchivo.setProcedure("P_ADMON_ARCHIVO.SUBIR_ARCHIVO_ANEXO");
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkCatalogo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkRegistro);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkUsuario);
		    spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=descripcion);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkEstado);
		    spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=nombreArchivo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
		    result = spArchivo.execute();
			return result.getprocOutVariables().resultado;
		</cfscript>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="actualizaOtros" hint="Guarda un registro del archivo que se subió al FTP">
		<cfargument name="descripcion"   hint="Descripcion del archivo">
		<cfargument name="nombreArchivo" hint="Nombre del archivo">
		<cfargument name="pkArchivo"     hint="pk del registro">
		<cfscript>
			spArchivo = new storedproc();
		    spArchivo.setDatasource("DS_GRAL");
		    spArchivo.setProcedure("P_ADMON_ARCHIVO.ACTUALIZA_OTROS");
		    spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=descripcion);
		    spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=nombreArchivo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkArchivo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
		    result = spArchivo.execute();
			return result.getprocOutVariables().resultado;
		</cfscript>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultarNombreArchivo" hint="Obtiene el nombre de un archivo">
		<cfargument name="pkCatalogo" hint="Pk del archivo en el catalogo">
		<cfargument name="pkObjeto"   hint="Pk del objeto">
		<cfquery name="qFileName" datasource="DS_GRAL">
			SELECT 	ARCH.TAR_NOMBRE_ARCHIVO NOMBRE,
					ARCH.TAR_DESCRIPCION DESCRIPCION
			FROM 	GRAL.DOCTARCHIVOS ARCH
			WHERE   ARCH.TAR_FK_CARCHIVO = #pkCatalogo#
            AND 	ARCH.TAR_PKOBJETO    = #pkObjeto#
            AND 	ARCH.TAR_FK_ESTADO   <> <cfqueryparam value="#application.SIIIP_CTES.ESTADO.DOCUMENTOELIMINADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn qFileName>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultarNombreArchivoAnexo" hint="Obtiene el nombre de un archivo">
		<cfargument name="pkArchivo" hint="Pk del archivo en el catalogo">
		<cfquery name="qFileName" datasource="DS_GRAL">
			SELECT 	ARCH.TAR_NOMBRE_ARCHIVO NOMBRE,
					ARCH.TAR_DESCRIPCION DESCRIPCION
			FROM 	GRAL.DOCTARCHIVOS ARCH
			WHERE   ARCH.TAR_PK_ARCHIVO = #pkArchivo#
		</cfquery>
		<cfreturn qFileName>		
	</cffunction>



	<!---
	* Fecha : julio de 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="eliminarArchivo" hint="Actualiza el estado de un registro específico">
		<cfargument name="pkArchivo" hint="Pk del arhivo">
		<cfargument name="pkEstado"  hint="Pk del estado eliminado del procedimiento de los archivos">
		<cfscript>
			spArchivo = new storedproc();
		    spArchivo.setDatasource("DS_GRAL");
		    spArchivo.setProcedure("P_ADMON_ARCHIVO.ELIMINA_ARCHIVO");
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkArchivo);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkEstado);
		    spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
		    result = spArchivo.execute();
			return result.getprocOutVariables().resultado;
		</cfscript>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultaDocumentos" hint="Devuelve la vista con los documentos a solicitar">
		<cfargument name="pksDocumentos" type="string"  hint="Pks de los documentos">
		<cfargument name="requerido" 	 type="numeric" hint="Pks de los documentos">
		<cfargument name="extension" 	 type="string"  hint="Pks de los documentos">
		<cfargument name="convenio"   	 type="numeric" hint="pk del convenio">
		<cfargument name="recargar" 	 type="string"  hint="Funcion que debe recargar despues de subir un archivo">
		<cfquery name="resultado" datasource="DS_GRAL">
			SELECT  ARCH.CAR_PK_ARCHIVO AS PKDOC,
				    ARCH.CAR_NOMBRE     AS NOMBRE,
				    #requerido#         AS REQUERIDO,
				    #pksDocumentos# 	AS TIPODOC,
				    '#extension#'       AS EXTENSION,
				    #convenio# 		    AS CONVENIO,
				    '#recargar#'		AS FUNCION
			FROM    GRAL.DOCCARCHIVO ARCH
			WHERE   ARCH.CAR_PK_ARCHIVO   IN (#pksDocumentos#)
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha: Junio del 2017
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene solamente los registros.
    ---> 
    <cffunction name="consultaArchivo" hint="Obtiene el archivo registrado">
		<cfargument name="pksDocumentos" type="numeric" hint="">
		<cfargument name="requerido" 	 type="numeric" hint="Pks de los documentos">
		<cfargument name="extension" 	 type="string"  hint="Pks de los documentos">
		<cfargument name="convenio"   	 type="numeric" hint="pk del objeto">
		<cfargument name="recargar" 	 type="string"  hint="Funcion que debe recargar despues de subir un archivo">
        <cfquery name="qResult" datasource="DS_GRAL">
            SELECT  DOCS.TAR_PK_ARCHIVO 	AS PKARCHIVO,
            		#pksDocumentos# 		AS PKDOC,
            		'##'||#pksDocumentos# 	AS IDPKDOC,
                    #pksDocumentos# 		AS TIPODOC,
                    #requerido#         	AS REQUERIDO,
				    '#extension#'       	AS EXTENSION,
                    DOCS.TAR_FK_RUTA  		AS CESRUTA,
                    DOCS.TAR_FK_ESTADO 		AS CESESTADO,
                    #convenio# 				AS CONVENIO,
       				CAT.CAR_NOMBRE 			AS NOMBRECAT,
                    REPLACE(DOCS.TAR_NOMBRE_ARCHIVO, '.zip', '') AS NOMBRE,
                    DOCS.TAR_DESCRIPCION 	AS DESCRIPCION,
                    '#recargar#'		    AS FUNCION
            FROM    GRAL.DOCTARCHIVOS DOCS,
       				GRAL.DOCCARCHIVO  CAT
			WHERE   DOCS.TAR_FK_CARCHIVO = CAT.CAR_PK_ARCHIVO
			AND     DOCS.TAR_PKOBJETO    = #convenio#
			AND 	DOCS.TAR_FK_CARCHIVO = #pksDocumentos#
			AND 	DOCS.TAR_FK_ESTADO   <> <cfqueryparam value="#application.SIIIP_CTES.ESTADO.DOCUMENTOELIMINADO#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qResult>
    </cffunction>


    <!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="existeConvenio" hint="Devuelve la vista con los documentos a solicitar">
		<cfargument name="convenio"   	 type="numeric" hint="pk del objeto">
		<cfargument name="pksDocumentos" type="numeric" hint="pk del catalogo">
		<cfquery name="resultado" datasource="DS_GRAL">
			SELECT COUNT(DOCS.TAR_PK_ARCHIVO) AS EXISTE
			FROM   GRAL.DOCTARCHIVOS DOCS
			WHERE  DOCS.TAR_PKOBJETO    = #convenio#
			AND    DOCS.TAR_FK_CARCHIVO = #pksDocumentos#
			AND    DOCS.TAR_FK_ESTADO   <> <cfqueryparam value="#application.SIIIP_CTES.ESTADO.DOCUMENTOELIMINADO#" cfsqltype="cf_sql_numeric">
		</cfquery>		
		<cfreturn resultado>
	</cffunction>


	<!---
	* Fecha : Junio  2017
	* Autor : SGS
	--->
	<cffunction name="archivosRequeridosCargados" hint="Consulta el numero de archivos requeridos ya cargados">
        <cfargument name="pkRegistro"   type="numeric"  required="yes" hint="Pk del registro">
        <cfargument name="tipoConvenio" type="numeric"  required="yes" hint="tipo de convenio">
		<cfquery name="resultado" datasource="DS_GRAL">
			SELECT  COUNT(TAR.TAR_PK_ARCHIVO) AS ARCHIVOSCARGADOS
			FROM    GRAL.DOCTARCHIVOS TAR,
			        GRAL.DOCCARCHIVO  CAR
			WHERE   TAR.TAR_PKOBJETO = #pkRegistro#
			        AND TAR.TAR_FK_ESTADO <> <cfqueryparam value="#application.SIIIP_CTES.ESTADO.DOCUMENTOELIMINADO#" cfsqltype="cf_sql_numeric">
			        AND TAR.TAR_FK_CARCHIVO = CAR.CAR_PK_ARCHIVO
			        AND CAR.CAR_PK_ARCHIVO IN (
			        	SELECT 	TAC.TARC_FK_ARCHIVO
			        	FROM   	GRAL.DOCTARCHIVOCONVENIO TAC
			        	WHERE  	TAC.BCON_FK_TIPOCONVENIO = #tipoConvenio#
			        			AND TAC.TARC_REQUERIDO = 1
			        			AND TAC.TARC_FK_ESTADO = 2 
			        	)
		</cfquery>
		<cfreturn resultado>		
	</cffunction>


</cfcomponent>

