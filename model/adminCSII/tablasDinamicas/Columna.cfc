<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 26 de agosto de 2015
* Descripcion: 
* Objeto de negocio para las columnas
* Autor:Arturo Christian Santander Maya 
* ================================
--->
<cfcomponent accessors="true">
	
	<cfproperty name="id">
	<cfproperty name="nombre">
	<cfproperty name="nombreGeneral">
	<cfproperty name="tipo">
	<cfproperty name="tipoDato">
	<cfproperty name="icono">
	<cfproperty name="prioridad">
	<cfproperty name="descripcion">
	<cfproperty name="filtros" type="array">
	<cfproperty name="agregaciones" type="array">

	
	
	

	<cffunction name="init">
		<cfscript>
			
			filtros=[];
			agregaciones=[];
			return this;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	
	<cffunction name="obtenerFiltroporId" hint="Obtiene un filtro asociado a la columna ">
		<cfargument name="idFilt">
		<cfscript>
			for (filtro in filtros){
				if(filtro.getId() eq idFilt){
					return filtro;
				}
			}
			return ;
		</cfscript>		
	</cffunction>
	
	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="obtenerAgregacionPorId" hint="Obtiene una agregacion asociada a la columna">
		<cfargument name="idAgr">
		<cfscript>
			for (agregacion in agregaciones){
				if(agregacion.getId() eq idAgr){
					return agregacion;
				}
			}
			return ;
		</cfscript>	
	</cffunction>


	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="eliminarAgregacion" hint="Elimina una agregacion asociada a la columna">
		<cfargument name="idAgrColVis">
		<cfscript>
			for (var i =1;i<=arrayLen(agregaciones);i++){
				if(agregaciones[i].getIdAgrColVis() eq idAgrColVis){
					ArrayDeleteAt(agregaciones,i);
			
				}
			}
		
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	
	<cffunction name="insertarAgregacion" hint="Inserta una agregacion ">
		<cfargument name="agregacion">
		<cfscript>
			arrayAppend(agregaciones, agregacion);
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="insertarFiltro" hint="Inserta un filtro">
		<cfargument name="filtro">
		<cfscript>
			arrayAppend(filtros, filtro);
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="eliminarFiltro" hint="Elimina un filtro">
		<cfargument name="idFiltColVis">
		<cfscript>
			for (var i =1;i<=arrayLen(filtros);i++){
				if(filtros[i].getidFiltColVis() eq idFiltColVis){
					ArrayDeleteAt(filtros,i);
			
				}
			}
		
		</cfscript>
	</cffunction>


</cfcomponent>