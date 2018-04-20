<cfcomponent>

	<cfproperty name="fileManager" inject="utils.filetransfer.FileManager">

	<!---
	* Fecha:		Diciembre 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="index" access="public" returntype="void" output="false" hint="carga las vista principal">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.Periodos  = cn.getPeriodos();
			prc.Formatos = cn.getFormatos();
			event.setView("formatosTrimestrales/captura/captura");
		</cfscript>
    </cffunction>

	<!---
	* Fecha:		Diciembre 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="getAdmonFormatos" access="public" returntype="void" output="false"  hint="carga la vista de administracion de formatos">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.formatosPeriodo  = cn.getFormatosPeriodo(rc.formato, rc.periodo);
			event.setView("formatosTrimestrales/captura/administradorFormatos").noLayout();
		</cfscript>
    </cffunction>

	<!---
	* Fecha:		Diciembre 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="getInfoReporte" access="public" returntype="void" output="false"  hint="obtiene la informacion del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo);
			prc.acciones = cn.getReporte(rc.reporte);
			prc.optionsmap  = cn.getCatalogoAsociacionesDependencias(prc.reporte.getpkAsociacion());
			event.setView("formatosTrimestrales/captura/tablaCaptura").noLayout();
		</cfscript>
    </cffunction>


    <!---
	* Fecha:		Diciembre 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="getCapturaReporte" access="public" returntype="void" output="false"  hint="obtiene la informacion del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo);
			prc.acciones = cn.getReporte(prc.reporte.getpkReporte());
			event.setView("formatosTrimestrales/captura/consulta").noLayout();
		</cfscript>
    </cffunction>


	<!---
	* Fecha:		Enero 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="getInfoReporteConsulta" access="public" returntype="void" output="false"  hint="obtiene la informacion del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo); 
			event.setView("formatosTrimestrales/captura/consulta").noLayout();
		</cfscript>
    </cffunction>


	<!---
	* Fecha:		Diciembre 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="guardarInfo" access="public" returntype="void" output="false"   hint="guarda la informacion del reporte">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.guardarInfo(rc.pkCformato,rc.pkTformato, rc.periodo, rc.pkReporte, rc.datos);
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    </cffunction>

	<!---
	* Fecha:		Enero 2016
	* @author: 		Marco Torres.
	--->
	<cffunction name="eliminarFilas" access="public" returntype="void" output="false" hint="elimina las filas que esten en el array">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.eliminarFilas(rc.pkCformato, rc.periodo, rc.pkReporte, rc.arrayEliminadas);
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    </cffunction>


    <!---
	* Fecha:		Febrero 2017
	* @author: 		Alejandro Tovar
	--->
	<cffunction name="cambiarEstadoRT" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.cambiarEstadoRT(rc.pkRegistro, rc.accion, rc.nombreFormato, rc.periodoFormato, rc.claveFormato);
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    </cffunction>
    
    <!---
	* Fecha:		Febrero 2017
	* @author: 		Marco Torres, Ana Juarez.
	--->
	<cffunction name="getColumna" access="public" returntype="void" output="false" hint="carga la vista de configuracion de las columnas">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getColumna(rc.fila,rc.columna);

			prc.plantillas = cn.getPlantillas();
			prc.tiposDato = cn.getTiposDato();
			prc.columna  = respuesta.columna ;
			prc.sumandos  = respuesta.sumandos ;

			event.setView("formatosTrimestrales/captura/columna").noLayout();
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="getReporteLlenado" access="public" returntype="void" output="false" hint="obtiene la informacion del reporte seleccionado para el llenado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo, rc.reporte);
			prc.optionsmap  = cn.getCatalogoAsociacionesDependencias(prc.reporte.getpkAsociacion());

			if ( ArrayIsEmpty(prc.reporte.getfilas()) ){

				var pkColumnas = ArrayNew(1);

				for ( columna in prc.reporte.getEncabezado().getColumnasUltimoNivel() ){
		    		ArrayAppend(pkColumnas, columna.getData() );
				}

				var resultado = cn.crearFilaNueva(rc.formato, rc.reporte, serializeJSON(pkColumnas), rc.producto, session.cbstorage.persona.PK);
				prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo, rc.reporte);
				prc.optionsmap  = cn.getCatalogoAsociacionesDependencias(prc.reporte.getpkAsociacion());
				event.setView("formatosTrimestrales/captura/formularioCaptura").noLayout();

			}else {
				event.setView("formatosTrimestrales/captura/formularioCaptura").noLayout();
			}

		</cfscript>
    </cffunction>


    <!---
	* Fecha:   Septiemnbre 2017
	* @author: Alejandro Tovar
	--->  
	<cffunction name="getPkFila" access="public" returntype="void" output="false" hint="Obtiene el pk de la fila">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo, rc.reporte);
			var pkFila = prc.reporte.getfilas()[1].getPk_Fila();

			event.renderData(type="json", data=pkFila);
		</cfscript>
    </cffunction>


    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="getFilaData" hint="obtiene la informacion de la fila del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var resultado = cn.getFilaData(rc.pkFila);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="saveDatosFormulario" hint="guardar la informacion de la fila del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
		<cfscript>
			cn.actualizarEstadoFila(rc.pkFila,2);
			var resultado = cn.saveDatosFormulario(rc.fila, rc.pkFila);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="crearFilaNueva" hint="crea una fila para el reporte que se esta llenando">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
		<cfscript>

			var resultado = cn.crearFilaNueva(rc.formato, rc.reporte, rc.pkColumnas, rc.pkProducto, session.cbstorage.persona.PK);
			cn.actualizarEstadoFila(resultado,0);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="eliminarFilaFormulario" hint="elimina una fila para el reporte que se esta llenando">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var resultado = cn.eliminarFilaFormulario(rc.pkFila);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="cargarNota" hint="obtiene la nota del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var resultado = cn.cargarNota(rc.formato, rc.periodo, rc.reporte);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Marzo 2017
	* @author: 		SGS
	--->  
	<cffunction name="guardarNota" hint="edita la nota del reporte seleccionado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var resultado = cn.guardarNota(rc.formato, rc.periodo, rc.reporte, rc.nota);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>


    <!---
	* Fecha: Septiembre 2017
	* @author: Alejandro Tovar
	--->  
	<cffunction name="getTfidf" hint="calcula el tf-idf de mision vision y objetivo">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var resultado = cn.getTfidf(rc.formato);
			event.renderData(type="json", data=resultado);
		</cfscript>
    </cffunction>


    <!---
	* Fecha: Octubre 2017
	* @author: Alejandro Tovar
	--->
	<cffunction name="subirArchivo" hint="Sube el archivo al servidor FTP">
		<cfargument name="Event" type="any">
		<cfscript>
			var CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales");
			var resultado = 0;
			rc = Event.getCollection();
			attachResult = fileManager.attachFile("upload_files", "sero.listas", session.cbstorage.usuario.vertiente & "\" & rc.pkCFormato & "\" & rc.pkColumna & "\" & rc.pkFila & "\");
			if(attachResult.SUCCESS) {
				var archivo = CN.registrarArchivo(rc.pkCFormato, rc.pkColumna, rc.pkFila, attachResult.FILENAME);
				resultado = 1;
			}
	    </cfscript>
	    <cfreturn resultado>
	</cffunction>


	<!---
	* Fecha: Octubre 2017
	* @author: Alejandro Tovar
	--->
	<cffunction name="descargarComprobante" access="remote" hint="Descarga un archivo del FTP">
		<cfscript>
			rc = Event.getCollection();
			var CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales");
			fileNameDownload = CN.consultarNombreArchivo(rc.pkCatFmt, rc.pkColDown, rc.pkFilaDown).NOMBRE[1];

			if ( structKeyExists(rc,"vertiente") ){
				path = rc.vertiente & "\" & rc.pkCatFmt & "\" & rc.pkColDown & "\" & rc.pkFilaDown & "\";
			}else {
				path = session.cbstorage.usuario.vertiente & "\" & rc.pkCatFmt & "\" & rc.pkColDown & "\" & rc.pkFilaDown & "\";
			}

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
				abort;
			}else {
				/*MODIFICACION PARA OBTENER LOS DOCUMENTOS QUE SE SUBIERON AL SISTEMA CON DOS O MAS PUNTOS EN EL NOMBRE*/
				var rutaFtp = "ftp://148.204.77.105/siiis/documentos/documentosFtp/" & path;
				// var rutaFtp = "D:\FTPSIIP\siiis\documentos\documentosFtp\1\95\439\225777";

				var lista = directoryList(rutaFtp, true, 'name', "", "DateLastModified DESC");
				var split = listToArray(fileNameDownload, '.');
				var correccionNombre = '';
				
				for (archivo in lista){
					if ( find(split[1], archivo) EQ 1 ){
						correccionNombre = archivo;
						break;
					}
				}

				// Considerado para los casos en los que el archivo tiene caracteres especiales y no los encuentra (regresa el ultimoq ue subieron).
				if(correccionNombre EQ ''){
					if(ArrayLen(lista) GT 0){
						correccionNombre = lista[1];
					}
				}

				if (correccionNombre NEQ ''){
					fileResult = fileManager.downloadFile(correccionNombre, "sero.listas", path);

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
						abort;
					}
				}else {
					event.setView("adminCSII/vistasaAvisos/archivoNoEncontrado").noLayout();
				}
			}
		</cfscript>
	</cffunction>


	<!---
	* Fecha:	Octubre 2017
	* @author: 	Alejandro Tovar.
	--->
	<cffunction name="cargaProductos" access="public" returntype="void" output="false"  hint="carga la vista de administracion de formatos">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.productos  = cn.getNodosHoja(rc.pkProducto);
			prc.pkProducto = rc.pkProducto;
			prc.revistaissn = rc.revistaissn;
			event.setView("formatosTrimestrales/captura/productos2").noLayout();
		</cfscript>
    </cffunction>


    <!---
	* Fecha:	Octubre 2017
	* @author: 	Alejandro Tovar.
	---> 
	<cffunction name="productosEdicion" access="public" returntype="void" output="false" hint="obtiene la informacion del reporte seleccionado para el llenado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			if(StructKeyExists(rc, "estado")){
				prc.validacion = rc.estado;
			}else{
				prc.validacion = 0;
			}
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo, rc.reporte);
			prc.optionsmap  = cn.getCatalogoAsociacionesDependencias(prc.reporte.getpkAsociacion());

			if ( ArrayIsEmpty(prc.reporte.getfilas()) ){

				var pkColumnas = ArrayNew(1);

				for ( columna in prc.reporte.getEncabezado().getColumnasUltimoNivel() ){
		    		ArrayAppend(pkColumnas, columna.getData() );
				}

				var resultado = cn.crearFilaNueva(rc.formato, rc.reporte, serializeJSON(pkColumnas));
				prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo, rc.reporte);
				prc.optionsmap  = cn.getCatalogoAsociacionesDependencias(prc.reporte.getpkAsociacion());
				event.setView("formatosTrimestrales/captura/productosEdicion").noLayout();

			}else {
				event.setView("formatosTrimestrales/captura/productosEdicion").noLayout();
			}

		</cfscript>
    </cffunction>
	
	
	    <!---
	* Fecha:	febreo 2018
	* @author: 	Marco Torres.
	---> 
	<cffunction name="editarproductoEvaluado" access="public" returntype="void" output="false" hint="obtiene la informacion del reporte seleccionado para el llenado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte = cn.getInfoReporte(rc.formato, rc.periodo, rc.reporte);
			prc.optionsmap  = cn.getCatalogoAsociacionesDependencias(prc.reporte.getpkAsociacion());
			
			event.setView("formatosTrimestrales/captura/productosEdicion").noLayout();
		</cfscript>
    </cffunction>


    <!---
   	* Fecha: 	20/12/2017
   	* @autor:	SGS
   	--->
   	<cffunction name="llenarPrecargados" access="public" hint="Obtiene los valores de la celdas que seran precargadas">
   		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
   		<cfscript>
   			var rc = Event.getCollection();
   			var resultado = CN.obtenerDatosPrecargados(rc.celda, rc.issn, rc.issnAnio);
   			return event.renderData(type="json", data=resultado);
   		</cfscript>
   	</cffunction>

	<!---
	* Fecha:	Enero de 2018
	* Autor:	Roberto Cadena
	---> 
	<cffunction name="eliminarProducto" hint="elimina el registro de productopersona y de fila">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			return CN.eliminarProducto(rc.pkFila);
		</cfscript>
	</cffunction>

	<!----
	* Fecha:	Marzo de 2018
	* Autor:	Alejandro Rosales
	--->
	<cffunction name="eliminarComprobante" hint="elimina el comprobante asociado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var resultado = CN.eliminarComprobante(rc.PKCATFMT, rc.PKCOLDEL, rc.PKFILADEL );
			return event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

</cfcomponent>
