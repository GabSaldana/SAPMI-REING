<cfcomponent accessors="true">
	<cfproperty name="PK_CREQUISITO" hint="pk del catalogo de requisitos">
	<cfproperty name="PK_TREQUISITO" hint="pk de la tabla de requisitos">
	<cfproperty name="PK_MOVIMIENTO" hint="pk del movimiento">
	<cfproperty name="PK_PERSONA" 	hint="pk de la persona">
	<cfproperty name="REQUISITO" 	hint="requisitos">
	<cfproperty name="TIENEREQUISITO" 		 hint="indica si ya cumplio el requisito">
	<cfproperty name="T_OBLIGATORIO" type="numeric" hint="si es obligatorio en el catalogo">
	
	<!---
	* Fecha : Noviembre 2017
	* author : Marco Torres
	--->
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Noviembre 2017
	* author : Marco Torres
	--->
	<cffunction name="getColor"   hint="obtiene el color con que debe pinrtarse el elemento en la vista">
		<cfscript>
			if(this.getTIENEREQUISITO() eq 0 and this.getT_OBLIGATORIO() EQ 1)
				return 'alert-danger';
			else if(this.getTIENEREQUISITO() eq 0)
				return 'alert-warning';
			else
				return 'alert-success';
		</cfscript>
	</cffunction>
</cfcomponent>