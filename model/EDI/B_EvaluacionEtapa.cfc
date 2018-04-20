<cfcomponent accessors="true">	
	<cfproperty name="PK_EVALUACION"			hint ="pk de la evaluacion">
	<cfproperty name="PK_EVALUACIONETAPA"		hint ="pk de la etapa de evaluacion">
	<cfproperty name="FECHA_CAPTURA"			hint ="fecha de la captura">
	<cfproperty name="PUNTAJE_OBTENIDO"			hint ="puntaje obtenido">
	<cfproperty name="FK_RECLASIFICACION"		hint ="fk de reclasificacion, sirve para indicar reclasificacion">
	<cfproperty name="FK_EVALUADOR"				hint ="fk del evaluador">
	<cfproperty name="FK_TIPO_EVALUACION"		hint ="fk del tipo de evaluacion">
	<cfproperty name="NOMBRE_TIPO_EVALUACION"	hint ="nombre de la evaluacion">
	<cfproperty name="ESTADO_EVALUACION"		hint ="estado">
	<cfproperty name="PUNTUACION_MAXIMA"		hint ="Puntuacion maxima">
	<cfproperty name="TIPO_PUNTUACION"			hint ="Puntuacion continua o fija">
	<cfproperty name="ACCIONESCVE"				hint ="clave de las acciones">
	<cfproperty name="PKACCIONES"				hint ="pk's de las acciones">
	<cfproperty name="CESESTADO"				hint ="estado">
	<cfproperty name="CESRUTA"					hint ="ruta">
	<cfproperty name="EDOACT"					hint ="estado actual">
	<cfproperty name="CVETIPO"					hint ="clave del tipo de evaluacion">
	<cfproperty name="REC_CLASIFICACION"		hint ="clasificacion de la reclasificacion">
	<cfproperty name="REC_CLASIFICACION_ROMANO"		hint ="clasificacion de la reclasificacion">	
	<cfproperty name="REC_SUBCLASIFICACION"		hint ="subclasificacion de la reclasificacion">
	<cfproperty name="REC_SUBCLASIFICACION_ROMANO"		hint ="subclasificacion de la reclasificacion">	
	<cfproperty name="REC_PUNTAJE"				hint ="puntaje maximo de la nueva clasificacion">
	<cfproperty name="MOTIVO"					hint ="Motivo de calificar el producto con cero">
	<cfproperty name="COMENT_EVAL"					hint ="Motivo de calificar el producto con cero">
	<cfproperty name="REC_PUNTMAX"					hint ="Motivo de calificar el producto con cero">
	<cfproperty name="REC_TIPOPUNTUACION"					hint ="Motivo de calificar el producto con cero">
	<cfproperty name="EDITABLE"					hint ="indica si la etapa se puede editar por el evaluador" defaul="false">
	<!---
		* Fecha : Noviembre 2017
		* author : Daniel Memije
	--->
	<cffunction name="init">
		<cfscript>						
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="getNuevoTipoPuntuacion">
		<cfscript>
			if(this.getREC_TIPOPUNTUACION() neq '')
				return	this.getREC_TIPOPUNTUACION();
			else		
				return	this.getTIPO_PUNTUACION();
		</cfscript>
	</cffunction>
	
	
	<cffunction name="getNuevoPuntajeMaximo">
		<cfscript>
			if(this.getREC_PUNTMAX() neq '')
				return	this.getREC_PUNTMAX();
			else		
				return	this.getPUNTUACION_MAXIMA();
		</cfscript>
	</cffunction>

	<cffunction name="getCOMENT_EVAL2">
		<cfscript>
				return	REReplaceNoCase(this.getCOMENT_EVAL(),"<!--(.*)-->","","ALL");
		</cfscript>
	</cffunction>

</cfcomponent>
