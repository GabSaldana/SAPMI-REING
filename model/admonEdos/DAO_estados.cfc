<cfcomponent> 


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la tabla con los procedimientos disponibles.
    --->
    <cffunction name="obtenerProced" hint="Obtiene procedimientos">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT   TPROC.CPR_PK_PROCEDIMIENTO PK, 
                     TPROC.CPR_NOMBRE           NOMBRE,
                     TPROC.CPR_FK_ESTADO        EDO,
                     TVER.TVE_VERTIENTE_NOMBRE  VERT
               FROM  PDIPIMP.CESCPROCEDIMIENTO TPROC,
                     PDIPIMP.CESRRUTA          RPR,
                     PDIPIMP.CESCESTADO        CER,
                     PDIPIMP.CESRESTADOACCION  REA,
                     PDIPIMP.USRRACCIONROL     RAR,
                     PDIPIMP.USRTROL           TRO,
                     PDIPIMP.USRTVERTIENTE     TVER
              WHERE  TPROC.CPR_FK_ESTADO        = 2
                AND  TPROC.CPR_PK_PROCEDIMIENTO = RPR.RPR_FK_PROCEDIMIENTO
                AND  RPR.RPR_PK_RUTA            = CER.CER_FK_RUTA
                AND  CER.CER_PK_ESTADO          = REA.REA_FK_ESTADO_RUTA
                AND  REA.REA_FK_ACCION_ROL      = RAR.RAR_PK_ACCIONROL
                AND  RAR.RAR_FK_ROL             = TRO.TRO_PK_ROL
                AND  TVER.TVE_PK_VERTIENTE      = TPROC.CPR_FK_VERTIENTE

                    <cfif NOT #ArrayFind(Session.cbstorage.grant, 'usuarios.adminRoles')#>
                        AND TRO.TRO_FK_VERTIENTE = #Session.cbstorage.usuario.VERTIENTE#
                    </cfif>

             GROUP BY TPROC.CPR_PK_PROCEDIMIENTO, TPROC.CPR_NOMBRE,  TPROC.CPR_FK_ESTADO, TVER.TVE_VERTIENTE_NOMBRE
             ORDER BY PK ASC       
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la vista principal para visualizar las rutas.
    --->
    <cffunction name="setRutas" hint="Obtiene las rutas ligadas a un procedimiento">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  TRUTA.RPR_PK_RUTA      PK, 
                    TRUTA.RPR_DESCRIPCION  NOMBRE
            FROM    PDIPIMP.CESRRUTA TRUTA
            WHERE   RPR_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
                    AND TRUTA.RPR_FK_PROCEDIMIENTO = #pkProcedimiento#
            ORDER BY NOMBRE ASC    
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la tabla con las rutas disponibles en algún procedimiento.
    ---> 
    <cffunction name="getTablaEstadosRutas" hint="Obtiene los estados pertenecientes a una ruta">
        <cfargument name="pkRuta"   type="numeric" required="yes" hint="pk de la ruta">
        <cfargument name="pkProced" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  ESTADO.CER_PK_ESTADO     PK, 
                    ESTADO.CER_NOMBRE        NOMBRE,
                    ESTADO.CER_DESCRIPCION   DESCR,
                    ESTADO.CER_NUMERO_ESTADO EDONUM,
                    CAR.CAR_NOMBRE_AREA      AREA
            FROM    PDIPIMP.CESRRUTA   TRUTA,
                    PDIPIMP.CESCESTADO ESTADO,
		    PDIPIMP.CESCAREA   CAR
            WHERE   RPR_PK_RUTA = CER_FK_RUTA             
                    AND CER_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#			
                    AND ESTADO.CER_FK_AREA = CAR_PK_AREA
                    AND TRUTA.RPR_FK_PROCEDIMIENTO = #pkProced#  
                    AND RPR_PK_RUTA = #pkRuta#
            ORDER BY PK ASC          
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    
    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que agrega un nuevo estado relacionado a una ruta
    --->    
    <cffunction name="addEstado" hint="Guarda nuevo estado relacionado a un prodedimiento">
        <cfargument name="ruta"   type="numeric" required="yes" hint="pk del procedimiento">
        <cfargument name="numero" type="numeric" required="yes" hint="Numero del estado">
        <cfargument name="nombre" type="string"  required="yes" hint="Nombre del estado">
        <cfargument name="descr"  type="string"  required="yes" hint="Descripcion del estado">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.GUARDAR_ESTADO" datasource="DS_PDIPIMP">
                <cfprocparam value="#ruta#"   cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#numero#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string"  type="in">
                <cfprocparam value="#descr#"  cfsqltype="cf_sql_string"  type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfoutput>
                    <cfreturn 0>
                </cfoutput>
            </cfcatch>
        </cftry>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la vista principal para visualizar las relaciones con que cuenta una ruta.
    --->
    <cffunction name="setRelaciones" hint="Obtiene las relaciones rol-estados">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  CEA.REA_PK_ESTADOACCION PK,
                    UTR.TRO_ROL_NOMBRE      NOMROL,
                    UTA.TAC_ACCION_NOMBRE   NOMACCION,
                    CES.CER_NOMBRE          EDOUNO,
                    CES.CER_NUMERO_ESTADO   NUMUNO,
                    CESD.CER_NOMBRE         EDODOS,
                    CESD.CER_NUMERO_ESTADO  NUMDOS
            FROM    PDIPIMP.USRTACCION         UTA,
                    PDIPIMP.USRTROL            UTR,
                    PDIPIMP.USRRACCIONROL      USA,
                    PDIPIMP.CESRESTADOACCION   CEA,
                    PDIPIMP.CESCESTADO         CES,
                    PDIPIMP.CESCESTADO         CESD
            WHERE   RAR_FK_ROL = TRO_PK_ROL
                    AND RAR_FK_ACCION = TAC_PK_ACCION
                    AND REA_FK_ESTADO_RUTA = CES.CER_PK_ESTADO
                    AND REA_FK_CAMBIO_ESTADO = CESD.CER_PK_ESTADO
                    AND REA_FK_ACCION_ROL = RAR_PK_ACCIONROL
                    AND REA_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
                    AND CESD.CER_FK_RUTA = #pkRuta#
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los roles disponibles en el sistema
    --->
    <cffunction name="getRoles" hint="Obtiene los roles del sistema">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  TROL.TRO_PK_ROL      PK, 
                    TROL.TRO_ROL_NOMBRE  NOMBRE
            FROM    PDIPIMP.USRTROL TROL
            WHERE   TRO_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            ORDER BY NOMBRE ASC          
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene estados con que cuenta una ruta.
    --->
    <cffunction name="getEstados" hint="Obtiene estados pertenecientes a una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  CEDO.CER_PK_ESTADO       PK, 
                    CEDO.CER_NOMBRE          NOMBRE,
                    CEDO.CER_NUMERO_ESTADO   NUM
            FROM    PDIPIMP.CESCESTADO CEDO
            WHERE   CER_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
                    AND CER_FK_RUTA = #pkRuta#
            ORDER BY PK ASC          
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene las acciones que puede realizar algún rol.
    --->
    <cffunction name="getAcciones" hint="Obtiene las acciones del sistema">
        <cfargument name="pkRol"    type="numeric" required="yes" hint="pk del rol">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  RAR.RAR_PK_ACCIONROL     PK,
                    TAC.TAC_ACCION_NOMBRE    NOMBRE,
                    TMO.TMO_MODULO_NOMBRE    MODULO
            FROM    PDIPIMP.USRRACCIONROL RAR,
                    PDIPIMP.USRTACCION    TAC,
                    PDIPIMP.USRTMODULO    TMO
            WHERE   RAR.RAR_FK_ACCION     = TAC.TAC_PK_ACCION
                    AND TAC.TAC_FK_MODULO = TMO.TMO_PK_MODULO
                    AND RAR.RAR_FK_ROL    = #pkRol#
            ORDER BY MODULO ASC
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Agrega una nueva relacion entre el rol-acción, y establece sus estados.
    --->
    <cffunction name="addEdoAccion" hint="Guarda la relacion entre los estados y el rol">
        <cfargument name="accionRol" type="numeric" required="yes" hint="pk de la accion-Rol">
        <cfargument name="edoAct"    type="numeric" required="yes" hint="Estado inicial">
        <cfargument name="edoSig"    type="numeric" required="yes" hint="Estado final">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.GUARDAR_EDO_ACCION" datasource="DS_PDIPIMP">
                <cfprocparam value="#accionRol#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#edoAct#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#edoSig#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de la relación accion-rol.
    --->
    <cffunction name="cambiarEdoRel" hint="Cambia el estado de las relaciones">
        <cfargument name="pkRel" type="numeric" required="yes" hint="pk de la relacion">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.CAMBIA_EDO_RELACION" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkRel#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los procedimientos con que cuenta el sistema.
    --->
    <cffunction name="getProced" hint="Obtiene las operaciones relacionadas de un procedimiento">
        <cfargument name="pkProced" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  COP.OPR_PK_OPERACION PK, 
                    COP.OPR_NOMBRE       NOMBRE
            FROM    PDIPIMP.CESTOPERACION COP
            WHERE   OPR_FK_ESTADO > #application.SIE_CTES.ESTADO.CANCELADO#
                    AND OPR_FK_PROCEDIMIENTO = #pkRuta#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los tipos de las operaciones.
    --->
    <cffunction name="getTipoOper" hint="Obtiene el tipo de las operaciones">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  CTOP.TOP_PK_TIPOOPERACION  PK, 
                    CTOP.TOP_NOMBRE            NOMBRE
            FROM    PDIPIMP.CESCTIPOOPERACION CTOP
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene las operaciones que se pueden realizar al ejecutar una acción.
    --->
    <cffunction name="setTablaAccOpe" hint="Obtiene tabla de operaciones">
        <cfargument name="pkRelacion" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  OAC.OAC_PK_OPERACIONACCION  PK,
                    TOP.OPR_NOMBRE              OPERACION,
                    TIP.TOP_NOMBRE              TIPO
            FROM    PDIPIMP.CESROPERACIONACCION  OAC,
                    PDIPIMP.CESTOPERACION        TOP,
                    PDIPIMP.CESCTIPOOPERACION    TIP
            WHERE   OAC.OAC_FK_OPERACION = TOP.OPR_PK_OPERACION
                    AND OAC.OAC_FK_TIPOOPERACION = TIP.TOP_PK_TIPOOPERACION
                    AND OAC.OAC_FK_ESTADO > #application.SIE_CTES.ESTADO.CANCELADO#
                    AND OAC.OAC_FK_ESTADOACCION = #pkRelacion#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que relaciona operaciones con alguna acción.
    ---> 
    <cffunction name="relacionaAccionOperacion" hint="Relaciona operaciones y acciones">
        <cfargument name="pkOperacion" type="numeric" required="yes" hint="pk del procedimiento">
        <cfargument name="pkTipoOper"  type="numeric" required="yes" hint="Numero del estado">
        <cfargument name="pkRelacion"  type="numeric" required="yes" hint="Nombre del estado">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.RELACIONA_ACCION_OPERACION" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkOperacion#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkTipoOper#"  cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkRelacion#"  cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de la relación acción-operación.
    --->
    <cffunction name="cambiarEdoOper" hint="Cambia estado de la relacion operacion accion">
        <cfargument name="pkOper" type="numeric" required="yes" hint="pk de la relacion">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.CAMBIA_EDO_OPERACION" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkOper#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de un estado.
    --->
    <cffunction name="eliminaEstado" hint="Cambia estado de un estado">
        <cfargument name="pkEstado" type="numeric" required="yes" hint="pk del estado">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.CAMBIA_EDO_ESTADO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkEstado#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>


<!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="setTablaOpe" hint="Obtiene las operaciones para la tabla de procedimientos">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk de la operacion">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                TOP.OPR_PK_OPERACION PK,
                TOP.OPR_NOMBRE NOMBRE,
                TOP.OPR_DESCRIPCION DESCRIPCION,
                TOP.OPR_FK_ESTADO EDO
            FROM
                PDIPIMP.CESTOPERACION TOP
            WHERE
                TOP.OPR_FK_PROCEDIMIENTO = #pkProcedimiento#
                AND TOP.OPR_FK_ESTADO > #application.SIE_CTES.ESTADO.CANCELADO#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="addOperacion" hint="Guarda la operacion">
        <cfargument name="oper" type="string"  required="yes" hint="Nombre de la operacion">
        <cfargument name="desc"  type="string"  required="yes" hint="Descripcion de la operacion">
        <cfargument name="proced" type="numeric" required="yes" hint="Procedimento">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.GUARDAR_OPERACION" datasource="DS_PDIPIMP">
                <cfprocparam value="#oper#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#proced#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="addRuta" hint="Guarda la ruta">
        <cfargument name="ruta" type="string"  required="yes" hint="Nombre de la ruta">
        <cfargument name="proced" type="numeric" required="yes" hint="Procedimento">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.GUARDAR_RUTA" datasource="DS_PDIPIMP">
                <cfprocparam value="#ruta#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#proced#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="cambiarEdoRuta" hint="Cambia el estado de las rutas">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ESTADOS.CAMBIA_EDO_RUTA" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkRuta#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <!---
    * Fecha: Julio de 2017
    * @author Roberto Cadena
    --->
    <cffunction name="getDependencias" hint="Cambia el estado de las rutas">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                CAR.CAR_PK_AREA     PK_UR,
                CAR.CAR_NOMBRE_AREA NOMBRE_UR
            FROM
                CESCAREA CAR
            ORDER BY NOMBRE_UR ASC
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>


</cfcomponent>