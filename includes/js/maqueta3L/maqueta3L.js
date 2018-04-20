/** 
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       junio 2017
* Descripcion: Contenido js con las funciones para redimensionar 3 capas
* Autor:       aaron quintana gomez
* ================================
*/


 // variables globales para 3 secciones redimensionables 
var currentStack =true;
var dragging     = false;
var stack ;
var xbeforeResize = window.innerWidth;
var inspEve = false;
var glo_maxCont1  = true; 

/** 
  * Descripcion:    Objeto con nuestro listado de funciones
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function secciones3L(){ 
    this.init_3L = function(){
        inicializar_3L();
         browserResize();
    }
    this.maxCont = function(bol){
        glo_maxCont1 = bol;
    }
}

/** 
  * Descripcion:    Refreca las barras de desplazamiento x y 
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function fixDragBtn() {
  
    var offsetY = 18; // espacion adicional en Y 
    var offsetX = 71; // espacion adicional en X
    var textareawidth, leftpadding, dragleft, containertop, buttonwidth
    var containertop = Number(w3_getStyleValue(document.getElementById("container"),        "top").replace("px", "")); //ALTURA DEL CONTENEDOR
    textareasize     = Number(w3_getStyleValue(document.getElementById("iframewrapper1"), "width").replace("px", ""));
    leftpadding      = Number(w3_getStyleValue(document.getElementById("iframe1"), "padding-left").replace("px", ""));
    buttonwidth      = Number(w3_getStyleValue(document.getElementById("dragbarY"),       "width").replace("px", ""));
    textareaheight   = w3_getStyleValue( document.getElementById("iframewrapper1"), "height");
    dragleft         = textareasize + leftpadding + (leftpadding / 2) - (buttonwidth / 2) +(offsetY);
      
    //HORIZONTAL
    document.getElementById("dragbarY").style.top    = containertop + "px";
    document.getElementById("dragbarY").style.left   = (dragleft +1) + "px";
    document.getElementById("dragbarY").style.height = textareaheight;
    $(".mq-scroll-y").css("height",(Number(textareaheight.replace("px", "")) -30) +"px");
    var areaHeightCont3 = w3_getStyleValue( document.getElementById("iframewrapper3"), "height").replace("px","");
    var areaHeightCont2 = w3_getStyleValue( document.getElementById("iframewrapper2"), "height").replace("px","");

    switch((glo_maxCont1) ? 1: 0){
      case 0: 
        $(".embed-responsive-item").css("height", (Number(textareaheight.replace("px", ""))  ) +"px" );
          $(".embed-responsive-4by3").css("padding-bottom",(Number(textareaheight.replace("px", "")) ) +"px");
      break
      case 1: // Contenedor 1 maximizado
          $(".embed-responsive-item").css("height", (Number(areaHeightCont3) -100) +"px" );
          $(".embed-responsive-4by3").css("padding-bottom",(Number(areaHeightCont3) -100) +"px");
          $(".mq-conv-f2").css("height",(Number(areaHeightCont2) -35 ) +"px")
      break;
    }
    
    document.getElementById("dragbarY").style.width  = 5;
    document.getElementById("dragbarY").style.cursor = "col-resize";

    //VERTICAL
    alturaContenedor2 =  Number(w3_getStyleValue(document.getElementById("iframewrapper2"), "height").replace("px", ""));
    anchoContenedor2 =  Number(w3_getStyleValue( document.getElementById("iframewrapper2"), "width").replace("px",""));
    document.getElementById("dragbarX").style.top    =  (alturaContenedor2 +offsetX) +"px" ; //ALTURA DEL CONTENEDOR
    document.getElementById("dragbarX").style.left   =  (dragleft +12) + "px" ;
    document.getElementById("dragbarX").style.width  = (anchoContenedor2) +"px"  ;
    document.getElementById("dragbarX").style.cursor = "row-resize";
    document.getElementById("dragbarX").style.height = 20;
}

/** 
  * Descripcion:    Al dar clcik en el elemento se activa la bandera  para arrastrar eje Y
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function dragstart(e) { 
    e.preventDefault();
    visibleF1("visible");
    dragging = true; // Se activa bandera para arrastrar
    stack    = "";
}

/** 
  * Descripcion:    Al dar clcik en el elemento se activa la bandera  para arrastrar eje X
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function dragstart2(e) {
    e.preventDefault();
    visibleF1("visible");
    dragging = true; // Se activa bandera para arrastrar
    stack    = " horizontal";
}


/** 
  * Descripcion:    actualiza las dimensiones al mover el cursor
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function dragmove(e) {
    var  offsetCursorY = 8; // que tan alejado esta el cursor  la vertical
        if (dragging) {
            document.getElementById("shield").style.display = "block";         
            if (stack != " horizontal") {
                var percentage = (e.pageX / window.innerWidth) * 100; 
                if(percentage >  52){
                    offsetCursorY = 3;
                }
                percentage = percentage - offsetCursorY;
                if (percentage > 5 && percentage < 98) {
                    var mainPercentage                                      = 100-percentage;
                    document.getElementById("iframecontainer1").style.width = percentage     + "%";
                    document.getElementById("iframecontainer2").style.width = mainPercentage + "%";
                    document.getElementById("iframecontainer3").style.width = mainPercentage + "%";
                    $(".mq-heigth").removeClass("mq-embed-responsive-item");
                    fixDragBtn();
                }
            } else {
                  $(".mq-heigth").addClass("mq-embed-responsive-item");
                  var  offsetCursorX = 3; // que tan alejado esta el cursor  la vertical
                  var containertop = Number(w3_getStyleValue(document.getElementById("container"), "top").replace("px", ""));
                  var percentage   = ((e.pageY  / window.innerHeight )  * 100);
                  if(percentage >  52){
                      offsetCursorX  = 5;
                  }
                  percentage = percentage - offsetCursorX;
                  if (percentage > 10 && percentage < 90) {
                      var mainPercentage                                       = 100-percentage;
                      document.getElementById("iframecontainer2").style.height =  percentage     + "%";
                      document.getElementById("iframecontainer3").style.height =  mainPercentage  + "%";
                       // document.getElementById("mq-pdf-embed-responsive-4by3").style.paddingBottom = (mainPercentage)  + "%";
                      $(".mq-embed-responsive-item").css("height",(mainPercentage +20) +"%");
                      fixDragBtn();
                  }
              }        
          }
           if(inspEve){
              fixDragBtn();
          }
}

/** 
  * Descripcion:    Al soltar el boton, se refresca
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function dragend() {
    document.getElementById("shield").style.display = "none";
    dragging = false;
    if (window.editor) {
        window.editor.refresh();
    }
}

/** 
  * Descripcion:    Puede obtener diferentes propiedades de un elemento su ancho, alto, background
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function w3_getStyleValue(elmnt,style) {
  if (window.getComputedStyle) {
      return window.getComputedStyle(elmnt,null).getPropertyValue(style);
  } else {
      return elmnt.currentStyle[style];
  }
}

/** 
  * Descripcion:    Refresca  el alto y ancho de los contenedores dependiendo la posicion vertical u horizontal
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function restack(horizontal) {
    stack = "";
    if (horizontal) {
        stack = " horizontal";
        currentStack=false;
    } else {        
        currentStack=true;    
    }
    fixDragBtn(); 
}

/** 
  * Descripcion:    Al cambiar el tamaño del navegador refresca los iframes
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function browserResize() 
{   
    minContendor1();
    document.getElementById("page-wrapper").style.minHeight = window.innerHeight +"px";
    fixDragBtn();      
}
    
function minContendor1(){
    var dimensionPantalla=  [468,728,970,1200,1500,1900,3000];
    var ancho_ventana = window.innerWidth;
    var opcion;
    var porcent;
    var array_porcent = [];
    if ( $( "#mq-ico-f1" ).hasClass( "fa fa-angle-right" )) {
        array_porcent[0] = 10;
        array_porcent[1] = 5;
        array_porcent[2] = 1;
        array_porcent[3] = 2;
        array_porcent[4] = 2;
        array_porcent[5] = 2;
        array_porcent[6] = 2;
    } 
    else{
        array_porcent[0] = 50;
        array_porcent[1] = 60;
        array_porcent[2] = 50;
        array_porcent[3] = 50;
        array_porcent[4] = 50;
        array_porcent[5] = 25; 
        array_porcent[6] = 25;    
    }
    for (i=0;i<dimensionPantalla.length;i++) {
        if(ancho_ventana <= dimensionPantalla[i]){
            opcion = i;
            break;
        }
    }
    // dimension responsiva  para minicontenedor
    document.getElementById("container").style.top = "70px";
    switch(opcion){
        case 0:
          porcent = array_porcent[0];
          document.getElementById("container").style.top = "121px"; // dimension responsiva  para celulares
        break; 
        case 1:
          porcent = array_porcent[1]; 
        break; 
        case 2:
          porcent = array_porcent[2]; 
        break; 
        case 3:  
          porcent = array_porcent[3]; 
        break;
        case 4:
          porcent = array_porcent[4]; 
        break;
        case 5:  
          porcent = array_porcent[5]; 
        break; 
        case 6:  
          porcent = array_porcent[6]; 
        break; 
   }

   var mainPercentage                                      = 100-porcent;
   document.getElementById("iframecontainer1").style.width = porcent     + "%";
   document.getElementById("iframecontainer2").style.width = mainPercentage + "%";
   document.getElementById("iframecontainer3").style.width = mainPercentage + "%";
   fixDragBtn();
}
/** 
  * Descripcion:    reduce de tamano el iframe1
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function toggleFrame1(){
    visibleF1("hidden");
    if ( $( "#mq-ico-f1" ).hasClass( "fa fa-angle-right" )) {
        visibleF1("visible");
        $("#mq-tit-f1").append("Convenios");
        $("#mq-ico-f1").removeClass("fa fa-angle-right");
        $("#mq-ico-f1").addClass("fa arrow");
    } 
    else{
         visibleF1("hidden");
         $("#mq-tit-f1").empty();
        $("#mq-ico-f1").removeClass("fa arrow");
        $("#mq-ico-f1").addClass("fa fa-angle-right");
        
    }
    minContendor1();
    fixDragBtn();
}

/** 
  * Descripcion:    contenido del frame 1 visible 
  * Fecha creacion: junio 2017
  * @author:        aaron quintana gomez
*/
function visibleF1(vis){
    document.getElementById("mq-tit-f1").style.visibility = vis;
    document.getElementById("mq-cont-f1").style.visibility = vis;
}

/** 
 * Descripcion:    Trae la informacion listada de todos los convenios para mostrarse en la estructura de arbol
 * Fecha creacion: junio 2017
 * @author:        aaron quintana gomez
*/
function inicializar_3L(){      
    if ( window.addEventListener) {              
        window.addEventListener("resize"   , browserResize);
    }else if (window.attachEvent) {                 
        window.attachEvent("onresize"      , browserResize);
    }               
    if (window.addEventListener) {
      document.getElementById("dragbarY").addEventListener("mousedown" , function(e) { dragstart(e);});
      document.getElementById("dragbarY").addEventListener("touchstart", function(e) {dragstart(e);});
      document.getElementById("dragbarX").addEventListener("mousedown" , function(e) {dragstart2(e);});
      document.getElementById("dragbarX").addEventListener("touchstart", function(e) {dragstart2(e);});
	    
	    window.addEventListener("mousemove", function(e) {inspEve=true; dragmove(e);});
      window.addEventListener("touchmove", function(e) {inspEve=true; dragmove(e);});
      window.addEventListener("mouseup", dragend);
      window.addEventListener("touchend", dragend);
      window.addEventListener("load", fixDragBtn);
    }
}
