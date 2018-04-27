<cfcomponent>

    <cfscript>

        this.ESTADO                                         = structNew();
        this.ESTADO.CANCELADO                               = 0;
        this.ESTADO.EDICION                                 = 1;
        this.ESTADO.VALIDADO                                = 2;
        this.ESTADO.OBSOLETO                                = 3;
        this.ESTADO.AUTORIZADO                              = 4;
        this.ESTADO.EVALUADO                                = 5;
        this.ESTADO.APROBADO                                = 36;
        this.ESTADO.RECHAZADO                               = 127;
        this.ESTADO.PV4                                     = 37;
        this.ESTADO.DOCUMENTOELIMINADO                      = 193;
        this.ESTADO.SOLICITUDCAPTURA                        = 209;
        this.ESTADO.SOLICITUDENVIADASIP                     = 211;
        this.ESTADO.APLICO_RI							    = 290;
        this.ESTADO.SOLICITUD_ATENDIDA                      = 289;

        /*********************************SAPMI*******************************************/
        this.ESTADO.ELIMINADO                               = 315;
        this.ESTADO.CAPTURA                                 = 319;
        this.ESTADO.VALIDADO_POR_RESPONSABLE                = 320;
        this.ESTADO.VALIDADO_POR_LA_DIRECCION               = 322;
        /****************************************************************************/

        this.FUNCIONPRUEBA                                  = structNew();
        this.FUNCIONPRUEBA.V_EDO                            = 'VERIFICAR_ESTADO';
        this.FUNCIONPRUEBA.V_DIR                            = 'VERIFICAR_DIRECTOR';
        this.FUNCIONPRUEBA.V_SDIR                           = 'VERIFICAR_SUBDIRECTOR';
        this.FUNCIONPRUEBA.V_ANA                            = 'VERIFICAR_ANALISTA';
        this.FUNCIONPRUEBA.M_CORR                           = 'MANDAR_CORREO_CA';
        this.FUNCIONPRUEBA.TERMNA_EVAL                      = 'TERMINA_EVALUACION';
        this.FUNCIONPRUEBA.MANTIENE_RESIDENCIA              = 'MANTIENE_RESIDENCIA';

        this.TIPOOPERACION                                  = structNew();
        this.TIPOOPERACION.PRE                            	= 1;
        this.TIPOOPERACION.POS                            	= 2;

        this.CORREOS                                        = structNew();
        this.CORREOS.CUENTA_INVESTIGADOR                    = 1;
        this.CORREOS.RECH_CONVENIO                          = 2;
        this.CORREOS.RECORDATORIO_VOTACION                  = 3;
        this.CORREOS.AVISO_EMISION_VOTOS                    = 4;
        this.CORREOS.CONTRASENA                             = 5;
        this.CORREOS.EVALUACIONESPENDIENTES                 = 11;
        this.CORREOS.PKADMIN								= 6581;

        this.PROCEDIMIENTO                                  = structNew();
        this.PROCEDIMIENTO.CONFIGURACION_FORMATOS           = 1;
        this.PROCEDIMIENTO.CAPTURA_FORMATOS                 = 2;
        this.PROCEDIMIENTO.CONVENIOS                        = 28;
        this.PROCEDIMIENTO.DOCUMENTOS                       = 42;
        this.PROCEDIMIENTO.EVAL_EDI                         = 85;
        this.PROCEDIMIENTO.SOLI_EDI                         = 86;        
        this.PROCEDIMIENTO.EVAL_ESCOLARIDAD                 = 105;
        this.PROCEDIMIENTO.EVALUACION_INDICADORES           = 115;

        this.TABLA_CAMBIO                                   = structNew();
        this.TABLA_CAMBIO.TABLA_DOC                         = 'DOCTARCHIVOS';
        this.TABLA_CAMBIO.COLUMNA_DOC                       = 'TAR_FK_ESTADO';
        this.TABLA_CAMBIO.TABLA_CONV                        = 'DOCTARCHIVOS';
        this.TABLA_CAMBIO.COLUMNA_CONV                      = 'TAR_FK_ESTADO';

        this.TIPOCOMENTARIO                                 = structNew();
        this.TIPOCOMENTARIO.TODOS                           = 0;
        this.TIPOCOMENTARIO.CONVENIO                        = 7;
        this.TIPOCOMENTARIO.DOCUMENTO                       = 27;

        this.FORMATO                                        = structNew();
        this.FORMATO.VALIDADO                               = 6;

        this.RUTA                                           = structNew();
        this.RUTA.CAPTURA_FORMATOS.R_GRAL                   = 2;
        this.RUTA.EVALUACIONEDI                             = 65;

        this.ACCION                                         = structNew();
        this.ACCION.ASOCIACION_FORMATOS                     = 106;


        // Roles de Usuario
        this.FILTRO_ROLES                                   = arrayNew(1);
        //ADMSIS
        this.ADMSIS                                         = 3;

        // SISEMEC
        // Facilitador SISEMEC
        arrayAppend(this.FILTRO_ROLES, 38);
        // Participante SISEMEC
        arrayAppend(this.FILTRO_ROLES, 39);
        // Responsable UPDCE
        arrayAppend(this.FILTRO_ROLES, 40);
        // Auxiliar UPDCE            
        arrayAppend(this.FILTRO_ROLES, 41);

        // SICREO
        // Facilitador SICREO
        arrayAppend(this.FILTRO_ROLES, 17);        
        // Participante SICREO
        arrayAppend(this.FILTRO_ROLES, 18);        

        // CONVINV
        this.ROLES                                          = structNew();
        this.ROLES.ANALISTADINV                             = 42;
        this.ROLES.TITULARDINV                              = 43;
        this.ROLES.SECRETARIOIP                             = 44;
        this.ROLES.ANALISTADEP                              = 45;
        this.ROLES.RESPONSABLEDEP                           = 46;
        this.ROLES.TITULARDEP                               = 48;
        this.ROLES.ANALISTADNCD                             = 50;
        this.ROLES.RESPONSABLEDNCD                          = 51;
        this.ROLES.ADMSIS                                   = 3;
        //EDI
        this.ROLES.INV_EVA                                  = 182;
        this.ROLES.INV_CVU                                  = 62;
        this.ROLES.EDI_EVA                                  = 82;

        //TREQUISITOS
        this.TREQUISITO.ART9                                = 1;
        this.TREQUISITO.ART11SECIX                          = 10;
        this.TREQUISITO.ART11SECVII                         = 8;
        this.TREQUISITO.ART11SECI                           = 83;
        this.TREQUISITO.ART11SECI2                          = 101;
        this.TREQUISITO.ART11SECII                          = 3;
        this.TREQUISITO.ART11SECVI                          = 7;
        this.TREQUISITO.ART11SECVIII                        = 121;
        this.TREQUISITO.ART11SECIV                          = 141;        
        this.TREQUISITO.ART11SECIV2                         = 142;
        this.TREQUISITO.ART11SECIV3                         = 143;
        this.TREQUISITO.ART11SECIV4                         = 144;
        this.TREQUISITO.ART16                               = 19;
        this.TREQUISITO.ART16SEC1                           = 34;

        //Productos
        this.CPRODUCTO.ACTDOCENTE                           = 15;
        this.CPRODUCTO.PROYINVES                            = 126;

        //escolaridad
        this.CESCOLARIDAD.PKMAESTRIA                        = 1;
        this.CESCOLARIDAD.PKDOCTORADO                       = 2;

        this.TIPOEVALUACION.SIP                             = 1;
        this.TIPOEVALUACION.CE                              = 2;
        this.TIPOEVALUACION.CA                              = 3;
        this.TIPOEVALUACION.RI                              = 4;
        this.TIPOEVALUACION.FINAL                           = 24;
        
        this.EMAIL.ENCARGADOPROCESO                         = 'mgalaz@ipn.mx';


        //MOVIMIENTOS
        this.MOVIMIENTO.MANTIENE_RESIDENCIA                 = 21;
        this.MOVIMIENTO.REINGRESO_RESIDENCIA                = 41;
        this.MOVIMIENTO.INGRESO_RESIDENCIA                  = 4;
        this.MOVIMIENTO.ANIO_GRACIA                         = 3;

		//TIPOS DE SOLICITUD
		this.TIPOSOLICITUD.ANIO_GRACIA						= 11;
		this.TIPOSOLICITUD.DISPENSA							= 12;

		//NIVELES EDI
		this.NIVEL.CERO 									= 21;

        //DICTAMEN EDI
        this.DIRECTOR_NOMBRE                                 = 'DRA. LAURA ARREOLA MENDOZA';
        this.DIRECTOR_GENERO                                 =  2;
        this.DIRECTOR_INICIALES                              = 'LAM/MGL/cmg';
        


        return this;
    </cfscript>

</cfcomponent>