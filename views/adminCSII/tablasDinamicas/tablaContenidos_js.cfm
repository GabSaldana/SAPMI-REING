<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Contenido Tabla
* Fecha 23 de Marzo de 2017
* Descripcion:
* Script para el submodulo de Contenido de tablas
* Autor: Alejandro Rosales
* ================================
--->
<script>
     $(document).ready(function() {   
         $('#tabla-accion').bootstrapTable({
        	 exportDataType: "all",
        	 showExport: true,
        	 'data-show-export': true,
        	 exportOptions: {
        	 	 fileName: 'Tabla',
        	 	 worksheetName: 'Datos'
             }
         });
     });
 </script>
 <style>
     .azulSumaCol{
         background-color:#25b1ff;
         color:#000;
         font-weight: bold;
     }
     .azulSumaFil{
         color:#000;
         background-color:#4af;
     }.azulSumaSeccion{
         color:#000;
         background-color:#39D;
     }
     .azulSumaFilUltima{
         color:#fff;
         background-color:#17c;
     }
 </style>