<cfcomponent>	
	<cfproperty name="CN" 	 inject="CVU.CN_CVU">


	<cffunction name="operacionArchivos" hint="muestra la vista de Escolaridad">
		<cfargument name="event" type="any">
		<cfscript>
			var archivos = this.getArchivosTrayectoria();
		</cfscript>

		<!--- En esta linea se pone la ruta del disco duro externo (solo cambia la letra de la unidad) --->
		<cfdirectory action="list" type="file" directory="E:\siiip\SolicitudPosgrado\EDI\" recurse="true" name="myList">

		<cfdump var="#archivos#">
		<cfdump var="#myList#"> 
		<cfabort>

   		<cfloop from="1" to="#myList.recordcount#" index="i">
   			<cfloop from="1" to="#archivos.recordcount#" index="j">

	   			<cfif (#compare(#myList.Name[i]#, #archivos.ARCHIVO[j]#)#) EQ 0>

	   				<!--- <cfif #Find(#archivos.OBJ_TEMP[j]#, #myList.Directory[i]#)# GT 0> --->
	   					<cfif #Find(#archivos.ASPIRANTE[j]#, #myList.Directory[i]#)# GT 0>

	   						<cfif NOT DirectoryExists('D:\FTP\SIIIP\documentosFTP\TRAY2\'&archivos.CATALOGO[j]&'\'&archivos.OBJETO[j])> 
								<cfdirectory action="create" directory="D:\FTP\SIIIP\documentosFTP\TRAY2\#archivos.CATALOGO[j]#\#archivos.OBJETO[j]#">
							</cfif>

							<cfdirectory action="copy" destination="D:\FTP\SIIIP\documentosFTP\TRAY2\#archivos.CATALOGO[j]#\#archivos.OBJETO[j]#" directory="#myList.Directory[i]#" >

	   					</cfif>
	   				<!--- </cfif> --->


	   			</cfif>
	   		</cfloop>
   		</cfloop>

   		<cfreturn true>

	</cffunction>


	<cffunction name="archivosHumanos" hint=" ">
		<cfargument name="event" type="any">
		<cfscript>
			var archivos = this.getArchivosHumanos();
		</cfscript>

		<!--- En esta linea se pone la ruta del disco duro externo (solo cambia la letra de la unidad) --->
		<cfdirectory action="list" type="file" directory="E:\ch\personal\" recurse="true" name="myList">

		<cfdump var="#myList#">
		<cfdump var="#archivos#">
		<cfabort>

		<cfloop from="1" to="#myList.recordcount#" index="i">
   			<cfloop from="1" to="#archivos.recordcount#" index="j">
	   			<cfif (#myList.Name[i]# EQ #archivos.ARCHIVO[j]#) AND #Find('\'&#archivos.OBJ_TEMP[j]#&'\', #myList.Directory[i]#)# >

	   				<!--- Crea las carpetas dentro del ftp (poner la ruta donde estara el FTP) --->
	   				<cfif NOT DirectoryExists('D:\FTP\SIIIP\documentosFTP\666\'&archivos.CATALOGO[j]&'\'&archivos.OBJETO[j])> 
						<cfdirectory action="create" directory="D:\FTP\SIIIP\documentosFTP\666\#archivos.CATALOGO[j]#\#archivos.OBJETO[j]#">
					</cfif>

					<cfdirectory action="copy" destination="D:\FTP\SIIIP\documentosFTP\666\#archivos.CATALOGO[j]#\#archivos.OBJETO[j]#" directory="#myList.Directory[i]#" >

					<!--- Crea las carpetas dentro de la instancia (poner la ruta donde estara el FTP) --->
					<!--- <cfif NOT DirectoryExists(#expandPath("./documentosFTP/#session.cbstorage.usuario.vertiente#/#archivos.CATALOGO[j]#/#archivos.OBJETO[j]#")#)> 
						<cfdirectory action="create" directory="#expandPath("./documentosFTP/#session.cbstorage.usuario.vertiente#/#archivos.CATALOGO[j]#/#archivos.OBJETO[j]#")#">
					</cfif>

					<cfdirectory action="copy" destination="#expandPath("./documentosFTP/#session.cbstorage.usuario.vertiente#/#archivos.CATALOGO[j]#/#archivos.OBJETO[j]#")#" directory="#myList.Directory[i]#"> --->

	   			</cfif>
	   		</cfloop>
   		</cfloop>

   		<cfreturn true>

	</cffunction>



	<cffunction name="operacionDisenoRedisenoProgramas" hint="muestra la vista de Escolaridad">
		<cfargument name="event" type="any">
		<cfscript>
			var archivos = this.getDisenoRedisenoProgramas();
		</cfscript>

		<cfdirectory action="list" type="file" directory="D:\EDI\" recurse="true" name="myList">

		<!--- <cfdump var="#myList#">
		<cfdump var="#archivos#"> 
		<cfabort> --->

		<cfloop from="1" to="#myList.recordcount#" index="i">
   			<cfloop from="1" to="#archivos.recordcount#" index="j">




	   			<cfif (#compare(#myList.Name[i]#, #archivos.NOM_SIP[j]#)#) EQ 0 AND (#compare(#myList.Name[i]#, #archivos.NOM_DOC[j]#)#) EQ 0 AND (#compare(#archivos.NOM_SIP[j]#, #archivos.NOM_DOC[j]#)#) EQ 0>


	   				<cfif #Find(#archivos.ELEM_SIP[j]#, #myList.Directory[i]#)# GT 0>
	   					<cfif #Find(#archivos.CAT_SIP[j]#, #myList.Directory[i]#)# GT 0>

	   						<!--- Crea las carpetas dentro del ftp (poner la ruta donde estara el FTP) --->
			   				<cfif NOT DirectoryExists('D:\FTP\SIIIP\documentosFTP\F41\'&archivos.PK_CFORMATO[j]&'\'&archivos.PK_COL[j]&'\'&archivos.PK_FILA[j])> 
								<cfdirectory action="create" directory="D:\FTP\SIIIP\documentosFTP\F41\#archivos.PK_CFORMATO[j]#\#archivos.PK_COL[j]#\#archivos.PK_FILA[j]#">
							</cfif>

							<cfdirectory action="copy" destination="D:\FTP\SIIIP\documentosFTP\F41\#archivos.PK_CFORMATO[j]#\#archivos.PK_COL[j]#\#archivos.PK_FILA[j]#" directory="#myList.Directory[i]#" >

	   					</cfif>
	   				</cfif>


	   			</cfif>
	   		</cfloop>
   		</cfloop>

   		<cfreturn true>

	</cffunction>







	<cffunction name="getArchivosMigracion" hint="">
		<cfquery name="res" datasource="DS_GRAL">
			SELECT  DOC.TAR_NOMBRE_ARCHIVO AS ARCHIVO,
					DOC.TAR_PKOBJETO AS OBJETO,
					DOC.TAR_FK_CARCHIVO AS CATALOGO,
					DOC.TAR_OBJ_TEMP    AS OBJ_TEMP,
					DOC.TAR_CAT_TEMP    AS CAT_TEMP
			FROM    GRAL.DOCTARCHIVOS2  DOC
			WHERE   DOC.TAR_PK_TEMPORAL IS NOT NULL
			  AND   DOC.TAR_CAT_TEMP IS NOT NULL
		</cfquery>
		<cfreturn res>
	</cffunction>


	<cffunction name="getArchivosTrayectoria" hint="">
		<cfquery name="res" datasource="DS_GRAL">
			SELECT  DOC.TAR_NOMBRE_ARCHIVO AS ARCHIVO,
					DOC.TAR_PKOBJETO AS OBJETO,
					DOC.TAR_FK_CARCHIVO AS CATALOGO,
					DOC.TAR_OBJ_TEMP    AS OBJ_TEMP,
					DOC.TAR_CAT_TEMP    AS CAT_TEMP,
					TFA.TFA_FK_ASPIRANTE AS ASPIRANTE
			FROM    GRAL.DOCTARCHIVOS2  DOC,
                    SIIIP.EDI_TFORMACION_ACADEMICA@DBL_SIIIP TFA
			WHERE   DOC.TAR_PK_TEMPORAL IS NOT NULL
			  AND   DOC.TAR_CAT_TEMP  IN (97, 31)
			  AND   DOC.TAR_OBJ_TEMP = TFA.TFA_PK_FORMACION_ACADEMICA
		</cfquery>
		<cfreturn res>
	</cffunction>


	<cffunction name="getArchivosHumanos" hint="">
		<cfquery name="res" datasource="DS_GRAL">
			SELECT  DOC.TAR_NOMBRE_ARCHIVO AS ARCHIVO,
					DOC.TAR_PKOBJETO AS OBJETO,
					DOC.TAR_FK_CARCHIVO AS CATALOGO,
					DOC.TAR_OBJ_TEMP    AS OBJ_TEMP
			FROM    GRAL.DOCTARCHIVOS2  DOC
			WHERE   DOC.TAR_PK_TEMPORAL IS NOT NULL
			  AND   DOC.TAR_FK_CARCHIVO IN (868, 867, 866)
		</cfquery>
		<cfreturn res>
	</cffunction>



	<cffunction name="getDisenoRedisenoProgramas" hint="">
		<cfquery name="res" datasource="DS_GRAL">
SELECT DOC.TIA_FK_ELEMENTO AS PKproceso,
       DOC.TIA_FK_ARCHIVO  AS CAT_SIP,
       DOC.TIA_ARCHIVO     AS NOM_SIP,
       PROP.TPP_FK_FILA    AS PK_FILA,
       CEL.TCE_FK_FORMATO  AS PK_CFORMATO,
       COLM.TCL_PK_COLUMNA AS PK_COL,
       CEL.TCE_VALOR       AS NOM_DOC,
       PERS.TPS_PK_TEMP    AS ELEM_SIP
  FROM EVTTCELDA CEL,
       EVTTCOLUMNA COLM,
       CVUCTPRODUCTOPERSONA PROP,
       SIIIP.EDI_TINVESTIGACION_ARCHIVOS@DBL_SIIIP DOC,
       CVUTPERSONA PERS
 WHERE DOC.TIA_FK_ARCHIVO		IN (95)
   AND DOC.TIA_FK_ELEMENTO     	= PROP.TPP_PK_PRODUCTOTEMP
   AND PROP.TPP_FK_FILA        	= CEL.TCE_FK_FILA
   AND CEL.TCE_FK_COLUMNA      	= COLM.TCL_PK_COLUMNA
   AND COLM.TCL_FK_TIPODATO    	IN (104, 41)
   AND CEL.TCE_FK_FORMATO      	= 121
   AND PROP.TPP_FK_PERSONA     	= PERS.TPS_PK_PERSONA
		</cfquery>
		<cfreturn res>
	</cffunction>




</cfcomponent>
