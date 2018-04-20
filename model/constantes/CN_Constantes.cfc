<cfcomponent>

    <cfscript>

        DAO = CreateObject('component','DAO_Constantes');

        this.ESTADO                                         = structNew();
        this.ESTADO.CANCELADO                               = 0;
        this.ESTADO.EDICION                                 = 1;
        this.ESTADO.VALIDADO                                = 2;
        this.ESTADO.OBSOLETO                                = 3;
        this.ESTADO.AUTORIZADO                              = 4;
        this.ESTADO.EVALUADO                                = 5;
        
        this.FUNCIONPRUEBA                                  = structNew();
        this.FUNCIONPRUEBA.V_EDO                            = 'VERIFICAR_ESTADO';
        this.FUNCIONPRUEBA.V_DIR                            = 'VERIFICAR_DIRECTOR';
        this.FUNCIONPRUEBA.V_SDIR                           = 'VERIFICAR_SUBDIRECTOR';
        this.FUNCIONPRUEBA.V_ANA                            = 'VERIFICAR_ANALISTA';

        this.TIPOOPERACION                                  = structNew();
        this.TIPOOPERACION.PRE                            	= 1;
        this.TIPOOPERACION.POS                            	= 2;

        this.TIPOCOMENTARIO                                 = structNew();
        this.TIPOCOMENTARIO.TODOS                           = 0;
        this.TIPOCOMENTARIO.CAMBIO_ESTADO                   = 1;
        this.TIPOCOMENTARIO.ALTA_FACILITADOR                = 2;

        this.PROCEDIMIENTO                                  = structNew();
        this.PROCEDIMIENTO.CONFIGURACION_FORMATOS           = 1;
        this.PROCEDIMIENTO.CAPTURA_FORMATOS                 = 2;
	
	    this.RUTA                                           = structNew();
        this.RUTA.CONFIGURACION_FORMATOS.R_GRAL             = 1;
        this.RUTA.CAPTURA_FORMATOS.R_GRAL                   = 2;

        this.CORREOS                                        = structNew();
        this.CORREOS.DESACTIVACION_CUENTA                   = 1;
        this.CORREOS.RECUPERACION_CUENTA                    = 2;
        this.CORREOS.VALIDACION_FORMATO                     = 3;
        this.CORREOS.RECHAZO_FORMATO                        = 4;
        this.CORREOS.CREACION_USUARIO                       = 21;

        this.ACCION                                         = structNew();
        this.ACCION.ASOCIACION_FORMATOS                     = 106;

        this.FORMATO                                        = structNew();
        this.FORMATO.VALIDADO                               = 6;

        this.ROLES                                          = structNew();
        rolesDelSistema = DAO.obtenerRoles();
        for( i = 1; i lte rolesDelSistema.recordCount; i++){
            if( Not StructKeyExists(this.ROLES, rolesDelSistema.NOMBRE[i])){
                StructInsert(this.ROLES, rolesDelSistema.NOMBRE[i], rolesDelSistema.PK[i]);
            }
        }

        return this;
    </cfscript>

</cfcomponent>