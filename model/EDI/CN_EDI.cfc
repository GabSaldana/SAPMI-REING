<cfcomponent>	
	<cfproperty name="dao"			inject="EDI/DAO_EDI">
	<cfproperty name="populator"	inject="wirebox:populator">
	<cfproperty name="wirebox"		inject="wirebox">
	<cfproperty name="cache"		inject="cachebox:default">
	<cfproperty name="cnEmail"		inject="utils.email.CN_service">
	<cfproperty name="cnUsuarios"   inject="adminCSII/usuarios/CN_usuarios">
	<cfproperty name="cnMes"        inject="utils.maquinaEstados.CN_maquinaEstados">

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

		<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllProductos" hint="Obtiene todos los productos">
		<cfscript>
			return DAO.getAllProductos();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getAllProductosEDI" hint="Obtiene todos los productos de EDI">
		<cfscript>
			return DAO.getAllProductosEDI();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getArbolProductosNoEvaluados" hint="Obtiene el arbol de productos que esta en EDI">
		<cfargument name="pkPersona" hint="pk de la persona">			
		<cfscript>		
			var clasificaciones = createObject("java", "java.util.LinkedHashMap").init();
			var datosArbol = DAO.getArbolProductosNoEvaluados(pkPersona);
			for(producto in datosArbol){
				if(!structKeyExists(clasificaciones,producto.CLASIFICACION)){
					clasificaciones[producto.CLASIFICACION] = arrayNew(1);					
				}
				producto.RUTAPRODUCTOSARRAY = ListToArray(producto.RUTAPRODUCTOS,"$$");
				arrayAppend(clasificaciones[producto.CLASIFICACION],producto);								
			}			
			return clasificaciones;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getArbolProductosEvaluados" hint="Obtiene el arbol de productos que esta en EDI">
		<cfargument name="pkPersona" hint="pk de la persona">			
		<cfscript>		
			var clasificaciones = createObject("java", "java.util.LinkedHashMap").init();
			var datosArbol = DAO.getArbolProductosEvaluados(pkPersona);
			for(producto in datosArbol){
				if(!structKeyExists(clasificaciones,producto.CLASIFICACION)){
					clasificaciones[producto.CLASIFICACION] = arrayNew(1);					
				}
				producto.RUTAPRODUCTOSARRAY = ListToArray(producto.RUTAPRODUCTOS,"$$");
				arrayAppend(clasificaciones[producto.CLASIFICACION],producto);								
			}			
			return clasificaciones;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getNodosRaiz" hint="OBTIENE LOS NODOS RAIZ (SIN PADRES) DE LOS PRODUCTOS">	
		<cfscript>
			return DAO.getNodosRaiz();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getEtapasEvaluacionProductoPersona" hint="OBTIENE LAS ETAPAS DE EVALUACION DE UN PRODUCTO">
		<cfargument name="pkEvaluacion" hint="pk de EVALUACIONPRODUCTOEDI">		
		<cfscript>
			var resultado = [];
			var datosEvaluacionEtapa = DAO.getEtapasEvaluacionProductoPersona(pkEvaluacion);
			for(var i in datosEvaluacionEtapa){
				var etapa = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),i);
				arrayAppend(resultado,etapa);
			}
			return resultado;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getEvaluacionProductoPersona" hint="OBTIENE LA EVALUACION DE UN PRODUCTO">
		<cfargument name="pkProductoEDI" hint ="pk del producto de EDI">		
		<cfargument name="pkPersona"     hint ="pk de la persona">
		<cfscript>
			var aux = {};
			var resultado = [];
			var datosProductos = DAO.getEvaluacionProductoPersona(pkProductoEDI,pkPersona);			

			for (var i in datosProductos){											
				var evaluacionProducto = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionProducto"),i);
				evaluacionProducto.setEVALUACION_ETAPA(this.getEtapasEvaluacionProductoPersona(evaluacionProducto.getPK_EVALUACIONPRODUCTO()));
				if(structKeyExists(aux,i.PK_CPRODUCTOEDI)){
					arrayAppend(aux[i.PK_CPRODUCTOEDI].getEVALUACION_PRODUCTOS(), evaluacionProducto);
				}else{
					aux[i.PK_CPRODUCTOEDI] = populator.populateFromStruct(wirebox.getInstance("EDI/B_Evaluacion"),i);;					
					arrayAppend(aux[i.PK_CPRODUCTOEDI].getEVALUACION_PRODUCTOS(), evaluacionProducto);					
				}
			}	
			for(var i in aux){
				aux[i].setRUTA_PRODUCTOS(listtoarray(aux[i].getRUTA_PRODUCTOS(),'$$'));
				// aux[i]
				arrayAppend(resultado, aux[i]);				
			}						
			return resultado;			
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getTiposEvaluacion" hint="obtiene los tipos de evaluacion">		
		<cfscript>
			return DAO.getTiposEvaluacion();
		</cfscript>		
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getPersonasConProductosEDI" hint="obtiene las personas con productos en EDI">		
		<cfscript>
			return DAO.getPersonasConProductosEDI();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getTablaAspiranteProceso" hint="obtiene la tabla de movimientos de aspiranteproceso">
		<cfargument name="pkProceso" type="numeric"	hint ="pk del proceso">
		<cfscript>
			var aspirantes = DAO.getTablaAspiranteProceso(pkProceso, session.cbstorage.usuario.pk, session.cbstorage.usuario.rol);
			return cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.SOLI_EDI#, aspirantes, Session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getProcesos" hint="obtiene los procesos existentes">
		<cfscript>
			return DAO.getProcesos();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadores" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso" hint ="pk del proceso" type="numeric">
		<cfscript>
			var usuarios	= DAO.getUsuariosRoles([62, 182,82]);
			var evaluadores	= DAO.getEvaluadoresProceso(pkProceso);
			for(i=1; i lte usuarios.recordcount; i++){
				for(j=1; j lte evaluadores.recordcount; j++){
					if(usuarios.PKUSUARIO[i]  eq evaluadores.FKUSUARIO[j]){
						switch(evaluadores.EVALTIPO[j]) {
							case "1":
								usuarios.EVALSIP[i] = 'checked';
								break; 
							case "2":
								usuarios.EVALCE[i] = 'checked';
								break; 
							case "3": case "4":
								usuarios.EVALCA[i] = 'checked';
								break;
						}
					}
				}
			}
			return usuarios;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setTipoEvaluador" hint="Asigna un tipo de evaluacion a un evaluador">
		<cfargument name="pkUsuario"  type="numeric" hint="pk del usuario">
		<cfargument name="pkTipoEval" type="numeric" hint="pk del tipo de evaluacion">
		<cfargument name="pkProceso"  type="numeric" hint="pk del proceso">
		<cfargument name="estado"	  type="numeric" hint="estado">
		<cfscript>
			var tipoEval = DAO.setTipoEvaluador(pkUsuario, pkTipoEval, pkProceso, estado);
			var rolEvaluador = cnUsuarios.getRolDeUsuario(pkUsuario);
			
			if (rolEvaluador NEQ #application.SIIIP_CTES.ROLES.EDI_EVA#){
				if (tipoEval GT 0){	
					var isEval = DAO.usuarioIsEvaluador(pkUsuario).EVALUADOR[1];
					if (isEval GT 0){
						tipoEval = DAO.setRolEvaluador(pkUsuario, #application.SIIIP_CTES.ROLES.INV_EVA#);
					}else {
						tipoEval = DAO.setRolEvaluador(pkUsuario, #application.SIIIP_CTES.ROLES.INV_CVU#);
					}
				}
			}

			return tipoEval;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPersonasSolicitudEDI" hint="Asigna un tipo de evaluacion a un evaluador">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del usuario">
		<cfscript>
			var personas	= DAO.getPersonasSolicitudEDI(pkProceso);
			var evaluadores	= DAO.getEvaluadoresActivos(pkProceso);
			for(i=1; i lte personas.recordcount; i++)
				for(j=1; j lte evaluadores.recordcount; j++)
					if(personas.PKPERSONA[i]  eq evaluadores.PKPERSONA[j])
						switch(evaluadores.PKEVALUACIONTIPO[j]){
							case "1":
								personas.EVALSIP[i]			= evaluadores.NOMBRE[j]&' '&evaluadores.PATERNO[j]&' '&evaluadores.MATERNO[j]&' ';
								personas.PKEVALSIP[i]		= evaluadores.PKEVALUADOR[j];
								personas.BOTONEVALSIP[i]	= 'fa-user-times';
								personas.CLASEEVALSIP[i]	= 'btn-danger';
								//personas.COMPLETAEVALSIP[i]	= getAllProductosEvaluados(personas.PKPERSONA[i], evaluadores.PKEVALUADOR[j], 1, pkProceso) eq 0 ? '' : '<button type="button" data-original-title="Produtos Evaluados" data-toggle="tooltip" class="btn btn-primary btn-circle"><span class="fa fa-check"></span></button>';
								break; 
							case "2":
								personas.EVALCE[i]			= evaluadores.NOMBRE[j]&' '&evaluadores.PATERNO[j]&' '&evaluadores.MATERNO[j]&' ';
								personas.PKEVALCE[i]		= evaluadores.PKEVALUADOR[j];
								personas.BOTONEVALCE[i]		= 'fa-user-times';
								personas.CLASEEVALCE[i]		= 'btn-danger';
								//personas.COMPLETAEVALCE[i]	= getAllProductosEvaluados(personas.PKPERSONA[i], evaluadores.PKEVALUADOR[j], 2, pkProceso) eq 0 ? '' : '<button type="button" data-original-title="Produtos Evaluados" data-toggle="tooltip" class="btn btn-primary btn-circle"><span class="fa fa-check"></span></button>';
								break; 
							case "3":
								personas.EVALCA[i]			= evaluadores.NOMBRE[j]&' '&evaluadores.PATERNO[j]&' '&evaluadores.MATERNO[j]&' ';
								personas.PKEVALCA[i]		= evaluadores.PKEVALUADOR[j];
								personas.BOTONEVALCA[i]		= 'fa-user-times';
								personas.CLASEEVALCA[i]		= 'btn-danger';
								//personas.COMPLETAEVALCA[i]	= getAllProductosEvaluados(personas.PKPERSONA[i], evaluadores.PKEVALUADOR[j], 3, pkProceso) eq 0 ? '' : '<button type="button" data-original-title="Produtos Evaluados" data-toggle="tooltip" class="btn btn-primary btn-circle"><span class="fa fa-check"></span></button>';
								break;
							 case "4":
								personas.EVALRI[i]			= evaluadores.NOMBRE[j]&' '&evaluadores.PATERNO[j]&' '&evaluadores.MATERNO[j]&' ';
								personas.PKEVALRI[i]		= evaluadores.PKEVALUADOR[j];
								personas.BOTONEVALRI[i]		= 'fa-user-times';
								personas.CLASEEVALRI[i]		= 'btn-danger';
								//personas.COMPLETAEVALRI[i]	= getAllProductosEvaluados(personas.PKPERSONA[i], evaluadores.PKEVALUADOR[j], 4 , pkProceso) eq 0 ? '' : '<button type="button" data-original-title="Produtos Evaluados" data-toggle="tooltip" class="btn btn-primary btn-circle"><span class="fa fa-check"></span></button>';
								break;
						}
			return personas;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllProductosEvaluados" hint="Elimina al evaluador que va a evaluar los productos de un investigador">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del evaluador">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del tipo de evaluacion">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">
		<cfscript>
			return DAO.getAllProductosEvaluados(pkPersona, pkEvaluador, pkTipoEval, pkProceso);
		</cfscript>
	</cffunction>
	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEvaluador" hint="Elimina al evaluador que va a evaluar los productos de un investigador">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del evaluador">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del tipo de evaluacion">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">
		<cfscript>
			return DAO.eliminarEvaluador(pkPersona, pkEvaluador, pkTipoEval, pkProceso);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresTipo" hint="Muestra todos los usuarios para asignar a evaluar con base a un tipo de evaluacion">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del tipo de evaluacion">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">
		<cfscript>
			pkTipoEval = pkTipoEval eq 4 ? 3 : pkTipoEval;
			return DAO.getEvaluadoresTipo(pkTipoEval, pkProceso);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setEvaluadorInvestigador" hint="Asigna un evaluador a un investigador">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del evaluador">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del tipo de evaluacion">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">
		<cfscript>
			return DAO.setEvaluadorInvestigador(pkPersona, pkEvaluador, pkTipoEval, pkProceso);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllEvaluadores" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfscript>
			var evaluadores = DAO.getAllEvaluadores(pkProceso);
			var evaluacionEvaluadores = DAO.getEvaluadoresTiposEvaluadores(pkProceso);
			for(i=1; i lte evaluadores.recordcount; i++){
				for(j=1; j lte evaluacionEvaluadores.recordcount; j++){
					if(evaluadores.PKEVALUADOR[i]  eq evaluacionEvaluadores.PKEVALUADOR[j]){
						switch(evaluacionEvaluadores.EVALTIPO[j]) {
							case "1":
								evaluadores.EVALSIP[i]	= '1';
								break; 
							case "2":
								evaluadores.EVALCE[i]	= '2';
								break; 
							case "3":
								evaluadores.EVALCA[i]	= '3';
								break;
							 case "4":
								evaluadores.EVALRI[i]	= '4';
								break;
						}
					}
				}
			}
			return evaluadores;
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getInvestigadoresConEvaluacion" hint="Muestra todos las evaluaciones que se le pueden hacer a un investigador con base en un evaluador">
		<cfargument name="pkEvaluador"	type="numeric"	hint ="pk del evaluador">
		<cfargument name="tipoInvest"	type="array"	hint ="nombres de los tipos de investigadores que puede ser un evaluador">
		<cfargument name="pktipoInvest"	type="array"	hint ="pk de los tipos de investigadores que puede ser un evaluador">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfscript>
			var evaluadores = DAO.getAllInvestigadoresTipoEval(tipoInvest, pkProceso);
			var evaluacionEvaluadores = DAO.getEvaluadoresTiposEvaluadoresTipoEval(pkEvaluador, pktipoInvest, pkProceso);
			for(i=1; i lte evaluadores.recordcount; i++){
				for(j=1; j lte evaluacionEvaluadores.recordcount; j++){
					if(evaluadores.PKPERSONA[i]  eq evaluacionEvaluadores.FKPERSONA[j]){						
						switch(evaluacionEvaluadores.EVALTIPO[j]) {
							case "1":
								evaluadores.EVALSIP[i]	= '1';
								evaluadores.CHECKEDEVALSIP[i]	= 'checked';
								break; 
							case "2":
								evaluadores.EVALCE[i]	= '2';
								evaluadores.CHECKEDEVALCE[i]	= 'checked';
								break; 
							case "3":
								evaluadores.EVALCA[i]	= '3';
								evaluadores.CHECKEDEVALCA[i]	= 'checked';
								break;
							 case "4":
								evaluadores.EVALRI[i]	= '4';
								evaluadores.CHECKEDEVALRI[i]	= 'checked';
								break;
						}
					}
				}
			}
			return evaluadores;
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getAutoEvaluacion" hint="Obtiene el objeto de la autoevaluacion">
		<cfargument name="productos"	 hint ="array con productos en EDI">
		<cfargument name="proceso"		hint ="objeto del proceso">
		<cfscript>			
			var structRes = createObject("java", "java.util.LinkedHashMap").init(); //Se usa este tipo de dato por que coldfusion no realiza un ordenamiento en las llaves
			for(producto in productos){												
				for(fila in producto.REPORTE.getFILAS()){
					var clasificacion = fila.getCLASIFICACION();
					var clasificacionRomano = fila.getCLASIFICACION_ROMANO();
					var subclasificacion = fila.getSUBCLASIFICACION();
					var subclasificacionRomano = fila.getSUBCLASIFICACION_ROMANO();
					var anio = (fila.getANIO() > 0) ? fila.getANIO() : "SIN ASIGNAR";
					if(!structKeyExists(structRes, clasificacion)){
						structRes[clasificacion] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion]["NOMBRE"] = producto.RUTA[1];			
						structRes[clasificacion]["PUNTAJECLASIFICACION"] = 0;
						structRes[clasificacion]["ROMANO"]  = clasificacionRomano;
					}
					if(!structKeyExists(structRes[clasificacion], subclasificacion)){
						structRes[clasificacion][subclasificacion] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] = 0;
						structRes[clasificacion][subclasificacion]["ROMANO"] = subclasificacionRomano;
						// structRes[clasificacion][subclasificacion]["RUTA"] = producto.RUTA;
						// Crea una estructura para cada anio del proceso
						for(var i = proceso.getFECHAINIPROC(); i <= proceso.getFECHAFINPROC();i++){
							structRes[clasificacion][subclasificacion][i] = createObject("java", "java.util.LinkedHashMap").init();
							structRes[clasificacion][subclasificacion][i]["PRODUCTOS"] = arrayNew(1);
							structRes[clasificacion][subclasificacion][i]["PUNTAJE"] = 0;
						}
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"] = createObject("java", "java.util.LinkedHashMap").init();													
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"]["PRODUCTOS"] = arrayNew(1);
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"]["PUNTAJE"] = 0;						
					}
					// Asegura que el producto corresponda al proceso senalado
					if(structKeyExists(structRes[clasificacion][subclasificacion], anio)){
						arrayAppend(structRes[clasificacion][subclasificacion][anio]["PRODUCTOS"], fila);
						if(compare(anio,"SIN ASIGNAR") != 0){
							structRes[clasificacion][fila.getSUBCLASIFICACION()][anio]["PUNTAJE"] += fila.getMAX_PUNTUACION();
							structRes[clasificacion]["PUNTAJECLASIFICACION"] += fila.getMAX_PUNTUACION();
							structRes[clasificacion][fila.getSUBCLASIFICACION()]["PUNTAJESUBCLASIFICACION"] += fila.getMAX_PUNTUACION();
						}						
					}
					// Le pone una bandera de invalido al puntaje del producto que no corresponda al anio del proceso
					else{						
						structRes[clasificacion][subclasificacion][anio]["PUNTAJE"] = "INVALIDO";						
					}							
					if(compare(structRes[clasificacion][subclasificacion][anio]["PUNTAJE"],"INVALIDO") EQ 0){
						structDelete(structRes[clasificacion][subclasificacion],anio);						
					}	
				}				
			}
			return structRes;
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getResumenEvaluacion" hint="Obtiene el objeto de la autoevaluacion">
		<cfargument name="productos"	 hint ="array con productos en EDI">
		<cfargument name="proceso"			hint ="objeto del proceso">
		<cfargument name="pkTipoEvaluacion"		hint ="objeto del proceso">
		<cfscript>			
			var structRes = createObject("java", "java.util.LinkedHashMap").init(); //Se usa este tipo de dato por que coldfusion no realiza un ordenamiento en las llaves			
			for(producto in productos){
				var filas = producto.REPORTE.getFILAS();												
				var filasCoautoria = arrayNew(1);
				for(var indexFila = 1; indexFila <= arrayLen(filas); indexFila++){					
					var fila = filas[indexFila];
					var clasificacion = fila.getCLASIFICACION();
					var clasificacionRomano = fila.getCLASIFICACION_ROMANO();
					var subclasificacion = fila.getSUBCLASIFICACION();
					var subclasificacionRomano = fila.getSUBCLASIFICACION_ROMANO();
					var anio = (fila.getANIO() > 0) ? fila.getANIO() : "SIN ASIGNAR";											

					var fechaRef = CreateDateTime(0,1,1,0,0,0);										
					for(evaluacion in fila.getEVALUACION_ETAPAS()){
						if(Len(evaluacion.getFECHA_CAPTURA()) GT 0){
							var fechaEvaluacion = ParseDateTime(evaluacion.getFECHA_CAPTURA());
							// Si fechaEvaluacion es mas reciente que fechaRef							
							if(	
								(evaluacion.getFK_TIPO_EVALUACION() EQ pkTipoEvaluacion AND fila.GETPROCESO() EQ proceso.GETPKPROCESO()) //SI ES DE ESTE PROCESO OBTIENE LAS DE LA ETAPA QUE LE CORRESPONDE AL EVALUADOR
								OR (dateCompare(fechaEvaluacion,fechaRef) AND ((fila.GETPROCESO() NEQ proceso.GETPKPROCESO()) OR (pkTipoEvaluacion EQ application.SIIIP_CTES.TIPOEVALUACION.FINAL)))				// SI ES DE OTRO PROCESO OBTIENE LA ULTIMA QUE SE CAPTURO								
								){										
								fechaRef = fechaEvaluacion;																
								// Si las clasificaciones son diferentes (y la reclasificacion no esta vacia)
								if(fila.getPKTPRODUCTOEDI() NEQ evaluacion.getFK_RECLASIFICACION() AND Len(evaluacion.getFK_RECLASIFICACION()) GT 0){
									// fila.setMAX_PUNTUACION(evaluacion.getREC_PUNTAJE());
									clasificacion = evaluacion.getREC_CLASIFICACION();
									clasificacionRomano = evaluacion.getREC_CLASIFICACION_ROMANO();
									subclasificacion = evaluacion.getREC_SUBCLASIFICACION();
									subclasificacionRomano = evaluacion.getREC_SUBCLASIFICACION_ROMANO();
								}
								else{
									clasificacion = fila.getCLASIFICACION();
									clasificacionRomano = fila.getCLASIFICACION_ROMANO();
									subclasificacion = fila.getSUBCLASIFICACION();
									subclasificacionRomano = fila.getSUBCLASIFICACION_ROMANO();
								}													
							}																	
						}
					}

					fila.setCLASIFICACION(clasificacion);
					fila.setSUBCLASIFICACION(subclasificacion);
					fila.setCLASIFICACION_ROMANO(clasificacionRomano);
					fila.setSUBCLASIFICACION_ROMANO(subclasificacionRomano);

					var coautoria = reFind("1[(]3.05[)]", subclasificacion);
					
					if(coautoria){						
				
						var clasif1_1 = duplicate(fila);
						clasif1_1.setCLASIFICACION('1');
						clasif1_1.setSUBCLASIFICACION('01');
						clasif1_1.setCLASIFICACION_ROMANO('I');
						clasif1_1.setSUBCLASIFICACION_ROMANO('I');
						
						var clasif3_5 = duplicate(fila);
						clasif3_5.setCLASIFICACION('3');
						clasif3_5.setSUBCLASIFICACION('05');
						clasif3_5.setCLASIFICACION_ROMANO('III');
						clasif3_5.setSUBCLASIFICACION_ROMANO('V');						
												
						arrayAppend(filasCoautoria, clasif1_1);
						arrayAppend(filasCoautoria, clasif3_5);	
							
						
						continue; // Salta todo el código restante en la iteracion
					}															

					if(!structKeyExists(structRes, clasificacion)){
						structRes[clasificacion] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion]["NOMBRE"] = producto.RUTA[1];			
						structRes[clasificacion]["PUNTAJECLASIFICACION"] = 0;
						structRes[clasificacion]["ROMANO"]  = clasificacionRomano;
					}
					if(!structKeyExists(structRes[clasificacion], subclasificacion)){
						structRes[clasificacion][subclasificacion] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] = 0;
						structRes[clasificacion][subclasificacion]["ROMANO"] = subclasificacionRomano;
						// structRes[clasificacion][subclasificacion]["RUTA"] = producto.RUTA;
						// Crea una estructura para cada anio del proceso
						for(var i = proceso.getFECHAINIPROC(); i <= proceso.getFECHAFINPROC();i++){
							structRes[clasificacion][subclasificacion][i] = createObject("java", "java.util.LinkedHashMap").init();
							structRes[clasificacion][subclasificacion][i]["PRODUCTOS"] = arrayNew(1);
							structRes[clasificacion][subclasificacion][i]["PUNTAJE"] = 0;
						}
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"] = createObject("java", "java.util.LinkedHashMap").init();													
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"]["PRODUCTOS"] = arrayNew(1);
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"]["PUNTAJE"] = 0;						
					}
					// Asegura que el producto corresponda al proceso senalado
					if(structKeyExists(structRes[clasificacion][subclasificacion], anio)){
						arrayAppend(structRes[clasificacion][subclasificacion][anio]["PRODUCTOS"], fila);
						if(compare(anio,"SIN ASIGNAR") != 0){
							var puntajeEvaluacion = 0;
							var fechaRef = CreateDateTime(0,1,1,0,0,0);
							// FIXME: No se suma el puntaje							
							for(evaluacion in fila.getEVALUACION_ETAPAS()){
								if(Len(evaluacion.getFECHA_CAPTURA()) GT 0){
									var fechaEvaluacion = ParseDateTime(evaluacion.getFECHA_CAPTURA());
									// Si fechaEvaluacion es mas reciente que fechaRef
									if(
										(evaluacion.getFK_TIPO_EVALUACION() EQ pkTipoEvaluacion AND fila.GETPROCESO() EQ proceso.GETPKPROCESO()) //SI ES DE ESTE PROCESO OBTIENE LAS DE LA ETAPA QUE LE CORRESPONDE AL EVALUADOR
										OR (dateCompare(fechaEvaluacion,fechaRef) AND ((fila.GETPROCESO() NEQ proceso.GETPKPROCESO()) OR (pkTipoEvaluacion EQ application.SIIIP_CTES.TIPOEVALUACION.FINAL)))				// SI ES DE OTRO PROCESO OBTIENE LA ULTIMA QUE SE CAPTURO								
									){										
										fechaRef = fechaEvaluacion;
										puntajeEvaluacion = val(evaluacion.getPUNTAJE_OBTENIDO());
									}																	
								}
							}
							structRes[clasificacion][subclasificacion][anio]["PUNTAJE"] += puntajeEvaluacion;
							structRes[clasificacion]["PUNTAJECLASIFICACION"] += puntajeEvaluacion;
							structRes[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] += puntajeEvaluacion;							
						}						
					}
					// Le pone una bandera de invalido al puntaje del producto que no corresponda al anio del proceso
					else{						
						structRes[clasificacion][subclasificacion][anio]["PUNTAJE"] = "INVALIDO";						
					}							
					if(compare(structRes[clasificacion][subclasificacion][anio]["PUNTAJE"],"INVALIDO") EQ 0){
						structDelete(structRes[clasificacion][subclasificacion],anio);						
					}					
				}

									
				for(filacoaut in filasCoautoria){	
					var clasificacion = filacoaut.getCLASIFICACION();
					var clasificacionRomano = filacoaut.getCLASIFICACION_ROMANO();
					var subclasificacion = filacoaut.getSUBCLASIFICACION();
					var subclasificacionRomano = filacoaut.getSUBCLASIFICACION_ROMANO();
					var anio = (filacoaut.getANIO() > 0) ? filacoaut.getANIO() : "SIN ASIGNAR";					

					var fechaRef = CreateDateTime(0,1,1,0,0,0);										
					for(evaluacion in filacoaut.getEVALUACION_ETAPAS()){
						if(Len(evaluacion.getFECHA_CAPTURA()) GT 0){
							var fechaEvaluacion = ParseDateTime(evaluacion.getFECHA_CAPTURA());
							// Si fechaEvaluacion es mas reciente que fechaRef
							if(
									(evaluacion.getFK_TIPO_EVALUACION() EQ pkTipoEvaluacion AND filacoaut.GETPROCESO() EQ proceso.GETPKPROCESO()) //SI ES DE ESTE PROCESO OBTIENE LAS DE LA ETAPA QUE LE CORRESPONDE AL EVALUADOR
										OR (dateCompare(fechaEvaluacion,fechaRef) AND ((fila.GETPROCESO() NEQ proceso.GETPKPROCESO()) OR (pkTipoEvaluacion EQ application.SIIIP_CTES.TIPOEVALUACION.FINAL)))				// SI ES DE OTRO PROCESO OBTIENE LA ULTIMA QUE SE CAPTURO								
								){										
								fechaRef = fechaEvaluacion;																
								// Si las clasificaciones son diferentes (y la reclasificacion no esta vacia)
								/*if(filacoaut.getPKTPRODUCTOEDI() NEQ evaluacion.getFK_RECLASIFICACION() AND Len(evaluacion.getFK_RECLASIFICACION()) GT 0){
									// fila.setMAX_PUNTUACION(evaluacion.getREC_PUNTAJE());
									clasificacion = evaluacion.getREC_CLASIFICACION();
									clasificacionRomano = evaluacion.getREC_CLASIFICACION_ROMANO();
									subclasificacion = evaluacion.getREC_SUBCLASIFICACION();
									subclasificacionRomano = evaluacion.getREC_SUBCLASIFICACION_ROMANO();
								}
								else{
									clasificacion = filacoaut.getCLASIFICACION();
									clasificacionRomano = filacoaut.getCLASIFICACION_ROMANO();
									subclasificacion = filacoaut.getSUBCLASIFICACION();
									subclasificacionRomano = filacoaut.getSUBCLASIFICACION_ROMANO();
								}*/													
							}																	
						}
					}

					var nombre = "";
					if(compare(clasificacion&'.'&subclasificacion,'1.01') EQ 0){
						nombre = DAO.getClasificacionProductos(1).CLASIFICACION[1];								
					}else if(compare(clasificacion&'.'&subclasificacion,'3.05') EQ 0){
						nombre = DAO.getClasificacionProductos(3).CLASIFICACION[1];
					}

					filacoaut.setCLASIFICACION(clasificacion);
					filacoaut.setSUBCLASIFICACION(subclasificacion);
					filacoaut.setCLASIFICACION_ROMANO(clasificacionRomano);
					filacoaut.setSUBCLASIFICACION_ROMANO(subclasificacionRomano);												

					if(!structKeyExists(structRes, clasificacion)){
						structRes[clasificacion] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion]["NOMBRE"] = nombre;
						structRes[clasificacion]["PUNTAJECLASIFICACION"] = 0;
						structRes[clasificacion]["ROMANO"]  = clasificacionRomano;
					}
					if(!structKeyExists(structRes[clasificacion], subclasificacion)){
						structRes[clasificacion][subclasificacion] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] = 0;
						structRes[clasificacion][subclasificacion]["ROMANO"] = subclasificacionRomano;
						// structRes[clasificacion][subclasificacion]["RUTA"] = producto.RUTA;
						// Crea una estructura para cada anio del proceso
						for(var i = proceso.getFECHAINIPROC(); i <= proceso.getFECHAFINPROC();i++){
							structRes[clasificacion][subclasificacion][i] = createObject("java", "java.util.LinkedHashMap").init();
							structRes[clasificacion][subclasificacion][i]["PRODUCTOS"] = arrayNew(1);
							structRes[clasificacion][subclasificacion][i]["PUNTAJE"] = 0;
						}
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"] = createObject("java", "java.util.LinkedHashMap").init();													
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"]["PRODUCTOS"] = arrayNew(1);
						structRes[clasificacion][subclasificacion]["SIN ASIGNAR"]["PUNTAJE"] = 0;	
					}
					// Asegura que el producto corresponda al proceso senalado
					if(structKeyExists(structRes[clasificacion][subclasificacion], anio)){

						arrayAppend(structRes[clasificacion][subclasificacion][anio]["PRODUCTOS"], filacoaut);

						if(compare(anio,"SIN ASIGNAR") != 0){
							
							
							
							var puntajeEvaluacion = 0;
							var fechaRef = CreateDateTime(0,1,1,0,0,0);
							// FIXME: No se suma el puntaje							
							for(evaluacion in filacoaut.getEVALUACION_ETAPAS()){
								if(Len(evaluacion.getFECHA_CAPTURA()) GT 0){
									var fechaEvaluacion = ParseDateTime(evaluacion.getFECHA_CAPTURA());
									// Si fechaEvaluacion es mas reciente que fechaRef
									
									if(
										(evaluacion.getFK_TIPO_EVALUACION() EQ pkTipoEvaluacion AND filacoaut.GETPROCESO() EQ proceso.GETPKPROCESO()) //SI ES DE ESTE PROCESO OBTIENE LAS DE LA ETAPA QUE LE CORRESPONDE AL EVALUADOR
											OR (dateCompare(fechaEvaluacion,fechaRef) AND ((fila.GETPROCESO() NEQ proceso.GETPKPROCESO()) OR (pkTipoEvaluacion EQ application.SIIIP_CTES.TIPOEVALUACION.FINAL)))				// SI ES DE OTRO PROCESO OBTIENE LA ULTIMA QUE SE CAPTURO								
										){
										fechaRef = fechaEvaluacion;
										if(clasificacion EQ '1' AND subclasificacion EQ '01' AND val(evaluacion.getPUNTAJE_OBTENIDO()) GT 0){
											puntajeEvaluacion = val(evaluacion.getPUNTAJE_OBTENIDO()) - 15;

										}										
										else if(clasificacion EQ '3' AND subclasificacion EQ '05' AND val(evaluacion.getPUNTAJE_OBTENIDO()) GT 0){
											puntajeEvaluacion = 15;
										}
										else {
											puntajeEvaluacion = 0;
										}								
									}																	
								}
							}
							structRes[clasificacion][subclasificacion][anio]["PUNTAJE"] += puntajeEvaluacion;
							structRes[clasificacion]["PUNTAJECLASIFICACION"] += puntajeEvaluacion;
							structRes[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] += puntajeEvaluacion;							
						}						
					}
					// Le pone una bandera de invalido al puntaje del producto que no corresponda al anio del proceso
					else{						
						structRes[clasificacion][subclasificacion][anio]["PUNTAJE"] = "INVALIDO";						
					}							
					if(compare(structRes[clasificacion][subclasificacion][anio]["PUNTAJE"],"INVALIDO") EQ 0){
						structDelete(structRes[clasificacion][subclasificacion],anio);						
					}					
				}				
			}			
			return structRes;
		</cfscript>
	</cffunction>
	
	<!---
	*Fecha:	Enero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getAutoEvaluacionBAK" hint="Obtiene el objeto de la autoevaluacion">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="proceso"		hint ="objeto del proceso">
		<cfscript>
			var resultado = [];
			var structClasificacion = createObject("java", "java.util.LinkedHashMap").init(); //Se usa este tipo de dato por que coldfusion no realiza un ordenamiento en las llaves
			var datosAutoEvaluacion = DAO.getInformacionAutoEvaluacion(pkPersona);

			var structRes = createObject("java", "java.util.LinkedHashMap").init();				

			for(var i in datosAutoEvaluacion){
				
				// Se crea el objeto de producto
				var producto = populator.populateFromStruct(wirebox.getInstance("EDI/B_AutoEvaluacion"),i);

				// Agrega el anio a producto
				var anio = DAO.getFechaByTipo(producto.getPK_FILA(),3);
				anio = anio.recordcount ? anio.ANIO[1] : "SIN ASIGNAR";
				producto.setANIO(anio);
				
				// Obtiene el pk de clasificacion				
				var clasificacion = producto.getCLASIFICACION();															
				// Obtiene el nombre de la clasificacion
				var clasificacionNombre = DAO.getClasificacionProductos(clasificacion);				

				// Si no existe la clasificacion en ese anio
				if(!structKeyExists(structRes, clasificacion)){
					structRes[clasificacion] = createObject("java", "java.util.LinkedHashMap").init();
					structRes[clasificacion]["NOMBRE"] = clasificacionNombre.recordcount > 0 ? clasificacionNombre.CLASIFICACION[1] : "";
					structRes[clasificacion]["PUNTAJECLASIFICACION"] = 0;
				}
				// Si no existe la subclasificacion en la clasificacion
				if(!structKeyExists(structRes[clasificacion],producto.getSUBCLASIFICACION())){
					structRes[clasificacion][producto.getSUBCLASIFICACION()] = createObject("java", "java.util.LinkedHashMap").init();					
					structRes[clasificacion][producto.getSUBCLASIFICACION()]["PUNTAJESUBCLASIFICACION"] = 0;
					// Crea una estructura para cada anio del proceso
					for(var i = proceso.getFECHAINIPROC(); i <= proceso.getFECHAFINPROC();i++){
						structRes[clasificacion][producto.getSUBCLASIFICACION()][i] = createObject("java", "java.util.LinkedHashMap").init();
						structRes[clasificacion][producto.getSUBCLASIFICACION()][i]["PRODUCTOS"] = arrayNew(1);
						structRes[clasificacion][producto.getSUBCLASIFICACION()][i]["PUNTAJE"] = 0;
					}					
					structRes[clasificacion][producto.getSUBCLASIFICACION()]["SIN ASIGNAR"] = createObject("java", "java.util.LinkedHashMap").init();													
					structRes[clasificacion][producto.getSUBCLASIFICACION()]["SIN ASIGNAR"]["PRODUCTOS"] = arrayNew(1);
					structRes[clasificacion][producto.getSUBCLASIFICACION()]["SIN ASIGNAR"]["PUNTAJE"] = 0;
					// Asegura que el producto corresponda al proceso senalado
					if(structKeyExists(structRes[clasificacion][producto.getSUBCLASIFICACION()], producto.getANIO())){
						arrayAppend(structRes[clasificacion][producto.getSUBCLASIFICACION()][anio]["PRODUCTOS"], producto);
						if(compare(anio,"SIN ASIGNAR") != 0){
							structRes[clasificacion][producto.getSUBCLASIFICACION()][anio]["PUNTAJE"] += producto.getMAX_PUNTUACION();
							structRes[clasificacion]["PUNTAJECLASIFICACION"] += producto.getMAX_PUNTUACION();
							structRes[clasificacion][producto.getSUBCLASIFICACION()]["PUNTAJESUBCLASIFICACION"] += producto.getMAX_PUNTUACION();							
						}						
					}
				}else{
					// Asegura que el producto corresponda al proceso senalado
					if(structKeyExists(structRes[clasificacion][producto.getSUBCLASIFICACION()], producto.getANIO())){
						arrayAppend(structRes[clasificacion][producto.getSUBCLASIFICACION()][anio]["PRODUCTOS"], producto);
						if(compare(anio,"SIN ASIGNAR") != 0){
							structRes[clasificacion][producto.getSUBCLASIFICACION()][anio]["PUNTAJE"] += producto.getMAX_PUNTUACION();
							structRes[clasificacion]["PUNTAJECLASIFICACION"] += producto.getMAX_PUNTUACION();
							structRes[clasificacion][producto.getSUBCLASIFICACION()]["PUNTAJESUBCLASIFICACION"] += producto.getMAX_PUNTUACION();							
						}
					}
				}				
			}			
			return structRes;
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getClasificacionProductos" hint="Obtiene el primer nivel de clasificacion">		
		<cfargument name="pkClasif"	type="numeric" hint ="pk de la clasificacion">
		<cfscript>
			return DAO.getClasificacionProductos(pkClasif);
		</cfscript>
	</cffunction>	
	
	<!---
	*Fecha:	Enero 2018
	*Autor:	JLGC
	--->
	<cffunction name="getEvaluacionDatosInvestigador" hint="Trae los Datos del Investigador para la Evaluación">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="pkMovimiento"	type="numeric" hint ="pk del movimiento">
		<cfscript>
			return DAO.getEvaluacionDatosInvestigador(pkPersona, pkMovimiento);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	JLGC
	--->
	<cffunction name="getEvaluacionDatosInvestigadorNivel" hint="Trae el Nivel en la evaluacion del investigador">
		<cfargument name="pkPersona" type="numeric" hint ="pk de la persona">
		<cfscript>
			return DAO.getEvaluacionDatosInvestigadorNivel(pkPersona);
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	JLGC
	--->
	<cffunction name="getEvaluacionDatosInvestigadorRed" hint="Trae la Red en la evaluacion del investigador">
		<cfargument name="pkPersona" type="numeric" hint ="pk de la persona">
		<cfscript>
			return DAO.getEvaluacionDatosInvestigadorRed(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	24 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getPersonaSiga" hint="obtiene el pk de la persona siga">
		<cfargument name="pkPersona" type="numeric" hint="Pk de la persona">
		<cfscript>
			return DAO.getPersonaSiga(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getCorreoUsuario" hint="obtiene el pk de la persona siga">
		<cfargument name="pkPersona" type="numeric" hint="Pk de la persona">
		<cfscript>
			return DAO.getCorreoUsuario(pkPersona).CORREO[1];
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="enviarCorreoEvaluaciones" hint="Envia un correo para notificar al evaluador que tiene evaluaciones pendientes">
		<cfargument name="pkPersona"	type="numeric"	hint ="pk de la persona">
		<cfargument name="emailDestino"	type="string"	hint ="correo destino">
		<cfscript>

			var fechaEmail = 'Ciudad de México a ' & LSDateFormat(now() ,"long", "Spanish (Standard)");
			var usuario		= cnUsuarios.getUsuarioContrasena(pkPersona);
			var asunto			= 'Evaluaciones pendientes';
			var pkCorreo 		= #application.SIIIP_CTES.CORREOS.EVALUACIONESPENDIENTES#;
			var etiquetas		= {fecha: fechaEmail, pass: usuario.CONTRASENA[1], usuario: usuario.NOMBRE[1] };
			
			return cnEmail.enviarCorreoByPkPlantilla(asunto, '', emailDestino, pkCorreo, etiquetas);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaPuntajeProducto" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="puntajes" type="any" hint="pk de la etapa">
		<cfscript>
			var puntajesEval = deserializeJSON(puntajes);
			
			for (var i = 1; i LE ArrayLen(puntajesEval); i = i+1) {
				if (puntajesEval[i].accion EQ 0){
					DAO.guardaPuntajeProducto(puntajesEval[i].pkEtapa, round(puntajesEval[i].puntajes));
				}else {

					if(puntajesEval[i].puntajes GTE 0){
						var guardaPuntos = DAO.guardaPuntajeProducto(puntajesEval[i].pkEtapa, round(puntajesEval[i].puntajes));
						if (guardaPuntos GT 0){
							if (i EQ 1){
								this.cambiaEstadoEvaluacion(puntajesEval[i].pkEvaluacion, puntajesEval[i].accion);
							}else {
								if(puntajesEval[i].pkEtapa NEQ puntajesEval[i-1].pkEtapa){
									this.cambiaEstadoEvaluacion(puntajesEval[i].pkEvaluacion, puntajesEval[i].accion);
								}
							}
						}
					}

				}
            }		

            return 1;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaPuntajeProductoCero" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="puntajes" type="any" hint="pk de la etapa">
		<cfscript>
			var puntajesEval = deserializeJSON(puntajes);
			
			for (var i = 1; i LE ArrayLen(puntajesEval); i = i+1) {
				if (puntajesEval[i].accionCero EQ 0){
					DAO.guardaPuntajeProductoCero(puntajesEval[i].etapaCero, puntajesEval[i].puntajes, puntajesEval[i].motivoCero);
				}else {

					if(puntajesEval[i].puntajes GTE 0){
						var guardaPuntos = DAO.guardaPuntajeProductoCero(puntajesEval[i].etapaCero, puntajesEval[i].puntajes, puntajesEval[i].motivoCero);
						if (guardaPuntos GT 0){
							if (i EQ 1){
								this.cambiaEstadoEvaluacion(puntajesEval[i].evaluacionCero, puntajesEval[i].accionCero);
							}else {
								if(puntajesEval[i].etapaCero NEQ puntajesEval[i-1].etapaCero){
									this.cambiaEstadoEvaluacion(puntajesEval[i].evaluacionCero, puntajesEval[i].accionCero);
								}
							}
						}
					}

				}
            }

            return 1;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="cambiaEstadoEvaluacion" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="pkRegistro" type="numeric" required="yes" hint="Pk del registro que se va a modificar">
		<cfargument name="accion"     type="string"  required="yes" hint="Pk de la acción">
		<cfscript>
			respuesta = StructNew();
			respuesta.exito = true;
			
			var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.EVAL_EDI#;
			var ROL = session.cbstorage.usuario.ROL;

			//OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
			estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
			pkEdoAccion  = cnMes.getEdoSigBypkAccion(accion, ROL, estadoactual.ESTADO[1]);
			
			if(pkEdoAccion.recordcount EQ 0){
				respuesta.exito = false;
				respuesta.fallo = true;
				return respuesta;
			}

			//CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
			registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

			//VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
			if (registroBitacora.fallo){
				respuesta.exito = false;
				respuesta.fallo = true;
				return respuesta;
			}
		
			return respuesta;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="cambiaEstadoEvaluacionEscolaridad" hint="valida la escolaridad">
		<cfargument name="pkRegistro" type="array" required="yes" hint="array con los pk de los registros a validar">
		<cfargument name="accion"     type="string"  required="yes" hint="Pk de la acción">
		<cfscript>
			respuesta = StructNew();
			respuesta.exito = true;
			for(registro in pkRegistro){
				
				var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.EVAL_ESCOLARIDAD#;
				var ROL = session.cbstorage.usuario.ROL;

				//OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
				estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, registro);
				pkEdoAccion  = cnMes.getEdoSigBypkAccion(accion, ROL, estadoactual.ESTADO[1]);
				
				if(pkEdoAccion.recordcount EQ 0){
					respuesta.exito = false;
					respuesta.fallo = true;
					return respuesta;
				}

				//CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
				registroBitacora = cnMes.cambiarEstado(registro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

				//VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
				if (registroBitacora.fallo){
					respuesta.exito = false;
					respuesta.fallo = true;
					return respuesta;
				}				
			}		
			return respuesta;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	31 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaComentarioEvaluacion" hint="Guarda el comentario en una evaluacion">
		<cfargument name="pkEvaluacion" type="numeric" hint="Pk de la evaluacion etapa">
		<cfargument name="contenido"    type="string"  hint="Contenido del comentario">
		<cfscript>
			return DAO.guardaComentarioEvaluacion(pkEvaluacion, contenido);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	31 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="reclasificacionProducto" hint="Cambia la clasificacion de un producto">
		<cfargument name="pkProdRecla" type="numeric" hint="Pk de la clasificacion">
		<cfargument name="pkEvalEtapa" type="numeric" hint="Pk de la etapa evaluacion">
		<cfscript>
			return DAO.reclasificacionProducto(pkProdRecla, pkEvalEtapa);
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Enero 2018
    * author: Alejandro Tovar
		--->        
   	<cffunction name="getValidacionesByAspitanteProceso" hint="Obtiene las etapas de evaluacion con la fila">
		<cfargument name="pkEvaluado">
		<cfargument name="pkProceso">
		<cfscript>
			var validaciones  = dao.getValidacionesByAspitanteProceso(pkEvaluado,pkProceso);
			var queryAcciones = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.SOLI_EDI#, validaciones, Session.cbstorage.usuario.ROL);
			return queryAcciones;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getValidacionesByEvaluacionEscolaridad">
		<cfargument name="pkEvaluado" type="numeric">
		<cfargument name="pkProceso" type="numeric">			
		<cfscript>
			var validaciones  = dao.getValidacionesByEvaluacionEscolaridad(pkEvaluado, pkProceso);
			var queryAcciones = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.EVAL_ESCOLARIDAD#, validaciones, Session.cbstorage.usuario.ROL);
			return queryAcciones;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="cambiaEstadoEvalAspiranteProceso" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="pkRegistro" 	type="numeric" required="yes" hint="Pk del registro que se va a modificar">
		<cfargument name="accion"     	type="string"  required="yes" hint="Pk de la acción">
		<cfargument name="pkEvaluado" 	type="numeric" required="yes" hint="Pk del registro que se va a modificar">
		<cfargument name="tipoEval"   	type="numeric" required="yes" hint="Pk de la acción">
		<cfargument name="pkNivel"   	type="numeric" required="yes" hint="Pk del nivel">
		<cfargument name="observacion"  type="string"  required="yes" hint="Observacion de la evaluacion">
		<cfargument name="anioGracia"   type="numeric" required="yes" hint="Asignacion de año de gracia">
		<cfargument name="residencia"   type="numeric" required="yes" hint="Asignacion de año de residencia">
		<cfargument name="dispensa"     type="numeric" required="yes" hint="Asignacion de dispensa">
		<cfargument name="artDispensa"  type="string"  required="yes" hint="articulo de dispensa">
		<cfscript>

			var pkEvaluador = session.cbstorage.usuario.PK;
			var nivelAsignado = DAO.asignarNivelEvaluador(pkRegistro, pkEvaluador, tipoEval, pkNivel, observacion, residencia, anioGracia, dispensa, artDispensa);

			if( nivelAsignado GT 0 ){
				respuesta.exito = 1;
				//SE VALIDAN LOS PRODUCTOS EVALUADOS Y LOS QUE SE TIENEN ASIGNADOS PARA EVALUAR
				var evaluado = DAO.verificaProductosEvaluados(pkEvaluador, pkEvaluado, tipoEval);
				var evaluar  = DAO.verificaProductosParaEvaluar(pkEvaluador, pkEvaluado, tipoEval);

				var escolaridadEvaluada    = DAO.verificaEscolaridadEvaluada(pkEvaluador, pkEvaluado, tipoEval);
				var escolaridadParaEvaluar = DAO.verificaEscolaridadParaEvaluar(pkEvaluador, pkEvaluado, tipoEval);				
			
				//Sin productos por evaluar
				if(evaluar.recordcount EQ 0){
					return 0;
				}				

				//Se han evaluado todos los productos
				if (evaluado.recordcount EQ evaluar.recordcount AND escolaridadEvaluada.recordcount EQ escolaridadParaEvaluar.recordcount){
				
					var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.SOLI_EDI#;
					var ROL = session.cbstorage.usuario.ROL;

					//OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
					estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
					pkEdoAccion  = cnMes.getEdoSigBypkAccion(accion, ROL, estadoactual.ESTADO[1]);
					
					//OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
            		//EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)

            		resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1], pkRegistro);

					if(pkEdoAccion.recordcount EQ 0){
						return 0;
					}

					//SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
            		if (resPreoperacion.exito){
						//CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
						registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

						//VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
						if (registroBitacora.fallo){
							return 0;
						}

						//OBTENER POS-OPERACIONES DE LA ACCION
			            resPostoperacion  = this.ejecutaPostOperaciones(PKEDOACCION=pkEdoAccion.EDOACC_PK[1],PKREGISTRO=pkRegistro, RESIDENCIA=residencia, GRACIA=anioGracia, DISPENSA=dispensa, ARTDISPENSA=artDispensa);
			            respuesta.exito   = resPostoperacion.exito;
			            respuesta.mensaje = resPostoperacion.mensaje;

			            //ACTUALIZA LA BITÁCORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
			            if (respuesta.mensaje NEQ ''){
			            	cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
			            }
					}
					else	
						respuesta = resPreoperacion;
				}else {
					respuesta.exito = 0;
				}
			}else {
				respuesta.exito = 0;
			}
			return respuesta;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="quitarReclasificacion" hint="Elimina la relcasificacion de un producto">
		<cfargument name="pkEtapa" type="numeric" hint="Pk de la evaluacion etapa">
		<cfscript>
			return DAO.quitarReclasificacion(pkEtapa);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getMotivoCalificacion" hint="Obtiene los motivos de calificar con 0 un producto">
		<cfscript>
			return DAO.getMotivoCalificacion();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getNivelEDI" hint="Obtiene la llista de los niveles por EDI">
		<cfscript>
			return DAO.getNivelEDI();
		</cfscript>
	</cffunction>

	<!--- 
    *Fecha: Febrero de 2018
    *Autor: JLGC
    --->
    <cffunction name="guardarObservacion" hint="Realiza guardado de la observacion de la evaluacion del investigador">
        <cfargument name="PkAspProc"     type="numeric" required="yes" hint="PK del Aspirante">
        <cfargument name="PkTipoEva"     type="numeric" required="yes" hint="PK del Tipo evaluacion">
        <cfargument name="observaciones" type="string"  required="yes" hint="Observaciones">
        <cfscript>
            return DAO.guardarObservacion(PkAspProc, session.cbstorage.usuario.pk, PkTipoEva, observaciones);
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Febrero de 2018
    *Autor: JLGC
    --->
    <cffunction name="getObservacion" hint="Muestra observacion de la evaluacion del investigador">
        <cfargument name="PkAspProc"     type="numeric" required="yes" hint="PK del Aspirante">
        <cfargument name="PkTipoEva"     type="numeric" required="yes" hint="PK del Tipo evaluacion">
        <cfscript>
            return DAO.getObservacion(PkAspProc, session.cbstorage.usuario.pk, PkTipoEva);
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Febrero de 2018
    *Autor: JLGC
    --->
    <cffunction name="getSolicitudResidenciaInv" hint="Muestra la solicitud de residencia del investigador">
        <cfargument name="PkAspProc"     type="numeric" required="yes" hint="PK del Aspirante">
        <cfscript>
            return DAO.getSolicitudResidenciaInv(PkAspProc);
        </cfscript>
    </cffunction>
		<!---
    * Fecha: Septiembre 2017
    * @author 
    * Descripcion: Función que obtiene y ejcuta las pre-operaciones.
    --->
    <cffunction name="ejecutaPreOperaciones" hint="Ejecuta pre-operaciones">
        <cfargument name="PKEDOACCION" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfargument name="PKREGISTRO"  type="numeric" required="yes" hint="Pk de la reservacion">
        <cfargument name="PKPERSONA"   type="numeric" required="NO">
        <cfargument name="EVALUACION"  type="numeric" required="NO">
        <cfscript>
            respuesta 			= StructNew();
            respuesta.exito 	= true;
            respuesta.mensaje 	= '';
			respuesta.retroceso = false;
            fn1 				= true;

            posOperaciones = cnMes.getOperaciones(PKEDOACCION, #application.SIIIP_CTES.TIPOOPERACION.PRE#);

            if (ArrayFind(posOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.MANTIENE_RESIDENCIA#)) {

            	var residencia 	= 0;
				var observacion = "No se mantiene la residencia";
				var nivel 		= #application.SIIIP_CTES.NIVEL.CERO#;

				if (EVALUACION EQ 1){
					residencia 	= 1;
					observacion = "Se mantiene la residencia";
					nivel 		= DAO.getNivelEdiActual(PKPERSONA).NIVEL[0];
					if(nivel EQ ''){
						nivel = #application.SIIIP_CTES.NIVEL.CERO#;
					}
				}

                fn1 = this.asignarNivelEvaluador(PKREGISTRO, session.cbstorage.usuario.PK, application.SIIIP_CTES.TIPOEVALUACION.CA, nivel, observacion, residencia, -1, -1);


                if (not fn1){
                    respuesta.mensaje = 'Error al mandeter la residencia';
                }
            }

			
            if (fn1){
                respuesta.exito = true;
            } else {
                respuesta.exito = false;
            }

            return respuesta;
        </cfscript>
    </cffunction>

	<!---
    * Fecha: Febrero 2018
    * @author Ana Belem Juárez Méndez
    * Descripcion: Función que obtiene y ejcuta las pos-operaciones.
    --->
    <cffunction name="ejecutaPostOperaciones" hint="Ejecuta pos-operaciones">
        <cfargument name="PKEDOACCION" 	type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfargument name="PKREGISTRO" 	type="numeric" required="yes" hint="Pk de ">
        <cfargument name="RESIDENCIA" 	type="numeric" required="NO">
        <cfargument name="GRACIA" 		type="numeric" required="NO">
        <cfargument name="DISPENSA"		type="numeric" required="NO">
        <cfargument name="ARTDISPENSA"	type="string"  required="NO">
        <cfscript>
            var emailCA='';
          	respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';

            fn1 = true;
            fn2 = true;

			preOperaciones = cnMes.getOperaciones(pkEdoAccion, #application.SIIIP_CTES.TIPOOPERACION.POS#);
          
            /*Se pone a modo de ejemplo se puede poner en una funcion*/
            if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.M_CORR#)) {
            	evaluadorCA = this.obtenerEvaluadorCAdeSolicitud(pkRegistro);
            	if (isNull(evaluadorCA.EMAIL[1])){
            		emailCA = #application.SIIIP_CTES.EMAIL.ENCARGADOPROCESO#;

            	} else {
            		emailCA = evaluadorCA.EMAIL[1];
            	}

            	
                fn1 = this.enviarCorreoEvaluaciones(evaluadorCA.USUARIO[1], emailCA);
                if (not fn1){
                    respuesta.mensaje = 'Error al mandar correo al evaluador CA';
                }
            }


			if (ArrayFind(preOperaciones, #application.SIIIP_CTES.FUNCIONPRUEBA.TERMNA_EVAL#)) {
                fn2 = this.terminarEvaluacion(pkRegistro, RESIDENCIA, GRACIA, DISPENSA, ARTDISPENSA);
                if (not fn2){
                    respuesta.mensaje = 'Error al terminar la evaluacion';
                }
            }

            if (fn1 AND fn2){
                respuesta.exito = true;
            } else {
                respuesta.exito = false;
            }
            return respuesta;
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Febrero de 2018
    *Autor: Ana Belem Juárez Méndez
    --->
    <cffunction name="obtenerEvaluadorCAdeSolicitud" hint="obtiene el pkUsuario y el email del evaluador CA de una solicitud">
        <cfargument name="pkRegistro"     type="numeric" required="yes" hint="PK de un registro en EVALUACIONASPIRANTEPROCESO">
        <cfscript>
            return DAO.obtenerEvaluadorCAdeSolicitud(pkRegistro);
        </cfscript>
    </cffunction>

 	<!---
		*Fecha:	Febrero 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="getEscolaridadByPkUsuarioANDPkEvaluadorANDPkProceso" hint="obtiene las evaluaciones disponibles con el pk del usuario, el pk del evaluador y el pk del proceso">
		<cfargument name="pkPersona" hint="pk de la persona">
		<cfargument name="pkEvaluador" hint="pk del evaluador">
		<cfargument name="proceso" hint="bean del proceso">
		<cfscript>			
			return DAO.getEscolaridadByPkUsuarioANDPkEvaluadorANDPkProceso(pkPersona, pkEvaluador, proceso);
		</cfscript>
	</cffunction>
	
    <!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="mantieneResidencia" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="pkRegistro" type="numeric" required="yes" hint="Pk del registro que se va a modificar">
		<cfargument name="accion"     type="string"  required="yes" hint="Pk de la acción">
		<cfargument name="pkPersona"  type="numeric" required="no" hint="Pk de la persona">
		<cfargument name="evaluacion" type="numeric" required="no" hint="Asigna o no la residencia(1/0)">
		<cfscript>
			respuesta.exito = 1;

			var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.SOLI_EDI#;
			var ROL = session.cbstorage.usuario.ROL;

			//OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
			estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
			pkEdoAccion  = cnMes.getEdoSigBypkAccion(accion, ROL, estadoactual.ESTADO[1]);
			
			//OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
    		//EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)

    		resPreoperacion = this.ejecutaPreOperaciones(PKEDOACCION=pkEdoAccion.EDOACC_PK[1], PKREGISTRO=pkRegistro, PKPERSONA=pkPersona, EVALUACION=evaluacion);

			if(pkEdoAccion.recordcount EQ 0){
				return 0;
			}

			//SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
    		if (resPreoperacion.exito){
				//CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
				registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

				//VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
				if (registroBitacora.fallo){
					return 0;
				}

				//OBTENER POS-OPERACIONES DE LA ACCION
	            resPostoperacion  = this.ejecutaPostOperaciones(PKEDOACCION=pkEdoAccion.EDOACC_PK[1],PKREGISTRO=pkRegistro, RESIDENCIA=evaluacion, GRACIA=-1, DISPENSA=-1, ARTDISPENSA='');
	            respuesta.exito   = resPostoperacion.exito;
	            respuesta.mensaje = resPostoperacion.mensaje;

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
	*Fecha:	Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="guardaPuntajeEvaluacionEsc" hint="Guarda el puntaje de la evaluacion de escolaridad">
		<cfargument name="pkEvaluacion"  type="numeric" hint="Pk de la evaluacion etapa">
		<cfargument name="puntaje" 				type="numeric" hint="puntaje obtenido">
		<cfscript>
			return DAO.guardaPuntajeEvaluacionEsc(pkEvaluacion, puntaje);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="guardaPuntajeEvaluacionEscCero" hint="Guarda el motivo de la evaluacion en cero">
		<cfargument name="pkEvaluacion"  type="numeric" hint="Pk de la evaluacion etapa">
		<cfargument name="puntaje" 				type="numeric" hint="puntaje obtenido">
		<cfargument name="motivo" 				type="numeric" hint="motivo">
		<cfscript>
			return DAO.guardaPuntajeEvaluacionEscCero(pkEvaluacion, puntaje, motivo);
		</cfscript>
	</cffunction>
    
    <!--- 
    *Fecha: Febrero de 2018
    *Autor: Alejandro Tovar
    --->
    <cffunction name="solicitoAnioGracia" hint="Devuelve si el usuario solicito año de gracia">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
        <cfargument name="pkProceso" type="numeric" required="yes" hint="pk del proceso">
        <cfscript>
        	var solicitud = DAO.solicitoAnioGracia(pkPersona, pkProceso).SOLICITUD[1];
        	return solicitud GT 0 ? true : false;
        </cfscript>
    </cffunction>


    <!--- 
    *Fecha: Febrero de 2018
    *Autor: Alejandro Tovar
    --->
    <cffunction name="terminarEvaluacion" hint="Se asigna el año de gracia y/o residencia el evaluador CA">
        <cfargument name="pkRegistro"  type="numeric" required="yes" hint="pk del registro">
        <cfargument name="residencia"  type="numeric" required="yes" hint="asigna residencia">
        <cfargument name="anioGracia"  type="numeric" required="yes" hint="asigna anio de gracia">
        <cfargument name="dispensa"    type="numeric" required="yes" hint="asigna dispensa">
        <cfargument name="artDispensa" type="string"  required="yes" hint="articulo de dispesa">
        <cfscript>
        	var termina = DAO.terminarEvaluacion(pkRegistro, residencia, anioGracia, dispensa, artDispensa);
        	return termina GT 0 ? true : false;
        </cfscript>
    </cffunction>

    <!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="tieneInconformidad" hint="Verifica si el investigador tiene inconformidad en productos">
		<cfargument name="pkTipoEval" type="numeric" hint="tipo de la evaluacion">
		<cfargument name="pkPersona"  type="numeric" hint="pk de la persona (investigador)">
		<cfargument name="proceso"	  type="numeric" hint="pk del proceso actual">
		<cfscript>
			return DAO.tieneInconformidad(pkTipoEval, pkPersona, proceso);
		</cfscript>
	</cffunction>
	
	
	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Marco Torres
	--->
	<cffunction name="enviarToEvaluacion" hint="envia un producto evaluado a la evaluacion actual">
		<cfargument name="pkFila" type="numeric" hint="">
		<cfargument name="pkProceso" type="numeric" hint="proceso al que se envia">
		<cfscript>
			return DAO.enviarToEvaluacion(pkFila,pkProceso);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getNivelesSIPCE" hint="Obtiene los niveles asignados por el evaluador SIP y CE">
		<cfargument name="pkPersona" type="numeric" hint="pk de la persona">
		<cfargument name="pkProceso" type="numeric" hint="pk del proceso actual">
		<cfscript>
			return DAO.getNivelesSIPCE(pkPersona, pkProceso, session.cbstorage.usuario.PK);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getNivelesSIPCECA" hint="Obtiene los niveles asignados por el evaluador SIP y CE">
		<cfargument name="pkPersona" type="numeric" hint="pk de la persona">
		<cfargument name="pkProceso" type="numeric" hint="pk del proceso actual">
		<cfscript>
			return DAO.getNivelesSIPCECA(pkPersona, pkProceso, session.cbstorage.usuario.PK);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="asignarNivelEvaluador" hint="Asigna el nivel a un investigador">
		<cfargument name="PkAspProc"    type="numeric" hint="Pk del aspirante proceso">
		<cfargument name="pkEvaluador"  type="numeric" hint="Pk del evaluador">
		<cfargument name="pkTipoEval"   type="numeric" hint="tipo de evaluacion">
		<cfargument name="pkNivel" 	    type="numeric" hint="nivel edi asignado">
		<cfargument name="observacion"  type="string"  hint="observacion de la evaluacion">
		<cfargument name="residencia"   type="numeric" hint="Asignacion de año de residencia">
		<cfargument name="anioGracia"   type="numeric" hint="Asignacion de año de gracia">
		<cfargument name="dispensa"     type="numeric" hint="Asignacion de año de gracia">
		<cfargument name="artDispensa"  type="string" hint="Asignacion de año de gracia">
		<cfscript>
			return DAO.asignarNivelEvaluador(PkAspProc, pkEvaluador, pkTipoEval, pkNivel, observacion, residencia, anioGracia, dispensa, artDispensa);
		</cfscript>
	</cffunction>

	<!--- 
    *Fecha: Marco de 2018
    *Autor: Alejandro Tovar
    --->
    <cffunction name="solicitoDispensa" hint="Devuelve si el usuario solicito dispensa">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
        <cfargument name="pkProceso" type="numeric" required="yes" hint="pk del proceso">
        <cfscript>
        	var solicitud = DAO.solicitoDispensa(pkPersona, pkProceso).SOLICITUD[1];
        	return solicitud GT 0 ? true : false;
        </cfscript>
    </cffunction>

  <!---
  	*Fecha:	Febrero 2018
  	*Autor:	Daniel Memije
  --->
  <cffunction name="getAllEscolaridadByPkPersona" hint="obtiene el historial de escolaridad con el pk de la persona">
  	<cfargument name="pkPersona" hint="pk de la persona">		
  	<cfscript>			
  		return DAO.getAllEscolaridadByPkPersona(pkPersona);
  	</cfscript>
  </cffunction>

  <!---
		*Fecha:	Marzo 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="getObtencionGradoEscolarByPkPersona" hint="obtiene las obtenciones de grado escolar de una persona">
		<cfargument name="pkUsuario" hint="pk del usuario">
		<cfscript>
			var obtencionesGrado = DAO.getObtencionGradoEscolarByPkPersona(pkUsuario);
			var resultado = [];
			for(obtencion in obtencionesGrado){
				var instancia = populator.populateFromStruct(wirebox.getInstance("EDI/B_Escolaridad"),obtencion);
				instancia.initAnio();
				instancia.setEVALUACIONES(this.getEtapasEvaluacionEscolaridadByObtencionGrado(instancia.getPK_OBTENCIONGRADO()));
				arrayAppend(resultado, instancia);
			}
			return resultado;
		</cfscript>
	</cffunction>

	<!---
		*Fecha:	Marzo 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="getEtapasEvaluacionEscolaridadByObtencionGrado" hint="obtiene las etapas de evaluacion con el pk de la obtencion de un grado academico">
		<cfargument name="pkObtencion" hint="pk de la obtencion de grado academico">
		<cfscript>
			var etapasEvaluacion = DAO.getEtapasEvaluacionEscolaridadByObtencionGrado(pkObtencion);
			var resultado = [];
			for(etapa in etapasEvaluacion){
				var instancia = populator.populateFromStruct(wirebox.getInstance("EDI/B_EvaluacionEtapa"),etapa);
				arrayAppend(resultado, instancia);
			}
			return resultado;
		</cfscript>
	</cffunction>

	<!---
		*Fecha:	Marzo 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="addEscolaridadAResumen" hint="agrega la escolaridad al resumen de evaluacion">
		<cfargument name="escolaridadBean" hint="bean con la escolaridad y sus etapas de evaluacion">
		<cfargument name="resumenBean" hint="bean con el resumen">
		<cfargument name="proceso" hint="bean con el proceso">
		<cfargument name="pkTipoEvaluacion" hint="pk del tipo de evaluacion">		
		<cfscript>
			for(escolaridad in escolaridadBean){
				var clasificacion = escolaridad.getCLASIFICACION();
				var subclasificacion = escolaridad.getSUBCLASIFICACION();
				var clasificacionRomano = escolaridad.getCLASIFICACION_ROMANO();
				var subclasificacionRomano = escolaridad.getSUBCLASIFICACION_ROMANO();
				var anio = escolaridad.getANIO();
				if(!structKeyExists(resumenBean, clasificacion)){
					resumenBean[clasificacion] = createObject("java", "java.util.LinkedHashMap").init();
					resumenBean[clasificacion]["NOMBRE"] = "Formaci&oacute;n Acad&eacute;mica";
					resumenBean[clasificacion]["PUNTAJECLASIFICACION"] = 0;
					resumenBean[clasificacion]["ROMANO"]  = clasificacionRomano;					
				}
				if(!structKeyExists(resumenBean[clasificacion], subclasificacion)){
					resumenBean[clasificacion][subclasificacion] = createObject("java", "java.util.LinkedHashMap").init();
					resumenBean[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] = 0;
					resumenBean[clasificacion][subclasificacion]["ROMANO"] = subclasificacionRomano;					
					for(var i = proceso.getFECHAINIPROC(); i <= proceso.getFECHAFINPROC();i++){
						resumenBean[clasificacion][subclasificacion][i] = createObject("java", "java.util.LinkedHashMap").init();
						resumenBean[clasificacion][subclasificacion][i]["PRODUCTOS"] = arrayNew(1);
						resumenBean[clasificacion][subclasificacion][i]["PUNTAJE"] = 0;
					}
					resumenBean[clasificacion][subclasificacion]["SIN ASIGNAR"] = createObject("java", "java.util.LinkedHashMap").init();													
					resumenBean[clasificacion][subclasificacion]["SIN ASIGNAR"]["PRODUCTOS"] = arrayNew(1);
					resumenBean[clasificacion][subclasificacion]["SIN ASIGNAR"]["PUNTAJE"] = 0;						
				}
				if(structKeyExists(resumenBean[clasificacion][subclasificacion], anio)){
					arrayAppend(resumenBean[clasificacion][subclasificacion][anio]["PRODUCTOS"], escolaridad);
					if(compare(anio,"SIN ASIGNAR") != 0){
						var puntajeEvaluacion = 0;
						var fechaRef = CreateDateTime(0,1,1,0,0,0);
						// FIXME: No se suma el puntaje							
						for(evaluacion in escolaridad.getEVALUACIONES()){
							if(Len(evaluacion.getFECHA_CAPTURA()) GT 0){
								var fechaEvaluacion = ParseDateTime(evaluacion.getFECHA_CAPTURA());
								// Si fechaEvaluacion es mas reciente que fechaRef
								if(
									(evaluacion.getFK_TIPO_EVALUACION() EQ pkTipoEvaluacion AND escolaridad.GETPROCESO() EQ proceso.GETPKPROCESO()) //SI ES DE ESTE PROCESO OBTIENE LAS DE LA ETAPA QUE LE CORRESPONDE AL EVALUADOR
									OR (dateCompare(fechaEvaluacion,fechaRef) AND ((escolaridad.GETPROCESO() NEQ proceso.GETPKPROCESO()) OR (pkTipoEvaluacion EQ application.SIIIP_CTES.TIPOEVALUACION.FINAL)))				// SI ES DE OTRO PROCESO OBTIENE LA ULTIMA QUE SE CAPTURO								
								){																	

									fechaRef = fechaEvaluacion;
									puntajeEvaluacion = val(evaluacion.getPUNTAJE_OBTENIDO());
								}																	
							}
						}
						resumenBean[clasificacion][subclasificacion][anio]["PUNTAJE"] += puntajeEvaluacion;
						resumenBean[clasificacion]["PUNTAJECLASIFICACION"] += puntajeEvaluacion;
						resumenBean[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"] += puntajeEvaluacion;							
					}
				}
				else{						
					resumenBean[clasificacion][subclasificacion][anio]["PUNTAJE"] = "INVALIDO";						
				}							
				if(compare(resumenBean[clasificacion][subclasificacion][anio]["PUNTAJE"],"INVALIDO") EQ 0){
					structDelete(resumenBean[clasificacion][subclasificacion],anio);						
				}			
			}
			return resumenBean;
		</cfscript>
	</cffunction>
	
	<!---
	*Fecha: Marzo de 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getClasificaciones" hint="Obtiene las clasificaciones de las UR">
		<cfscript>
			return DAO.getClasificaciones();
		</cfscript>
	</cffunction>

	<!---
	*Fecha: Marzo de 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getUR" hint="Obtiene las UR">
		<cfargument name="clasificacion" hint="tipo de clasificacion" default="">
		<cfscript>
			return DAO.getUR(clasificacion);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getTablaAspiranteProcesoUR" hint="obtiene la tabla de movimientos de aspiranteproceso">
		<cfargument name="pkProceso" type="numeric"	hint ="pk del proceso">
		<cfargument name="pkUr" type="any"	hint ="ur">
		<cfscript>
			return DAO.getTablaAspiranteProcesoUR(pkProceso, session.cbstorage.usuario.pk, pkUr);
		</cfscript>
	</cffunction>
	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getResumenEvaluacionSeleccionados" hint="obtiene la tabla de movimientos de aspiranteproceso">
		<cfargument name="productos" type="any"	hint ="arreglo de productos">
		<cfargument name="proceso" type="any"	hint ="ur">
		<cfargument name="estado" type="any"	hint ="ur">
		
		<cfscript>
			var datos = [];
			for(i = 1; i LTE arrayLen(productos);i++){
				resumen = getResumenEvaluacion(productos[i], proceso, estado);
				arrayAppend(datos, resumen);
			}
			return datos;
		</cfscript>
	</cffunction>


</cfcomponent>
