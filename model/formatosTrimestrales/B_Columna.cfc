<cfcomponent accessors="true"  >
	<cfproperty name="pk_columna" hint="pk de la columna">
	<cfproperty name="NOM_COLUMNA">
	<cfproperty name="orden">
	<cfproperty name="TIPO_DATO">
	<cfproperty name="TIPO_DATONOMBRE" > 
	<cfproperty name="data" default="1">
	<cfproperty name="type" default="numeric">
	<cfproperty name="source" type="array">
	<cfproperty name="sumandos" type="array">
 	<cfproperty name="readOnly" >
	<cfproperty name="requerido" >
	<cfproperty name="NIVEL" >
	<cfproperty name="renderer" default="" > 
	<cfproperty name="pk_Padre">
	<cfproperty name="pk_Formato">
	<cfproperty name="pk_plantilla" default="0">
	<cfproperty name="nombre_plantilla" default="0">
	<cfproperty name="hijosDeNivel" default="0"> 
	<cfproperty name="totalHijosUltimoNivel" default="0">
	<cfproperty name="posicionCol" default="0">
	<cfproperty name="agrupar" default="0">
	<cfproperty name="COL_ORIGEN">
	<cfproperty name="TRIM_COPIABLE">
	<cfproperty name="allowInvalid" default="true">
	<cfproperty name="validator" default="getValidator" >
	<cfproperty name="BLOQUEADA_EDO">
	<cfproperty name="REFERENCIA">
	<cfproperty name="COPIABLE_EDO">
	<cfproperty name="COLUMNATOTAL_EDO">
	<cfproperty name="COLUMNATOTALFINAL_EDO">
	<cfproperty name="bloqueada">
	<cfproperty name="DESCRIPCION">
	<cfproperty name="PLANTILLASECCION">
	<cfproperty name="panalisis" default="0">
	<cfproperty name="operandos" type="array">	<!--- A.B.J.M. para guardar operandos de los sumandos --->
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>	

	<cffunction name="getSortedSource" hint="ordena el arreglo en base a la columna seleccionada (getagruparCol)">
		<cfscript>
			var sortOrder = "asc";        
	        var sortType = "textnocase";
	       	
	       	var catalogo = this.getSource();
	        arraySort(catalogo,sortType,sortOrder);        
	        return catalogo;

		</cfscript>
	</cffunction>	

</cfcomponent>