 <!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Editor de Tablas
* Fecha 27 de Marzo de 2017
* Descripcion:
* Script correspondiente al submodulo de edición de tablas 
* Autor:Jonathan Martinez
* ================================
--->
<cfprocessingdirective pageEncoding="utf-8">
 <cfoutput>
 <!---Se iniciializa el objeto que contendra la informacion de la tabla con la que se está trabajando--->
     <script type="text/javascript">
     var tabla=new Object();
     tabla.columnas=[];
     tabla.columnasn=[];
     tabla.filas=[];
     tabla.filasn=[];
     tabla.valores=[];
     tabla.valoresn=[];
     var filtros = [];
     <cfif isDefined('prc.tabla') >
        <cfloop index='i' from='1' to='#prc.tabla['columnas'].RECORDCOUNT#'>
             <cfoutput>
                 tabla.columnas.push('#prc.tabla['columnas'].IDCOL[i]#');
                 tabla.columnasn.push('#prc.tabla['columnas'].NOMBRE[i]#');
             </cfoutput>
         </cfloop>
         <cfloop index='i' from='1' to='#prc.tabla['filas'].RECORDCOUNT#'>
             <cfoutput>
                 tabla.filas.push('#prc.tabla['filas'].IDCOL[i]#');
                 tabla.filasn.push('#prc.tabla['filas'].NOMBRE[i]#');
             </cfoutput>
         </cfloop>
         <cfloop index='i' from='1' to='#prc.tabla['valores'].RECORDCOUNT#'>
             <cfoutput>
                 tabla.valores.push('#prc.tabla['valores'].IDCOL[i]#');
                 tabla.valoresn.push('#prc.tabla['valores'].NOMBRE[i]#');
             </cfoutput>
         </cfloop>
         <cfloop index='i' from='1' to='#prc.tabla['filtros'].RECORDCOUNT#'>
             var filtroA = new Object();
             <cfoutput>
                 filtroA.idCol='#prc.tabla['filtros'].IDCOL[i]#';
                 filtroA.nomCol='#prc.tabla['filtros'].NOMBRECOL[i]#';
                 filtroA.idFlt='#prc.tabla['filtros'].IDFILT[i]#';
                 filtroA.nomFlt='#prc.tabla['filtros'].NOMBREFILT[i]#';
                 filtroA.val='#prc.tabla['filtros'].VALOR[i]#';
                 filtros.push(filtroA);
             </cfoutput>
         </cfloop>
         <cfoutput>
             tabla.id='#prc.tabla['tabla'].IDTAB#';
             tabla.nombre='#prc.tabla['tabla'].NOMBRE#';
             tabla.descripcion='#prc.tabla['tabla'].DESCRIPCION#';
             tabla.conjunto='#prc.conjunto.getId()#';
         </cfoutput>
     </cfif>
     $( document ).ready(function() {
         $(".save-sr").hide();
         $.post('#event.buildLink("adminCSII.tablasDinamicas.creacionTabla.getTabla")#',{
             columnas : JSON.stringify(tabla.columnas),  filas : JSON.stringify(tabla.filas),  valores : JSON.stringify(tabla.valores), filtros: JSON.stringify(filtros)
         }, function(data){
             $('.chart-table').html(data);
             for(var i=0 ; i < tabla.columnas.length ; i++){
                 $(".chart-canvas-col").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+tabla.columnas[i]+'><span class="btn btn-primary btn-outline dropdown-toggle nombre-col"> '+tabla.columnasn[i]+'</span><span class="btn btn-primary btn-outline close-param"><i class="fa fa-times"></i></span></div>');
                 var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+tabla.columnas[i]+"'],.metrica .ibox-content [data-col-id='"+tabla.columnas[i]+"']");
                 elementoOriginal.addClass("disabled");
                 elementoOriginal.draggable('disable');
             }
             for(var i=0 ; i < tabla.filas.length ; i++){
                 $(".chart-canvas-fil").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+tabla.filas[i]+'><span class="btn btn-success btn-outline dropdown-toggle nombre-col"> '+tabla.filasn[i]+'</span><span class="btn btn-success btn-outline close-param"><i class="fa fa-times"></i></span></div>');
                 var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+tabla.filas[i]+"'],.metrica .ibox-content [data-col-id='"+tabla.filas[i]+"']");
                 elementoOriginal.addClass("disabled");
                 elementoOriginal.draggable('disable');
             }
             for(var i=0 ; i < tabla.valores.length ; i++){
                 $(".chart-canvas-val").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+tabla.valores[i]+'><span class="btn btn-warning btn-outline dropdown-toggle nombre-col"> '+tabla.valoresn[i]+'</span><span class="btn btn-warning btn-outline close-param"><i class="fa fa-times"></i></span></div>');
                 var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+tabla.valores[i]+"'],.metrica .ibox-content [data-col-id='"+tabla.valores[i]+"']");
                 elementoOriginal.addClass("disabled");
                 elementoOriginal.draggable('disable');
             }
             if(filtros.length != 0){
                $(".filtros .msj-filtro").hide();
                for(var i=0 ; i < filtros.length ; i++){
                     $(".filtros .btn-toolbar").append('<div  data-col-id="'+filtros[i].idCol+'" data-col-nombre="'+filtros[i].nomCol+'" data-filt-idfilt="'+filtros[i].idFlt+'" data-val = "'+filtros[i].val+'"class="btn-group fast-animated fadeInLeft"><span class="btn btn-danger btn-outline dropdown-toggle nombre-col"  > '+ filtros[i].nomCol+' '+' '+filtros[i].nomFlt+' '+filtros[i].val+' </span> <span class=" btn btn-danger btn-outline close-param "> <i class="fa fa-times "></i> </span></div>'  );
                }
            }
         });



        $("##desc").on("input", function() {
           // alert("Change to " + this.value);
           $(".save-sr").show();
        });

        $("##name").on("input", function() {
           // alert("Change to " + this.value);
            $(".save-sr").show();
      
        });

        $(".sharetable").on("click", function(){
          //  alert("Compartir");
               //  $('##listaUsuarios').modal('toggle');
                     

                     $.post('#event.buildLink("adminCSII.tablasDinamicas.administradorTablas.obtenerUsuariosAutorizados")#',
                         {idCon:$("[data-con-id]").attr("data-con-id"),idTab:tabla.id},
                     function(data){
                         $('##listaUsuarios').modal('toggle');
                         $("##listaUsuarios .modal-body").attr("data-rep-id",tabla.id);
                         $("##listaUsuarios .modal-body").html( data );
                     });
                    
        });
        $("##btnCompartir").click(
            function(event){

            // $('##listaUsuarios').modal('toggle');
                     var idUsr = "";
                     var listaUsuarios = $('##tabla_share_User').bootstrapTable('getSelections');
                     for(var i=0; i < listaUsuarios.length; i++){
                         if(i == (listaUsuarios.length-1))
                             idUsr=idUsr+listaUsuarios[i].id;
                         else
                             idUsr=idUsr+listaUsuarios[i].id+",";
                     }
                     $.post('#event.buildLink("adminCSII.tablasDinamicas.administradorTablas.compartirTabla")#',
                         {idTab:$("##listaUsuarios .modal-body").attr("data-rep-id"),usuarios:idUsr},
                     function(data){           
                         if(data===true){
                             $('##listaUsuarios').modal('toggle');
                             $("##listaUsuarios .modal-body").html( data );
                             toastr.success('Compartida exitosamente','Tabla');
                         }
                     });
            }
            );
         <!---
           *Fecha 24 de marzo de 2017
           *Descripcion: Agrega a la representacion de las dimensiones y las metricas la propiedad de ser arrastradas.
           *@author: Jonathan Martinez 
         --->
         $(".dimension .ibox-content a, .metrica .ibox-content a").draggable({
             revert: "invalid", 
             containment: ".wrapper-content",
             cursor: "move",
             zIndex:200,
             helper:function(event,ui){
                 var element=$("<div></div>");
                 return element.append($(this).html());
             }
         });
         <!---
           *Fecha 15 de marzo de 2017
           *Descripcion: Permite que los elementos arrastrados puedan ser depositados en el contenedor de las graficas y de acuerdo al tipo al que pertenezcan realiza la funcion correspondiente.
           *@author: Jonathan Martinez 
         --->
            
         $(".chart-canvas-col").droppable({
             accept: " .dimension .ibox-content a ",
             activeClass: "canvas-highlight",
             drop: function( event, ui ) {
                 if(ui.draggable.parents(".dimension").length){
                     ui.draggable.addClass("disabled");
                     ui.draggable.draggable('disable');
                     $(".chart-canvas-col").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+ui.draggable.attr("data-col-id")+'><span class="btn btn-primary btn-outline dropdown-toggle nombre-col"> '+ui.draggable.text()+'</span><span class="btn btn-primary btn-outline close-param"><i class="fa fa-times"></i></span></div>');
                     tabla.columnas.push(ui.draggable.attr("data-col-id"));
                     crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
              validaLenVal();
                 }
                 else{
                     toastr.error('No se puede agregar ese tipo de dato','Columna');
                 }
             }
         });

         $(".chart-canvas-fil").droppable({
             accept: " .dimension .ibox-content a",
             activeClass: "canvas-highlight",
             drop: function( event, ui ) {
                 if(tabla.columnas.length <= 0){
                     toastr.error('Debes agregar una columna antes','Filas');
                 }
                 else{
                     if(ui.draggable.parents(".dimension").length){
                         ui.draggable.addClass("disabled");
                         ui.draggable.draggable('disable');
                         $(".chart-canvas-fil").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+ui.draggable.attr("data-col-id")+'><span class="btn btn-success btn-outline dropdown-toggle nombre-col"> '+ui.draggable.text()+'</span><span class="btn btn-success btn-outline close-param"><i class="fa fa-times"></i></span></div>');
                         tabla.filas.push(ui.draggable.attr("data-col-id"));
                         crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
              validaLenVal();
                     }
                     else{
                         toastr.error('No se puede agregar ese tipo de dato','Fila');
                     }
                 }
             }
         });

          $(".chart-canvas-val").droppable({
              accept: " .metrica .ibox-content a",
              activeClass: "canvas-highlight",
              drop: function( event, ui ) {
                if(tabla.columnas.length <= 0){
                     toastr.error('Debes agregar una columna antes','Valores');
                 }
                 else{
                     if(ui.draggable.parents(".metrica").length){
                         ui.draggable.addClass("disabled");
                         ui.draggable.draggable('disable');
                         $(".chart-canvas-val").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+ui.draggable.attr("data-col-id")+'><span class="btn btn-warning btn-outline dropdown-toggle nombre-col"> '+ui.draggable.text()+'</span><span class="btn btn-warning btn-outline close-param"><i class="fa fa-times"></i></span></div>');
                         tabla.valores.push(ui.draggable.attr("data-col-id"));
                         crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
            validaLenVal();
                     }
                     else{
                          toastr.error('No se puede agregar ese tipo de dato','Fila');
                     }
                 }
             }
         });

         $(".ibox-content .chart-canvas-col").on("click", ".close-param",function(){
             if(tabla.columnas.length == 1 && (tabla.filas.length > 0 || tabla.valores.length >0)){
                 toastr.error('Elimine todos los valores y filas antes','Columnas');
             }
             else{
                 var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$(this).parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$(this).parent().attr("data-col-id")+"']");
                 var elemento = $(this).parents(".btn-group").first();
                 var index = tabla.columnas.indexOf($(this).parent().attr("data-col-id"));
                 tabla.columnas.splice(index,1);
                 elemento.switchClass("fadeInLeft","fadeOutLeft");
                 elemento.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
                 function(e) {
                     elementoOriginal.removeClass("disabled");
                     elementoOriginal.draggable("enable"); 
                     elemento.remove();          
                 });
                 crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
              validaLenVal();
             }
         });

         $(".ibox-content .chart-canvas-fil").on("click", ".close-param",function(){
             var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$(this).parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$(this).parent().attr("data-col-id")+"']");
             var elemento = $(this).parents(".btn-group").first();
             var index = tabla.filas.indexOf($(this).parent().attr("data-col-id"));
             tabla.filas.splice(index,1);
             elemento.switchClass("fadeInLeft","fadeOutLeft");
             elemento.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
             function(e) {
                 elementoOriginal.removeClass("disabled");
                 elementoOriginal.draggable("enable"); 
                 elemento.remove();            
             });
             crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
            validaLenVal();
         });

         $(".ibox-content .chart-canvas-val").on("click", ".close-param",function(){
             var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$(this).parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$(this).parent().attr("data-col-id")+"']");
             var elemento = $(this).parents(".btn-group").first();
             var index = tabla.valores.indexOf($(this).parent().attr("data-col-id"));
             tabla.valores.splice(index,1);
             elemento.switchClass("fadeInLeft","fadeOutLeft");
             elemento.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
             function(e) {
                 elementoOriginal.removeClass("disabled");
                 elementoOriginal.draggable("enable"); 
                 elemento.remove();            
             });
             crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
         validaLenVal();
         });
         $("##buttonConfig").on('click', function () {
              $.post('#event.buildLink("adminCSII.tablasDinamicas.creacionTabla.actualizarTabla")#',{
                 columnas : JSON.stringify(tabla.columnas),  filas : JSON.stringify(tabla.filas),  valores : JSON.stringify(tabla.valores), filtros: JSON.stringify(filtros), nombre: $('[name="name_usr"]').val(), descripcion: $('[name="desc_usr"]').val(), idTab: tabla.id
             }, function(data){
                 window.location.assign("#event.buildLink('adminCSII.tablasDinamicas/conjuntosDatos/cargarConjunto.idCon.#prc.conjunto.getId()#')#");
             });
         });
          $(".create-ct").on('click', function () {
            crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros);
         

         });
         function crearTabla(columnas,filas,valores,filtros){
             if(valores.length != 0){
                $(".save-sr").show();
      
             }
             else{
                $(".save-sr").hide();
      
             }
             $.post('#event.buildLink("adminCSII.tablasDinamicas.creacionTabla.getTabla")#',{
                 columnas : JSON.stringify(columnas),  filas : JSON.stringify(filas),  valores : JSON.stringify(valores), filtros: JSON.stringify(filtros)
             }, function(data){
                 $('.chart-table').html(data);
             });
           }
     /************************************************************************************************************************************/
     /*Modal filtro*/
     /************************************************************************************************************************************/

         $(".modal-body ##comboColumnas li a").click(function(event){
           var contenedor= $(this).closest(".btn-toolbar");
           var comboPadre=$(this).closest(".btn-group").first();
           var elemento=$(this);
           actualizarComboSeleccion(comboPadre,elemento,"data-col-id");
           $.post('#event.buildLink("adminCSII.tablasDinamicas.editorVisualizaciones.obtenerFiltrosColumna")#', 
               { idCol:$(this).attr("data-col-id") , idCon:$("[data-con-id]").attr("data-con-id")},
           function(data){
               if(comboPadre.siblings().length){
                   comboPadre.siblings().remove(); 
               }
               var comboFiltros=$('<div id="filtrosCol" class="btn-group animated fadeInUp "><button id="nombre-filtro" type="button" class="btn nombre-combo btn-success btn-outline">Filtros</button><button type="button" class="btn btn-success btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu menu-combo-filtro" role="menu"></ul></div>');
               var lista=comboFiltros.find("ul");
               for ( var i=0; i<data["filtros"].length ;i++ ){
                   var elementoList=$('<li ><a data-flt-id="'+data["filtros"][i]["id"]+'">'+data["filtros"][i]["representacion"]+'</a></li>');
                   lista.append(elementoList);
               }  
               contenedor.append(comboFiltros);
               var comboValores=$('<div id="valoresCol" class="btn-group animated fadeInUp "><button id="nombre-valor" type="button" class="btn nombre-combo btn-primary btn-outline">Valores</button><button type="button" class="btn btn-primary btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu menu-combo-filtro" role="menu"></ul></div>');
               var lista=comboValores.find("ul");
               for ( var i=0; i<data["valores"]["DATA"]["VALORES"].length ;i++){
                   var elementoList=$('<li  ><a data-flt-val="'+data["valores"]["DATA"]["VALORES"][i]+'">'+data["valores"]["DATA"]["VALORES"][i]+'</a></li>');
                   lista.append(elementoList);
               }       
                contenedor.append(comboValores);
                var comboRango = $('<div id="rangoCol" class="btn-group animated fadeInUp "><button id="nombre-rango" type="button" class="btn nombre-combo btn-primary btn-outline">Rango</button><button type="button" class="btn btn-primary btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu menu-combo-filtro" role="menu"></ul></div>');
               var lista=comboRango.find("ul");
               for ( var i=1; i<=5 ;i++){
                   var elementoList=$('<li  ><a data-flt-val="'+i+'">'+i+'</a></li>');
                   lista.append(elementoList);
               }       
               contenedor.append(comboRango);
               $("##rangoCol").hide();
           });
         });

         function actualizarComboSeleccion(combo,elementoSel,tipoValor){   
             combo.find(".nombre-combo").html(elementoSel.html());
             combo.attr(tipoValor,elementoSel.attr(tipoValor));
         }

         $(".modal-body").on("click", "##filtrosCol li a, ##valoresCol li a, ##rangoCol li a",function(){
            
           var comboPadre=$(this).closest(".btn-group").first();
           var elemento=$(this);
         //console.log(elemento);
           if (comboPadre.attr("id")==="filtrosCol"){
             var tipoVal="data-flt-id";
             if($(elemento).attr("data-flt-id") == 3){
                $("##rangoCol").show();
                $("##valoresCol").hide();
             }else{
                 $("##rangoCol").hide();
               $("##valoresCol").show();
             }
           }
           else{
             var tipoVal="data-flt-val";   
           }
             actualizarComboSeleccion(comboPadre,elemento,tipoVal);
         });

         $('##filtrosModal').on('hidden.bs.modal', function () { 
             reiniciarFiltrosModal($(this));
         });

         function reiniciarFiltrosModal(modal){
             var contenedor=modal.find(".modal-body");
             var comboCols=contenedor.find("##comboColumnas");
             if(comboCols.siblings().length){
                 comboCols.siblings().remove(); 
             }
             var nombre=comboCols.children("##nombre-col");
             nombre.html("Dimensiones");
             comboCols.removeAttr("data-col-id");
         }
         
         $(".ibox-content .btn-toolbar").on("click", ".close-param",function(){
             removerElemento($(this));
             if(filtros == 0)
                $(".filtros .msj-filtro").show();
             
         });

        function validaLenVal(){
          if(tabla.columnas.length == 0){
            toastr.error('Ingresa una columna antes de agregar filas y valores','Modifique el número de columnas');  
            toastr.error('La creación de la tabla necesita al menos de una columna','Modifique el número de columnas');  
          }else{
            toastr.success('Ahora puede ingresar valores','Modifique el número de valores');
            toastr.success('Ahora puede ingresar más columnas y/o filas','Modifique el número de columnas y/o filas');
          }
           if(tabla.valores.length != 0){
              $(".footerAcciones").show();
            } else{
                $(".footerAcciones").hide();
             } 
         }
         
         function removerElemento($item){
           var elemento=$item;
           var padre=elemento.parents(".btn-group").first();
           if (elemento.parents(".filtros").length){
               var object = new Object();
               object.idCol = padre.attr("data-col-id");
               object.idFlt = padre.attr("data-filt-idfilt");
               object.val = padre.attr("data-val");
               for(index = 0; index < filtros.length; index++){
                 if(object.idCol == filtros[index].idCol && object.idFlt == filtros[index].idFlt && object.val == filtros[index].val){
                     break;
                 }
               }
               filtros.splice(index,1);   
               padre.switchClass("fadeInLeft","fadeOutLeft");
               padre.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
               function(e) {
                 padre.remove();        
                 toastr.success('Eliminado exitosamente','Filtro');
                 crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros); 
                 validaLenVal();
               });        
           }
         }

            $("##agregarFiltro").on("click",function(){
           var idCol=$("##comboColumnas").attr("data-col-id");            
           var idFlt=$("##filtrosCol").attr("data-flt-id");
           var val;
           var t;
           if($("##valoresCol").is(":visible")){
            val=$("##valoresCol").attr("data-flt-val");
            t=$("##nombre-valor").text();
           }
           else{
            val=$("##rangoCol").attr("data-flt-val");
            t=$("##nombre-rango").text();
           }
           var s=$("##nombre-col").text(); 
           var a=$("##nombre-filtro").text();
             if ((typeof idCol !== typeof undefined )&&(typeof idFlt!== typeof undefined  )&&(typeof val !== typeof undefined )) {
               var filtroA = new Object();
               filtroA.idCol = idCol;
               filtroA.idFlt = idFlt;
               filtroA.val = val;
               filtros.push(filtroA);
               $('##filtrosModal').modal('toggle');
               $(".filtros .msj-filtro").hide();
               $(".filtros .btn-toolbar").append('<div  data-col-id="'+idCol+'" data-col-nombre="'+s+'" data-filt-idfilt="'+idFlt+'" data-val = "'+t+'"class="btn-group fast-animated fadeInLeft filtroTab"><span class="btn btn-danger btn-outline dropdown-toggle nombre-col"  > '+ s+' '+' '+a+' '+t+' </span> <span class=" btn btn-danger btn-outline close-param "> <i class="fa fa-times "></i> </span></div>'  );
               toastr.success('Agregado exitosamente','Filtro');
               crearTabla(tabla.columnas,tabla.filas,tabla.valores,filtros); 
               validaLenVal();            
             }
         });
      });
     </script>
 </cfoutput>
 <style>
     .footerAcciones{
        position: fixed;
        bottom: 0px;  
        background-color:rgba(250,250,250,.8);
        width:100%;
        border-top:solid 2px #7f2554;
        padding:5px;
        z-index:100;
     }
 </style>
