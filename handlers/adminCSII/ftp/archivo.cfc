
<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: FTP
* Fecha : septiembre de 2016
* Descripcion: handler 
* =========================================================================
--->

<cfcomponent>

	<cfproperty name="cnAdmonArchivo" inject="adminCSII.ftp.CN_Archivo">
	<cfproperty name="fileManager"    inject="utils.filetransfer.FileManager">

	<cffunction name="index" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>			
			event.setView("adminCSII/ftp/V_documentosFtp");
		</cfscript>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="subirArchivo" hint="Sube el archivo al servidor FTP">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = 0;
			rc = Event.getCollection();
			attachResult = fileManager.attachFile("upload_files", "sero.listas", session.cbstorage.usuario.vertiente & "\" & rc.pkCatalogo & "\" & rc.pkRegistro & "\");

			if (attachResult.SUCCESS) {
				var archivo = cnAdmonArchivo.registrarArchivo(rc.pkCatalogo, rc.pkUsuario, rc.desc, 168, attachResult.FILENAME, rc.pkRegistro);
				resultado = 1;
			}
	    </cfscript>
	    <cfreturn resultado>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="subirArchivoAnexo" hint="Sube el archivo al servidor FTP">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = 0;
			rc = Event.getCollection();
			attachResult = fileManager.attachFile("upload_files", "sero.listas", session.cbstorage.usuario.vertiente & "\" & rc.pkCatalogo & "\" & rc.pkRegistro & "\");

			if (attachResult.SUCCESS) {
				var archivo = cnAdmonArchivo.registrarArchivoAnexo(rc.pkCatalogo, rc.pkUsuario, rc.desc, 168, attachResult.FILENAME, rc.pkRegistro);
				resultado = 1;
			}
	    </cfscript>
	    <cfreturn resultado>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="actualizaOtros" hint="Sube el archivo al servidor FTP">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = 0;
			rc = Event.getCollection();
			attachResult = fileManager.attachFile("upload_files", "sero.listas", rc.pkCatalogo & "\" & rc.pkRegistro & "\");

			if (attachResult.SUCCESS) {
				var archivo = cnAdmonArchivo.actualizaOtros(rc.desc, attachResult.FILENAME, rc.pkArchivo);
				resultado = 1;
			}
	    </cfscript>
	    <cfreturn resultado>
	</cffunction>


	<!---
	* Fecha : septiembre de 2016
	* Autor : Yareli Andrade
	--->
	<cffunction name="eliminarArchivo" hint="Cambia el estado del registro de un archivo">
		<cfargument name="Event" type="any">
		<cfscript>
			resultado = cnAdmonArchivo.eliminarArchivo(rc.pkArchivo);
	    </cfscript> 
	    <cfreturn resultado>
	</cffunction>


	<!---
	* Fecha : septiembre de 2016
	* Autor : Yareli Andrade
	--->
	<cffunction name="descargarArchivo" access="remote" hint="Descarga un archivo del FTP">
		<cfscript>
			rc = Event.getCollection();

			fileNameDownload = cnAdmonArchivo.consultarNombreArchivo(rc.pkCatalogo, rc.pkObjeto).NOMBRE[1];
			path = session.cbstorage.usuario.vertiente & "\" & rc.pkCatalogo & "\" & rc.pkObjeto & "\";
			fileResult = fileManager.downloadFile(fileNameDownload, "sero.listas", path);

			if (fileResult.SUCCESS) {
				context = getPageContext();
				context.setFlushOutput(false);
				response = context.getFusionContext().getResponse().getResponse();
				out = response.getOutputStream();
				response.setContentLength(fileResult.FILESIZE);
				response.setHeader("Content-Type","application/pdf");
				response.setHeader("Content-disposition","attachment; filename="& replace(fileResult.FILENAME," ","_","ALL"));
				out.write(fileResult.FILE.toByteArray());
				out.flush();
				out.close();
				return;
			}else{
				event.setView("adminCSII/vistasaAvisos/archivoNoEncontrado").noLayout();
			}
		</cfscript>
	</cffunction>



	<!---
	* Fecha : julio de 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="descargarArchivoAnexo" access="remote" hint="Descarga un archivo del FTP">
		<cfscript>
			rc = Event.getCollection();

			fileNameDownload = cnAdmonArchivo.consultarNombreArchivoAnexo(rc.PKARCHIVOANEXO).NOMBRE[1];
			path = session.cbstorage.usuario.vertiente & "\" & rc.pkCatalogo & "\" & rc.pkObjeto & "\";
			fileResult = fileManager.downloadFile(fileNameDownload, "sero.listas", path);

			if (fileResult.SUCCESS) {
				context = getPageContext();
				context.setFlushOutput(false);
				response = context.getFusionContext().getResponse().getResponse();
				out = response.getOutputStream();
				response.setContentLength(fileResult.FILESIZE);
				response.setHeader("Content-Type","application/pdf");
				response.setHeader("Content-disposition","attachment; filename="& replace(fileResult.FILENAME," ","_","ALL"));
				out.write(fileResult.FILE.toByteArray());
				out.flush();
				out.close();
			}
			return;
		</cfscript>
	</cffunction>




	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultaDocumentos" hint="Regresa la vista con los documentos a solicitar">
		<cfargument name="Event" type="any">
		<cfscript>
			documento = cnAdmonArchivo.consultaDocumentos(rc.documentos, rc.requerido, rc.extension, rc.convenio, rc.recargar);
			prc.archivo = documento.DOCUMENTO;
			prc.existe = documento.existe;

			if ( (documento.existe GTE 1) AND (rc.documentos EQ 920) ){
				event.setView("adminCSII/ftp/componenteOtros").noLayout();
			}else if ( (documento.existe EQ 0) AND (rc.documentos EQ 920) ){
				event.setView("adminCSII/ftp/componenteSimpleOtros").noLayout();
			}else if( (documento.existe GTE 1) AND (rc.documentos NEQ 920)){
				event.setView("adminCSII/ftp/componenteFTP").noLayout();
			}else if( (documento.existe EQ 0) AND (rc.documentos NEQ 920)){
				event.setView("adminCSII/ftp/componenteSimple").noLayout();
			}
	    </cfscript>
	</cffunction>

	<!---
	* Fecha : Julio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultaOtros" hint="Regresa la vista con los documentos a solicitar">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.archivo = cnAdmonArchivo.consultaOtros(rc.documentos, rc.requerido, rc.extension, rc.convenio, rc.recargar);
			event.setView("adminCSII/ftp/componenteSimpleOtros").noLayout();
	    </cfscript>
	</cffunction>


	<!---
	* Fecha : Junio del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultarNombreArchivo" access="remote" hint="Descarga un archivo del FTP">
		<cfscript>
			fileNameDownload = cnAdmonArchivo.consultarNombreArchivo(rc.pkCatalogo, rc.pkObjeto).NOMBRE[1];
			path = session.cbstorage.usuario.vertiente & "\" & rc.pkCatalogo & "\" & rc.pkObjeto & "\";
			fileResult = fileManager.downloadFile(fileNameDownload, "sero.listas", path);

			event.renderData(data=toBase64(fileResult.FILE2));
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que cambia el estado del registro en cuestión a partir de la accion que se realiza.
    --->
	<cffunction name="cambiarEstado" hint="Cambia el estado del registro indicado al siguiente de la ruta">
		<cfargument name="Event" type="any">
		<cfscript>
			var destin = deserializeJSON(rc.destinatarios);
			var resultado = cnAdmonArchivo.cambiarEstado(rc.pkRegistro, rc.accion, #application.SIIIP_CTES.PROCEDIMIENTO.DOCUMENTOS#, 
														 Session.cbstorage.usuario.ROL, rc.asunto, rc.comentario, rc.prioridad, destin, tipoComent);

			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent>

