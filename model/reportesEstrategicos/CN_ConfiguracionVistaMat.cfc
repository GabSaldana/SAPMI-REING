<!---
* =====================================================================================
* IPN - CSII
* Sistema: SII 
* Modulo: Principal
* Sub modulo: Pruebas
* Fecha: 10 de diciembre de 2015
* Descripcion: Componente de negocio para la configuración de reportes estrátegicos.
* =====================================================================================
--->

<cfcomponent>
    <cfprocessingdirective pageEncoding="utf-8">

    <!---
    * Fecha creacion: 11 de diciembre de 2015
    * @author Yareli Licet Andrade Jimenez
    --->        
    <cffunction name="agregarConfiguracion" access="remote" hint="Guarda nuevo registro de configuracion de reportes estrategicos">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la configuracion">
        <cfargument name="descripcion" type="string" required="no" hint="Descripcion de la configuracion">
        <cfargument name="configuracion" type="string" required="yes" hint="JSON de la configuracion">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.agregarConfiguracion(usuario, conjunto, nombre, descripcion, configuracion);
        </cfscript>
    </cffunction>

    <!---
    * Fecha creacion: 14 de diciembre de 2015
    * @author Yareli Licet Andrade Jimenez
    --->  
    <cffunction name="obtenerConfiguracion"access="remote" hint="Obtiene las configuraciones disponibles para un conjunto de datos especifico">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.obtenerConfiguracion(usuario, conjunto);
        </cfscript>
    </cffunction> 

    <!---
    * Fecha creacion: 14 de diciembre de 2015
    * @author Yareli Licet Andrade Jimenez
    --->    
    <cffunction name="cargarCongiguracion" access="remote" hint="Consulta los parametros de una configuracion definida">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfargument name="configuracion" type="numeric" required="yes" hint="Clave de la configuracion">
        <cfscript>
            prc.num = "12";
        
            dao = CreateObject('component','DAO_ConfiguracionVistaMat'); 
            return dao.cargarCongiguracion(usuario, conjunto, configuracion);
        </cfscript>
    </cffunction> 

    <!---   
    * Fecha creacion: 26 de enero de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="eliminarReporte" access="remote" hint="Elimina el reporte estrategico seleccionado">
        <cfargument name="reporte" type="numeric" required="yes" hint="Clave del reporte estrategico">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.eliminarReporte(reporte, usuario, conjunto);
        </cfscript>
    </cffunction>

    <!---   
    * Fecha creacion: 03 de febrero de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="actualizarReporte" access="remote" hint="Actualiza el reporte seleccionado">
        <cfargument name="reporte" type="numeric" required="yes" hint="Clave del reporte estrategico">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la configuracion">
        <cfargument name="descripcion" type="string" required="no" hint="Descripcion de la configuracion">
        <cfargument name="configuracion" type="string" required="yes" hint="JSON de la configuracion">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.actualizarReporte(reporte, usuario, conjunto, nombre, descripcion, configuracion);
        </cfscript>
    </cffunction>


    <!---
    * Funciones para el modulo Compartir
    * Fecha creacion: 16 de febrero de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="obtenerConfiguracionShare"access="remote" hint="Obtiene las configuraciones disponibles que han sido compartidas">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.obtenerConfiguracionShare(usuario, conjunto);
        </cfscript>
    </cffunction> 

      <!---
    * Fecha creacion: 15 de febrero de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="obtenershareUserG"access="remote" hint="Obtiene los Usuarios para Compartir">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.obtenershareUserG(idUsuario);
        </cfscript>
    </cffunction> 

      <!---
    * Fecha creacion: 17 de febrero de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="obtenershareUserS"access="remote" hint="Obtiene los Usuarios a los Cuales ya se les Compartio">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.obtenershareUserS(idReporte);
        </cfscript>
    </cffunction> 
 <!---
   * Fecha creacion: 31 de marzo de 2017
   * @author Jonathan Martinez
   --->  
   <cffunction name="obtenerreportes"access="remote" hint="Obtiene los reportes a los que se puede relacionar">
       <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
       <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto">
       <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del reporte">
       <cfscript>
           var arbol=[];
           var nivel=[];
           var flag=true;
           dao = CreateObject('component','DAO_ConfiguracionVistaMat');
           arrayAppend(arbol,idReporte);
           arrayAppend(nivel,idReporte);
           while (flag){
                res = dao.obtenerarbolreportes(ArrayToList(nivel));
                if(res.recordCount == 0)
                    flag=false;
                else{
                    nivel=[];
                    for(var i=1 ; i<= res.recordCount;i++){
                        arrayAppend(nivel,res.IDREP[i]);
                        arrayAppend(arbol,res.IDREP[i]);
                    }
                }
            }
           return dao.obtenerreportes(idUsuario,idConjunto,ArrayToList(arbol));
       </cfscript>
   </cffunction> 
    <!---
    * Fecha creacion: 31 de marzo de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="obtenerrelacionReport"access="remote" hint="Obtiene el reporte al cual esta relacionado">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del reporte">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.obtenerrelacionReport(idReporte);
        </cfscript>
    </cffunction> 
    <!---
    * Fecha creacion: 31 de marzo de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="agregarRelacion"access="remote" hint="Guarda la relacion del reporte">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del reporte">
        <cfargument name="idRelacion" type="numeric" required="yes" hint="Clave del reporte a relacionar">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.agregarRelacion(idReporte,idRelacion);
        </cfscript>
    </cffunction> 

       <!---
    * Fecha creacion: 20 de febrero de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="obtenershareupdate"access="remote" hint="Obtiene los Usuarios compartidos eliminandolos">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.obtenershareupdate(idReporte);
        </cfscript>
    </cffunction> 

      <!---
    * Fecha creacion: 16 de febrero de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="agregarShare"access="remote" hint="Agrega un Uusario en la Lista de Share">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario a compartir">
        <cfargument name="reporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.agregarShare(usuario,reporte);
        </cfscript>
    </cffunction> 

      <!---
    * Fecha creacion: 20 de febrero de 2017
    * @author Jonathan Martinez
    --->  
    <cffunction name="actualizaShare"access="remote" hint="Actualiza un usuario en la lista de compartir">
        <cfargument name="usuario" type="numeric" required="yes" hint="Clave del usuario a compartir">
        <cfargument name="reporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            return dao.actualizaShare(usuario,reporte);
        </cfscript>
    </cffunction>

    
    <!---
    * Fecha creacion: 07 de marzo de 2017
    * @author Alejandro Rosales
    --->  
    <cffunction name="copyReporte"access="remote" hint="Actualiza un usuario en la lista de compartir">
        <cfargument name="usuario" type="numeric" required="yes" hint="Id de usuario propiertario">
        <cfargument name="conjunto" type="numeric" required="yes" hint="Id conjunto">
        <cfargument name="reporte" type="numeric" required="yes" hint="Clave del Reporte">
        
        <cfscript>
            dao = CreateObject('component','DAO_ConfiguracionVistaMat');
            var resultado = dao.getReporte(reporte);
            var pkN = dao.agregarConfiguracion(usuario, conjunto, resultado.NOMBRE, resultado.DES, resultado.CONFIGURACION ); 
          if(pkN > 0)
                dao.agregarRelacion(pkN, resultado.RELACION);
            return pkN;
        </cfscript>
        <cfdump var = "#resultado#" abort="true">
    </cffunction>

    <!---
    * Fecha creacion: 09 de marzo de 2017
    * @author Alejandro Rosales
    --->

    <cffunction name="setPrivilegio" access="remote" hint="Cambio el privilegio de un reporte compartido">
        <cfargument name="idRelacion" type="numeric" required="yes" hint="id de la relacion">
        <cfargument name="estado" type="numeric" required="yes" hint="nuevo estado">
        <cfscript>
            dao = createObject('component', 'DAO_ConfiguracionVistaMat');
            var resultado = dao.setPrivilegio(idRelacion,estado);
            return resultado;
        </cfscript>
    </cffunction>

    <!--- 
    * Fecha creacion: 31 de Marzo de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="getReportRelated" access="remote" hint = "Obtiene el reporte relacionado">
        <cfargument name="pkReporte" type="numeric" required="yes" hint="pkReporte a consultar">
        <cfscript>
            dao = createObject('component','DAO_ConfiguracionVistaMat');
           var D = structNew();
           D["val"] = dao.getReportRelated(pkReporte).R;
           if(D.val > 0)
            D["desc"] =  dao.getReportRelated(D["val"]).D;
            return  D;
        </cfscript>
    </cffunction>

    <!--- 
    * Fecha creacion: 27 de Septiembre de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="altaShare" access="remote" hint="Alta comparticion de reportes">
        <cfargument name="idReporte" type="numeric" required="true" hint="pk del reporte">
        <cfargument name="idUsuario" type="numeric" required="true" hint="pk de usuario">
        <cfscript>
            dao = createObject('component','DAO_ConfiguracionVistaMat');
            return dao.altaShare(idReporte, idUsuario);
        </cfscript>
    </cffunction>

    <!--- 
    * Fecha creacion: 27 de Septiembre de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="bajaShare" access="remote" hint="Alta comparticion de reportes">
        <cfargument name="idReporte" type="numeric" required="true" hint="pk del reporte">
        <cfargument name="idUsuario" type="numeric" required="true" hint="pk de usuario">
        <cfscript>
            dao = createObject('component','DAO_ConfiguracionVistaMat');
            return dao.bajaShare(idReporte, idUsuario);
        </cfscript>
    </cffunction>

    <!---
    * Fecha: Octubre 03, 2017
    * Autor: Alejandro Rosales
    --->
    <cffunction name="altaTodosShare" access="remote" hint="Alta comparticion de reportes">
        <cfargument name="idReporte" type="numeric" required="true" hint="pk del reporte">
        <cfargument name="idUsuarios" type="any" required="true" hint="pks de usuario">
        <cfscript>
            var ids = deserializeJSON(idUsuarios);
            for( i = 1; i <= arrayLen(ids);i++){
                altaShare(idReporte ,ids[i]);
            }
            return true;
           
        </cfscript>
    </cffunction>
    <!---
    * Fecha: Octubre 03, 2017
    * Autor: Alejandro Rosales
    --->
    <cffunction name="bajaTodosShare" access="remote" hint="Alta comparticion de reportes">
        <cfargument name="idReporte" type="numeric" required="true" hint="pk del reporte">
        <cfargument name="idUsuarios" type="any" required="true" hint="pks de usuario">
        <cfscript>
            var ids = deserializeJSON(idUsuarios);
            for( i = 1; i <= arrayLen(ids);i++){
                bajaShare(idReporte ,ids[i]);
            }
            return true;
          
        </cfscript>
    </cffunction>
    <!---
    * Fecha: Octubre 03, 2017
    * Autor: Alejandro Rosales
    --->
    <cffunction name="setTodosPrivilegios" access="remote" hint="Cambio de privilegio de todas las relaciones">
        <cfargument name="idRelaciones" type="any" required="true" hint="pk de las relaciones entre usuarios">
        <cfargument name="state" type="numeric" required="true" hint="estado nuevo del privilegio">
        <cfscript>
            var ids = deserializeJSON(idRelaciones);
             for( i = 1; i <= arrayLen(ids);i++){
                setPrivilegio(ids[i] ,state);
            }
            return true; 
        </cfscript>
    </cffunction>
    <!---
    * Fecha: Octubre 03, 2017
    * Autor: Alejandro Rosales
    --->
    <cffunction name="getEstadoPrivilegio" access="remote" hint="Cambio de privilegio de todas las relaciones">
        <cfargument name="idRelacion" type="any" required="true" hint="pk relacion">
        <cfscript>
            dao = createObject('component','DAO_ConfiguracionVistaMat');
            return dao.getEstadoPrivilegio(idRelacion);
        </cfscript>
    </cffunction>


</cfcomponent>
