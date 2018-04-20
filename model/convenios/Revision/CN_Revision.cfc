<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Componente de Negocio para el modulo de convenios/revision
* ================================
---->
<cfcomponent>
<cfproperty name="dao" inject="convenios.Revision.DAO_Revision">

    <!---
     * Descripcion:    obtiene las clasificaciones, dependecias o convenios si los hay
     * Fecha creacion: junio 2017
     * @author:        aaron quintana gomez
    --->
    <cffunction name="getClasificacionesUr" access="public"  hint="Obtiene los convenios y llena una tabla">
    <cfargument name="ARG_TIPO_CONVENIO" type="string" required="yes" hint="tipo de convenio 1(ELEC),2(MEXUS),3(MEXUS)"><cfscript>
        qry        =  dao.getClasificacionesUr(ARG_TIPO_CONVENIO);             
        nivel1     = '[]';
        nivel2     = '[]';
        nivel3     = '[]';
        JsonArbol  = "[]";
        sumConvClas = 0; //Suma de convenios por clasificacion
        sumConvDep = 0;  // Suma convenios por dependendencia
        var etNumCon = "<span class='label'>ARG_SC</span>"; 
        if (qry.RECORDCOUNT > 0){
            tam = qry.RECORDCOUNT;
            for (i=1;i<= tam ; i++){   
                convenio   = "<a onclick='consultaConvenio(ARG_PK);' style='font-weight: bold; color: ##00695c'>ARG_CONV</a>";                    
                if( qry.CLAVE_CONVENIO[i] NEQ ""){
                    convenio = replace(convenio,"ARG_PK",qry.PK_CONVENIO[i]);
                    nivel1 = nuevoNodo("[]",nivel1,"NV11L1", replace(convenio,"ARG_CONV",qry.CLAVE_CONVENIO[i])); 
                    sumConvClas ++;
                    sumConvDep ++;
                }
                if(qry.NOMBRE_UR[i] != qry.NOMBRE_UR[i+1]){
                    nivel2 = nuevoNodo(nivel1,nivel2,"NV22L2", replace(etNumCon,"ARG_SC",sumConvDep) &"&nbsp;&nbsp;" &qry.NOMBRE_UR[i]);
                    nivel1 = "[]";
                    sumConvDep = 0;
                }
                if( qry.CLASIFICACION_UR[i] != qry.CLASIFICACION_UR[i+1] ) {

                    nivel3 = nuevoNodo(nivel2,nivel3,"NV33L3", replace(etNumCon,"ARG_SC",sumConvClas) &"&nbsp;&nbsp;" &qry.CLASIFICACION_UR[i]);
                    nivel2 = "[]";
                    sumConvClas  = 0;
                }
            }
        }
        nivel3    = replace(nivel3,'NV11L1','','ALL');
        nivel3    = replace(nivel3,'NV22L2','','ALL');
        nivel3    = replace(nivel3,'NV33L3','','ALL');
        JsonArbol =nivel3 ;
    return JsonArbol;
    </cfscript>
    </cffunction>



    <!---
    * Descripcion:    Sustitulle los caracteres especiales para los acentos 
    * Fecha creacion: junio 2017
    * @author:        aaron quintana gomez
    --->
    <cffunction name="nuevoNodo" access="public"  hint="Obtiene los convenios y llena una tabla">
    <cfargument name="data"      type="string" required="yes" hint="datos para el arbol"> 
    <cfargument name="jsoStr"    type="string" required="yes" hint="cadena en formato json">
    <cfargument name="cSust"     type="string" required="yes" hint="caracter a sustituir"> 
    <cfargument name="etiqueta"  type="string" required="yes" hint="nombre">       
    <cfscript>
        tipoNodo = (data EQ "[]")?"HOJA":"SUBARBOL"; 
        nodoJso = ""; 
        switch (tipoNodo){
            case "HOJA":
                nodoJso  = (jsoStr EQ "[]") ? "[$" &cSust &"]" : replace(jsoStr,cSust&"]" , ",$" &cSust &"]"); 
                nodoJso  =  replace(nodoJso,"$",'{%text%:%nombreHoja%}');
                nodoJso  =  replace(nodoJso,"nombreHoja",etiqueta);
                break;
            case "SUBARBOL":
                nodoJso = (jsoStr EQ "[]") ? "[$"& cSust &"]" : replace(jsoStr,cSust&"]",",$" &cSust&"]"); 
                nodoJso =  replace(nodoJso,"$",'{%text%:%nombreHoja%,%nodes%:hijo}');
                nodoJso =  replace(nodoJso,"nombreHoja",etiqueta);
                nodoJso =  replace(nodoJso,"hijo",data);                             
                break;       
            }        
        return nodoJso;
    </cfscript>
    </cffunction>

</cfcomponent>