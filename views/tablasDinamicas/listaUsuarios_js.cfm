<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Tablas de Usuarios
* Fecha 28 de Marzo de 2017
* Descripcion:
* Vista  para el submodulo de Tablas de Usuarios
* Autor: Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8"> 
 <script >
     <!--- Inicializacion de variables --->
     var data = [];
     var share= [];
     var cont=1;
     <!--- Inicia Cuerpo del Script --->
     <cfif isDefined('prc.usuarios') >
         <cfloop array="#prc.usuarios#" index="usr">
             <cfoutput>
                     data.push({
                         id: "#usr.getId()#",
                         nombre: "#usr.getNombre()#",
                         apPaterno: "#usr.getaPaterno()#",
                         apMaterno: "#usr.getaMaterno()#",
                         propietario: "#usr.getPropietario()#",
                         rol: "#usr.getRol()#",
                         share: "#usr.getShare()#"
                     });
             </cfoutput>
         </cfloop>
     </cfif>
     $(document).ready(function() { 
         $('#tabla_share_User').bootstrapTable(); 
         $('#tabla_share_User').bootstrapTable('hideColumn', 'id');
         $('#tabla_share_User').bootstrapTable('load', data);
         for (var i=0; i<data.length;i++){
             if(data[i].propietario == 1)
                  $('#tabla_share_User').bootstrapTable('check', i);
         }
     });
 </script>