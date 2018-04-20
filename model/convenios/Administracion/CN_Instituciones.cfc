<!----
* ================================
* IPN – CSII
* Sistema:     SIIIP (Sistema Institucional de Información de Investigación y Posgrado)
* Modulo:      Convenios
* Fecha:       1 de Febrero de 2018
* Descripcion: Componente de Negocio para el modulo de administracion de instituciones 
* ================================
---->
<cfcomponent>
	<cfproperty name="DAO" inject="convenios.administracion.DAO_Instituciones">

    <cffunction name="getInstituciones" hint="obtiene la lista de las instituciones">
        <cfscript>
            return DAO.getInstituciones();
        </cfscript>
    </cffunction>

    <cffunction name="getModalidades" hint="obtiene la lista de las modalidades que puede tener un convenio">
        <cfscript>
            return DAO.getModalidades();
        </cfscript>
    </cffunction>

    <cffunction name="agregarInstitucion" access="remote" hint="Agrega un nuevo registro al catalogo de instituciones">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
		<cfargument name="ubicacion"      	type="string"  required="yes" hint="Direccion de la institucion">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion breve de la funcion principal de la institucion">
		<cfscript>
			return DAO.agregarInstitucion(UCase(nombre), UCase(ubicacion), UCase(descripcion));
		</cfscript>
	</cffunction>

	<cffunction name="agregarModalidad" access="remote" hint="Agrega un nuevo registro al catalogo de modalidades">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
		<cfscript>
			return DAO.agregarModalidad(UCase(nombre));
		</cfscript>
	</cffunction>

	<cffunction name="editarInstitucion" access="remote" hint="Edita un registro del catalogo de instituciones">
		<cfargument name="pk"           	type="numeric" required="yes" hint="Identificador de la institucion">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
		<cfargument name="ubicacion"      	type="string"  required="yes" hint="Direccion de la institucion">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion breve de la funcion principal de la institucion">
		<cfscript>
			return DAO.editarInstitucion(pk, UCase(nombre), UCase(ubicacion), UCase(descripcion));
		</cfscript>
	</cffunction>

	<cffunction name="editarModalidad" access="remote" hint="Edita un registro del catalogo de modalidades">
		<cfargument name="pk"           	type="numeric" required="yes" hint="Identificador de la institucion">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
		<cfscript>
			return DAO.editarModalidad(pk, UCase(nombre));
		</cfscript>
	</cffunction>

	<cffunction name="consultarInstitucion" access="remote" hint="Consulta la informacion de una institucion">
		<cfargument name="pkIns"    type="numeric"  required="yes" hint="Identificador unico de la institucion">
		<cfscript>
			return DAO.consultarInstitucion(pkIns);
		</cfscript>
	</cffunction>

	<cffunction name="consultarModalidad" access="remote" hint="Consulta la informacion de una modalidad">
		<cfargument name="pkMod"    type="numeric"  required="yes" hint="Identificador unico de la modalidad">
		<cfscript>
			return DAO.consultarModalidad(pkMod);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarInstitucion" access="remote" hint="Actualiza el estado del registro de una institucion">
		<cfargument name="pk"    	 type="numeric"  required="yes" hint="Identificador unico de la institucion">
		<cfargument name="estado"    type="numeric"  required="yes" hint="Identificador unico de la institucion">
		<cfscript>
			return DAO.actualizarInstitucion(pk, estado);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarModalidad" access="remote" hint="Actualiza el estado del registro de una modalidad">
		<cfargument name="pk"    	 type="numeric"  required="yes" hint="Identificador unico de la institucion">
		<cfargument name="estado"    type="numeric"  required="yes" hint="Identificador unico de la institucion">
		<cfscript>
			return DAO.actualizarModalidad(pk, estado);
		</cfscript>
	</cffunction>


</cfcomponent>