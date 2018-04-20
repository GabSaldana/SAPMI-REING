<!---
* =====================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Acciones Formativas
* Fecha: 28 de abril de 2016
* Descripcion: Componente de negocio para la elaboración del formato de evaluación.
* =====================================================================================
--->

<cfcomponent>

	<!---
    * Fecha : 28 de abril de 2016
    * @author : Yareli Andrade
    --->  
    <cffunction name="obtenerFormato"access="remote" hint="Obtiene los datos para construir el formato de evaluacion">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerFormato();
        </cfscript>
    </cffunction>

    <!---
    * Fecha : 28 de abril de 2016
    * @author : Yareli Andrade
    --->  
    <cffunction name="obtenerEscala"access="remote" hint="Obtiene los valores de un tipo de escala">
        <cfargument name="pkEscala" type="numeric" required="yes" hint="Tipo de escala">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerEscala(pkEscala);
        </cfscript>
    </cffunction>

    <!---
    * Fecha : 02 de mayo de 2016
    * @author : Yareli Andrade
	*------------------------------
	* Fecha : 09 de junio de 2016
    * @author : Víctor Manuel Mazón Sánchez
	* Se hace el cambio de que si el PK es cero manda a llamar un insert, si no, un update
    --->        
    <cffunction name="guardarEvaluacion" access="remote" hint="Obtiene el pk del registro de evaluación del curso correspondiente">
        <cfargument name="pkusuarioEval" type="numeric" required="yes" hint="Pk de la evaluación de un curso">
        <cfargument name="pkParticipante" type="numeric" required="yes" hint="Pk del resgitro participante-curso">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de la evaluación">
        <cfargument name="pkEstado" type="numeric" required="yes" hint="Pk del estado"> 
        <cfscript>            
            dao = CreateObject('component','DAO_Evaluacion');
			var pkGuardado = 0;			
			if((pkusuarioEval eq 0 AND(pkEstado eq 2))) {
                pkGuardado = dao.guardarEvaluacion(pkParticipante, pkEvaluacion, 2);
			}else{
                pkGuardado = dao.guardarEvaluacion(pkParticipante, pkEvaluacion, 1);
            }
            return pkGuardado;
        </cfscript>
    </cffunction>

    <!---
    * Fecha : 02 de mayo de 2016
    * @author : Yareli Andrade
	*------------------------
    * Fecha modificacion: 09 de junio de 2016
    * @author Víctor Manuel Mazón Sánchez
	* Descripcion: Se hace el cambio de que si el PK es cero manda a llamar un insert, si no, un update
    --->   
    <cffunction name="guardarEscala" access="remote" hint="">
        <cfargument name="pkEvalEscal" type="numeric" required="yes" hint="Pk de la escala de un aspecto de evaluación">    
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de la evaluación">
        <cfargument name="aspecto" type="numeric" required="no" hint="">
        <cfargument name="obs" type="string" required="no" hint="">
        <cfargument name="escala" type="numeric" required="no" hint="">
        <cfscript>            
            var dao = CreateObject('component','DAO_Evaluacion');
			var pkGuardado = 0;			
			pkGuardado = dao.guardarEscala(pkEvaluacion, aspecto, obs, escala);			
            return pkGuardado;
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: 02 de mayo de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="obtenerEvaluacion" access="remote" hint="Obtiene evaluación">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de evaluación">
        <cfargument name="pkCursoEval" type="numeric" required="yes" hint="Pk del registro curso-evaluacion">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerEvaluacion(pkEvaluacion, pkCursoEval);
        </cfscript>
    </cffunction>
    
    <!---
    * Fecha creacion: 07 de junio de 2016
    * @author Víctor Manuel Mazón Sánchez
	*-------------------------
	Se crea controlador para obtener la forma que se muestra
    --->
    <cffunction name="getForma" access="remote" hint="Obtiene forma">
        <cfargument name="pkEvaluacion" type="numeric" required="yes" hint="Pk de evaluación">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerForma(pkEvaluacion);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: 07 de junio de 2016
    * @author Víctor Manuel Mazón Sánchez
	*-------------------------
	Se crea controlador para obtener las escalas de los selects
    --->
    <cffunction name="getEscalas" access="remote" hint="Obtiene escalas">
        <cfscript>
		    dao = CreateObject('component','DAO_Evaluacion');
			return dao.obtenerEscalas();
        </cfscript>
    </cffunction>



    

</cfcomponent>