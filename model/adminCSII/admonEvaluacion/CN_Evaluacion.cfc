<cfcomponent>

    <cffunction name="obtenerEvaluaciones"access="remote" hint="Obtiene todas las evaluaciones">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerEvaluaciones();
        </cfscript>
    </cffunction>

    <cffunction name="guardarEvaluacion" access="remote" hint="Guarda las evaluaciones">
        <cfargument name="nombre" type="string" required="yes" hint="">
        <cfargument name="fechaIni" type="string" required="yes" hint="">
        <cfargument name="fechaFin" type="string" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.guardarEvaluacion(nombre, fechaIni, fechaFin);
        </cfscript>
    </cffunction>

    <cffunction name="guardarSeccion" access="remote" hint="Guarda las evaluaciones">
        <cfargument name="nombreSecc" type="string" required="yes" hint="">
        <cfargument name="ordenSecc" type="numeric" required="yes" hint="">
        <cfargument name="fkEvaluacion" type="numeric" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.guardarSeccion(nombreSecc, ordenSecc, fkEvaluacion);
        </cfscript>
    </cffunction>

    <cffunction name="guardarAspecto" access="remote" hint="Guarda las evaluaciones">
        <cfargument name="nombreAsp" type="string" required="yes" hint="">
        <cfargument name="ordenAsp" type="numeric" required="yes" hint="">
        <cfargument name="seccion" type="numeric" required="yes" hint="">
        <cfargument name="escala" type="numeric" required="yes" hint="">
        <cfargument name="evaluacion" type="numeric" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.guardarAspecto(nombreAsp, ordenAsp, seccion, escala, evaluacion);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerAspectoSeccion" access="remote" hint="Obtiene los aspectosSeccion de una evaluacion">
        <cfargument name="pkEvaluacion" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerAspectoSeccion(pkEvaluacion);
        </cfscript>
    </cffunction>

    <cffunction name="actualizarOrdenElemento" access="remote" hint="Obtiene los aspectosSeccion de una evaluacion">
        <cfargument name="lista" type="string" required="yes" hint="">
        <cfargument name="tipoTabla" type="numeric" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            tabla = deserializeJSON(lista);      
            writedump(tabla);
            for(i = 1; i lte ArrayLen(tabla); i++){
                if(tipoTabla == 1)
                    dao.actualizarOrdenAspectos(tabla[i].orden, tabla[i].pk);
                else
                    dao.actualizarOrdenSeccion(tabla[i].orden, tabla[i].pk);
            }
            abort;
            return 1;
        </cfscript>
    </cffunction>

    <cffunction name="eliminarSeccion" access="remote" hint="Obtiene los aspectosSeccion de una evaluacion">
        <cfargument name="Seccion" type="numeric" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.eliminarSeccion(Seccion);
        </cfscript>
    </cffunction>

    <cffunction name="eliminarAspecto" access="remote" hint="Obtiene los aspectosSeccion de una evaluacion">
        <cfargument name="pkAspecto" type="numeric" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.eliminarAspecto(pkAspecto);            
        </cfscript>
    </cffunction>

    <cffunction name="obtenerAspecto" access="remote" hint="Obtiene los aspectos de una evaluacion">
        <cfargument name="pkSecc" required="yes" hint="">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerAspecto(pkSecc);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerEscala" access="remote" hint="Obtiene las escalas de una evaluacion">
        <cfscript>
            dao = CreateObject('component','DAO_Evaluacion');
            return dao.obtenerEscala();
        </cfscript>
    </cffunction>

</cfcomponent>