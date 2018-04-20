<!---
* ============================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Acciones Formativas
* Fecha: 28 de abril de 2016
* Descripcion: Acceso a datos para la elaboración del formato de evaluación.
* ============================================================================
--->

<cfcomponent>
    <!---
    * Fecha creacion: 28 de abril de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="obtenerFormato" access="remote" hint="Obtiene los datos para construir el formato de evaluacion">
        <cfquery datasource="DS_SIIS_CUR" name="qFormato">
            SELECT CA.CAP_PK_ASPECTO CVE,
                CAS.CAS_NOMBRE SECCION,
                CA.CAP_NOMBRE ASPECTO,
                CET.CET_PK_ESCALATIPO TIPO
            FROM CASPECTO CA,
                CASPECTOSECCION CAS,
                CESCALATIPO CET,
                CEVALUACION CE
            WHERE CA.CAP_FK_ESTADO = 2
                AND CA.CAP_FK_ASPECTOSECCION = CAS.CAS_PK_ASPECTOSECCION
                AND CA.CAP_FK_ESCALATIPO = CET.CET_PK_ESCALATIPO 
                AND CAP_FK_EVALUACION = 1
            ORDER BY CAS.CAS_ORDEN, CA.CAP_ORDEN
        </cfquery>
        <cfreturn qFormato>
    </cffunction>

    <!---
    * Fecha creacion: 28 de abril de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="obtenerEscala" access="remote" hint="Obtiene los valores de un tipo de escala">
        <cfargument name="pkEscala" type="numeric" required="yes" hint="Tipo de escala">
        <cfquery datasource="DS_SIIS_CUR" name="qEscala">
            SELECT CE.CEC_NOMBRE DES,        
                    CE.CEC_PK_ESCALA VAL
                FROM CESCALA CE,
                    CESCALATIPO CET
                WHERE CE.CEC_FK_ESCALATIPO = CET.CET_PK_ESCALATIPO
                    AND CET.CET_PK_ESCALATIPO = '#arguments.pkEscala#'
        </cfquery>
        <cfreturn qEscala>
    </cffunction>

    <!---
    * Fecha creacion: 02 de mayo de 2016
    * @author Yareli Andrade
	*------------------------------
	* Fecha : 09 de junio de 2016
    * @author : Víctor Manuel Mazón Sánchez
	* Se hace el cambio de que si el PK es cero manda a llamar un insert, si no, un update
    --->     
    <cffunction name="guardarEvaluacion" access="remote" hint="Obtiene el pk del registro de evaluación del curso correspondiente">
        <cfargument name="pkParticipante" type="numeric" required="no" hint="Pk del resgitro participante-curso">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de la evaluación">
        <cfargument name="pkEstado" type="numeric" required="yes" hint="Pk del estado que deberá tener">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GUARDAR_EVALUACION" datasource="DS_GRAL">
            <cfprocparam value="#pkParticipante#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkEstado#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <!---
	* Fecha : 09 de junio de 2016
    * @author : Víctor Manuel Mazón Sánchez
	* descripción: Recibe PK y valores para actualizar un registro de cuerso evaluacion
    --->     
    <cffunction name="actualizarEvaluacion" access="remote" hint="Obtiene el pk del registro de evaluación del curso correspondiente">
        <cfargument name="pkCursoEvaluacion" type="numeric" required="no" hint="Pk del resgitro curso-Evaluacion">
        <cfargument name="pkParticipante" type="numeric" required="no" hint="Pk del resgitro participante-curso">
        <cfargument name="pkCurso" type="numeric" required="yes" hint="Pk del resgitro de curso-calendario">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de la evaluación">
        <cfargument name="pkEstado" type="numeric" required="yes" hint="Pk del estado que deberá tener">
        <cfstoredproc procedure="SIIS_CUR.P_EVALUACION.ACTUALIZAR_EVALUACION" datasource="DS_GRAL">
            <cfprocparam value="#pkCursoEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkParticipante#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkCurso#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkEstado#" cfsqltype="cf_sql_numeric" type="in">            
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>
    

    <!---
    * Fecha : 02 de mayo de 2016
    * @author : Yareli Andrade
	-------------------------
	* Fecha : 09 de junio de 2016
    * @author : Víctor Manuel Mazón Sánchez
	* descripción: Se agrego una escala 0 dentro del tipo de escala 3, por lo que ya no habra FK_ESCALA nulos y ya no será necesario distinguir
	--->        
    <cffunction name="guardarEscala" access="remote" hint="">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de la evaluación">
        <cfargument name="aspecto" type="numeric" required="no" hint="">
        <cfargument name="obs" type="string" required="no" hint="">
        <cfargument name="escala" type="numeric" required="no" hint="">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GUARDAR_ESCALA" datasource="DS_GRAL">
            <cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#aspecto#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#obs#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#escala#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>


    <!---
	* Fecha : 09 de junio de 2016
    * @author : Víctor Manuel Mazón Sánchez
	* descripción: Recibe PK y valores para actualizar un registro de evaluacion escala
	--->        
    <cffunction name="actualizarEscala" access="remote" hint="">
        <cfargument name="pkEvalEscal" type="numeric" required="yes" hint="Pk de la escala de un aspecto de evaluación">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de la evaluación">
        <cfargument name="aspecto" type="numeric" required="no" hint="">
        <cfargument name="obs" type="string" required="no" hint="">
        <cfargument name="escala" type="numeric" required="no" hint="">
        <cfstoredproc procedure="SIIS_CUR.P_EVALUACION.ACTUALIZAR_ESCALA" datasource="DS_GRAL">
            <cfprocparam value="#pkEvalEscal#" cfsqltype="cf_sql_numeric" type="in">        
            <cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#aspecto#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#obs#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#escala#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    

    <!---
    * Fecha creacion: 02 de mayo de 2016
    * @author Yareli Andrade
	*------------------------
    * Fecha modificacion: 07 de junio de 2016
    * @author Víctor Manuel Mazón Sánchez
	* Descripcion: Se cambia la consulta a un procedimiento almacenado y en el procedimiento se agrega que regrese el pk de cada registro para poder hacer update
    --->
    <cffunction name="obtenerEvaluacion" access="remote" hint="Obtiene evaluación">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de evaluación">
        <cfargument name="pkCursoEval" type="numeric" required="yes" hint="Pk del registro curso-evaluacion">
            <cfstoredproc procedure="GRAL.P_EVALUACION.OBTENER_EVALUACION" datasource="DS_GRAL">
                <cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">            
                <cfprocparam value="#pkCursoEval#" cfsqltype="cf_sql_numeric" type="in">                            
                <cfprocresult name="qEvaluacion">
            </cfstoredproc>
        <cfreturn qEvaluacion>
    </cffunction>

    <!---
    * Fecha creacion: 07 de junio de 2016
    * @author Víctor Manuel Mazón Sánchez
	*-------------------------
	Se crea DAO para obtener la forma que se muestra en vista
    --->
    <cffunction name="obtenerForma" access="remote" hint="Obtiene forma">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de evaluación">
         <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.OBTENER_FORMA" datasource="DS_GRAL">
                <cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">            
                <cfprocresult name="qForma">
            </cfstoredproc>
        <cfreturn qForma>
    </cffunction>

    <!---
    * Fecha creacion: 07 de junio de 2016
    * @author Víctor Manuel Mazón Sánchez
	*-------------------------
	Se crea DAO para obtener las escalas que se muestra en vista, primero consulta cuantos tipos de escalas existen y luego las trae en un arreglo
    --->
    <cffunction name="obtenerEscalas" access="remote" hint="Obtiene forma">
      <cfquery datasource="DS_GRAL" name="qCuantas">
         SELECT CET_PK_ESCALATIPO  AS PK  FROM EDSCESCALATIPO CET
      </cfquery>
      <cfset escalas= ArrayNew(1)>
      <cfloop query="qCuantas">
      	 <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.OBTENER_ESCALA" datasource="DS_GRAL">
                <cfprocparam value="#qCuantas.PK#" cfsqltype="cf_sql_numeric" type="in">                     
                <cfprocresult name="qEscala">
            </cfstoredproc>
          <cfset escalas[qCuantas.PK]=qEscala>  
       </cfloop>

        <cfreturn escalas>        
    </cffunction>    

</cfcomponent>