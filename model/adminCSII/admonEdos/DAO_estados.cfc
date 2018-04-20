<cfcomponent> 


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la tabla con los procedimientos disponibles.
    --->
    <cffunction name="obtenerProced" hint="Obtiene procedimientos">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  TPROC.CPR_PK_PROCEDIMIENTO PK, 
                    TPROC.CPR_NOMBRE           NOMBRE,
                    TPROC.CPR_FK_ESTADO        EDO,
                    TVER.TVE_VERTIENTE_NOMBRE  VERT
              FROM  GRAL.CESCPROCEDIMIENTO TPROC,
                    GRAL.USRTVERTIENTE     TVER
             WHERE  TPROC.CPR_FK_ESTADO        = 2
               AND  TVER.TVE_PK_VERTIENTE      = TPROC.CPR_FK_VERTIENTE                 

                <cfif NOT #ArrayFind(Session.cbstorage.grant, 'usuarios.adminRoles')#>
                    AND TPROC.CPR_FK_VERTIENTE = #Session.cbstorage.usuario.VERTIENTE#
                </cfif>        

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
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  TRUTA.RPR_PK_RUTA      PK, 
                    TRUTA.RPR_DESCRIPCION  NOMBRE
            FROM    GRAL.CESRRUTA TRUTA
            WHERE   TRUTA.RPR_FK_ESTADO = 2
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
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  ESTADO.CER_PK_ESTADO     PK, 
                    ESTADO.CER_NOMBRE        NOMBRE,
                    ESTADO.CER_DESCRIPCION   DESCR,
                    ESTADO.CER_NUMERO_ESTADO EDONUM,
                    CAR.CAR_NOMBRE_AREA      AREA
            FROM    GRAL.CESRRUTA   TRUTA,
                    GRAL.CESCESTADO ESTADO,
                    GRAL.CESCAREA   CAR
            WHERE   RPR_PK_RUTA = CER_FK_RUTA 
                    AND ESTADO.CER_FK_AREA = CAR_PK_AREA
                    AND CER_FK_ESTADO = 2
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
        <cfargument name="area"   type="numeric"  required="yes" hint="Area perteneciente">
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.GUARDAR_ESTADO" datasource="DS_GRAL">
                <cfprocparam value="#ruta#"   cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#numero#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string"  type="in">
                <cfprocparam value="#descr#"  cfsqltype="cf_sql_string"  type="in">
                <cfprocparam value="#area#"  cfsqltype="cf_sql_numeric"  type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene la vista principal para visualizar las relaciones con que cuenta una ruta.
    --->
    <cffunction name="setRelaciones" hint="Obtiene las relaciones rol-estados">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  CEA.REA_PK_ESTADOACCION PK,
                    UTR.TRO_ROL_NOMBRE      NOMROL,
                    UTA.TAC_ACCION_NOMBRE   NOMACCION,
                    CES.CER_NOMBRE          EDOUNO,
                    CES.CER_NUMERO_ESTADO   NUMUNO,
                    CESD.CER_NOMBRE         EDODOS,
                    CESD.CER_NUMERO_ESTADO  NUMDOS
            FROM    GRAL.USRTACCION         UTA,
                    GRAL.USRTROL            UTR,
                    GRAL.USRRACCIONROL      USA,
                    GRAL.CESRESTADOACCION   CEA,
                    GRAL.CESCESTADO         CES,
                    GRAL.CESCESTADO         CESD
            WHERE   RAR_FK_ROL = TRO_PK_ROL
                    AND RAR_FK_ACCION = TAC_PK_ACCION
                    AND REA_FK_ESTADO_RUTA = CES.CER_PK_ESTADO
                    AND REA_FK_CAMBIO_ESTADO = CESD.CER_PK_ESTADO
                    AND REA_FK_ACCION_ROL = RAR_PK_ACCIONROL
                    AND REA_FK_ESTADO = 2
                    AND CESD.CER_FK_RUTA = #pkRuta#
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="setRelacionesFiltros" hint="Obtiene las relaciones rol-estados con filtros">
        <cfargument name="pkRuta"   type="numeric"  required="yes" hint="pk de la ruta">
        <cfargument name="roles"    type="array"    required="yes" hint="roles">
        <cfargument name="acciones" type="array"    required="yes" hint="acciones">
        <cfargument name="estados"  type="array"    required="yes" hint="estados">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  CEA.REA_PK_ESTADOACCION PK,
                    UTR.TRO_ROL_NOMBRE      NOMROL,
                    UTA.TAC_ACCION_NOMBRE   NOMACCION,
                    CES.CER_NOMBRE          EDOUNO,
                    CES.CER_NUMERO_ESTADO   NUMUNO,
                    CESD.CER_NOMBRE         EDODOS,
                    CESD.CER_NUMERO_ESTADO  NUMDOS
            FROM    GRAL.USRTACCION         UTA,
                    GRAL.USRTROL            UTR,
                    GRAL.USRRACCIONROL      USA,
                    GRAL.CESRESTADOACCION   CEA,
                    GRAL.CESCESTADO         CES,
                    GRAL.CESCESTADO         CESD
            WHERE   RAR_FK_ROL = TRO_PK_ROL
            AND     RAR_FK_ACCION = TAC_PK_ACCION
            AND     REA_FK_ESTADO_RUTA = CES.CER_PK_ESTADO
            AND     REA_FK_CAMBIO_ESTADO = CESD.CER_PK_ESTADO
            AND     REA_FK_ACCION_ROL = RAR_PK_ACCIONROL
            AND     REA_FK_ESTADO = 2
            AND     CESD.CER_FK_RUTA = <cfqueryparam value="#arguments.pkRuta#" cfsqltype="cf_sql_numeric">

            <cfif roles[1] neq 0>
                AND(
                <cfloop index = "i" from="1" to="#arrayLen(roles)#">
                <cfif i neq 1>
                 OR 
                </cfif>
                UTR.TRO_PK_ROL = <cfqueryparam value="#arguments.roles[i]#" cfsqltype="cf_sql_numeric">
                </cfloop>
                )
            </cfif>

            <cfif acciones[1] neq 0>
                AND(
                <cfloop index = "i" from="1" to="#arrayLen(acciones)#">
                <cfif i neq 1>
                 OR 
                </cfif>
                UTA.TAC_PK_ACCION = <cfqueryparam value="#arguments.acciones[i]#" cfsqltype="cf_sql_numeric">
                </cfloop>
                )
            </cfif>

            AND CESD.CER_NUMERO_ESTADO BETWEEN <cfqueryparam value="#arguments.estados[1]#" cfsqltype="cf_sql_numeric">
                AND <cfqueryparam value="#arguments.estados[2]#" cfsqltype="cf_sql_numeric">

        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los roles disponibles en el sistema
    --->
    <cffunction name="getRoles" hint="Obtiene los roles del sistema">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  TROL.TRO_PK_ROL      PK, 
                    TROL.TRO_ROL_NOMBRE  NOMBRE
            FROM    GRAL.USRTROL TROL
            WHERE   TRO_FK_ESTADO = 2
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
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  CEDO.CER_PK_ESTADO       PK, 
                    CEDO.CER_NOMBRE          NOMBRE,
                    CEDO.CER_NUMERO_ESTADO   NUM
            FROM    GRAL.CESCESTADO CEDO
            WHERE   CER_FK_ESTADO = 2
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
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  RAR.RAR_PK_ACCIONROL     PK,
                    TAC.TAC_ACCION_NOMBRE    NOMBRE,
                    TMO.TMO_MODULO_NOMBRE    MODULO
            FROM    GRAL.USRRACCIONROL RAR,
                    GRAL.USRTACCION    TAC,
                    GRAL.USRTMODULO    TMO
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
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.GUARDAR_EDO_ACCION" datasource="DS_GRAL">
                <cfprocparam value="#accionRol#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#edoAct#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#edoSig#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
   </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de la relación accion-rol.
    --->
    <cffunction name="cambiarEdoRel" hint="Cambia el estado de las relaciones">
        <cfargument name="pkRel" type="numeric" required="yes" hint="pk de la relacion">
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.CAMBIA_EDO_RELACION" datasource="DS_GRAL">
                <cfprocparam value="#pkRel#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los procedimientos con que cuenta el sistema.
    --->
    <cffunction name="getProced" hint="Obtiene las operaciones relacionadas de un procedimiento">
        <cfargument name="pkProced" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  COP.OPR_PK_OPERACION PK, 
                    COP.OPR_NOMBRE       NOMBRE
            FROM    GRAL.CESTOPERACION COP
            WHERE   OPR_FK_ESTADO > 0
                    AND OPR_FK_PROCEDIMIENTO = #pkProced#
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
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  CTOP.TOP_PK_TIPOOPERACION  PK, 
                    CTOP.TOP_NOMBRE            NOMBRE
            FROM    GRAL.CESCTIPOOPERACION CTOP
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
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  OAC.OAC_PK_OPERACIONACCION  PK,
                    TOP.OPR_NOMBRE              OPERACION,
                    TIP.TOP_NOMBRE              TIPO
            FROM    GRAL.CESROPERACIONACCION  OAC,
                    GRAL.CESTOPERACION        TOP,
                    GRAL.CESCTIPOOPERACION    TIP
            WHERE   OAC.OAC_FK_OPERACION = TOP.OPR_PK_OPERACION
                    AND OAC.OAC_FK_TIPOOPERACION = TIP.TOP_PK_TIPOOPERACION
                    AND OAC.OAC_FK_ESTADO > 0 
                    AND OAC.OAC_FK_ESTADOACCION = #pkRelacion#
                    AND OPR_FK_ESTADO = 2
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
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.RELACIONA_ACCION_OPERACION" datasource="DS_GRAL">
                <cfprocparam value="#pkOperacion#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkTipoOper#"  cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkRelacion#"  cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de la relación acción-operación.
    --->
    <cffunction name="cambiarEdoOper" hint="Cambia estado de la relacion operacion accion">
        <cfargument name="pkOper" type="numeric" required="yes" hint="pk de la relacion">
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.CAMBIA_EDO_OPERACION" datasource="DS_GRAL">
                <cfprocparam value="#pkOper#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado de un estado.
    --->
    <cffunction name="eliminaEstado" hint="Cambia estado de un estado">
        <cfargument name="pkEstado" type="numeric" required="yes" hint="pk del estado">
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.CAMBIA_EDO_ESTADO" datasource="DS_GRAL">
                <cfprocparam value="#pkEstado#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


<!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    <cffunction name="setTablaOpe" hint="Obtiene las operaciones para la tabla de procedimientos">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="pk de la operacion">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT
                TOP.OPR_PK_OPERACION PK,
                TOP.OPR_NOMBRE NOMBRE,
                TOP.OPR_DESCRIPCION DESCRIPCION,
                TOP.OPR_FK_ESTADO EDO
            FROM
                GRAL.CESTOPERACION TOP
            WHERE
                TOP.OPR_FK_PROCEDIMIENTO = #pkProcedimiento#
                AND TOP.OPR_FK_ESTADO > 0
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
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.GUARDAR_OPERACION" datasource="DS_GRAL">
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
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.GUARDAR_RUTA" datasource="DS_GRAL">
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
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.CAMBIA_EDO_RUTA" datasource="DS_GRAL">
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
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getDependencias" hint="Cambia el estado de las rutas">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT
                CAR.CAR_PK_AREA     PK_UR,
                CAR.CAR_NOMBRE_AREA NOMBRE_UR
            FROM
                GRAL.CESCAREA CAR
            ORDER BY NOMBRE_UR ASC
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getOperaciones" hint="Cambia el estado de las rutas">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  REA.REA_PK_ESTADOACCION     AS PK,
                    OPR.OPR_PK_OPERACION        AS PKOPERACION,
                    OPR.OPR_NOMBRE              AS NOMBREOPERACION,
                    OPR.OPR_DESCRIPCION         AS DESCRIPCIONOPERACION,
                    TOP.TOP_PK_TIPOOPERACION    AS PKTIPOOPERACION,
                    TOP.TOP_NOMBRE              AS TIPOOPERACION
            FROM    CESTOPERACION       OPR,
                    CESROPERACIONACCION OAC,
                    CESCTIPOOPERACION   TOP,
                    CESRESTADOACCION    REA,
                    CESCESTADO          CER
            WHERE   OAC.OAC_FK_OPERACION = OPR.OPR_PK_OPERACION
            AND     TOP.TOP_PK_TIPOOPERACION = OAC.OAC_FK_TIPOOPERACION
            AND     REA.REA_PK_ESTADOACCION = OAC.OAC_FK_ESTADOACCION
            AND     CER.CER_PK_ESTADO = REA.REA_FK_ESTADO_RUTA
            AND     CER.CER_FK_RUTA = <cfqueryparam value="#arguments.pkRuta#" cfsqltype="cf_sql_numeric">
            AND     REA.REA_FK_ESTADO = 2
            AND     OPR.OPR_FK_ESTADO = 2
            ORDER BY OPR.OPR_PK_OPERACION
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getSelectOperaciones" hint="Cambia el estado de las rutas">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  OPR.OPR_PK_OPERACION        AS PKOPERACION
            FROM    CESTOPERACION       OPR,
                    CESROPERACIONACCION OAC,
                    CESCTIPOOPERACION   TOP,
                    CESRESTADOACCION    REA,
                    CESCESTADO          CER
            WHERE   OAC.OAC_FK_OPERACION = OPR.OPR_PK_OPERACION
            AND     TOP.TOP_PK_TIPOOPERACION = OAC.OAC_FK_TIPOOPERACION
            AND     REA.REA_PK_ESTADOACCION = OAC.OAC_FK_ESTADOACCION
            AND     CER.CER_PK_ESTADO = REA.REA_FK_ESTADO_RUTA
            AND     CER.CER_FK_RUTA = <cfqueryparam value="#arguments.pkRuta#" cfsqltype="cf_sql_numeric">
            AND     REA.REA_FK_ESTADO = 2
            AND     OPR.OPR_FK_ESTADO = 2
            GROUP BY OPR.OPR_PK_OPERACION
            ORDER BY OPR.OPR_PK_OPERACION
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getAllAcciones" hint="Obtiene las acciones de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  UTA.TAC_PK_ACCION       PK,
                    UTA.TAC_ACCION_NOMBRE   NOMACCION
            FROM    GRAL.USRTACCION         UTA,
                    GRAL.USRTROL            UTR,
                    GRAL.USRRACCIONROL      USA,
                    GRAL.CESRESTADOACCION   CEA,
                    GRAL.CESCESTADO         CES,
                    GRAL.CESCESTADO         CESD
            WHERE   RAR_FK_ROL = TRO_PK_ROL
                    AND RAR_FK_ACCION = TAC_PK_ACCION
                    AND REA_FK_ESTADO_RUTA = CES.CER_PK_ESTADO
                    AND REA_FK_CAMBIO_ESTADO = CESD.CER_PK_ESTADO
                    AND REA_FK_ACCION_ROL = RAR_PK_ACCIONROL
                    AND REA_FK_ESTADO = 2
                    AND CESD.CER_FK_RUTA = <cfqueryparam value="#arguments.pkRuta#" cfsqltype="cf_sql_numeric">
            GROUP BY TAC_PK_ACCION, TAC_ACCION_NOMBRE
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getAllEstados" hint="Obtiene los estados de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  CER.CER_PK_ESTADO       AS PK,
                    CER.CER_NUMERO_ESTADO   AS NUMEDO
            FROM    CESCESTADO  CER
            WHERE   CER.CER_FK_RUTA = <cfqueryparam value="#arguments.pkRuta#" cfsqltype="cf_sql_numeric">
            AND     CER.CER_FK_ESTADO = 2
            ORDER BY CER_NUMERO_ESTADO
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>

    <!---
    * Fecha:    Septiembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getAllRoles" hint="Obtiene los roles de una ruta">
        <cfargument name="pkRuta" type="numeric" required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  UTR.TRO_PK_ROL          PK,
                    UTR.TRO_ROL_NOMBRE      NOMROL
            FROM    GRAL.USRTACCION         UTA,
                    GRAL.USRTROL            UTR,
                    GRAL.USRRACCIONROL      USA,
                    GRAL.CESRESTADOACCION   CEA,
                    GRAL.CESCESTADO         CES,
                    GRAL.CESCESTADO         CESD
            WHERE   RAR_FK_ROL = TRO_PK_ROL
                    AND RAR_FK_ACCION = TAC_PK_ACCION
                    AND REA_FK_ESTADO_RUTA = CES.CER_PK_ESTADO
                    AND REA_FK_CAMBIO_ESTADO = CESD.CER_PK_ESTADO
                    AND REA_FK_ACCION_ROL = RAR_PK_ACCIONROL
                    AND REA_FK_ESTADO = 2
                    AND CESD.CER_FK_RUTA = <cfqueryparam value="#arguments.pkRuta#" cfsqltype="cf_sql_numeric">
            GROUP BY TRO_PK_ROL, TRO_ROL_NOMBRE
        </cfquery>
        <cfreturn qUsuarios> 
    </cffunction>

</cfcomponent>