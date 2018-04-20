<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Explorador de conjuntos de datos
* Fecha 27 de Marzo de 2017
* Descripcion:
* Script correspondiente al submodulo de creacion de tablas 
* Autor:Jonathan Martinez
* ================================
--->
<cfprocessingdirective pageEncoding="utf-8"> 
 <cfoutput>
   <script type="text/javascript">
   var columnas = [];
   var filas = [];
   var valores = [];
   var filtros = [];
     $( document ).ready(function() { 
       toastr.error('Ingresa una columna antes de agregar filas y valores','Modifique el número de columnas');  
       toastr.error('La creación de la tabla necesita al menos de una columna','Modifique el número de columnas');  
       $(".footerAcciones").hide();
     <!---
       *Fecha 15 de marzo de 2017
       *Descripcion: Agrega a la representacion de las dimensiones y las metricas la propiedad de ser arrastradas.
       *@author: Jonathan Martinez 
     --->  
       $(".dimension .ibox-content a,.metrica .ibox-content a").draggable({
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
             columnas.push(ui.draggable.attr("data-col-id"));
             crearTabla(columnas,filas,valores,filtros); 
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
           if(columnas.length <= 0){
             toastr.error('Debes agregar una columna antes','Filas');
           }
           else{
             if(ui.draggable.parents(".dimension").length){
               ui.draggable.addClass("disabled");
               ui.draggable.draggable('disable');
               $(".chart-canvas-fil").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+ui.draggable.attr("data-col-id")+'><span class="btn btn-success btn-outline dropdown-toggle nombre-col"> '+ui.draggable.text()+'</span><span class="btn btn-success btn-outline close-param"><i class="fa fa-times"></i></span></div>');
               filas.push(ui.draggable.attr("data-col-id"));
               crearTabla(columnas,filas,valores,filtros);  
              validaLenVal();
             }
             else{
               toastr.error('No se puede agregar ese tipo de dato','Fila');
             }
           }
         }
       });

       $(".chart-canvas-val").droppable({
         accept: " .metrica .ibox-content a ",
         activeClass: "canvas-highlight",
         drop: function( event, ui ) {
           if(columnas.length <= 0){
             toastr.error('Debes agregar una columna antes','Valores');
           }
           else{
             if(ui.draggable.parents(".metrica").length){
               ui.draggable.addClass("disabled");
               ui.draggable.draggable('disable');
               $(".chart-canvas-val").append('<div style=" margin:5px;" class="btn-group fast-animated fadeInLeft" data-col-id='+ui.draggable.attr("data-col-id")+'><span class="btn btn-warning btn-outline dropdown-toggle nombre-col"> '+ui.draggable.text()+'</span><span class="btn btn-warning btn-outline close-param"><i class="fa fa-times"></i></span></div>');
               valores.push(ui.draggable.attr("data-col-id"));
               crearTabla(columnas,filas,valores,filtros);
              validaLenVal(); 
             }
             else{
               toastr.error('No se puede agregar ese tipo de dato','Fila');
             }
           }
         }
       });

       $(".ibox-content .chart-canvas-col").on("click", ".close-param",function(){
         if(columnas.length == 1 && (filas.length > 0 || valores.length >0)){
           toastr.error('Elimine todos los valores y filas antes','Columnas');
         }
         else{
           var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$(this).parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$(this).parent().attr("data-col-id")+"']");
           var elemento = $(this).parents(".btn-group").first();
           var index = columnas.indexOf($(this).parent().attr("data-col-id"));
           columnas.splice(index,1);
           elemento.switchClass("fadeInLeft","fadeOutLeft");
           elemento.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
           function(e) {
             elementoOriginal.removeClass("disabled");
             elementoOriginal.draggable("enable"); 
             elemento.remove();               
           });
           crearTabla(columnas,filas,valores,filtros);
           validaLenVal();
         }
       });

       $(".ibox-content .chart-canvas-fil").on("click", ".close-param",function(){
         var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$(this).parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$(this).parent().attr("data-col-id")+"']");
         var elemento = $(this).parents(".btn-group").first();
         var index = filas.indexOf($(this).parent().attr("data-col-id"));
         filas.splice(index,1);
         elemento.switchClass("fadeInLeft","fadeOutLeft");
         elemento.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
         function(e) {
           elementoOriginal.removeClass("disabled");
           elementoOriginal.draggable("enable"); 
           elemento.remove();                
         });
         crearTabla(columnas,filas,valores,filtros);
         validaLenVal();
       });

       $(".ibox-content .chart-canvas-val").on("click", ".close-param",function(){
         var elementoOriginal= $(".dimension .ibox-content  [data-col-id='"+$(this).parent().attr("data-col-id")+"'],.metrica .ibox-content [data-col-id='"+$(this).parent().attr("data-col-id")+"']");
         var elemento = $(this).parents(".btn-group").first();
         var index = valores.indexOf($(this).parent().attr("data-col-id"));
          valores.splice(index,1);
         elemento.switchClass("fadeInLeft","fadeOutLeft");
         elemento.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
         function(e) {
           elementoOriginal.removeClass("disabled");
           elementoOriginal.draggable("enable"); 
           elemento.remove();                
         });
         crearTabla(columnas,filas,valores,filtros);
        validaLenVal();
       });

       $("##buttonConfig").on('click', function () {
         $('.title-save').text('Guardar Tabla');
         $('##buttonConfig2').text('Guardar');     
         $('##saveConfirmation').modal('show');
       });


       $(".create-ct").on('click', function () {
         crearTabla(columnas,filas,valores,filtros);

       });

       $("##buttonConfig2").on('click', function () {
           $.post('#event.buildLink("tablasDinamicas.creacionTabla.guardarTabla")#',{
             columnas : JSON.stringify(columnas),  filas : JSON.stringify(filas),  valores : JSON.stringify(valores), filtros: JSON.stringify(filtros), nombre: $('[name="name_usr"]').val(), descripcion: $('[name="desc_usr"]').val()
           }, function(data){
             location.reload();
           });   
         $('##saveConfirmation').modal('hide');
       });
      
       $('##saveConfirmation').on('hidden.bs.modal', function() {
         $(this).find('form')[0].reset();
       });

       function crearTabla(columnas,filas,valores,filtros){
        
         $.post('#event.buildLink("tablasDinamicas.creacionTabla.getTabla")#',{
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
         $.post('#event.buildLink("tablasDinamicas.editorVisualizaciones.obtenerFiltrosColumna")#', 
             { idCol:$(this).attr("data-col-id") , idCon:$("[data-con-id]").attr("data-con-id")},
         function(data){
             if(comboPadre.siblings().length){
                 comboPadre.siblings().remove(); 
             }
             var comboFiltros=$('<div id="filtrosCol" class="btn-group animated fadeInUp "><button id="nombre-filtro" type="button" class="btn nombre-combo btn-success btn-outline ">Filtros</button><button type="button" class="btn btn-success btn-outline dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button><ul class="dropdown-menu menu-combo-filtro" role="menu"></ul></div>');
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
         if(   filtros.length == 0 )
            $(".filtros .msj-filtro").show();
       
         
       });
    
       function validaLenVal(){
        if(columnas.length == 0){
          toastr.error('Ingresa una columna antes de agregar filas y valores','Modifique el número de columnas');  
          toastr.error('La creación de la tabla necesita al menos de una columna','Modifique el número de columnas');  
        }else{
          toastr.success('Ahora puede ingresar valores','Modifique el número de valores');
          toastr.success('Ahora puede ingresar más columnas y/o filas','Modifique el número de columnas y/o filas');
        }
         if(valores.length != 0){
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
               crearTabla(columnas,filas,valores,filtros);
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
             crearTabla(columnas,filas,valores,filtros); 
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