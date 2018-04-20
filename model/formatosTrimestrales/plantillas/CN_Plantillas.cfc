

<cfcomponent <!--- accessors="true" singleton --->>

	<cfproperty name="DAO_P" 			inject="formatosTrimestrales.plantillas.DAO_Plantillas">
	<cfproperty name="populator" 	inject="wirebox:populator">
	<cfproperty name="wirebox" 		inject="wirebox">
	<cfproperty name="cache" 		inject="cachebox:default">
	
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
<!-----******************************Inicio Funciones de plantillas**************************************************************
**********************************************************************************************************************************************  --->
	
	<!---
	* Descripcion: Funcion que guarda el nombre de la plantilla y guarda los valores 
	* Fecha: 17 de mayo del 2106
	* @author: Isaul Nieto Cruz
	---> 
	<cffunction name="setPlantilla" access="remote" hint="">
		<cfargument name="nombrePlantilla" type="string" required="yes" hint="" />
		<cfargument name="valoresPlantilla" type="string" required="yes" hint="" />
		<cfscript>
			valorPlantilla =  arguments.valoresPlantilla.split('@@,');
			var pk_NamePlantilla = DAO_P.setNombrePlantilla(nombrePlantilla);
			
			for(i = 1 ; i lte ArrayLen(valorPlantilla) ; i = i+1){
				respuesta = DAO_P.setValorePlantilla(pk_NamePlantilla,valorPlantilla[i]);
			}	
			return respuesta;
		</cfscript>
	</cffunction>
	
	<!---
	* Descripcion: Funcion que obtiene todas las plantillas disponibles para ser editas por el usuario
	* Fecha: 17 de mayo del 2016
	* Autor: Isaul Nieto.
	--->  
	<cffunction name="getAllPlantillas" access="public" hint="">
		<cfscript>
			return  DAO_P.getAllPlantillas();
		</cfscript>
    </cffunction>
	
	<!---
	* Descripcion: 
	* Fecha:
	* @author: Isaul Nieto.
	--->  
	<cffunction name="getPlantilla" access="remote" hint="">
	<cfargument name="pk_plantilla" type="numeric" required="yes" hint="" />
		<cfscript>
			var consulta = DAO_P.getPlantilla(pk_plantilla);			
			var resArray = '';
			for( var i = 1; i lte consulta.recordcount; i ++){
				resArray = resArray & '{"val":"' & JSStringFormat(consulta.VALORES_PLANTILLA[i]) & '","pk":"' & consulta.PK_PLANTILLA[i] & '"},';	
			}
			return resArray;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha:	Agosto 2016	
	* @author: 	Marco Torres.
	--->  
	<cffunction name="getFormatosRelacionados" access="remote" hint="Obtiene los Formatos Relacionados a la Plantilla">
	<cfargument name="pk_plantilla" type="numeric" required="yes" hint="" />
		<cfscript>
			 return DAO_P.getFormatosRelacionados(pk_plantilla);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha:	Agosto 2016	
	* @author: 	Marco Torres.
	--->  
	<cffunction name="actualizarCatalogo" access="remote" hint="Obtiene los Formatos Relacionados a la Plantilla">
	<cfargument name="pkColumna" type="numeric" required="yes" hint="" />
		<cfscript>
			 return DAO_P.actualizarCatalogo(pkColumna);
		</cfscript>
	</cffunction>
	
	<cffunction name="updateValorPlantilla" access="remote" hint="">
		<cfargument name="pk_plantilla" type="string" required="yes" hint="" />
		<cfargument name="valoresPlantilla" type="string" required="yes" hint="" />
		<cfscript>
			var elementos =  deSerializeJSON(valoresPlantilla);
			DAO_P.updateValoresPlantilla(pk_plantilla); // manda a 0 antes de insertar
			var respuesta = true;			
			for(elemento in elementos){
				if(StructKeyExists(elemento, 'pk')){
					respuesta = DAO_P.updateValorPlantilla(elemento['pk'],elemento['val']);
				} else if(StructKeyExists(elemento, 'val')){ 
					respuesta = DAO_P.setValorePlantilla(pk_plantilla,elemento['val']);
				}
			}
			return respuesta;
		</cfscript>
	</cffunction>
	
	<!---
	* Descripcion: Funcion que obtiene todas las plantillas disponibles para ser editas por el usuario
	* Fecha: 17 de mayo del 2016
	* Autor: Isaul Nieto.
	--->  
	<cffunction name="borraPlantilla" access="public" hint="">
		<cfargument name="pk_plantilla" type="string" required="yes" hint="" />
		<cfscript>
			return  DAO_P.borraPlantilla(arguments.pk_plantilla);
		</cfscript>
    </cffunction>

	<!---
	* Fecha:	Febrero 2017
	* @author: 	Roberto Cadena.
	--->  
	<cffunction name="copiarPlantilla" access="remote" hint="Copia una plantilla seleccionada">
	<cfargument name="pk_plantilla" type="numeric" required="yes"/>
	<cfargument name="nombre" type="string" required="yes"/>
		<cfscript>
			select = StructNew();
			select = DAO_P.selectPlantilla(pk_plantilla);
			plantilla = DAO_P.copiarPlantilla(select.estado, select.ruta, nombre, select.isur);
			DAO_P.copiarElemento(plantilla, pk_plantilla);
			abort;
		</cfscript>
	</cffunction>

<!-----******************************Inicio Funciones de Asociacion**************************************************************
**********************************************************************************************************************************************  --->
	<cffunction name="getPlantillaSeleccionadas" access="public" hint="">
		<cfargument name="pkPlantillas" type="array" required="yes" hint="" />
		<cfscript>
			var plantillas = [];
			var nomPlan = [];
			for(pk_plantilla in pkPlantillas){
				arrayAppend(plantillas, DAO_P.getPlantilla( pk_plantilla));
				arrayAppend(nomPlan,  DAO_P.nombrePlantilla(pk_plantilla));
			}
			var relacion =  StructNew();
			relacion.datos = plantillas;
			relacion.nombrePlantilla = nomPlan;
			return relacion;
		</cfscript>
    </cffunction>

    <cffunction name="setAsociacionPlantillas" access="public" hint="">
		<cfargument name="pkPlantillas" type="array" required="yes" hint="" />
		<cfscript>
			return  DAO_P.getAllPlantillas();
		</cfscript>
    </cffunction>
	
	<cffunction name="consultaAsociciacion" access="public" hint="">
		<cfargument name="nombreA" type="string" required="yes" hint="" />
		<cfscript>
			var pkAsociacion = DAO_P.consultaAsociacion(nombreA);
			return  pkAsociacion;
		</cfscript>
	</cffunction>
	

	<cffunction name="crearAsociacion" access="public" hint="">
		<cfargument name="nombreA" type="string" required="yes" hint="" />
		<cfscript>	 
			return DAO_P.crearAsociacion(nombreA);
		</cfscript>
    </cffunction>
    
	<cffunction name="asociarElementos" access="public" hint="">
		<cfargument name="asociaciones" type="array" required="yes" hint="" />
		<cfargument name="const" type="numeric" required="yes" hint=""/>
		<cfscript>			 
			var plantillas = [];
			for(elemento in asociaciones){
				 DAO_P.asociarElemento(elemento.pkelemento, elemento.pkPadre, const);
			}
			return  plantillas;
		</cfscript>
    </cffunction>
	<!---
	* Fecha:	Enero 2017	
	* @author: 	Roberto Cadena.
	--->  
	<cffunction name="asociarPlantilla" access="public" hint="Crea la asociación entre las plantilas padre e hijos">
		<cfargument name="asociaciones" type="array" required="yes" hint="" />
		<cfargument name="const" type="numeric" required="yes" hint=""/>
		<cfscript>
		var relaciones = arrayNew(1);
		var relacion =  StructNew();
		for(i=1;i<=ArrayLen(asociaciones)-1;i++){
			relacion.padre=asociaciones[i];
			relacion.hijo=asociaciones[i+1];
			relaciones[i]=relacion;
			DAO_P.asociarPlantilla(relacion.padre, relacion.hijo, const);		
			relacion = JavaCast( "null", 0 );
		}
		return 1;
		</cfscript>
    </cffunction>
    	<!---
	* Fecha:	Febrero 2017	
	* @author: 	Roberto Cadena.
	--->
    <cffunction name="getPlantillasAsociadas" access="public" hint="Mostrar plantillas asociadas">
	    <cfscript>
	    	return  DAO_P.getPlantillasAsociadas();
	    </cfscript>
    </cffunction>

    <cffunction name="cargarPlantillas" access="public" hint="devuelve los elementos de las plantilla de una asociación">
		<cfargument name="pkAsociacion" type="string" required="yes" hint="" />
		<cfscript>
			pkPlantillas = DAO_P.cargarPlantillas(pkAsociacion);
			var elementos = [];
			for(plantilla in pkPlantillas){
				arrayAppend(elementos, DAO_P.getPlantillaElementos(plantilla.pkPlantilla));
			}
			var relacion =  StructNew();
			relacion.pk = pkAsociacion;
			relacion.datos = elementos;
			relacion.nombre = DAO_P.AsociacionPk(pkAsociacion);
			relacion.nombrePlantilla = pkPlantillas;
			relacion.elementosAsociados = DAO_P.getElementosAsociados(pkAsociacion);
			return relacion;  
		</cfscript>
	</cffunction>

    <cffunction name="eliminarElementosAsociados" access="public" hint="Mostrar plantillas asociadas">
    	<cfargument name="pkAsociado" type="numeric" required="yes" hint="" />
	    <cfscript>
	    	return  DAO_P.eliminarElementosAsociados(pkAsociado);
	    </cfscript>
    </cffunction>

    <cffunction name="eliminarAsociacion" access="public" hint="Elimina una asociación">
    	<cfargument name="pkAsociacion" type="numeric" required="yes" hint="" />
	    <cfscript>
	    	return  DAO_P.eliminarAsociacion(pkAsociacion);
	    </cfscript>
    </cffunction>

    <cffunction name="actualizarNombre" access="public" hint="Actualizar una asociación">
    	<cfargument name="pkAsociado" type="numeric" required="yes" hint="" />
    	<cfargument name="nombre" type="string" required="yes" hint="" />
	    <cfscript>
	    	return  DAO_P.actualizarNombre( pkAsociado, nombre);
	    </cfscript>
    </cffunction>
</cfcomponent>