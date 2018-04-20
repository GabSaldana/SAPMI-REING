<!---
========================================================================
* IPN - CSII
* Sistema: EVALUACION
* Modulo: Clasificacion de encabezados de formatos y Definicion del cubo
* Fecha: Marzo de 2017
* Descripcion: handler 
* Autor: Alejandro Tovar
=========================================================================
--->

<cfcomponent>
	<cfproperty name="CN_Formatos" inject="formatosTrimestrales.CN_FormatosTrimestrales">

	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="index" access="public" returntype="void" output="false" hint="Lanza una ventana vacia para cargar los formatos validados">
		<cfargument name="event" type="any">
		<cfscript>
			prc.formato = CN_Formatos.getFormatosValidados();
			prc.cubos   = CN_Formatos.getCubos();
			event.setView("formatosTrimestrales/defCubo/defCubo");
		</cfscript>
    </cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
	<cffunction name="getClasificaciones" access="public" returntype="void" output="false"  hint="Obtiene los formatos validados">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.clasificacion = CN_Formatos.getClasificaciones();
			event.setView("formatosTrimestrales/defCubo/tablaFormatos").noLayout();
		</cfscript>
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getOpcionesClasificacion" access="public" returntype="void" output="false"  hint="Obtiene opciones para clasificar el encabezado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.infoCubo = CN_Formatos.getInfoCubo(rc.pkCubo);
			prc.hechos 	 = CN_Formatos.getHechos(rc.pkCubo);
			prc.dimensiones   = CN_Formatos.getDimensionesAsociadas(rc.pkCubo);
			prc.clasificacion = CN_Formatos.getClasificacion();
			event.setView("formatosTrimestrales/defCubo/opcionesClasificacion").noLayout();
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getDefinicionCubo" access="public" returntype="void" output="false"  hint="Obtiene opciones para clasificar el encabezado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.infoCubo = CN_Formatos.getInfoCubo(rc.pkCubo);
			prc.hechos 	 = CN_Formatos.getHechos(rc.pkCubo);
			prc.dimensiones = CN_Formatos.getDimensiones();
			prc.dimensionesAsociadas = CN_Formatos.getDimensionesAsociadas(rc.pkCubo);
			event.setView("formatosTrimestrales/defCubo/definicionCubo").noLayout();
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="cargaEncabezado" access="public" returntype="void" output="false" hint="carga la vista para captura de estructura de encabezado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.reporte = CN_Formatos.getEncabezado(rc.formato);
			prc.nombreReporte = CN_Formatos.getNombreFormato(rc.formato);
			event.setView("formatosTrimestrales/defCubo/clasificacionEncabezado").noLayout();
		</cfscript>
    </cffunction>


    <!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="guardaHecho" hint="Guarda hechos">
		<cfscript>
			resultado = CN_Formatos.guardaHecho(rc.nombreHecho, rc.tipoHecho, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="guardaDimension" hint="Guarda dimensiones">
		<cfscript>
			resultado = CN_Formatos.guardaDimension(rc.nombreDimen, rc.prefijoDimen);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="guardaCubo" hint="Guarda cubos">
		<cfscript>
			resultado = CN_Formatos.guardaCubo(rc.nombreCubo, rc.prefijoCubo, rc.pkFormato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="saveCube" hint="Guarda cubos">
		<cfscript>
			resultado = CN_Formatos.saveCube(rc.nombreCubo, rc.prefijoCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="asociaFormatoCubo" hint="Asocia formato-cubo">
		<cfscript>
			resultado = CN_Formatos.asociaFormatoCubo(rc.pkFormato, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="getPkCubo" hint="Obtiene el pk del cubo que esta asociado a un formato">
		<cfscript>
			resultado = CN_Formatos.getPkCubo(rc.pkFormato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getTablaCubos" access="public" returntype="void" output="false" hint="Obtiene la tabla de cubos asociados a un formato">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			prc.cubos = CN_Formatos.getPkCubo(rc.pkFormato);
			event.setView("formatosTrimestrales/defCubo/tablaCubos").noLayout();
		</cfscript>
    </cffunction>



	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="existeClasificacion" hint="Verifica si se han hecho cambios en la clasificacion">
		<cfscript>
			resultado = CN_Formatos.existeClasificacion(rc.pkFormato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="getcolumasDimension" hint="Obtiene las columnas de una dimension">
		<cfscript>
			resultado = CN_Formatos.getcolumasDimension(rc.pkDimension);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="asociaColumnaHecho" hint="Asocia una columna con un hecho">
		<cfscript>
			resultado = CN_Formatos.asociaColumnaHecho(rc.pkFormato, rc.pkHecho, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="asociaDimensionColumna" hint="Asocia columna con una dimension">
		<cfscript>
			resultado = CN_Formatos.asociaDimensionColumna(rc.pkFormato, rc.pkDimension, rc.pkColumna, rc.pkClasif, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="guardaColDim" hint="Guarda columna asociada a una dimensión">
		<cfscript>
			resultado = CN_Formatos.guardaColDim(rc.nombreCol, rc.tipoCol, rc.descrCol, rc.pkDimens);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="getConfigDimenColumna" hint="Obtiene la ascociacion de una columna con una dimension">
		<cfscript>
			resultado = CN_Formatos.getConfigDimenColumna(rc.pkColumna, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="getConfigHechoColumna" hint="Obtiene la ascociacion de una columna con un hecho">
		<cfscript>
			resultado = CN_Formatos.getConfigHechoColumna(rc.pkColumna, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="actualizaRelHecho" hint="Actualiza relacion entre una columna y un hecho">
		<cfscript>
			resultado = CN_Formatos.actualizaRelHecho(rc.pkHecho, rc.pkHecoColumna);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="actualizaRelDimension" hint="Actualiza el registro de una columna asociada a una dimension">
		<cfscript>
			resultado = CN_Formatos.actualizaRelDimension(rc.pkCubo, rc.pkDimension, rc.pkColDim, rc.pkClasif, rc.pkRelCols);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="validaCubo" hint="Establece como creado el registro del cubo.">
		<cfscript>
			resultado = CN_Formatos.validaCubo(rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Marzo, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="asociaDimensionCubo" hint="Asocia una dimension con el cubo">
		<cfscript>
			resultado = CN_Formatos.asociaDimensionCubo(rc.pkDimension, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Mayo 2016
	* @author: Ana Belem Juarez Mendez
	--->
	<cffunction name="existeAsociacionColumna" hint="Verifica si la columna esta asociada">
		<cfscript>
			resultado = CN_Formatos.existeAsociacionColumna(rc.pkColumna);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha creación: Mayo 2016
	* @author: Ana Belem Juarez Mendez
	--->
	<cffunction name="existeAsociacionDimension" hint="Verifica si la dimensión esta asociada">
		<cfscript>
			resultado = CN_Formatos.existeAsociacionDimension(rc.pkCubo, rc.pkDimension);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="existeAsociacionHecho" hint="Verifica si el hecho esta asociado">
		<cfscript>
			resultado = CN_Formatos.existeAsociacionHecho(rc.pkHecho);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Mayo 2017
	* @author: Ana Belem Juarez Mendez
	--->
	<cffunction name="eliminarColumna" hint="Elimina una columna de una dimensión">
		<cfscript>
			resultado = CN_Formatos.eliminarColumna(rc.pkColumna);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

<!---
	* Fecha creación: Mayo, 2016
	* @author: Ana Belem Juarez Mendez
	--->
	<cffunction name="desasociarHecho" hint="Desasocia una columna y un hecho">
		<cfscript>
			resultado = CN_Formatos.desasociarHecho(rc.pkHecoColumna);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Mayo 2017
	* @author: Ana Belem Juarez Mendez
	--->
	<cffunction name="desasociarDimension" hint="Desasocia una dimensión de una columna de un formato">
		<cfscript>
			resultado = CN_Formatos.desasociarDimension(rc.pkRelCols);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Mayo 2017
	* @author: Ana Belem Juarez Mendez
	--->
	<cffunction name="desasociarCuboDimension" hint="Desasocia una dimensión de un cubo">
		<cfscript>
			resultado = CN_Formatos.desasociarCuboDimension(rc.pkCubo, rc.pkDimension);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="cambiaEstadoHecho" hint="Cambia a 0 el estado del hecho">
		<cfscript>
			resultado = CN_Formatos.cambiaEstadoHecho(rc.pkHecho);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

   	<!---
	* Fecha creación: Abril, 2017
	* @author: Ana Belem Juárez M
	--->
	<cffunction name="getAnalisisAutomatico" hint="Obtiene el analisis del formato.">		
		<cfscript>
			resultado = CN_Formatos.getAnalisisAutomatico(rc.pkCubo, rc.pkFormato);				
			event.renderData(type="json", data=resultado);			
		</cfscript>
	</cffunction>

   	<!---
	* Fecha creación: Abril, 2017
	* @author: Ana Belem Juárez M
	--->
	<cffunction name="update_AnalisisAutomatico" hint="Actualiza el analisis del formato.">
		<cfscript>
			resultado = CN_Formatos.updateAnalisisAutomatico( rc.pkCubo, rc.pkColumna);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="getPreview" hint="Obtiene la vista previa de los datos del cubo.">
		<cfscript>
			prc.registros = CN_Formatos.getPreview(rc.pkCubo, rc.pkFormato);
			event.setView("formatosTrimestrales/defCubo/vistaPrevia").noLayout();
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="creaVistaBD" hint="Crea la vista en la base de datos.">
		<cfscript>
			resultado = CN_Formatos.creaVistaBD(rc.pkCubo);			
			event.renderData(type="json", data=resultado);	
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="replicaClasificacion" hint="Replica la clasificacion del encabezado, en caso de ser formato contenedor.">
		<cfscript>
			resultado = CN_Formatos.replicaClasificacion(rc.pkFormato, rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha creación: Abril, 2016
	* @author: Alejandro Tovar
	--->
	<cffunction name="cargaMetadatos" hint="Hace la carga de metadatos.">
		<cfscript>
			var resultado = CN_Formatos.cargaMetadatos(rc.pkCubo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent>
