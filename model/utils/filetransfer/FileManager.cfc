<cfcomponent>
	<cfproperty name="ftp" type="any" >
	<cfproperty name="zipFile" type="any">
	<cfproperty name="zipVO" type="any">
	<cfproperty name="resources" type="any">

	<cfscript>
		function init(){
			this.ftp = createObject("component","FTP");
			this.zipFile = createObject("java","edu.ipn.sectecnica.utils.files.ZipFile");
			this.resources = createObject("java","edu.ipn.sectecnica.utils.Resources.Resources");
			this.zipVO = createObject("java","edu.ipn.sectecnica.utils.files.ZipFileVo");
			this.resources.init();
			this.zipFile.init();
			this.zipVO.init();
		}
	</cfscript>

	<!---
	 * Des mod:		Se implemento proceso que valida si existe un archivo con el mismo nombre en la ruta local. De ser asi agrega un contador al final del nombre
	 * Fecha mod:	17.03.2015
	 * Autor mod:	HCC
	--->
	<cffunction name="attachFile" returntype="struct" >
		<cfargument name="filedata" hint="archivo a Adjuntar">
		<cfargument name="process" hint="para seguimiento: 'seguimiento' para doctos de planeacion: 'planeacion'">
		<cfargument name="folder" hint="estructura de carpetas en la que se almacenaran los archivos">
		<cfargument name="prefijo" default="" required="false">
		<cfset structResult = structnew()>
		<cfset structResult.FILENAME = "">
		<cfset structResult.SUCCESS = false>
		<cfsetting RequestTimeout = "900000">
			<cfscript>
				localPath = this.resources.getProperty( process & ".path.file") & folder;
				ftpPath = this.resources.getProperty( process & ".path.ftp") & folder;
				this.zipFile.validateFolder(localPath);
				
				// Sube archivo en el la ruta generada
				cffile = upload(filedata, localPath);
				filename = cffile.SERVERFILENAME;
				extension = cffile.SERVERFILEEXT;

				// Verifica si tiene extension ZIP y comprime
				if( extension EQ "zip") {
					rename(localPath & cffile.SERVERFILENAME & "." & cffile.SERVERFILEEXT,localPath & filename & "_." & cffile.SERVERFILEEXT);
					isZipped = this.zipFile.compressFile(localPath & filename & "_." & cffile.SERVERFILEEXT,localPath & filename & prefijo & ".zip");
				}else{
					counter	= 0;
					endFile	= '';
					//Valida si existe un archivo con el mismo nombre en la ruta local
					if(FileExists(localPath & fileName & '.zip')){
						counter = counter + 1;
						endFile = "(" & counter & ")";
						filenameTmp = filename;
						filename = filename & endFile;
						isZipped = this.zipFile.compressFile(localPath & filenameTmp & "." & cffile.SERVERFILEEXT, localPath & filename & prefijo & ".zip");
					}else{
						isZipped = this.zipFile.compressFile(localPath & filename & "." & cffile.SERVERFILEEXT, localPath & filename & prefijo & ".zip");
					}
				}
				if(isZipped eq true) {
					// Verifica si esta conectado el ftp
					if(not this.ftp.hasConnect()) {
						if(isDefined('process')) {
							this.ftp.connect(process);
						}else {
							this.ftp.connect();
						}
					}
					// Se envia el archivo al FTP
					this.ftp.changeToFolder(ftpPath);
					finalName = this.ftp.uploadFile(localPath, filename & prefijo ,"zip");
					structResult.LOCALPATH = localPath;
					structResult.FTPPATH = ftpPath;
					structResult.FILENAME = finalName;
					structResult.EXTENSION = extension;
					structResult.NOMBRE = filename;
					structResult.SUCCESS = true;
					return structResult;
				}
				return structResult;
			</cfscript>
	</cffunction>

	<cffunction name="downloadFile" returntype="struct">
		<cfargument name="fileName" required="yes">
		<cfargument name="process">
		<cfargument name="folder" required="yes">
		<cfscript>
		 	adminapi = createObject("component", "cfide.adminapi.base");
			this.init();
			localPath = this.resources.getProperty( process & ".path.file") & folder;
			ftpPath = this.resources.getProperty( process & ".path.ftp") & folder;
			
			try {
				this.zipFile.validateFolder(localPath);
				// Busca si existe en el servidor el archivo solicitado al ftp para evitar varias conexiones al mismo
				if(not FileExists(localPath & fileName)) {
					if(not this.ftp.hasConnect()) {
						if(isDefined('process')) {
							this.ftp.connect(process);
						} else {
							this.ftp.connect();
						}
					}
					this.ftp.downloadFile(ftpPath & filename,localPath & fileName);
				}

				// Descompresion de archivo zip
				zipVO = this.zipfile.decompressFile(localPath & fileName);
				StructFile = structnew();
				StructFile.FILE2 = zipVO.getFileB();
				StructFile.FILE = zipVO.getFile();
				StructFile.FILESIZE = zipVO.getFile().size();
				StructFile.FILENAME = zipVO.getName();
				StructFile.SUCCESS = true;
				return StructFile;
			} catch (any e) {
				logger("downloadLocalFile:: Error al cargar el archivo del ftp Message:" & e.message);
				logger("downloadLocalFile:: Error al cargar el archivo del ftp StackTrace:" & e.StackTrace);
				logger("downloadLocalFile:: Error al cargar el archivo del ftp Message:" & e.TagContext[1].RAW_TRACE);
				StructFile = structnew();
				StructFile.SUCCESS = false;
				return StructFile;
			}
		</cfscript>
	</cffunction>

	<cffunction name="deleteFile" returntype="boolean">
		<cfargument name="fileName" required="yes">
		<cfargument name="process" hint="para seguimiento: 'seguimiento' para doctos de planeacion: 'planeacion'">
		<cfargument name="folder" required="yes">
		<cfscript>
			ftpPath = this.resources.getProperty(process & ".path.ftp") & folder;
			if(not this.ftp.hasConnect()){
				if(isDefined('process')){
					this.ftp.connect(process);
				}else{
					this.ftp.connect();
				}
			}
			return this.ftp.deleteFile(ftpPath & filename);
		</cfscript>
	</cffunction>

	<cffunction  name="attachFilePhysical" returntype="struct" hint="Sube al FTP un archivo ya existente y lo comprime">
		<cfargument name="fileName" hint="Nombre del archivo">
		<cfargument name="process" hint="para seguimiento: 'seguimiento' para doctos de planeacion: 'planeacion'">
		<cfargument name="folder" hint="estructura de carpetas en la que se almacenaran los archivos">
		<cfset structResult = structnew()>
		<cfset structResult.FILENAME = "">
		<cfset structResult.SUCCESS = false>
		<cftry>
			<cfscript>
				punto = REFindNoCase("(\.[a-z]{3,4})$", arguments.fileName); // Obtine la localizacion del "." en el nombre del archivo
				if(punto neq 0){
					SERVERFILENAME = Left(arguments.fileName, punto - 1); // Obtiene el nombre del archivo
					SERVERFILEEXT = Mid(arguments.fileName, punto+1, Len(arguments.fileName)); // Obtiene la extension del archivo
					// Obtiene la ruta
					localPath = this.resources.getProperty( process & ".path.file") & folder;
					ftpPath = this.resources.getProperty( process & ".path.ftp") & folder;
					this.zipFile.validateFolder(localPath);
					// Verifica si tiene extension ZIP y comprime
					if( SERVERFILEEXT eq "zip" ) {
						rename(localPath & SERVERFILENAME & "." & SERVERFILEEXT,localPath & SERVERFILENAME & "_." & SERVERFILEEXT);
						isZipped = this.zipFile.compressFile(localPath & SERVERFILENAME & "_." & SERVERFILEEXT,localPath & SERVERFILENAME & ".zip");
					}else{
						isZipped = this.zipFile.compressFile(localPath & SERVERFILENAME & "." & SERVERFILEEXT,localPath & SERVERFILENAME & ".zip");
					}
					if(isZipped eq true){
						// Verifica si esta conectado el ftp
						if(not this.ftp.hasConnect(process)){
							if(isDefined('process')){
								this.ftp.connect(process);
							}else{
								this.ftp.connect();
							}
						}
						// Envio el archivo al FTP
						this.ftp.changeToFolder(ftpPath);
						finalName = this.ftp.uploadFile(localPath, SERVERFILENAME, "zip");
						structResult.LOCALPATH = localPath;
						structResult.FTPPATH = ftpPath;
						structResult.FILENAME = finalName;
						structResult.SUCCESS = true;
						this.ftp.disconnect();
						return structResult;
					}
				}
				return structResult;
			</cfscript>
			<cfcatch type="any">
				<cflog text="Repositorio.utils.filetransfer.attachFilePhysical:: Error al cargar el archivo del ftp: #cfcatch.message#">
				<cfreturn structResult>
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="attachFileNotZip" returntype="struct" hint="Sube un archivo a su directorio temporal y no lo comprime">
		<cfargument name="fileData" hint="Nombre del la variable contenedora del input file">
		<cfargument name="process" hint="para seguimiento: 'seguimiento' para doctos de planeacion: 'planeacion'">
		<cfargument name="folder" hint="estructura de carpetas en la que se almacenaran los archivos">
		<cfset structResult = structnew()>
		<cfset structResult.FILENAME = "">
		<cfset structResult.SUCCESS = false>
		<cftry>
			<cfscript>
				localPath = this.resources.getProperty(process & ".path.file") & folder;
				this.zipFile.validateFolder(localPath);
				//Sube archivo en el la ruta generada y temporal
				cffile = upload(arguments.fileData, localPath);
				finalName = cffile.SERVERFILENAME;
				structResult.LOCALPATH = localPath;
				structResult.FILENAME = finalName;
				structResult.SUCCESS = true;
				return structResult;
			</cfscript>
		<cfcatch type="any">
			<cflog text="Repositorio.utils.filetransfer.attachFileNotZip:: Error al cargar el archivo del ftp: #cfcatch.message#">
			<cfreturn structResult>
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="debug" access="public">
		<cfargument name="v">
		<cfdump var="#v#">
		<hr>
	</cffunction>

	<cffunction name="upload" returntype="any">
		<cfargument name="filedata">
		<cfargument name="destination">
		<cffile action="UPLOAD" filefield="#filedata#" destination="#destination#" nameconflict="MAKEUNIQUE">
		<cfreturn cffile>
	</cffunction>

	<cffunction name="rename">
		<cfargument name="source">
		<cfargument name="destination">
		<cffile action = "rename" source = "#source#" destination = "#destination#">
	</cffunction>

	<cffunction name="delete">
		<cfargument name="path">
		<cfargument name="name">
		<cffile action = "delete" file = "#path#+#name#" >
	</cffunction>

	<cffunction name="logger" access="remote">
		<cfargument name="text" required="yes">
		<cfset text="Repositorio.filetransfer.FileManager::"&text>
		<cflog text="#text#" type="information">
	</cffunction>

</cfcomponent>
