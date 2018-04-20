<cfcomponent>

    <cffunction name="getInstituciones" hint="Obtiene los modulos del sistema">
        <cfquery name="qInstituciones" datasource="DS_CONINV">
            SELECT
                TCONV.TINS_PK_INSTITUCION    AS PK,
                TCONV.TINS_NOMBRE            AS NOMBRE,
                TCONV.TINS_UBICACION         AS DIRECCION,
                TCONV.TINS_DESCRIPCION       AS DESCRIPCION,
                TCONV.TINS_ESTADO            AS EDO
            FROM                 
                CONINV.CINVTINSTITUCION TCONV
		   WHERE TCONV.TINS_ESTADO = 2	
            ORDER BY PK                   
        </cfquery>
        <cfreturn qInstituciones>        
    </cffunction>

    <cffunction name="getModalidades" hint="Obtiene la lista de modalidades">
        <cfquery name="qModalidades" datasource="DS_CONINV">
            SELECT
                TCONV.TMOD_PK_MODALIDAD      AS PK,
                TCONV.TMOD_NOMBRE            AS NOMBRE,
                TCONV.TMOD_ESTADO            AS EDO
            FROM                 
                CONINV.CINVTMODALIDAD TCONV
           WHERE TCONV.TMOD_ESTADO = 2  
            ORDER BY PK                   
        </cfquery>
        <cfreturn qModalidades>        
    </cffunction>

    <cffunction name="consultarInstitucion" hint="Obtiene los modulos del sistema">
        <cfargument name="pkIns"    type="numeric"  required="yes" hint="Identificador unico de la institucion">
        <cfquery name="qInstituciones" datasource="DS_CONINV">
            SELECT
                TCONV.TINS_NOMBRE            AS NOMBRE,
                TCONV.TINS_UBICACION         AS DIRECCION,
                TCONV.TINS_DESCRIPCION       AS DESCRIPCION,
                TCONV.TINS_ESTADO            AS EDO
            FROM                 
                CONINV.CINVTINSTITUCION TCONV
           WHERE TCONV.TINS_PK_INSTITUCION = '#arguments.pkIns#'               
        </cfquery>
        <cfreturn qInstituciones>        
    </cffunction>

    <cffunction name="consultarModalidad" hint="Obtiene los modulos del sistema">
        <cfargument name="pkMod"    type="numeric"  required="yes" hint="Identificador unico de la modalidad">
        <cfquery name="qModalidades" datasource="DS_CONINV">
            SELECT
                TCONV.TMOD_NOMBRE            AS NOMBRE,
                TCONV.TMOD_ESTADO            AS EDO
            FROM                 
                CONINV.CINVTMODALIDAD TCONV
           WHERE TCONV.TMOD_PK_MODALIDAD = '#arguments.pkMod#'               
        </cfquery>
        <cfreturn qModalidades>        
    </cffunction>

    <cffunction name="agregarInstitucion" access="public" returntype="numeric" hint="Agrega un nuevo registro al catalogo de instituciones">
        <cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
        <cfargument name="ubicacion"        type="string"  required="yes" hint="Direccion de la institucion">
        <cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion breve de la funcion principal de la institucion">
        <cfstoredproc procedure="CONINV.P_CONVENIO.INSERTINSTITUCION" datasource="DS_CONINV">
            <cfprocparam value="#nombre#"         cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#ubicacion#"      cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#descripcion#"    cfsqltype="cf_sql_string"   type="in">
            <cfprocparam variable="resultado"     cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <cffunction name="agregarModalidad" access="public" returntype="numeric" hint="Agrega un nuevo registro al catalogo de modalidades">
        <cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
        <cfstoredproc procedure="CONINV.P_CONVENIO.INSERTMODALIDAD" datasource="DS_CONINV">
            <cfprocparam value="#nombre#"         cfsqltype="cf_sql_string"   type="in">
            <cfprocparam variable="resultado"     cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <cffunction name="editarInstitucion" access="public" returntype="numeric" hint="Agrega un nuevo registro al catalogo de instituciones">
        <cfargument name="pk"               type="numeric" required="yes" hint="Identificador de la institucion">
        <cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
        <cfargument name="ubicacion"        type="string"  required="yes" hint="Direccion de la institucion">
        <cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion breve de la funcion principal de la institucion">
        <cfstoredproc procedure="CONINV.P_CONVENIO.UPDATEINSTITUCION" datasource="DS_CONINV">
            <cfprocparam value="#pk#"             cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#nombre#"         cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#ubicacion#"      cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#descripcion#"    cfsqltype="cf_sql_string"   type="in">
            <cfprocparam variable="resultado"     cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <cffunction name="editarModalidad" access="public" returntype="numeric" hint="Agrega un nuevo registro al catalogo de modalidades">
        <cfargument name="pk"               type="numeric" required="yes" hint="Identificador de la institucion">
        <cfargument name="nombre"           type="string"  required="yes" hint="Nombre de la institucion">
        <cfstoredproc procedure="CONINV.P_CONVENIO.UPDATEMODALIDAD" datasource="DS_CONINV">
            <cfprocparam value="#pk#"             cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#nombre#"         cfsqltype="cf_sql_string"   type="in">
            <cfprocparam variable="resultado"     cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <cffunction name="actualizarInstitucion" access="remote" hint="Actualiza el estado del registro de una institucion">
        <cfargument name="pk"               type="numeric" required="yes" hint="Identificador de la institucion">
        <cfargument name="estado"           type="numeric"  required="yes" hint="Nombre de la institucion">
        <cfstoredproc procedure="CONINV.P_CONVENIO.UPDATEINSTITUCION_EDO" datasource="DS_CONINV">
            <cfprocparam value="#pk#"             cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#estado#"         cfsqltype="cf_sql_numeric"   type="in">
            <cfprocparam variable="resultado"     cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <cffunction name="actualizarModalidad" access="remote" hint="Actualiza el estado del registro de una modalidad">
        <cfargument name="pk"               type="numeric" required="yes" hint="Identificador de la institucion">
        <cfargument name="estado"           type="numeric"  required="yes" hint="Nombre de la institucion">
        <cfstoredproc procedure="CONINV.P_CONVENIO.UPDATEMODALIDAD_EDO" datasource="DS_CONINV">
            <cfprocparam value="#pk#"             cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#estado#"         cfsqltype="cf_sql_numeric"   type="in">
            <cfprocparam variable="resultado"     cfsqltype="cf_sql_numeric"  type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

</cfcomponent>
