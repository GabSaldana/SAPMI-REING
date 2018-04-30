

<cfcomponent <!--- accessors="true" singleton --->>

	<cfproperty name="dao" 			inject="formatosTrimestrales/DAO_FormatosTrimestrales">
    <cfproperty name="cnMes"      	inject="utils.maquinaEstados.CN_maquinaEstados">
	<cfproperty name="populator" 	inject="wirebox:populator">
	<cfproperty name="wirebox" 		inject="wirebox">
	<cfproperty name="cache" 		inject="cachebox:default">
	<cfproperty name="cnEmail" 		inject="utils.email.CN_service">
	<cfproperty name="cnUtils" 		inject="utils.CN_utilities">
	<cfproperty name="CNSOL"      	inject="EDI.solicitud.CN_solicitud">
	
	
	<cfset startTime = getTickCount()>
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
<!-----******************************Inicio Funciones de genericas de encabezado**************************************************************
**********************************************************************************************************************************************  --->

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="creaEncabezado" hint="Funcion que llena los objetos del encabezado ">
		<cfargument name="pkFormato">
		<cfscript>
			var encabezado2 = cache.get("encabezado_"&pkFormato);

			if (!isNull(encabezado2)){
				return encabezado2;
			}else {
				var columnas=[];
				var datosColumnas = dao.getEncabezado(pkFormato);
				for(var x=1; x lte datosColumnas.recordcount; x++){
					var columna=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Columna"),datosColumnas,x);
					columna.setOrden(x-1);
					/*para las columnas de tipo dropdown obtiene los datos correspondientes*/
					if(columna.getType() eq 'dropdown'){
						columna.setSource(getCatalogoColumna(columna.getpk_columna()));	
					}
					/*para las columnas de totales obtiene las columnas que se van a sumar*/
					if(columna.getTIPO_DATO() eq 5){
						columna.setSumandos(getColumnasSumables(columna.getpk_columna()));	
						columna.setOperandos(getOperandos(columna.getpk_columna()));
					}
					columna.getbloqueada() == 1 ? columna.setbloqueada(true) : columna.setbloqueada(false);
					arrayAppend(columnas, columna);
				}
				encabezado = wirebox.getInstance("formatosTrimestrales/B_Encabezado");
				/*se puede meter en el cosntructor*/
				encabezado.setColumnas(columnas);
				encabezado.setNiveles(getNivelMaximo(datosColumnas));
				encabezado.calculaHijos(columnas);

				cache.set("encabezado_"&pkFormato, encabezado, 120, 20);

				return encabezado;
			}

		</cfscript>
	</cffunction>

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getCatalogoColumna" hint="Obtiene un array con el catalogo para las columnas de tipo catalogo">
		<cfargument name="pkColumna">
		<cfscript>
			var consulta=dao.getCatalogoColumna(pkColumna);
			var listaOpciones = [];
			for(var x=1; x lte consulta.recordcount; x++){
				arrayAppend(listaOpciones, consulta.OPCIONES[x]);
			}
		</cfscript>
		<cfreturn listaOpciones>
	</cffunction>
	
	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez
	--->        
   	<cffunction name="getOperandos" hint="Obtiene un array de las columnas que se suman para un total por columna">
		<cfargument name="pkColumna">
		<cfscript>
			var consulta=dao.getColumnasSumables(pkColumna);
			var listaOpciones = [];
			for(var x=1; x lte consulta.recordcount; x++){
				arrayAppend(listaOpciones, consulta.operando[x]);
			}
		</cfscript>
		<cfreturn listaOpciones>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getColumnasSumables" hint="Obtiene un array de las columnas que se suman para un total por columna">
		<cfargument name="pkColumna">
		<cfscript>
			var consulta=dao.getColumnasSumables(pkColumna);
			var listaOpciones = [];
			for(var x=1; x lte consulta.recordcount; x++){
				arrayAppend(listaOpciones, consulta.sumandos[x]);
			}
		</cfscript>
		<cfreturn listaOpciones>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getNivelMaximo" hint="Obtiene el nivel maximo para el encabezado de la consullta ">
		<cfargument name="queryColumnas">
		<cfquery name="res" dbtype="query">
			select max(nivel) maxNivel
			from	queryColumnas
		</cfquery>
		<cfreturn res.maxNivel[1]>
	</cffunction>

	<!---
    * Fecha : Enero 2017
    * author : Daniel Memije
	--->        
   	<cffunction name="getTiposDato" hint="Obtiene los tipos de dato para las columnas">				
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').getTiposDato();
		</cfscript>		
	</cffunction>

	<cffunction name="getPlantillas" hint="Obtiene las plantillas">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').getPlantillas();
		</cfscript>
	</cffunction>

	<cffunction name="guardarElementosCatalogo" hint="Guarda el catalogo">		
		<cfargument name="pkColumna">
		<cfargument name="catalogo">
		<cfscript>									
			dao.eliminarElementosCatalogo(pkColumna);
			for(var elemento in catalogo){
				dao.insertarElementosCatalogo(pkColumna,elemento);
			}
			return dao.getCatalogoColumna(pkColumna);			
		</cfscript>
	</cffunction>

	<cffunction name="copiarFormato" hint="Guarda el catalogo">		
		<cfargument name="pkFormato">
		<cfargument name="clave">
		<cfargument name="nombre">
		<cfscript>												
			return dao.copiarFormato(pkFormato,clave,nombre,session.cbstorage.usuario.PK,session.cbstorage.usuario.ROL);			
		</cfscript>
	</cffunction>
	
	<cffunction name="bloquearparaCaptura" hint="Bloquea la columna para captura">		
		<cfargument name="pkColumna">
		<cfargument name="bloqueada">
		<cfscript>												
			return dao.bloquearparaCaptura(pkColumna,bloqueada);			
		</cfscript>
	</cffunction>

	<cffunction name="formatoVersion" hint="">
		<cfargument name="pkTFormato">
		<cfscript>
			return dao.formatoVersion(pkTFormato,session.cbstorage.usuario.PK,session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>
	
	<cffunction name="columnaReferencia" hint="Bloquea la columna para captura">		
		<cfargument name="pkColumna">
		<cfargument name="referencia">
		<cfscript>												
			return dao.columnaReferencia(pkColumna,referencia);			
		</cfscript>
	</cffunction>

	<cffunction name="setCopiableTrimestre" hint="Copiar esta columna para cada trimestre">		
		<cfargument name="pkColumna">
		<cfargument name="copiable">
		<cfscript>												
			return dao.setCopiableTrimestre(pkColumna,copiable);			
		</cfscript>
	</cffunction>

	<cffunction name="setCalcularTotales" hint="Calcular Totales para cada valor de esta columna">		
		<cfargument name="pkFormato">
		<cfargument name="pkColumna">
		<cfscript>												
			return dao.setCalcularTotales(pkFormato,pkColumna);			
		</cfscript>
	</cffunction>

	<cffunction name="setCalcularTotalFinal" hint="Es la columna de Total Final">		
		<cfargument name="pkFormato">
		<cfargument name="pkColumna">
		<cfscript>												
			return dao.setCalcularTotalFinal(pkFormato,pkColumna);			
		</cfscript>
	</cffunction>

	<cffunction name="actualizarNombreColumna" hint="Es la columna de Total Final">		
		<cfargument name="pkColumna">
		<cfargument name="nombre">
		<cfscript>												
			return dao.actualizarNombreColumna(pkColumna,nombre);			
		</cfscript>
	</cffunction>

	<cffunction name="registrarSumaSecciones" hint="Mostrar la suma por las secciones de esta columna">		
		<cfargument name="pkFormato">
		<cfargument name="pkPlantilla">
		<cfargument name="pkColumna">
		<cfargument name="pkAsociacion">
		<cfscript>												
			return dao.registrarSumaSecciones(pkFormato,pkPlantilla,pkColumna,pkAsociacion);			
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez
	--->      
	<cffunction name="actualizarOperando" hint="Registra el operando de una columa">		
		<cfargument name="pkColumna">
		<cfargument name="pkDestino">
		<cfargument name="operacion">		
		<cfscript>												
			return dao.actualizarOperando(pkColumna,pkDestino,operacion);			
		</cfscript>
	</cffunction>

	<cffunction name="registrarOperando" hint="Registra el operando de una columa">		
		<cfargument name="pkColumna">
		<cfargument name="pkDestino">
		<cfargument name="operacion">		
		<cfscript>												
			return dao.registrarOperando(pkColumna,pkDestino,operacion);			
		</cfscript>
	</cffunction>

	<cffunction name="eliminarOperando" hint="Elimina el operando de una columa">		
		<cfargument name="pkColumna">
		<cfargument name="pkDestino">		
		<cfscript>												
			return dao.eliminarOperando(pkColumna,pkDestino);			
		</cfscript>
	</cffunction>

	<cffunction name="actualizarDescripcionColumna" hint="Actualiza el texto de ayuda de la columna">				
		<cfargument name="pkColumna">
		<cfargument name="descripcion">
		<cfscript>												
			return dao.actualizarDescripcionColumna(pkColumna,descripcion);			
		</cfscript>
	</cffunction>

	<cffunction name="getInfoCopiar" hint="Obtiene la clave y el nombre del formato a copiar">				
		<cfargument name="pkTformato">		
		<cfscript>												
			return dao.getInfoCopiar(pkTformato);			
		</cfscript>
	</cffunction>			
	



	
	
<!-----******************************Fin Funciones de genericas de encabezado**************************************************************
*******************************************************************************************************************************************  --->





<!-----******************************Inicio Funciones del modulo de configuracion**************************************************************
**************************************************************************************************************************************  --->

	<cffunction name="getInfoFormato" hint="obtiene los elementos necesarios para pintar la infoemacion del formato ">
		<cfargument name="pkTFormato">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = dao.getinfoFormato(pkTFormato);
			var formato=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
		</cfscript>
		<cfreturn formato>
	</cffunction>
	
	<cffunction name="getEncabezado" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkFormato">
		<cfscript>
			var reporte = wirebox.getInstance("formatosTrimestrales/B_Reporte");
			reporte.setEncabezado(creaEncabezado(pkFormato)); 
		</cfscript>
		<cfreturn reporte>
	</cffunction>
	
	<cffunction name="getColumna" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="fila">
		<cfargument name="pkColumna">
		<cfscript>
			var datosColumnas=dao.getColumna(pkColumna);
			var resultado  = structnew();
			var sumandos=[];
			var columna=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Columna"),datosColumnas,1);

			/*para las columnas de tipo dropdown obtiene los datos correspondientes*/
			if(columna.getType() eq 'dropdown'){
				columna.setSource(getCatalogoColumna(columna.getpk_columna()));	
			}
			/*para las columnas de totales obtiene las columnas que se van a sumar*/
			if(columna.getTIPO_DATO() eq 5){
				columna.setSumandos(getColumnasSumables(columna.getpk_columna()));	
				columna.setOperandos(getOperandos(columna.getpk_columna()));
			}
			if (isArray(columna.getSumandos())){
				for(var sumando in columna.getSumandos() ){
					arrayAppend(sumandos, this.getColumna(0,sumando).columna);
				}
			}
			respuesta.sumandos = sumandos;
			respuesta.columna = columna;
		</cfscript>
		<cfreturn respuesta>
	</cffunction>	
	
	<cffunction name="insertarFormato" access="public" >
		<cfargument name="clave" 	   hint="">
		<cfargument name="nombre"    hint="">		
		<cfargument name="vigencia"    hint="">
		<cfargument name="uresponsable"    hint="">
		<cfargument name="instrucciones"    hint="">
		<cfscript>
			
			/*esto ase debe de jalar con una constante*/
			var pkEdoInicio = 2;
			var pkruta	= 1;
			/*********************/
			
			return CreateObject('component', 'DAO_FormatosTrimestrales').insertarFormato(clave, nombre, vigencia, uresponsable,instrucciones,pkEdoInicio, pkruta,session.cbstorage.usuario.PK, session.cbstorage.usuario.rol);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarFormato" access="public" >
		<cfargument name="pkFormato" 	   	hint="">
		<cfargument name="claveFormato" 	hint="">
		<cfargument name="nombreFormato"	hint="">		
		<cfargument name="vigenciaFormato"	hint="">
		<cfargument name="areaFormato"    	hint="">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').actualizarFormato(pkFormato,claveFormato, nombreFormato,vigenciaFormato, areaFormato);
		</cfscript>
	</cffunction>


	<cffunction name="getClasif" access="public">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').getClasif();
		</cfscript>
	</cffunction>

	<cffunction name="getUR" access="public">
		<cfargument name="pkClasif" hint="">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').getUR(pkClasif);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarTipoDato" access="public">
		<cfargument name="pkColumna" hint="">
		<cfargument name="pkTipoDato" hint="">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').actualizarTipoDato(pkColumna,pkTipoDato);
		</cfscript>
	</cffunction>	

	<cffunction name="getElementosPlantilla" access="public">
		<cfargument name="pkPlantilla" hint="">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').getElementosPlantilla(pkPlantilla);
		</cfscript>
	</cffunction>

	<cffunction name="guardarPlantillaColumna" access="public">
		<cfargument name="pkColumna" hint="">
		<cfargument name="pkPlantilla" hint="">
		<cfscript>
			return CreateObject('component', 'DAO_FormatosTrimestrales').guardarPlantillaColumna(pkColumna,pkPlantilla);
		</cfscript>
	</cffunction>

	<cffunction name="getAsociacionPlantillas" access="public">
		<cfargument name="pkPlantilla" hint="">
		<cfscript>
			return dao.getAsociacionPlantillas(pkPlantilla);
		</cfscript>
	</cffunction>

	<cffunction name="getPlantillasAsociadas" access="public">
		<cfargument name="pkPlantilla" hint="">
		<cfscript>
			return dao.getPlantillasAsociadas(pkAsociacion);
		</cfscript>
	</cffunction>

	

	
	
	<cffunction name="guardarEstructuraReporteP2" hint="guarda la estructura del encabezado">
		<cfargument name="pkTformato">
		<cfargument name="encabezado">
		<cfscript>
			cache.clearAll();
		
			var arrayEncabezado = deserializejson(encabezado);
			
			var arrayPadres = [];
			/*para evitar que queden activas columnas que se eliminaron o se unieron,
			*  primero enviamos todas las columnas a estado cero, las que aun sigan en el encabezado regresaran posteriormente a estado uno*/
			dao.updateAllColumnastoCero(pkTformato);
			/*writedump(arrayEncabezado);
			abort;*/
			/*recorre las filas*/
			for(var fila in arrayEncabezado){
				/*recorre las columnas*/
				for(var celda in fila){
					/*en el caso del nivel 1 solo envia el pk padre como 0*/
					if(celda.nivel eq 1){
						var padre = 0;
					} else {
						/*en caso contrario recorre el arreglo que contiene los pks nuevos relacionados con los anteriores*/
						var padre = 0;
						for (var pkcolumnaTmp in arrayPadres){
							if(pkcolumnaTmp.pktemporal eq celda.idTMPpadre)	{
								padre = pkcolumnaTmp.pkcolumna;
							break;	
							}
						}
					}
					var pksColumna =structNew();
					
					if((structkeyexists(celda,'pkColumna')) and celda.pkColumna neq ''){
						pksColumna.pkcolumna =	 dao.updateColumnaEstructura(celda.pkColumna,celda.valor, celda.nivel ,celda.posicion, celda.colspan, 1, padre);
					} else {
						pksColumna.pkcolumna =	 dao.insertarColumna(pkTformato,celda.valor, celda.nivel ,celda.posicion, celda.colspan, 1, padre);
					}
					pksColumna.pktemporal = celda.idTmp;
					arrayappend(arrayPadres,pksColumna);
				}
			}
			
		</cfscript>
		<cfreturn 1>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	* Descripcion : Particularizacion del cambio de estado a la configuracion de formatos
------------------------------------------------ 
	Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="cambiarEstadoFT" hint="Se cambia el estado del registro en cuestión a partir de la accion que se realiza.">
        <cfargument name="pkRegistro"    type="numeric" required="yes" hint="Pk del registro que se va a modificar">
        <cfargument name="accion"      type="string" required="yes" hint="Pk de la acción">
        <cfscript>

            respuesta = StructNew();
            resPreoperacion   = StructNew();
            postPreoperacion  = StructNew();
            respuesta.exito   = true;
            respuesta.mensaje = '';
            
            var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.CONFIGURACION_FORMATOS#;
            var ROL = session.cbstorage.usuario.ROL;
             
            //OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
            estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
            pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, ROL,estadoactual.ESTADO[1]);

            //OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
            //EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)
            resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1]);

            //SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
            if (resPreoperacion.exito){
                //CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
                registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

                //VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
                if (registroBitacora.fallo){
                    //obtiene el estado actual del registro y lo muestra en el mensaje de salida.
                    respuesta.exito = false;
                    respuesta.fallo = true;
                    respuesta.mensaje = estadoactual.NOM_EDO[1];
                    return respuesta;
                }

                //OBTENER POS-OPERACIONES DE LA ACCION
                postPreoperacion  = this.ejecutaPostOperaciones(pkEdoAccion.EDOACC_PK[1]);
                respuesta.exito   = postPreoperacion.exito;
                respuesta.mensaje = postPreoperacion.mensaje;

                //ACTUALIZA LA BITÁCORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
                if (respuesta.mensaje NEQ ''){
                    cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
                }

            }else {
                respuesta = resPreoperacion;
            }

            return respuesta;
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene y ejcuta las pre-operaciones.
    --->
    <cffunction name="ejecutaPreOperaciones" hint="Ejecuta pre-operaciones">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfscript>
            respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';
            return respuesta;
        </cfscript>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene y ejcuta las pos-operaciones.
    --->
    <cffunction name="ejecutaPostOperaciones" hint="Ejecuta pos-operaciones">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfscript>
            respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';
            return respuesta;
        </cfscript>
    </cffunction>
	
	

<!-----******************************Fin Funciones del modulo de configuracion**************************************************************
**************************************************************************************************************************************  --->




<!-----******************************Inicio Funciones del modulo de captura***************************************************************
******************************************************************************************************************************************  --->
	<!-------funciones de guardado-------->
	
	<cffunction name="getInfoReporte" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			datosColumnas.FILAFIJA[1] = datosColumnas.FILAFIJA[1] EQ 1 ? 0 : 1;
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilas(pkTFormato,pkPeriodo)); 
		
			/*si tiene una seccion asociaciada consruye la estructutra y la mete en la propiedad secciones*/
			if(reporte.getpkPlantillaSeccion() NEQ ''){
				/*obtiene el pk de la plantilla de la columna de referencia*/
				
				var columna = reporte.getEncabezado().getColumnaByPK(reporte.getpkColumnaSeccion());
				
				var pkplantillaColumna = columna.getPk_plantilla();
				 
				var secciones = getEstructuraSecciones(reporte.getpkPlantillaSeccion(),pkplantillaColumna, reporte.getpkAsociacion());
				reporte.setSecciones(secciones);
			}
			
		</cfscript>
		<cfreturn reporte>
	</cffunction>
	
	<!---
    * Fecha : Febrero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="getEstructuraSecciones" hint="crea un aray con las secciones asociadas">
		<cfargument name="pkPlatillaPadre">
		<cfargument name="pkPlatillaHijo">
		<cfargument name="pkAsociacion">
		<cfscript>
			var consulta=dao.getEstructuraSecciones(pkPlatillaPadre,pkPlatillaHijo,pkAsociacion);
			var arraySecciones=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var asociado = structnew();
				asociado.padre = consulta.ELEMPADRE[x];
				asociado.hijo  = consulta.ELEMHIJO[x];
				arrayAppend(arraySecciones, asociado);
			}
		</cfscript>
		<cfreturn arraySecciones>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getArrayFilas" hint="crea un array con las filas de los reportes">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfscript>
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
		
		
		    if(pkTFormato == 0)
		    	var pkCFormato = 0;
		    else	
		        var pkCFormato = dao.getinfoFormato(pkTFormato).PKCFORMATO[1];
		    
		    
			var consulta=dao.getRespuestas(pkCFormato,pkTFormato,pkPeriodo,pkUsuario);
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
				var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Fila"),consulta,x);
					fila.SETCELDAS(celdas);
					arrayAppend(filas, fila);
					var celdas=[];
				}	
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>
	
	
	<!-------funciones de guardado-------->
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="guardarInfo" hint="funcion general para guardar la informacion">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkReporte">
		<cfargument name="datos">
		<cfscript>
			var estructuraDatos = crearEstructuraDatos(datos);
			
	
			actualizarDatos(pkCFormato, pkTFormato, pkPeriodo, estructuraDatos.DatosConPK);
			insertarDatos(pkCFormato,pkTFormato, pkPeriodo, pkReporte, estructuraDatos.DatosSinPK);
			abort;
		</cfscript>
		<cfreturn 1>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="crearEstructuraDatos" hint="crea una estructura con los datos que se van a actualizar y los que se van a insertar">
		<cfargument name="datos">
		<cfscript>
			var arrayDatos = deSerializeJSON(datos);
			var arrayDatosConPK = [];
			var arrayDatosSinPK = [];
			var res = structnew();
			
			for (fila in arrayDatos){
				if(StructKeyExists(fila, 'PK_FILA')){ 
					if (fila['PK_FILA'] neq 'encabezado' AND fila['PK_FILA'] neq 'TOTAL'){
						arrayappend(arrayDatosConPK,getArrayValoresConPKs(fila));
					}
				} else {
					arrayappend(arrayDatosSinPK,getArrayValoresSinPKs(fila));
				}
			}
			res.DatosConPK =arrayDatosConPK;
			res.DatosSinPK =arrayDatosSinPK;
		</cfscript>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="actualizarDatos" hint="recorre el arreglo y actualiza las filas que contiene">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="datos">
		<cfscript>
			var res=0;
			for (fila in datos){
				for (celda in fila){
					res = dao.actualizarDatos(pkCFormato,pkTFormato,pkPeriodo,celda.pkColumna, celda.pkfila,  celda.valor);
				}
			}
		</cfscript>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="insertarDatos" hint="recorre el arreglo e inserta las filas que contiene">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkReporte">
		<cfargument name="datos">
		<cfscript>
			
			var res=0;
			for (fila in datos){
				if(arraylen(fila) gt 0)
				var filaNueva = dao.insertarFila(pkCFormato,pkTFormato,pkPeriodo,pkReporte,session.cbstorage.usuario.PK);
				for (celda in fila){
					res = dao.insertarDatos(pkCFormato,pkTFormato,pkPeriodo,celda.pkColumna, filaNueva, celda.valor);
				}
			}
		</cfscript>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="eliminarFilas" hint="recorre el arreglo y elimina las filas que contiene">
		<cfargument name="pkCformato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkReporte">
		<cfargument name="arrayEliminadas">
		<cfscript>
			var array =  deserializeJSON(arrayEliminadas);
			var res=dao.eliminarFilas(pkCformato,pkPeriodo,arraytolist(array,","));
		</cfscript>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getArrayValoresConPKs" hint="A partir de una fila obtiene una estructura de pks de forma estandarizada (fila, columna valor)">
		<cfargument name="arreglo">
		<cfscript>
			var lista = StructKeyList(arreglo);
			var arrayValoresPKs= [];
			var totalValores = 0;
			
			for (i = 1;i lte ListLen(lista,",");i++ ){
				var res = structNew(); 
				res.pkfila = structFind(arreglo,'PK_FILA');
				res.pkColumna =listGetAt(lista,i,',');
				
				if(res.pkColumna neq 'PK_FILA'){
					if(structKeyexists(arreglo,res.pkColumna)){
						res.valor = StructFind(arreglo,res.pkColumna);
						totalValores++;
					} else{
						res.valor = '';
					}
					arrayappend(arrayValoresPKs,res);
				}
			}
			if(totalValores eq 0){
				/*si el arreglo no trae ningun valor regresa el array vacio y no inserta ningun dato*/
				arrayValoresPKs = [];
			}
			return arrayValoresPKs;
		</cfscript>
	</cffunction>
	
	
		<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getArrayValoresSinPKs" hint="A partir de una fila obtiene una estructura de pks de forma estandarizada (fila, columna valor)">
		<cfargument name="arreglo">
		<cfscript>
			var lista = StructKeyList(arreglo);
			var arrayValoresPKs= [];
			var totalValores = 0;
			
			for (i = 1;i lte ListLen(lista,",");i++ ){
				var res = structNew(); 
				res.pkColumna =listGetAt(lista,i,',');
				
					if(structKeyexists(arreglo,res.pkColumna)){
						res.valor = StructFind(arreglo,res.pkColumna);
						totalValores++;
					} else{
						res.valor = '';
					}
				arrayappend(arrayValoresPKs,res);
			}
			if(totalValores eq 0){
				/*si el arreglo no trae ningun valor regresa el array vacio y no inserta ningun dato*/
				arrayValoresPKs = [];
			}
			return arrayValoresPKs;
		</cfscript>
	</cffunction>

<!-----******************************Fin Funciones del modulo de captura**************************************************************
**************************************************************************************************************************************  --->
	<!--- <funciones que no van aqui> --->
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getPeriodos" hint="">
		<cfscript>
			var res=dao.getPeriodos();
		</cfscript>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getFormatos" hint="">
		<cfscript>
			var rol = session.cbstorage.usuario.ROL;
			var pkUsuario = '';
			var UR = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'Indicadores.verTodos')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				//UR = session.cbstorage.usuario.UR;
			}

			var formatos =dao.getFormatos(pkUsuario,UR);
			return cnMes.getQueryAcciones(115, formatos, 1);
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getFormatosPeriodo" hint="">
		<cfargument name="pkFormato">
		<cfargument name="pkPeriodo">
		<cfscript>
			var rol = session.cbstorage.usuario.ROL;
			var UR = '';
			var pkUsuario = '';			
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				//UR = session.cbstorage.usuario.UR;
			}
			
			if(pkPeriodo == '' OR pkPeriodo == 'null' ){
				var reportes = dao.getFormatosPeriodo(pkFormato,'',UR, pkUsuario);
			}
			else{
				arraypks = deserializeJSON(pkPeriodo);
				var reportes = dao.getFormatosPeriodo(pkFormato,arraytolist(arraypks,','),UR, pkUsuario);
			}
			return cnMes.getQueryAcciones(2, reportes, rol);
		</cfscript>
	</cffunction>

	<!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
	<cffunction name="cambiaColumna" hint="Marca o desmarca una celda de la tabla de Información de semestres previos">
        <cfargument name="pkColumna" type="numeric" required="yes" hint="pk de la columna">
        <cfargument name="pkColOrigen" type="numeric" required="yes" hint="pk de la columna origen">
        <cfargument name="trimCopiable" type="numeric" required="yes" hint="El trimestre anterior del que sera copiado">
        <cfscript>
            return dao.cambiaColumna(pkColumna, pkColOrigen, trimCopiable);
        </cfscript>
    </cffunction>

	<!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="cargaConfigGral" hint="Obtiene las configuraciones generales de un formato">
		<cfargument name="pkFormato" type="numeric" required="yes" hint="pk del formato">
		<cfscript>
            return dao.cargaConfigGral(pkFormato);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
	<cffunction name="cambiaConfigGral" hint="Cambia las configuraciones generales">
        <cfargument name="pkFormato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="insercionFilas" type="numeric" required="yes" hint="Valor de la opcion insercion de filas">
        <cfargument name="totalFinal" type="numeric" required="yes" hint="Valor de la opcion calcular totales">
        <cfargument name="acumulado"  type="numeric" required="yes" hint="genera totales">
        <cfscript>
            return dao.cambiaConfigGral(pkFormato, insercionFilas, totalFinal, acumulado);
        </cfscript>
    </cffunction>


    <!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	* Descripcion : Particularizacion del cambio de estado a la captura de reportes
------------------------------------------------ 
	Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="cambiarEstadoRT" hint="Se cambia el estado del registro en cuestión a partir de la accion que se realiza.">
        <cfargument name="pkRegistro"     type="numeric" required="yes" hint="Pk del registro que se va a modificar">
        <cfargument name="accion"         type="string"  required="yes" hint="Pk de la acción">
        <cfargument name="nombreFormato"  type="string"  required="yes" hint="Nombre del formato">
        <cfargument name="periodoFormato" type="string"  required="yes" hint="Periodo del formato">
        <cfargument name="claveFormato"   type="string"  required="yes" hint="Clave del formato">
        <cfscript>

            respuesta = StructNew();
            resPreoperacion   = StructNew();
            postPreoperacion  = StructNew();
            respuesta.exito   = true;
            respuesta.mensaje = '';
            
            var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.CAPTURA_FORMATOS#;
            var ROL = session.cbstorage.usuario.ROL;
             
            //OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
            estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
            pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, ROL,estadoactual.ESTADO[1]);

            //OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
            //EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)
            resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1]);

            //SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
            if (resPreoperacion.exito){
                //CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
                registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

                //VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
                if (registroBitacora.fallo){
                    //obtiene el estado actual del registro y lo muestra en el mensaje de salida.
                    respuesta.exito = false;
                    respuesta.fallo = true;
                    respuesta.mensaje = estadoactual.NOM_EDO[1];
                    return respuesta;
                }

                //OBTENER POS-OPERACIONES DE LA ACCION
                postPreoperacion  = this.ejecutaPostOperaciones(pkEdoAccion.EDOACC_PK[1]);
                respuesta.exito   = postPreoperacion.exito;
                respuesta.mensaje = postPreoperacion.mensaje;

                //INDICA SI EL CAMBIO DE ESTADO FUE UN RETROCESO
                respuesta.retroceso = registroBitacora.RETROCESO;
		respuesta.edoDest = registroBitacora.edoOrigen;
                if (respuesta.retroceso == true){
					this.notificacionRechazo(pkRegistro, nombreFormato, periodoFormato, claveFormato);
                } else{
                	var pkRolSiguiente = cnUtils.queryToArray(cnMes.getRolSigByClaveAccion(accion, estadoactual.ESTADO[1]));
                	for (var i = 1; i <= ArrayLen(pkRolSiguiente); i++){
                		this.notificacionValidacion(pkRolSiguiente[i].PK_ROL, nombreFormato, periodoFormato, claveFormato);
                	}
                }

                //ACTUALIZA LA BITÁCORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
                if (respuesta.mensaje NEQ ''){
                    cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
                }

            }else {
                respuesta = resPreoperacion;
            }

            return respuesta;
        </cfscript>
    </cffunction>

	<!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="notificacionValidacion" hint="Envia un correo para informar de una validacion">
    	<cfargument name="pkRolSiguiente" type="numeric" required="yes" hint="Pk de los roles siguientes">
    	<cfargument name="nombreFormato"  type="string"  required="yes" hint="Nombre del formato">
        <cfargument name="periodoFormato" type="string"  required="yes" hint="Periodo del formato">
        <cfargument name="claveFormato"   type="string"  required="yes" hint="Clave del formato">
        <cfscript>
            var fechaEmail = 'Ciudad de M&eacute;xico a ' & LSDateFormat(now() ,"long", "Spanish (Standard)");

            // El nombre de los elementos deben ser los mismo que los nombres de las etiquetas del correo que se va a enviar (pkCorreo)
            var datos = {fecha: fechaEmail, formato: nombreFormato, periodo: periodoFormato, clave: claveFormato};

            var asunto = HTMLEditFormat('Notificación de validación');
            var emailOrigen = Session.cbstorage.usuario.EMAIL; // emailOrigen puede ir vacio y por default se enviara mediante el e-mail del CSII 
            var SiguienteRol = cnUtils.queryToArray(dao.emailSiguienteRol(Session.cbstorage.usuario.UR, pkRolSiguiente));
            var emailDestino = '';
            for (var i = 1; i <= ArrayLen(SiguienteRol); i++){
            	emailDestino = emailDestino & SiguienteRol[i].EMAIL & ' ';
            }
            var pkCorreo = #application.SIIIP_CTES.CORREOS.VALIDACION_FORMATO#;
            var etiquetas = datos;
            return cnEmail.enviarCorreoByPkPlantilla(asunto, emailOrigen, emailDestino, pkCorreo, etiquetas);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="notificacionRechazo" hint="Envia un correo para informar del rechazo de un formato">
    	<cfargument name="pkRegistro"     type="numeric" required="yes" hint="Pk del registro modificado">
    	<cfargument name="nombreFormato"  type="string" required="yes" hint="Nombre del formato">
        <cfargument name="periodoFormato" type="string" required="yes" hint="Periodo del formato">
        <cfargument name="claveFormato"   type="string" required="yes" hint="Clave del formato">
        <cfscript>
            var fechaEmail = 'Ciudad de M&eacute;xico a ' & LSDateFormat(now() ,"long", "Spanish (Standard)");

            // El nombre de los elementos deben ser los mismo que los nombres de las etiquetas del correo que se va a enviar (pkCorreo)
            var datos = {fecha: fechaEmail, formato: nombreFormato, periodo: periodoFormato, clave: claveFormato};

            var asunto = HTMLEditFormat('Notificación de rechazo');
            var emailOrigen = Session.cbstorage.usuario.EMAIL; // emailOrigen puede ir vacio y por default se enviara mediante el e-mail del CSII 
            var AnteriorRol = cnUtils.queryToArray(dao.emailAnteriorRol(pkRegistro));
            var emailDestino = AnteriorRol[1].EMAIL;
            var pkCorreo = #application.SIIIP_CTES.CORREOS.RECHAZO_FORMATO#;
            var etiquetas = datos;
            return cnEmail.enviarCorreoByPkPlantilla(asunto, emailOrigen, emailDestino, pkCorreo, etiquetas);
        </cfscript>
    </cffunction>


	<!---
    * Fecha : Febrero 2017
    * author : Alejandro Tovar
	--->         
   	<cffunction name="getReporte" hint="">
		<cfargument name="pkReporte">
		<cfscript>
			var UR = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				//UR = session.cbstorage.usuario.UR;
			}
			var reportes = dao.getReporte(pkReporte, UR);
			return cnMes.getQueryAcciones(2, reportes, session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>




	<cffunction name="obtenerFormatos" hint="Obtiene los formatos de un periodo">
		<cfargument name="anio">
        <cfscript>
            return dao.obtenerFormatos(anio);
        </cfscript>
    </cffunction>



	<cffunction name="getInfoAcumulado" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="anio">
		<cfscript>

			var acumulado = wirebox.getInstance("formatosTrimestrales/B_Acumulado");
			
			acumulado.setReportes(this.getInfoAcumuladoByPeriodo(pkTFormato, anio));

		</cfscript>
		<cfreturn acumulado>
	</cffunction>


	<cffunction name="getInfoAcumuladoByPeriodo" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="anio">
		<cfscript>
			var periodos = dao.getPeriodosByReporte(pkTFormato, anio);
			var reportes = [];

			for(var x=1; x lte periodos.recordcount; x++){
				var resultado  = structnew();
				var datosColumnas = this.getinfoReporteCached(pkTFormato,periodos.PERIODO[x]);
				datosColumnas.FILAFIJA[1] = datosColumnas.FILAFIJA[1] EQ 1 ? 0 : 1;
				var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
				
				/*se obtiene el encabezado del formato*/
				reporte.setEncabezado(creaEncabezado(pkTFormato)); 
				reporte.setFilas(this.getArrayFilas(pkTFormato,periodos.PERIODO[x])); 
			
				/*si tiene una seccion asociaciada consruye la estructutra y la mete en la propiedad secciones*/
				if(reporte.getpkPlantillaSeccion() NEQ ''){
					/*obtiene el pk de la plantilla de la columna de referencia*/
					
					var columna = reporte.getEncabezado().getColumnaByPK(reporte.getpkColumnaSeccion());
					
					var pkplantillaColumna = columna.getPk_plantilla();
					 
					var secciones = getEstructuraSecciones(reporte.getpkPlantillaSeccion(),pkplantillaColumna, reporte.getpkAsociacion());
					reporte.setSecciones(secciones);
				}
				/* writedump(datosColumnas);
				abort; */
				arrayAppend(reportes, reporte);
			}

			/* writedump(reportes);
			abort;  */

		</cfscript>
		<cfreturn reportes>
	</cffunction>

	<!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="getCatalogoAsociacionesDependencias" hint="Obtiene el catalgo de las asociaciones padre-hijo de una asociacion">
		<cfargument name="pkAsociacion">
        <cfscript>        	
        	var padreStruct = structNew();
        	var asociaciones = dao.getCatalogoAsociacionesDependencias(pkAsociacion);
        	for(var x = 1; x <= asociaciones.recordcount; x++){
        		try{
        			structInsert(padreStruct, asociaciones.PADRENOMBRE[x],[]);
        		}catch(any e){}
        		arrayAppend(padreStruct[asociaciones.PADRENOMBRE[x]],asociaciones.HIJONOMBRE[x]);
        	}			
            return padreStruct;
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="getAsociacionesCatalogos" hint="obtiene las asociaciones de 2 catalogos">
		<cfargument name="pkPadre">
		<cfargument name="pkHijo">		
        <cfscript>        	
        	return dao.getAsociacionesCatalogos(pkPadre,pkHijo);
        </cfscript>
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="seleccionarAsociacionCatalogos" hint="Selecciona una asociacion de catalogos">
		<cfargument name="pkFormato">
		<cfargument name="pkAsociacion">		
        <cfscript>        	
        	return dao.seleccionarAsociacionCatalogos(pkFormato,pkAsociacion);
        </cfscript>
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="quitarAsociacionCatalogos" hint="Deselecciona una asociacion de catalogos">
        <cfargument name="pkFormato">		
        <cfscript>        	
        	return dao.quitarAsociacionCatalogos(pkFormato);
        </cfscript>
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="seleccionarColumnaOrigen" hint="Selecciona una columna como origen del catalogo">
		<cfargument name="pkFormato">
		<cfargument name="pkOrigen">
		<cfargument name="pkDestino">		
        <cfscript>        	
        	return dao.seleccionarColumnaOrigen(pkFormato,pkOrigen,pkDestino);
        </cfscript>
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="quitarColumnaOrigen" hint="Deselecciona una columna como origen del catalogo">
        <cfargument name="pkFormato">			
        <cfscript>        	
        	return dao.quitarColumnaOrigen(pkFormato);
        </cfscript>
    </cffunction>
	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="getReportes" access="public" hint="Muestra los formatos disponibles a relacionar">
		<cfscript>
			var formatosAsoc = dao.getFormatosRelacionados();
			var arrayFmts = cnUtils.queryToArraySinStruct(formatosAsoc);
			var arrayFmtsSerial = serializeJSON(arrayFmts);
			arrayFmtsSerial = RemoveChars(arrayFmtsSerial, 1, 1);
			arrayFmtsSerial = RemoveChars(arrayFmtsSerial, Len(arrayFmtsSerial), 1);

			return dao.getReportes(arrayFmtsSerial);
		</cfscript>
    </cffunction>

    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getAsociacionFormatos" access="public" hint="Obtiene las relaciones de formatos">
		<cfscript>
			return  dao.getAsociacionFormatos();
		</cfscript>
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="setAsociaciones" access="public" hint="Establece la relacion entre formatos seleccionados">
    	<cfargument name="nombres" type="string">
		<cfargument name="formatos">
		<cfscript>
			var formato = deserializeJSON(formatos);
			var pkNombre = dao.setNombreAsociacion(nombres);

			for (var i = 1; i LE ArrayLen(formato); i = i+1) {
				var asociacion = dao.setAsociaciones(pkNombre, formato[1], formato[i]);
			}

			return pkNombre;
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="setRelacionColumnas" access="public" hint="Inserta o actualiza la relacion de columnas">
    	<cfargument name="pkOrigen">
		<cfargument name="pkAsociado">
		<cfargument name="pkFormato">
		<cfscript>
			var existeRelacion = dao.existeRelacionColumnas(pkOrigen, pkAsociado, pkFormato);
			var accion = (existeRelacion.PKRELACION[1] > 1) ? 2 : 1;

			return dao.setRelacionColumnas(pkOrigen, pkAsociado, pkFormato, accion);
		</cfscript>
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getFormatosAsociacion" access="public" hint="Obtiene los reportes que estan asociados a un registro de asociacion">
		<cfargument name="pkAsociacion">
		<cfscript>
			var formatos = [];
			var existeRelacion = dao.getFormatosAsociados(pkAsociacion);
			var form = cnUtils.queryToArray(existeRelacion);

			arrayAppend(formatos, existeRelacion.PKORIGEN[1]);

			for (var i = 1; i LTE ArrayLen(form); i = i+1) {
				arrayAppend(formatos, existeRelacion.PKREPORTE[i]);
			}

			return formatos;
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getFormatosAsociacionContenedor" access="public" hint="Obtiene los reportes que estan asociados, excepto el formato contenedor">
		<cfargument name="pkAsociacion">
		<cfscript>
			var formatos = [];
			var existeRelacion = dao.getFormatosAsociacionContenedor(pkAsociacion);
			var form = cnUtils.queryToArray(existeRelacion);

			arrayAppend(formatos, existeRelacion.PKORIGEN[1]);

			for (var i = 1; i LTE ArrayLen(form); i = i+1) {
				arrayAppend(formatos, existeRelacion.PKREPORTE[i]);
			}

			return formatos;
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getColumnasAsociadas" access="public" hint="Obtiene las columnas asociadas a la columna origen">
    	<cfargument name="pkColumnaOrigen">
		<cfscript>
			return  dao.getColumnasAsociadas(pkColumnaOrigen);
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getNombreFormato" access="public" hint="Obtiene el nombre del formato">
    	<cfargument name="pkFormato"  type="numeric" required="yes">
		<cfscript>
			return  dao.getNombreFormato(pkFormato);
		</cfscript>
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getElementosByPlantilla" access="public" hint="Obtiene los elementos relacionados a una plantilla">
    	<cfargument name="pkPlantilla"  type="numeric" required="yes">
		<cfscript>
			return  dao.getElementosByPlantilla(pkPlantilla);
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="guardaClasificacionFormato" access="public" hint="Guarda la clasificacion del formato en la asociacion">
    	<cfargument name="pkFormato" type="numeric" required="yes">
    	<cfargument name="pkPlantilla" type="string" required="yes">
    	<cfargument name="clasificacion" type="string" required="yes">
    	<cfargument name="pkNombreAsociacion" type="numeric" required="yes">
		<cfscript>
			return  dao.guardaClasificacionFormato(pkFormato, pkPlantilla, clasificacion, pkNombreAsociacion);
		</cfscript>
    </cffunction>    


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getPlantillaSelected" access="public" hint="Obtiene la plantilla asociada a un formato">
    	<cfargument name="pkAsociacion" type="numeric" required="yes">
		<cfscript>
			return  dao.getPlantillaSelected(pkAsociacion);
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getValorElementos" access="public" hint="Obtiene los valores de los elementos de una plantilla">
    	<cfargument name="pkAsociacion" type="numeric" required="yes">
		<cfscript>
			return  dao.getValorElementos(pkAsociacion);
		</cfscript>
    </cffunction>


	

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->        
   	<cffunction name="getFilaData" hint="obtiene la informacion de la fila del reporte seleccionado">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
        <cfscript>
            return dao.getFilaData(pkFila);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->        
   	<cffunction name="saveDatosFormulario" hint="guardar la informacion de la fila del reporte seleccionado">
   		<cfargument name="fila" type="string" required="yes" hint="datos de la fila">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
        <cfscript>
        	var arrayFila = deserializejson(fila);
        	for(var celda in arrayFila){
        		dao.saveDatosFormulario(pkFila, celda.pkColumna, celda.valor);
        	}
            return 1;
        </cfscript>
    </cffunction>

	<!---
	* -------------------------------
    * Descripcion de la modificacion: relaciona el producto con la persona (recibe 2 nuevos argumentos pkProducto y pkPersona)
    * Fecha de la modificacion: Octubre 2017
    * Autor de la modificacion: Alejandro tovar
	* -------------------------------
    * Fecha creación: Marzo de 2017
    * @author: SGS
    ---> 
    <cffunction name="crearFilaNueva" hint="crea una fila para el reporte que se esta llenando">
		<cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="reporte" type="numeric" required="yes" hint="pk del reporte">
        <cfargument name="pkColumnas" type="string" required="yes" hint="pks de las columnas">
        <cfargument name="pkProducto" type="numeric" required="yes" hint="pks del producto">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona(inv)">
		<cfscript>
			var arrayColumnas = deserializejson(pkColumnas);
			var pkFormato = cnUtils.queryToArray(dao.pkFormatoReporte(formato));
			var filaNueva = dao.crearFilaNueva(pkFormato[1].PK_FORMATO, reporte,session.cbstorage.usuario.PK);
			for(i = 1; i <= ArrayLen(arrayColumnas); i++){
				dao.crearCelda(filaNueva, arrayColumnas[i], pkFormato[1].PK_FORMATO);
			}
			
			resultado = dao.relacionaProdPersona(pkProducto, filaNueva, pkPersona);

			return filaNueva;
		</cfscript>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    ---> 
    <cffunction name="eliminarFilaFormulario" hint="elimina una fila para el reporte que se esta llenando">
		<cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
		<cfscript>
			return dao.eliminarFilaFormulario(pkFila);
		</cfscript>
    </cffunction>



    <!-- definicion del cubo -->

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getFormatosValidados" hint="Obtiene los formatos validados y asignados de acuerdo al usuario">
		<cfscript>

			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos')){
				pkUsuario = session.cbstorage.usuario.PK;
			}

			return dao.getFormatosValidados(pkUsuario);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getInfoCubo" hint="Obtiene el nombre y prefijo del cubo">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfscript>
			return dao.getInfoCubo(pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getHechos" hint="Obtiene los hechos">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfscript>
			return dao.getHechos(pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getDimensiones" hint="Obtiene las dimensiones">
		<cfscript>
			return dao.getDimensiones();
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getDimensionesAsociadas" hint="Obtiene las dimensiones asociadas a un cubo">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfscript>
			return dao.getDimensionesAsociadas(pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getClasificacion" hint="Obtiene las clasificaciones">
		<cfscript>
			return dao.getClasificacion();
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="guardaHecho" hint="Guarda hechos">
   		<cfargument name="nombreHecho" type="string" required="yes">
   		<cfargument name="tipoHecho"   type="string" required="yes">
   		<cfargument name="pkCubo"      type="numeric" required="yes">
		<cfscript>
			return dao.guardaHecho(nombreHecho, tipoHecho, pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="guardaDimension" hint="Guarda dimensiones">
   		<cfargument name="nombreDimen"    type="string" required="yes">
   		<cfargument name="prefijoDimen"   type="string" required="yes">
		<cfscript>
			return dao.guardaDimension(nombreDimen, prefijoDimen);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="guardaCubo" hint="Registra cubo">
   		<cfargument name="nombreCubo"  type="string"  required="yes">
   		<cfargument name="prefijoCubo" type="string"  required="yes">
   		<cfargument name="pkFormato"   type="numeric" required="yes">
		<cfscript>
			var pkCubo = dao.guardaCubo(nombreCubo, prefijoCubo, pkFormato);
			dao.asociaFormatoCubo(pkFormato, pkCubo);

			return pkCubo;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="saveCube" hint="Registra cubo">
   		<cfargument name="nombreCubo"  type="string"  required="yes">
   		<cfargument name="prefijoCubo" type="string"  required="yes">
		<cfscript>
			return dao.guardaCubo(nombreCubo, prefijoCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="asociaFormatoCubo" hint="Asocia formato-cubo">
   		<cfargument name="pkFormato" type="numeric" required="yes">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfscript>
			return dao.asociaFormatoCubo(pkFormato, pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getPkCubo" hint="Registra cubo">
   		<cfargument name="pkFormato"  type="numeric" required="yes">
		<cfscript>
			return dao.getPkCubo(pkFormato);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="existeClasificacion" hint="Verifica si se han hecho cambios en la clasificacion">
   		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfscript>
			return dao.existeClasificacion(pkFormato);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getcolumasDimension" hint="Obtiene las columnas de una dimension">
   		<cfargument name="pkDimension" type="numeric" required="yes">
		<cfscript>
			return dao.getcolumasDimension(pkDimension);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="asociaColumnaHecho" hint="Asocia columna con un hecho">
   		<cfargument name="pkFormato" type="any" required="yes">
   		<cfargument name="pkHecho"   type="numeric" required="yes">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfscript>
			var asociacion = 0; 
			var formato = deserializeJSON(pkFormato);

			for (var i = 1; i LE ArrayLen(formato); i = i+1) {
					asociacion = dao.asociaColumnaHecho(formato[i], pkHecho);
			}

			return asociacion;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="asociaDimensionColumna" hint="Asocia columna con una dimension">
		<cfargument name="pkFormato"   type="any"     required="yes">
		<cfargument name="pkDimension" type="numeric" required="yes">
		<cfargument name="pkColumna"   type="numeric" required="yes">
		<cfargument name="pkClasif"    type="numeric" required="yes">
		<cfargument name="pkCubo"      type="numeric" required="yes">
		<cfscript>
			var asociacion = 0; 
			var formato   = deserializeJSON(pkFormato);
			var cuboDimen = dao.consultaRelCuboDimen(pkCubo, pkDimension);

			if (cuboDimen EQ -1){
				dao.asociaCuboDimension(pkCubo, pkDimension);
			}

			for (var i = 1; i LE ArrayLen(formato); i = i+1) {				
					asociacion = dao.asociaDimensionColumnas(formato[i], pkColumna, pkClasif);				
			}

			return asociacion;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="guardaColDim" hint="Guarda columna asociada a una dimensión">
   		<cfargument name="nombreCol" type="string"  required="yes">
   		<cfargument name="tipoCol"   type="string"  required="yes">
   		<cfargument name="descrCol"  type="string"  required="yes">
   		<cfargument name="pkDimens"  type="numeric" required="yes">
		<cfscript>
			return dao.guardaColDim(nombreCol, tipoCol, descrCol, pkDimens);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getConfigDimenColumna" hint="Obtiene la ascociacion de una columna">
   		<cfargument name="pkColumna" type="numeric" required="yes">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfscript>
			return dao.getConfigDimenColumna(pkColumna, pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getConfigHechoColumna" hint="Obtiene la ascociacion de una columna">
   		<cfargument name="pkColumna" type="numeric" required="yes">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfscript>
			return dao.getConfigHechoColumna(pkColumna, pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="actualizaRelHecho" hint="Actualiza relacion entre una columna y un hecho">
   		<cfargument name="pkHecho" type="numeric" required="yes">
   		<cfargument name="pkHecoColumna" type="numeric" required="yes">
		<cfscript>
			return dao.actualizaRelHecho(pkHecho, pkHecoColumna);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="actualizaRelDimension" hint="Actualiza el registro de una columna asociada a una dimension">
   		<cfargument name="pkCubo"      type="numeric" required="yes">
   		<cfargument name="pkDimension" type="numeric" required="yes">
   		<cfargument name="pkColDim"    type="numeric" required="yes">
   		<cfargument name="pkClasif"    type="numeric" required="yes">
   		<cfargument name="pkRelCols"   type="numeric" required="yes">
		<cfscript>
			var cuboDimen = dao.consultaRelCuboDimen(pkCubo, pkDimension);

			if (cuboDimen EQ -1){
				dao.asociaCuboDimension(pkCubo, pkDimension);
			}

			return dao.actualizaRelDimension(pkCubo, pkColDim, pkClasif, pkRelCols);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="validaCubo" hint="Establece como creado el registro del cubo.">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfscript>
			return dao.validaCubo(pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="asociaDimensionCubo" hint="Asocia una dimension con el cubo">
   		<cfargument name="pkDimension" type="numeric" required="yes">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfscript>
			return dao.asociaDimensionCubo(pkDimension, pkCubo);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getCubos" hint="Obtiene los cubos existentes">
		<cfscript>
			return dao.getCubos();
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getClasificaciones" hint="Obtiene las clasificaciones">
		<cfscript>
			return dao.getClasificaciones();
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeAsociacionColumna" hint="Verifica si la columna esta asociada">
   		<cfargument name="pkColumna" type="numeric" required="yes">
		<cfscript>
			var existe = dao.existeAsociacionColumna(pkColumna);
			var resultado = (existe.recordcount GT 0) ? true: false;
			
			return resultado;	
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeAsociacionDimension" hint="Verifica si la dimensión esta asociada">
		<cfargument name="pkCubo" type="numeric" required="yes">
   		<cfargument name="pkDimension" type="numeric" required="yes">
		<cfscript>
			var existe = dao.existeAsociacionDimension(pkCubo, pkDimension);
			var resultado = (existe.recordcount GT 0) ? true: false;

			return resultado;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="existeAsociacionHecho" hint="Verifica si el hecho esta asociado">
   		<cfargument name="pkHecho" type="numeric" required="yes">
		<cfscript>
			var existe = dao.existeAsociacionHecho(pkHecho);
			var resultado = (existe.recordcount GT 0) ? true: false;

			return resultado;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="eliminarColumna" hint="Elimina una columna de una dimensión">
   		<cfargument name="pkColumna" type="numeric" required="yes">
		<cfscript>
			return dao.eliminarColumna(pkColumna);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="desasociarHecho" hint="Desasocia una columna y un hecho">
   		<cfargument name="pkHecoColumna" type="numeric" required="yes">
		<cfscript>
			return dao.desasociarHecho(pkHecoColumna);
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="desasociarDimension" hint="Desasocia una dimensión de una columna de un formato">
   		<cfargument name="pkRelCols"   type="numeric" required="yes">
		<cfscript>	
			return dao.desasociarDimension(pkRelCols);
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="desasociarCuboDimension" hint="Desasocia una dimensión con un cubo">
		<cfargument name="pkCubo" type="numeric" required="yes">
   		<cfargument name="pkDimension" type="numeric" required="yes">
		<cfscript>
			return dao.desasociarCuboDimension(pkCubo, pkDimension);
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="cambiaEstadoHecho" hint="Cambia a 0 el estado del hecho">
   		<cfargument name="pkHecho" type="numeric" required="yes">
		<cfscript>
			return dao.cambiaEstadoHecho(pkHecho);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getPreview" hint="Obtiene la vista previa de los datos del cubo.">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
   		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfscript>
			var consulta = dao.getPreview(pkCubo, pkFormato);
			return dao.consultaPreview(consulta);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="creaVistaBD" hint="Crea la vista en la base de datos.">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfscript> 
			return  dao.creaVistaBD(pkCubo);
		</cfscript>
	</cffunction>




	


	<!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    ---> 
    <cffunction name="cargarNota" hint="obtiene la nota del reporte seleccionado">
		<cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="periodo" type="numeric" required="yes" hint="periodo del formato">
        <cfargument name="reporte" type="numeric" required="yes" hint="pk del reporte">
		<cfscript>
			return dao.cargarNota(formato, periodo, reporte);
		</cfscript>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    ---> 
	<cffunction name="guardarNota" hint="edita la nota del reporte seleccionado">
		<cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="periodo" type="numeric" required="yes" hint="periodo del formato">
        <cfargument name="reporte" type="numeric" required="yes" hint="pk del reporte">
        <cfargument name="nota" type="string" required="yes" hint="nota del reporte">
		<cfscript>
			return dao.guardarNota(formato, periodo, reporte, nota);
		</cfscript>
    </cffunction>

	<!-- REPLICA DE CLASIFICACION -->

	<!---
    * Fecha: Abril 2017
    * author: Alejandro Tovar
	* -------------------------------
    * Descripcion de la modificacion: Agregar validación para saber si ya existe la relación formato-cubo,
	* 								  la relación columna-hecho y la relación columna-dimensión..
    * Fecha de la modificacion: 24/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
	--->
   	<cffunction name="replicaClasificacion" hint="Replica la clasificacion del encabezado, en caso de ser formato contenedor.">
   		<cfargument name="pkFormato" type="numeric" required="yes">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfscript>
			var fomatosAsociados = dao.getFmtsAsocByCont(pkFormato);
			var colsFormatoCont = dao.getColsFmtCont(pkFormato);

			if (fomatosAsociados.recordcount GT 0){
				/* Asociacion de hechos */
				for (var x=1; x lte colsFormatoCont.recordcount; x++){
					var colsAsoc = dao.getColumnasAsociadas(colsFormatoCont.COLSFMT[x]);
					/* Columnas asociadas */
					for (var i=1; i lte colsAsoc.recordcount; i++){
						/* Hecho asociado */
						var hecho = dao.existeAsociacionColumnaHecho(colsFormatoCont.COLSFMT[x]);
						if (hecho.PKHECHO[1] NEQ ''){
							var colhech = dao.existeColumnaHecho(colsAsoc.PKCOLASOCIADA[i], hecho.PKHECHO[1]);
							if(colhech.COLUMNA[1] EQ ''){
								dao.asociaColumnaHecho(colsAsoc.PKCOLASOCIADA[i], hecho.PKHECHO[1]);
							}
						}

						/* Dimension asociada */
						var dimension = dao.existeAsociacionColumnaDimension(colsFormatoCont.COLSFMT[x], pkCubo);
						if (dimension.PKDIMEN[1] NEQ ''){
							var coldim = dao.existeColumnaDimension(colsAsoc.PKCOLASOCIADA[i], dimension.PKCOLDIM[1]);
							if(coldim.COLUMNA[1] EQ ''){
								dao.asociaDimensionColumnas(colsAsoc.PKCOLASOCIADA[i], dimension.PKCOLDIM[1], dimension.PKCLASIF[1]);
							}
						}
					}
				}

				for (var j=1; j lte fomatosAsociados.recordcount; j++){
					var formato = dao.existeFormatoCubo(fomatosAsociados.TAR_FK_ASOCIADO[j], pkCubo);
					if(formato.FORM[1] EQ ''){
					   var asociacion = dao.asociaFormatoCubo(fomatosAsociados.TAR_FK_ASOCIADO[j], pkCubo);
					} else{
						var asociacion = -1;
					}
				}

				return asociacion;
			}else {
				return fomatosAsociados.recordcount;
			}
		</cfscript>
	</cffunction>

    <!-- MODIFICACION ASOCIACION DE FORMATOS -->

	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="asociarFormatos" hint="Obtiene los niveles de un formato">
   		<cfargument name="formatos" type="any" required="yes">
		<cfscript>
			var resultado = structNew();
			var encabezados = [];
			var indice = [];
			var contenedor = 0;
			var arrayColumnasAsociadas = []; //arrayBidimensional

			for (var i = 1; i LTE ArrayLen(formatos); i = i+1) {
				
				var reporte = this.getEncabezado(formatos[i]);

				if (i EQ 1){
					contendor = reporte;
				}else {
					arrayAppend(arrayColumnasAsociadas ,contendor.getEncabezado().compararFormato(reporte, formatos[i]));//se crea el array bidimensional con las columnas asociadas
				}

				arrayAppend(encabezados, reporte);
				arrayAppend(indice, i);
				var nombre = this.getNombreFormato(formatos[i]);
				reporte.setNombre(nombre.NOMBREFMT[1]);
			}

		
			/***************************************************************************/
			var asociaciones = this.existenAsociaciones(formatos[1]).ASOCIADAS[1];

			if (asociaciones GT 0){
				resultado.promedio = 0;
				resultado.celdasRelacionadas = 0;
			}else {
				var promColumnas = this.getPromNivYCols(encabezados);
				var promUltimNiv = this.getPromColsUltimoNivel(encabezados);
				var promedioCelda = this.asociaColumnasYObtienePromedio(arrayColumnasAsociadas);
				var promedioTotal = [];

				for (var k = 1; k LTE ArrayLen(promUltimNiv); k = k+1) {
					var sumatoria = promColumnas.PROMEDIONIVELES[k] + promColumnas.PROMEDIOORDEN[k] + promUltimNiv[k] + promedioCelda.PROMEDIOCELDA[k];
					arrayAppend(promedioTotal, sumatoria/4);
				}

				resultado.promedio = promedioTotal;
				resultado.celdasRelacionadas = promedioCelda.CELDASRELACIONADAS;
			}

			/***************************************************************************/

			resultado.pkFormato = formatos;
			resultado.reporte   = encabezados;
			resultado.indice 	= indice;

			return resultado;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="existenAsociaciones" hint="Verifica si hay columnas asociadas del formato contenedor">
   		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfscript>
			return dao.existenAsociaciones(pkFormato);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="asociaColumnasYObtienePromedio" access="remote" hint="Asocia columnas y obtiene el promedio de coincidencia">
		<cfargument name="arrayColumnasAsociadas">
		<cfscript>
			var resultados = structNew(); 
			var promedioCelda = [];
			var celdasRelacionadas = [];

			for (var i = 1; i LTE ArrayLen(arrayColumnasAsociadas); i = i+1) {
				var suma = 0;
				var columnasAsociadas = 0;
	            for (var j = 1; j LTE ArrayLen(arrayColumnasAsociadas[i]); j = j+1) {
	                // asociacion de columnas
	                if (arrayColumnasAsociadas[i][j].PADRE NEQ -1){
	                	this.setRelacionColumnas(arrayColumnasAsociadas[i][j].PADRE, arrayColumnasAsociadas[i][j].HIJO, arrayColumnasAsociadas[i][j].PKASOCIADO);
	                }

	                //sumatoria de las columnas que fueron asociadas
	                if (arrayColumnasAsociadas[i][j].PADRE NEQ -1){
	                	columnasAsociadas = columnasAsociadas + 1;
					}

	                //sumatoria del porcentaje
	                suma = suma + arrayColumnasAsociadas[i][j].PORCENTAJE;
	            }
	            arrayAppend(promedioCelda, suma/ArrayLen(arrayColumnasAsociadas[i]));
	            arrayAppend(celdasRelacionadas, columnasAsociadas);
	        }

	        resultados.promedioCelda = promedioCelda;
	        resultados.celdasRelacionadas = celdasRelacionadas;

	        return resultados;
		</cfscript>
	</cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="getPromColsUltimoNivel" access="remote" hint="Obtiene el promedio de las columnas de ultimo nivel">
		<cfargument name="encabezados">
		<cfscript>
			var maximoNiv = [];
			for (var i = 1; i LTE ArrayLen(encabezados); i = i+1) {
				var cabeza = encabezados[i].getEncabezado();
                var columnas = cabeza.getColumnas();

                for (var j = 1; j LTE ArrayLen(columnas); j = j+1) {
                	var nivelMaximo = [];
					arrayAppend(nivelMaximo, columnas[j].getNivel());
				}
				arrayAppend(maximoNiv, ArrayMax(nivelMaximo));
			}

			var promUltNiv = [];
			for (var k = 2; k LTE ArrayLen(maximoNiv); k = k+1) {
				var prom = (maximoNiv[k] EQ maximoNiv[1]) ? 100 : 0;
				arrayAppend(promUltNiv,prom);
			}

			return promUltNiv;
		</cfscript>
	</cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="getPromNivYCols" access="remote" hint="Obtiene el promedio de coincidencia de niveles en los formatos asociados">
		<cfargument name="encabezados">
		<cfscript>
			var promedios = structNew(); 

			var maximoNiv = [];
			var maxOrden = [];
			for (var i = 1; i LTE ArrayLen(encabezados); i = i+1) {
				var cabeza = encabezados[i].getEncabezado();
                var columnas = cabeza.getColumnas();

                for (var j = 1; j LTE ArrayLen(columnas); j = j+1) {
                	var nivelMaximo = [];
	            	arrayAppend(nivelMaximo, columnas[j].getNivel());
	            	var ordenMaximo = [];
	            	arrayAppend(ordenMaximo, (columnas[j].getOrden())+1);
	            }
	            arrayAppend(maximoNiv, ArrayMax(nivelMaximo));
	            arrayAppend(maxOrden, ArrayMax(ordenMaximo));
			}

			var promedioNiveles = [];
			for (var k = 2; k LTE ArrayLen(maximoNiv); k = k+1) {
				var prom = (maximoNiv[k] EQ maximoNiv[1]) ? 100 : 0;
				arrayAppend(promedioNiveles,prom);
			}

			
			var promedioOrden = [];
			for (var l = 2; l LTE ArrayLen(maxOrden); l = l+1) {
				var promOrd = (maxOrden[l] EQ maxOrden[1]) ? 100 : 0;
				arrayAppend(promedioOrden,promOrd);
			}

			promedios.promedioNiveles = promedioNiveles;
			promedios.promedioOrden = promedioOrden;

			return promedios;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getColoresColumnas" access="remote" hint="Obtiene el numero de columnas asociadas a una columna">
		<cfargument name="formatosAsociados">
		<cfscript>
			var colFromFmt = dao.getColumnasByFormato(formatosAsociados[1]);
			var arrayCols = cnUtils.queryToArraySinStruct(colFromFmt);
			var arrayColores = [];
			
			for (var l = 1; l LTE ArrayLen(arrayCols); l = l+1) {
				var coumnNumero = structNew();
				var numero = dao.getColumnasAsociadas(arrayCols[l]).recordcount;
				coumnNumero.pkCol = arrayCols[l];

				if(numero EQ (ArrayLen(formatosAsociados)-2)){
					coumnNumero.color = 'Azul';
				}else if(numero EQ 0){
					coumnNumero.color = 'Gris';
				}else if(numero LT ArrayLen(formatosAsociados)){
					coumnNumero.color = 'Naranja';
				}

				arrayAppend(arrayColores,coumnNumero);
			}

			return arrayColores;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="cambiaEdoAsocColumns" access="remote" hint="Cambia a 0 el estado de la asociacion de las columnas">
		<cfargument name="pkColOrigen"   type="numeric" required="yes" hint="pk de la columna origen">
        <cfargument name="pkColAsociada" type="numeric" required="yes" hint="pk de la columna asociada">
        <cfargument name="pkFormato"     type="numeric" required="yes" hint="pk del formato">
		<cfscript>
			return dao.cambiaEdoAsocColumns(pkColOrigen, pkColAsociada, pkFormato);
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="cargaMetadatos" access="remote" hint="Hace la carga de metadatos.">
		<cfargument name="pkCubo" type="numeric" required="yes" hint="pk del cubo">
		<cfscript>
			return dao.cargaMetadatos(pkCubo);
		</cfscript>
    </cffunction>


<!---
    * Fecha : Abril 2017
    * author : Ana Belem Juárez M
	--->
   	<cffunction name="getAnalisisAutomatico" hint="Obtiene el pre analisis del formarto.">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
   		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfscript>
			var resultado = dao.getAnalisisAutomatico(pkCubo, pkFormato);
			return resultado;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Ana Belem Juárez M
	--->
   	<cffunction name="updateAnalisisAutomatico" hint="Obtiene el pre analisis del formarto.">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
   		<cfargument name="pkColumna" type="numeric" required="yes">
		<cfscript>
			var resultado = dao.updateAnalisisAutomatico(pkCubo, pkColumna);
			return resultado;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="resetClasifiacion" access="public" hint="Resetea clasificaciones de los formatos">
    	<cfargument name="pkNombreAsociacion" type="numeric" required="yes">
    	<cfargument name="pkPlantilla" type="numeric" required="yes">
		<cfscript>
			return  dao.resetClasifiacion(pkNombreAsociacion, pkPlantilla);
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Septiembre 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getTfidf" access="public" hint="calcula el tf-idf de mision vision y objetivo">
    	<cfargument name="formato" type="numeric" required="yes">
		<cfscript>
			return  dao.getTfidf(formato);
		</cfscript>
    </cffunction>




    <!--- FUNCIONES ESPECIFICAS SIIP --->

    <!---
    * Fecha : Octubre 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="registrarArchivo" hint="Guarda la ruta del documento en la celda correspondiente">
		<cfargument name="pkCFormato" hint="Pk del catalogo del archivo">
		<cfargument name="pkColumna"  hint="Pk de la columna">
		<cfargument name="pkFila"     hint="Pk de la fila">
		<cfargument name="filename"   hint="nombre del archivo">
		<cfscript>
			return DAO.registrarArchivo(pkCFormato, pkColumna, pkFila, filename);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Octubre 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="consultarNombreArchivo" hint="Obtiene el nombre de un archivo">
		<cfargument name="pkCFormato" hint="Pk del catalogo del archivo">
		<cfargument name="pkColumna"  hint="Pk de la columna">
		<cfargument name="pkFila"     hint="Pk de la fila">
		<cfscript>
			return dao.consultarNombreArchivo(pkCFormato, pkColumna, pkFila);
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Octubre 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getNodosHoja" hint="obtiene todos los productos de una persona a partir del pk de un producto">
		<cfargument name="pkProducto">
		<cfscript>
			var reportes = dao.getNodosHoja(pkProducto);
			var productos = [];
			var rutas = [];
			
			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductos(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i]);
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');
				arrayappend(productos,producto);
			}
			
			return productos;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Noviembre 2017
    * author : Daniel Memije
	--->        
 	<cffunction name="getNodosHojaEDI" hint="">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfscript>
			var reportes = dao.getNodosHojaEDI(pkProducto);
			var productos = [];
			var rutas = [];

			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosEDI(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i],pkUsuario);				
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');				
				arrayappend(productos,producto);
			}			
			return productos;
		</cfscript>
	</cffunction>	

	<!---
    * Fecha : Noviembre 2017
    * author : Daniel Memije
	--->        
	<cffunction name="getNodosHojaCVU" hint="">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfscript>
			var reportes = dao.getNodosHojaCVU(pkProducto);
			var productos = [];
			var rutas = [];

			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosCVU(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i],pkUsuario);				
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');				
				arrayappend(productos,producto);
			}				
			
			return productos;
		</cfscript>
	</cffunction>	
		
	<cffunction name="getInfoReporteByProductos" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProducto(datosColumnas.pkCFormato[1], pkTFormato,pkPeriodo,pkProducto)); 
			
		</cfscript>
		<cfreturn reporte>
	</cffunction>

	<cffunction name="getInfoReporteByProductosEDI" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfargument name="pkproceso">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProductoEDI(datosColumnas.PKCFORMATO[1],pkTFormato,pkPeriodo,pkProducto,pkUsuario,pkproceso)); 
		</cfscript>
		<cfreturn reporte>
	</cffunction>	
	
	<cffunction name="getinfoReporteCached" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkFormato">
		<cfargument name="pkPeriodo">
		<cfscript>
			
			var datosReporte = cache.get("datosReporte_"&pkFormato&pkPeriodo);
			if (!isNull(datosReporte)){
				return datosReporte;
			}else {
				 var datosReporte = dao.getinfoReporte(pkFormato,pkPeriodo);
				 cache.set("datosReporte_"&pkFormato&pkPeriodo,datosReporte,120,20);
				 return datosReporte;
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getallNodosPadresCached" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkFormato">
		<cfargument name="pkPeriodo">
		<cfscript>
			
			var nodos = cache.get("allNodosPadres");
			if (!isNull(nodos)){
				return nodos;
			}else {
				 var nodos = QueryToArray(dao.getAllNodosPadres());
				 cache.set("allNodosPadres",nodos,120,20);
				 return nodos;
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getInfoReporteByProductosCVU" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProductoCVU(datosColumnas.pkCFormato[1], pkTFormato,pkPeriodo,pkProducto,pkUsuario)); 
		</cfscript>
		<cfreturn reporte>
	</cffunction>

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getArrayFilasbyProducto" hint="crea un array con las filas de los reportes">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
		    
			var consulta=dao.getRespuestasbyProducto(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto);
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
				var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Fila"),consulta,x);
					fila.SETCELDAS(celdas);
					arrayAppend(filas, fila);
					var celdas=[];
				}	
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>

	<!---
    * Fecha : Noviembre 2016
    * author : Daniel Memije
	--->        
   	<cffunction name="getArrayFilasbyProductoEDI" hint="crea un array con las filas de los reportes">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfargument name="pkproceso">
		<cfscript>
		    		    
			//var consulta=dao.getRespuestasbyProductoEDI(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto);
				
			writedump('empieza ----'&getTickCount() - startTime & '    ');
			var datosEvaluacionEtapa =dao.getRespuestasbyProductoEDI(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto,Session.cbstorage.usuario.PK);

			
			if(datosEvaluacionEtapa.recordcount EQ 0){
				return [];
			}
			writedump('ENMEDIO----'&getTickCount() - startTime & '    ');
			var consultaCompleta = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.EVAL_EDI#, datosEvaluacionEtapa, Session.cbstorage.usuario.ROL);
			var isEvaluadorCA	 = getNumeroregistrosPorEtapa(consultaCompleta,Session.cbstorage.usuario.PK, 3).cuantos;/*identifica si es evaluador CA*/
			var consulta 		 = getfilasFromQuery(consultaCompleta);
						
			var celdas=[];
			var filas=[];
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){

				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
					var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_FilaEDI"),consulta,x);					
					
					fila.SETCELDAS(celdas);	
					fila.initAnio();				
					arrayAppend(filas, fila);
					var celdas=[];
					var etapas=[];
					
					/*obtiene las etapas de la fila*/
					var etapasFila = this.getEtapasFromQuery(consultaCompleta,consulta.PK_FILA[x],consulta.PKCELDA[x]);
					
					for(var i in etapasFila){
						if(i.FK_EVALUADOR eq Session.cbstorage.usuario.PK and fila.getPROCESO() eq pkproceso){
						/*para los evaluadores normales solo crea las etapas que les corresponden*/
							var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
							arrayAppend(etapas, etapa);
						} else if (fila.getPROCESO() neq pkproceso and i.FK_TIPO_EVALUACION eq 24 and arraycontains(session.cbstorage.grant,'evalEDI.reclaEval')){
						/*para el supervisor crea la etapa final para que la pueda editar*/
							var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
							arrayAppend(etapas, etapa);
						} else if (isEvaluadorCA gt 0){
						/*para el evaluador CA crea todas las etapas */
							var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
							arrayAppend(etapas, etapa);
						}
						
						if(pkCFormato eq 221){
						/*writedump(etapasFila);
						writedump(datosEvaluacionEtapa);
						writedump(consultaCompleta);*/
						//abort;
						}
					}
					fila.setEVALUACION_ETAPAS(etapas);
				}
			}
			writedump('despues----'&getTickCount() - startTime & '    ');
			//writedump(filas);
			/*if (pkTFormato eq 221){
				WRITEDUMP(filas);
				WRITEDUMP(etapas);
				
				abort;
			}*/
		</cfscript>
		<cfreturn filas>
	</cffunction>	

       
	<cffunction name="getfilasFromQuery" hint="crea un array con las filas de los reportes">
		<cfargument name="datos">
			<cfquery dbtype="query" name="res">
					SELECT  PKCELDA,
							TFF_FK_USUARIO,
					        valorcelda,
					        PK_FILA,
					        PK_COLUMNA,
					        SELECCIONADO,
					        PKCPRODUCTO,
					        NUM,
							PRODUCTO_ELIMINAR,
							PKTPRODUCTOEDI,
							CLASIFICACION,
							CLASIFICACION_ROMANO,
							SUBCLASIFICACION,
							SUBCLASIFICACION_ROMANO,
							EVALUACIONPRODUCTOEDI,
							 CESTADO_EVALUACION,
							PROCESO,
							PK_TIPOFECHA,
							ISNOMBRE
		       		 FROM	datos
					 GROUP BY PKCELDA,
							TFF_FK_USUARIO,
					        valorcelda,
					        PK_FILA,
					        PK_COLUMNA,
					        SELECCIONADO,
					        PKCPRODUCTO,
					        NUM,
							PRODUCTO_ELIMINAR,
							PKTPRODUCTOEDI,
							CLASIFICACION,
							CLASIFICACION_ROMANO,
							SUBCLASIFICACION,
							SUBCLASIFICACION_ROMANO,
							EVALUACIONPRODUCTOEDI,
							 CESTADO_EVALUACION,
							PROCESO,
							PK_TIPOFECHA,
							ISNOMBRE
				   order by PROCESO,PK_FILA,PK_COLUMNA
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<cffunction name="getEtapasFromQuery" hint="crea un array con las filas de los reportes">
	
		<cfargument name="datos">
		<cfargument name="pkFila">
		<cfargument name="pkCelda">
			<cfquery dbtype="query" name="res">
				select 
					PK_EVALUACION, 
                    PK_EVALUACIONETAPA, 
                    FECHA_CAPTURA, 
                    PUNTAJE_OBTENIDO, 
                    FK_RECLASIFICACION, 
                    FK_EVALUADOR, 
                    FK_TIPO_EVALUACION, 
                    ESTADO_EVALUACION, 
                     COMENT_EVAL,  
                    TIPO_PUNTUACION, 
                    PUNTUACION_MAXIMA, 
                    CESESTADO, 
                    CESRUTA, 
                    CVETIPO, 
                    SINCALIFICAR,
                    NOMBRE_TIPO_EVALUACION, 
       				PK_TIPO_EVALUACION, 
       				REC_CLASIFICACION, 
       				REC_CLASIFICACION_ROMANO, 
       				REC_SUBCLASIFICACION, 
       				REC_SUBCLASIFICACION_ROMANO, 
       				REC_PUNTAJE,
         			REC_PUNTMAX,
         			REC_TIPOPUNTUACION,
					MOTIVO,
					PKACCIONES,
                    ACCIONES,
                    ICONOS,
                    ACCIONESCVE,
                    NOMEDO,
                    NUMEDO,
                    CER_DESCRIPCION,
                    EDOACT,
                    RUTA_DESC,
                    RUTA_PK
			 FROM  datos
		where PK_FILA =#pkFila#
				and PKCELDA = #pkCelda#
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Marzo 2018
    * author : Marco Torres
	--->        
	<cffunction name="getNumeroregistrosPorEtapa" hint="obtiene el numero de productos para un evaluador en una etapa">
		<cfargument name="datos">
		<cfargument name="FK_EVALUADOR">
		<cfargument name="pkEtapa">
			<cfquery dbtype="query" name="res">
				select COUNT(FK_TIPO_EVALUACION) as cuantos
				 FROM  datos
				where FK_EVALUADOR =#FK_EVALUADOR#
				and FK_TIPO_EVALUACION = #pkEtapa#
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Noviembre 2016
    * author : Daniel Memije
	--->        
	<cffunction name="getArrayFilasbyProductoCVU" hint="crea un array con las filas de los reportes">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfscript>
			 		    
			var consulta=dao.getRespuestasbyProductoCVU(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto);
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
					var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Fila"),consulta,x);					
					fila.setEVALUACION_ETAPAS(this.getEtapasEvaluacionByFila(fila.getPK_FILA()));
					fila.SETCELDAS(celdas);					
					arrayAppend(filas, fila);
					var celdas=[];
				}	
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>

	
	<!---
    * Fecha : Octubre 2017
    * author : Alejandro Tovar
	--->       
   	<cffunction name="relacionaProdPersona" hint="relaciona una fila de un producto con una persona">
        <cfargument name="pkReporte" type="numeric" required="yes" hint="pk del reporte">
        <cfargument name="pkFila" 	 type="numeric" required="yes" hint="pk de la fila">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
        <cfscript>
            return dao.relacionaProdPersona(pkReporte, pkFila, pkPersona);
        </cfscript>
    </cffunction>


    <!---
    * Fecha : Noviembre 2017
    * author : Daniel Memije
		--->        
   	<cffunction name="getEtapasEvaluacionByFila" hint="Obtiene las etapas de evaluacion con la fila">
		<cfargument name="pkFila">		
		<cfscript>
			var res = [];
			var datosEvaluacionEtapa = dao.getEtapasEvaluacionByFila(pkFila);
			for(var i in datosEvaluacionEtapa){
				var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
				arrayAppend(res, etapa);
			}
			return res;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Enero 2018
    * author: Alejandro Tovar
	--->
   	<cffunction name="getEtapasEvaluacionByFilaAndPkUsuario" hint="Obtiene las etapas de evaluacion con la fila">
		<cfargument name="pkFila">
		<cfscript>
			var res = [];
			var datosEvaluacionEtapa = dao.getEtapasEvaluacionByFilaAndPkUsuario(pkFila, Session.cbstorage.usuario.PK);
			var queryAcciones 		 = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.EVAL_EDI#, datosEvaluacionEtapa, Session.cbstorage.usuario.ROL);
			for(var i in queryAcciones){
				var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
				arrayAppend(res, etapa);
			}
			return res;
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha:	Noviembre 2017
    * Autor:	Roberto Cadena
	--->          
   	<cffunction name="getNodosHojaNoEvaluado" hint="">
		<cfargument name="pkProducto">
		<cfscript>
			var reportes = dao.getNodosHoja(pkProducto);
			var productos = [];
			var rutas = [];
			
			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosNoEvaluado(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i]);
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');
				arrayappend(productos,producto);
			}
			
			return productos;
		</cfscript>
	</cffunction>

	<!---
    * Fecha:	Noviembre 2017
    * Autor:	Roberto Cadena
	--->          
   	<cffunction name="getNodosTodosNoEvaluado" hint="">
		<cfscript> 
			var nodos = getallNodosPadresCached();
			var reportes = dao.getNodosAllHoja(nodos);
			var productos = [];
			var rutas = [];
			
			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosNoEvaluadoEDI(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i]);
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');
				arrayappend(productos,producto);
			}	
			return productos;
		</cfscript>
	</cffunction>

	<!---
    * Fecha:	Diciembre 2018
    * Autor:	JLGC copia de getNodosTodosNoEvaluado
	--->          
   	<cffunction name="getNodosTodosSeleccionados" hint="">
		<cfscript> 
			var nodos = getallNodosPadresCached();
			var reportes = dao.getNodosAllHoja(nodos);
			var productos = [];
			var rutas = [];
			
			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosSeleccionadosEDI(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i]);
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');				
				if(arrayLen(producto.reporte.getFILAS()) GT 0){
					arrayappend(productos,producto);
				}
			}	
			return productos;
		</cfscript>
	</cffunction>

	<!---
    * Fecha:	Febrero 2018
    * Autor:	Daniel Memije
	--->          
	<cffunction name="getNodosTodosSeleccionadosAndPkUsuario" hint="">
		<cfargument name="pkUsuario">
		<cfargument name="pkProceso">
		<cfscript> 
			writedump('INICIO----'&getTickCount() - startTime & '    ');
			var nodos = getallNodosPadresCached();
			writedump('INICIO2----'&getTickCount() - startTime & '    ');
			var reportes = dao.getNodosAllHojabyPKUsuario(nodos,pkUsuario);
			writedump('INICIO QUERYS----'&getTickCount() - startTime & '    ');
			
			var productos = [];
			var rutas = [];
			var rutasee = [];
			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosEDI(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i],pkUsuario,pkProceso);
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');				
				if(arrayLen(producto.reporte.getFILAS()) GT 0){
					arrayappend(productos,producto);
				}
				
				
				writedump(rutasee);
				writedump(chr(13)&chr(10)&'producto');
				writedump(reportes.PRODUCTO[i] &'----'&getTickCount() - startTime & '    ');
			}
			//abort;
			var productosFiltrados = this.getNodosTodosSeleccionadosAndPkUsuarioByProceso(productos);
		
			return productosFiltrados;
		</cfscript>
	</cffunction>



	<!---
    * Fecha:	Febrero 2018
    * Autor:	Alejandro Tovar
	--->          
	<cffunction name="getNodosTodosSeleccionadosAndPkUsuarioByProceso" hint="Cambia el estado de los productos de años anteriores">
		<cfargument name="productos">
		<cfscript>
			var proceso = CNSOL.getProcesosEDI();
			
			for (var i = 1; i lte arrayLen(productos); i++){
				var productos2 = productos[i].reporte;
				var filas = productos2.getFilas();

				for(var j = 1; j lte arrayLen(filas); j++){
					
					/*writedump(proceso.getFECHAINIPROC());*/
					if( val(filas[j].getANIO()) LT proceso.getFECHAINIPROC() ){
							
						if( proceso.getPKPROCESO() EQ filas[j].getPROCESO() ){
							
							DAO.cambiaEstadoEvalProdEdi(filas[j].getEVALUACIONPRODUCTOEDI());
							//writedump('<br>anio: '&filas[j].getANIO());
							ArrayDeleteAt(filas, j);
							j--;
						}
					}
				}
				productos2.setFilas(filas);
			}
			return productos;
		</cfscript>
	</cffunction>

	
	<!---
    * Fecha:	Enero 2018
    * Autor:	Daniel Memije
	--->          
	<cffunction name="getNodosTodosSeleccionadosUsuario" hint="">
		<cfargument name="pkUsuario">
		<cfscript> 
			var nodos = getallNodosPadresCached();
			var reportes = dao.getNodosAllHojabyPKUsuario(nodos,pkUsuario);
			var productos = [];
			var rutas = [];
			for (var i = 1; i lte reportes.recordcount; i++){
				var producto= {};
				producto.reporte 	= this.getInfoReporteByProductosSeleccionadosEDIUsuario(reportes.Formato[i], reportes.periodo[i],reportes.PRODUCTO[i],pkUsuario);
				producto.ruta 		= listtoarray(reportes.RUTAPRODUCTOS[i],'$$');				
				if(arrayLen(producto.reporte.getFILAS()) GT 0){
					arrayappend(productos,producto);
				}
			}
			return productos;
		</cfscript>
	</cffunction>

	<cffunction name="QueryToArray" access="public" returntype="array" output="false" hint="This turns a query into an array of structures.">
    <cfargument name="Data" type="query" required="yes" />

    <cfscript>
    	var array = ArrayNew( 1 );
        // Define the local scope.
        var LOCAL = StructNew();
        // Get the column names as an array.
        LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );
        // Create an array that will hold the query equivalent.
        LOCAL.QueryArray = ArrayNew( 1 );
        // Loop over the query.
        for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
            // Create a row structure.
            LOCAL.Row = StructNew();
            // Loop over the columns in this row.
            for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
                // Get a reference to the query column.
                LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
                // Store the query cell value into the struct by key.
                LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
            }
            // Add the structure to the query array.
            ArrayAppend( array, LOCAL.Row.pkProducto );
        }
        // Return the array equivalent.
        return( array );
    </cfscript>
</cffunction>

	<!---
    * Fecha:	Noviembre 2017
    * Autor:	Roberto Cadena
	--->       
	<cffunction name="getInfoReporteByProductosNoEvaluado" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			datosColumnas.FILAFIJA[1] = datosColumnas.FILAFIJA[1] EQ 1 ? 0 : 1;
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProductoNoEvaluado(pkTFormato,pkPeriodo,pkProducto)); 
		
			/*si tiene una seccion asociaciada consruye la estructutra y la mete en la propiedad secciones*/
			if(reporte.getpkPlantillaSeccion() NEQ ''){
				/*obtiene el pk de la plantilla de la columna de referencia*/
				
				var columna = reporte.getEncabezado().getColumnaByPK(reporte.getpkColumnaSeccion());
				
				var pkplantillaColumna = columna.getPk_plantilla();
				 
				var secciones = getEstructuraSecciones(reporte.getpkPlantillaSeccion(),pkplantillaColumna, reporte.getpkAsociacion());
				reporte.setSecciones(secciones);
			}			
		</cfscript>
		<cfreturn reporte>
	</cffunction>

	<!---
    * Fecha:	Noviembre 2017
    * Autor:	Roberto Cadena
	--->       
	<cffunction name="getInfoReporteByProductosNoEvaluadoEDI" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			datosColumnas.FILAFIJA[1] = datosColumnas.FILAFIJA[1] EQ 1 ? 0 : 1;
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProductoNoEvaluadoEDI(pkTFormato,pkPeriodo,pkProducto)); 
		
			/*si tiene una seccion asociaciada consruye la estructutra y la mete en la propiedad secciones*/
			if(reporte.getpkPlantillaSeccion() NEQ ''){
				/*obtiene el pk de la plantilla de la columna de referencia*/
				
				var columna = reporte.getEncabezado().getColumnaByPK(reporte.getpkColumnaSeccion());
				
				var pkplantillaColumna = columna.getPk_plantilla();
				 
				var secciones = getEstructuraSecciones(reporte.getpkPlantillaSeccion(),pkplantillaColumna, reporte.getpkAsociacion());
				reporte.setSecciones(secciones);
			}			
		</cfscript>
		<cfreturn reporte>
	</cffunction>

	<!---
    * Fecha:	Diciembre 2018
    * Autor:	JLGCH copia de getInfoReporteByProductosNoEvaluadoEDI
	--->       
	<cffunction name="getInfoReporteByProductosSeleccionadosEDI" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			datosColumnas.FILAFIJA[1] = datosColumnas.FILAFIJA[1] EQ 1 ? 0 : 1;
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProductosSeleccionados(pkTFormato,pkPeriodo,pkProducto)); 
		
			/*si tiene una seccion asociaciada consruye la estructutra y la mete en la propiedad secciones*/
			if(reporte.getpkPlantillaSeccion() NEQ ''){
				/*obtiene el pk de la plantilla de la columna de referencia*/
				
				var columna = reporte.getEncabezado().getColumnaByPK(reporte.getpkColumnaSeccion());
				
				var pkplantillaColumna = columna.getPk_plantilla();
				 
				var secciones = getEstructuraSecciones(reporte.getpkPlantillaSeccion(),pkplantillaColumna, reporte.getpkAsociacion());
				reporte.setSecciones(secciones);
			}			
		</cfscript>
		<cfreturn reporte>
	</cffunction>

	<!---
    * Fecha:	Enero 2018
    * Autor:	Daniel Memije
	--->       
	<cffunction name="getInfoReporteByProductosSeleccionadosEDIUsuario" hint="obtiene los elementos necesarios para pintar la tabla de captura de infoemacion de in fortmato ">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">		
		<cfscript>
			var resultado  = structnew();
			var datosColumnas = this.getinfoReporteCached(pkTFormato,pkPeriodo);
			var reporte=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Reporte"),datosColumnas,1);
			
			/*se obtiene el encabezado del formato*/
			reporte.setEncabezado(creaEncabezado(pkTFormato)); 
			reporte.setFilas(this.getArrayFilasbyProductosSeleccionadosUsuario(datosColumnas.PKCFORMATO[1],pkTFormato,pkPeriodo,pkProducto,pkUsuario)); 
		</cfscript>
		<cfreturn reporte>
	</cffunction>

	

	<!---
    * Fecha:	Noviembre 2017
    * Autor:	Roberto Cadena
	--->        
   	<cffunction name="getArrayFilasbyProductoNoEvaluadoEDI" hint="crea un array con las filas de los reportes">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
		
		
		    if(pkTFormato == 0)
		    	var pkCFormato = 0;
		    else	
		        var pkCFormato = dao.getinfoFormato(pkTFormato).PKCFORMATO[1];
		    
		    
			var consulta=dao.getRespuestasbyProductoNoEvaluado(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto);
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
				var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_FilaEDI"),consulta,x);
					fila.setClASIFICACION(DAO.getDatosProductos(consulta.PKCPRODUCTO[x]).CLASIFICACION[1]);
					fila.setSUBClASIFICACION(DAO.getDatosProductos(consulta.PKCPRODUCTO[x]).SUBCLASIFICACION[1]);
					fila.SETCELDAS(celdas);					
					arrayAppend(filas, fila);
					var celdas=[];
				}	
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>

	<!---
    * Fecha:	Diciembre 2018
    * Autor:	JLGC copia de getArrayFilasbyProductoNoEvaluadoEDI
	--->        
   	<cffunction name="getArrayFilasbyProductosSeleccionados" hint="crea un array con las filas de los reportes">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
		
		
		    if(pkTFormato == 0)
		    	var pkCFormato = 0;
		    else	
		        var pkCFormato = dao.getinfoFormato(pkTFormato).PKCFORMATO[1];
		    
		    
			var consulta=dao.getRespuestasbyProductosSeleccionados(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto);
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
				var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_FilaEDI"),consulta,x);
					// fila.setClASIFICACION(DAO.getDatosProductos(consulta.PKCPRODUCTO[x]).CLASIFICACION[1]);
					// fila.setSUBClASIFICACION(DAO.getDatosProductos(consulta.PKCPRODUCTO[x]).SUBCLASIFICACION[1]);
					fila.setEVALUACION_ETAPAS(this.getEtapasEvaluacionByFila(fila.getPK_FILA()));
					fila.SETCELDAS(celdas);
					fila.initAnio();
					arrayAppend(filas, fila);
					var celdas=[];
				}	
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>

	<!---
    * Fecha:	Enero 2018
    * Autor:	Daniel Memije
	--->        
	<cffunction name="getArrayFilasbyProductosSeleccionadosUsuario" hint="crea un array con las filas de los reportes">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfargument name="pkUsuario">
		<cfscript>
				
			var datosEvaluacionEtapa =dao.getRespuestasbyProductoEDI(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto,Session.cbstorage.usuario.PK);
			var consultaCompleta 		 = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.EVAL_EDI#, datosEvaluacionEtapa, Session.cbstorage.usuario.ROL);
			var consulta 		 = getfilasFromQuery(consultaCompleta);
			
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
				var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_FilaEDI"),consulta,x);
					fila.SETCELDAS(celdas);
					fila.initAnio();
					arrayAppend(filas, fila);
					var celdas=[];
					var etapas=[];
					
					var etapasFila = this.getEtapasFromQuery(consultaCompleta,consulta.PK_FILA[x],consulta.PKCELDA[x]);
					for(var i in etapasFila){
						var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
							arrayAppend(etapas, etapa);
					}
					fila.setEVALUACION_ETAPAS(etapas);
				}
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>

	<!---
    * Fecha:	Noviembre 2017
    * Autor:	Roberto Cadena
	--->        
   	<cffunction name="getArrayFilasbyProductoNoEvaluado" hint="crea un array con las filas de los reportes">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkProducto">
		<cfscript>
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
		
		
		    if(pkTFormato == 0)
		    	var pkCFormato = 0;
		    else	
		        var pkCFormato = dao.getinfoFormato(pkTFormato).PKCFORMATO[1];
		    
		    
			var consulta=dao.getRespuestasbyProductoNoEvaluado(pkCFormato,pkTFormato,pkPeriodo,pkUsuario,pkProducto);
			var celdas=[];
			var filas=[];
			
			/*crea un JSON array con las filas y celdas*/
			for(var x=1; x lte consulta.recordcount; x++){
				var celda=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Celda"),consulta,x);
				arrayAppend(celdas, celda);
				if(consulta.PK_FILA[x] neq consulta.PK_FILA[x+1] ){
				var fila=populator.populateFromQuery(wirebox.getInstance("formatosTrimestrales/B_Fila"),consulta,x);
					fila.SETPK_CPRODUCTO(pkProducto);
					fila.SETCELDAS(celdas);
					arrayAppend(filas, fila);
					var celdas=[];
				}	
			}
		</cfscript>
		<cfreturn filas>
	</cffunction>

	<!---
    * Fecha creación: dIC de 2017
    * @author: ABJM
    --->
    <cffunction name="actualizarEstadoFila" hint="actualiza el estado de una fila">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
        <cfargument name="estado" type="numeric" required="yes" hint="estado de la fila">
		<cfscript>
			var res = dao.actualizarEstadoFila(pkFila, estado);
		</cfscript>
		<cfreturn res>
    </cffunction>

    <!---
   	* Fecha: 	20/12/2017
   	* @autor:	SGS
   	--->
   	<cffunction name="obtenerDatosPrecargados" access="public" hint="Obtiene los valores de la celdas que seran precargadas">
   		<cfargument name="celda" 	type="numeric" required="yes" hint="pk de la celda">
   		<cfargument name="issn" 	type="string"  required="yes" hint="Clave issn de la revista">
   		<cfargument name="issnAnio" type="numeric" required="yes" hint="Anio de la revista">
   		<cfscript>
   			return DAO.obtenerDatosPrecargados(celda, issn, issnAnio).DATA;
   		</cfscript>
   	</cffunction>

	<!---
	* Fecha:	Enero de 2018
	* Autor:	Roberto Cadena
	---> 
	<cffunction name="eliminarProducto" hint="elimina el registro de productopersona y de fila">
		<cfargument name="pkFila" type="numeric" required="yes" hint="Pk de la fila">
		<cfscript>
			return DAO.eliminarProducto(pkFila);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Febrero de 2018
	* Autor:	Daniel Memije
	---> 
	<cffunction name="getClasificacionesCVU" hint="Obtiene las clasificaciones de cvu">
		<cfscript>
			var res = createObject("java", "java.util.LinkedHashMap").init();

			var clasificacionesDatos = DAO.getClasificacionesCVU();
			for(clasificacion in clasificacionesDatos){
				if(!structKeyExists(res, clasificacion.PK_CLASIF)){
					res[clasificacion.PK_CLASIF] = createObject("java", "java.util.LinkedHashMap").init();
					res[clasificacion.PK_CLASIF]["NOMBRE"] = clasificacion.CLASIF;
					res[clasificacion.PK_CLASIF]["ROMANO"] = clasificacion.CLASIF_NUM_ROMANO;
					res[clasificacion.PK_CLASIF]["SUBCLASIFICACIONES"] = createObject("java", "java.util.LinkedHashMap").init();
				}
				if(!structKeyExists(res[clasificacion.PK_CLASIF]["SUBCLASIFICACIONES"], clasificacion.SUBCLASIF_NUM) AND Len(clasificacion.SUBCLASIF_NUM)){
					res[clasificacion.PK_CLASIF]["SUBCLASIFICACIONES"][clasificacion.SUBCLASIF_NUM] = createObject("java", "java.util.LinkedHashMap").init();
					res[clasificacion.PK_CLASIF]["SUBCLASIFICACIONES"][clasificacion.SUBCLASIF_NUM]["ROMANO"] = clasificacion.SUBCLASIF_NUM_ROMANO;
				}
			}
			var structCoautoria = {};
			structCoautoria["05"] = {};			
			structCoautoria["05"]["ROMANO"] = "V";
			structAppend(res[3]["SUBCLASIFICACIONES"], structCoautoria);
			return res;
			// writeDump(clasificacionesDatos);
			// writeDump(res);
			// abort;
		</cfscript>
	</cffunction>

	<cffunction name="eliminarComprobante" hint="Elimina archivo">
		<cfargument name="pkformato" type="any" hint="pk del formato asociado">
		<cfargument name="pkcol" type="any" hint="pk de la columna asociada">
		<cfargument name="pkfila" type="any" hint="pk de la fila asociada">
		<cfscript>
			return DAO.eliminarComprobante(pkformato, pkcol, pkfila);
		</cfscript>
	</cffunction>
	<!---
	* Fecha:	Marzo de 2018
	* Autor:	Alejandro Rosales
	---> 
	<cffunction name="getNodosTodosSeleccionadosUsuarioUR" hint="Obtiene los productos de los usuario en consulta">
		<cfargument name="consulta" type="any" hint="Consulta de los investigadores seleccionados">
		<cfargument name="proceso" type="any" hint="pk del proceso seleccionado">
		<cfscript>
			datos = [];
			for(invt in consulta){
					productos = getNodosTodosSeleccionadosUsuario(invt.FK_USUARIO,proceso);
					arrayAppend(datos, productos); 	
			}
			return datos;
		</cfscript>
	</cffunction>

</cfcomponent>