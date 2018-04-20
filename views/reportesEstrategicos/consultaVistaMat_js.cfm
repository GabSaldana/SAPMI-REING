<cfprocessingdirective pageEncoding="utf-8"> 
<script type="text/javascript">

//Variables globales
var logoSII = new Image();
logoSII.src = "/includes/img/logo/LogoSII_mini.png";
var logoIPN = new Image();
logoIPN.src = "/includes/img/logo/logoIPN.png";
var multi, tipoGrafica, chart, num_reporte, dimGrafica,descRp;
var path = [];
var pathindex = 0;
var filtrosA = [];
var listaUserShare=[]; // Contiene la Lista de Usuarios a compartir de cada reporte
var showFT = false;
<!---
 * Descripcion: Define los combos que se van a crear conforme al conjunto de datos seleccionado.
--->
function crearComponente(){
    var index = 0;
    var etiqueta = [];
    $.ajax({
        url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getCampo',
        type: 'POST',
        dataType: 'json'
    })
    .done(function(data) {

        for ( var i = 0; i < data.length; i++){
            if(data[i].tipo != 3 && data[i].tipo != 5){

                $('[name="ejeX"]').append($("<option></option>").attr("value",data[i].id).attr("data-name",data[i].gral).text(data[i].nombre));
                $('#etiqueta').append($("<option></option>").attr("value",data[i].id).attr("data-name",data[i].gral).text(data[i].nombre));
            }

            if(data[i].tipo == 3 || data[i].tipo == 5){
                var div = $("<div>");
                div.appendTo('#hechos');
            }

            else if (data[i].tipo == 2){
                var div = $("<div>");
                div.appendTo('#tiempo');
            }

            else if (data[i].tipo == 1){
                var div = $("<div>");
                div.appendTo('#depen');
            }

            else {
                var div = $("<div>");
                div.appendTo('#dimRes');
            }

            if(data[i].tipo == 3 || data[i].tipo == 5){
                div.addClass('radio i-checks');
                var eti = $('<label>').appendTo(div);
                eti.addClass('pln');
                eti.attr('title', data[i].desc);
                eti.attr('data-type', data[i].tipo);
                eti.attr('data-toggle', 'tooltip');
                var radio = $('<input>').appendTo(eti);
                eti.append(" " + data[i].nombre);
                radio.attr('value', data[i].id);
                radio.attr('id', data[i].id);
                radio.attr('type', "radio");
                radio.attr('name', "h");             
                
            }
            else if(data[i].priori != 2){

                div.addClass('form-group');
                var eti = $('<label>').appendTo(div);
                eti.addClass('col-sm-5 control-label');
                eti.text(data[i].nombre);
                var div2 = $("<div>").appendTo(div);
                div2.addClass('col-sm-7');
                var sel = $("<select>").appendTo(div2);
                sel.attr('data-root', data[i].root);

                // sel.attr('title', data[i].desc);
                sel.attr('data-title', data[i].desc);              
                
                // sel.attr('data-toggle', 'tooltip');
                sel.attr('id', data[i].id);
                
                sel.attr('name', data[i].id);
                if(data[i].o == 1){
                    sel.addClass("obligatorio");
                    var priori = $('<span>').text(" *").appendTo(eti);
                }
                sel.addClass( "form-control opc " );

                //select2
                sel.attr('multiple', 'multiple');
                sel.addClass( "multipleSelect" );

                var eltos = data[i].eltos;
                $(eltos).each(function() {      
                    sel.append($("<option>").attr('value',this).text(this));
                });
            }
        }

        //select2
        $(".multipleSelect").select2({
            placeholder: "Todos",
            language: "es"
            //allowClear: true
        });

        $(".select2-container").tooltip({
            title: function() {
                return $(this).prev().attr("data-title");
            },
            placement: 'top'
        });
        
        $('[data-toggle="tooltip"]').tooltip();

        // Se agregan validaciones a los select dinámicos
        $("#formRE .obligatorio").each(function () {
            $(this).rules('add', {
                required: true,
                messages: {
                    required: "Introduce un valor específico"
                }
            });
        });

        if ($("#tiempo > div").length == 0)
            $("#iboxTiempo").hide();

        idH = $("input[name=h]")[0].value;
        $("input[value=" + idH + "]").attr('checked', '');

        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
        
        actualizaOperacion(idH);

    })
    .fail(function() {
        console.log("Error.");
    });
}

<!---
 * Descripcion: Muestra etiquetas : select2.
--->
function createLabel(elemento){
    $(elemento).parent().find("span[class*='select2-container']").tooltip({
    //$(".select2-container").tooltip({
        title: function() {
            return $(this).prev().attr("data-title");
        },
        placement: 'top'
    });
}

<!---
 * Descripcion: Incluye las operaciones permitidas para cada hecho.
--->
function actualizaOperacion(idH){
    $.ajax({
        url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getOperacion',
        type: 'POST',
        dataType: 'json',
        data: {
            num : idH
        }
    })
    .done(function(data) {
        $("#operacion").show();
        // $("#operacion option:gt(0)").remove();
        
        // select2
        $("#operacion option").remove();
        $("#operacion").append($("<option>"));
        $("#operacion").select2({placeholder: 'Elegir operación', language: "es"});
        createLabel("#operacion");
        
        for( var i = 0; i < data.length; i++){
            $("#operacion").append($("<option>").attr('value',data[i].id).attr('data-tittle', data[i].titulo).text(data[i].desc));
        }
        if(data.length == 1){
            // $("#operacion").val(data[0].id);
            // $('#operacion').valid();

            // select2
            $("#operacion").val(data[0].id).trigger("change");               
            $("#operacion").hide();
            $('#operacion').select2('destroy');
        }
    });
}

$(document).on("ifChecked", "input:radio[name=h]", function (){
    actualizaOperacion($(this).val());
});


<!---
 * Descripcion: Obtiene los combos dependientes entre si.
---> 
function getDependencies(elto){
    
    var selectedRoot = $(elto).attr("data-root");
    //var selectIdX = $(elto).attr("id");
    var selectId = $(elto).attr("id");
    var selectVal = $(elto).val();
    var cambios = [];

    // Modificación: 23 de octubre
    // Desc. Aplicar cambios cuando se selecciona la opción todos
    if ($(elto).val() == null) {
        var preId = $(elto).attr("id");
        var preVal = null;
        while(preVal == null){
            preVal = $("#" + preId).parent().parent().prev().find('select[data-root="' + selectedRoot + '"]').val();
            preId = $("#" + preId).parent().parent().prev().find('select[data-root="' + selectedRoot + '"]').attr("id");
            if(preVal == null)
                preVal = 1;
        }
        selectId = preId;
        selectVal = preVal;
    }
    //El primer registro identifica el elemento modificado
    cambios.push({ name: selectId, value: selectVal});
    
    // Incluir en cambios los valores de los combos diferentes de "Todos"
    $("#depen .opc").each(function() {
        if($(this).val() != null && $(this).attr("id") != cambios[0].id && $(this).attr("data-root") == selectedRoot){
        //if($(this).val() != null && $(this).attr("id") != cambios[0].id 
            //&& $(this).attr("data-root") == selectIdX){
            cambios.push({ name: $(this).attr("id"), value: $(this).val()});
        }
    });

    // Modificación: 19 de octubre
    // Desc. Evitar errores de elementos no encontrados al considerar todos los filtros ya definidos.
    //Obtener la misma cantidad de elementos de la misma clase
    var claseEltos = $('#depen .opc[data-root="' + $(elto).attr("id") + '"]').length;
    if (cambios.length == $('#depen .opc[data-root="' + $(elto).attr("data-root") + '"]').length){
        cambios = [];
        cambios.push({ name: selectId, value: selectVal});
    }

    actualizaComponente(cambios, 1, selectId, selectVal, $(elto).attr("data-root"));
    // actualizaComponente(cambios, 1, selectId, selectVal, $('#depen .opc').length, $(elto).attr("data-root"));//, eltosDefinidos);
}
/*GetDependencias 2*/
function getDependencies2(Root,Id,Val){
    
    
    var selectedRoot = Root;
    //var selectIdX = $(elto).attr("id");
    var selectId = Id;
    var selectVal = Val;
    var cambios = [];

    // Modificación: 23 de octubre
    // Desc. Aplicar cambios cuando se selecciona la opción todos
    if (Val == null) {
        var preId = Id;
        var preVal = null;
        while(preVal == null){
            preVal = $("#" + preId).parent().parent().prev().find('select[data-root="' + selectedRoot + '"]').val();
            preId = $("#" + preId).parent().parent().prev().find('select[data-root="' + selectedRoot + '"]').attr("id");
            if(preVal == null)
                preVal = 1;
        }
        selectId = preId;
        selectVal = preVal;
    }
    //El primer registro identifica el elemento modificado
    cambios.push({ name: selectId, value: selectVal});
    
    // Incluir en cambios los valores de los combos diferentes de "Todos"
    $("#depen .opc").each(function() {
        if($(this).val() != null && $(this).attr("id") != cambios[0].id && $(this).attr("data-root") == selectedRoot){
        //if($(this).val() != null && $(this).attr("id") != cambios[0].id 
            //&& $(this).attr("data-root") == selectIdX){
            cambios.push({ name: $(this).attr("id"), value: $(this).val()});
        }
    });

    // Modificación: 19 de octubre
    // Desc. Evitar errores de elementos no encontrados al considerar todos los filtros ya definidos.
    //Obtener la misma cantidad de elementos de la misma clase
    var claseEltos = $('#depen .opc[data-root="' + Id + '"]').length;
    if (cambios.length == $('#depen .opc[data-root="' + Root + '"]').length){
        cambios = [];
        cambios.push({ name: selectId, value: selectVal});
    }

    actualizaComponente(cambios, 1, selectId, selectVal, Root);
    // actualizaComponente(cambios, 1, selectId, selectVal, $('#depen .opc').length, $(elto).attr("data-root"));//, eltosDefinidos);

}

/*dsaasdasdsadsadsadasdasdsdasdsadasdasdadadasdada*/
<!---
 * Descripcion: Actualiza los combos dependientes cuando uno es modificado.
--->
function actualizaComponente(filtros, tipo, id, ele, root){ //-- total,--, eltosSelected){
    var index = 0;
    var etiqueta = [];
    $.ajax({
        url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getUR',
        type: 'POST',
        data: {tipo:tipo, cambios:JSON.stringify(filtros), elto:id, root:root},
        dataType: 'json'
    })
    .done(function(data) {
        for ( var i = 0; i < data.length; i++){
            if(data[i].tipo == "0"){
                //Select2
                $("#" + data[i].id).val(data[i].nombre).trigger("change");
            }
            else{//ACTUALIZAR ELEMENTOS DE LOS COMBOS
                
                var sel = $('#' + data[i].id);
                sel.find('option').remove();

                //Select2 - Quitar elementos previamente seleccionados
                sel.val(null).trigger("change");
                var eltos = data[i].eltos;
                $(eltos).each(function() {
                    sel.append($("<option>").attr('value',this).text(this));
                });
            }
        }            
        $("#" + id ).val(ele).trigger("change");
        
    })
    .fail(function() {
        console.log("Error.");
    });

}

<!---
 * Descripcion: Obtiene los filtros seleccionados y crea la consulta que va a generar la grafica y la tabla de datos.
--->

function obtenerDatos(tipoGrafica, dimGrafica, config, tipoD,filtros){

    var ejeY = $("input[name=h]:checked").val();
    var ejeX = $('[name="ejeX"]').val();
    var et = $('#etiqueta').val();
    var operacion = $('#operacion').val();
    var tipo = $('[name="ejeX"] option:selected').text();
    var total = $("input[name=h]:checked").parent().parent().text();
    var filtroTiempo = 0;

    //VALIDAR SI ES INDICADOR - ELEGIR LA DIMENSION TIEMPO
    var tipoReporte = $("input[name=h]:checked").parent().parent().attr('data-type');
    if (tipoReporte == 5) {
        dimTiempo = [];
        $('#tiempo option:selected').each(function(){
            if($(this).val() != '0*')
                filtroTiempo = 1;
        });
        if(filtroTiempo != 1){
            $('#tiempo label').each(function(){
                desc = $(this).text();
                dimTiempo.push(desc.substring(0, desc.length-1));
            });
            for(i=0; i < dimTiempo.length; i++){
                if(dimTiempo[i] == $('[name="ejeX"] option:selected').text()){
                    filtroTiempo = 1;
                    break;
                }
            }
            if(filtroTiempo != 1){
                $("formRE").validate();
                $("#tiempo select").rules('add', {
                        timeNotEqual: "0*",
                        //timeNotEqual: "null"
                });
            }

        }
    }

        // select2
        if(et.length == 0)
            et = "0";
    
        var titulo = [];
        var opc = [];
         if($("input[name=h]:checked").val() == 501){
             titulo.push(total);
             titulo.push("URL");
         }
         else{
             titulo.push(tipo);
             titulo.push(total);
         }

        //Select2
        /*Generacion de nuevo grafica*/
        if(tipoD == 1){
            $(".opc").each(function(){
                if($(this).val() != null ){

               
                opc.push({ id: $(this).attr("id"), value: $(this).val(), desc: $(this).parent().parent().find('label').clone().children().remove().end().text()});
            }
            else{
                
            if ($(this).parents('#depen').length ) {
            
            var inde = [];
            $(this).children().each(function(){
              inde.push($(this).val());
            });
            opc.push({  id: $(this).attr("id") , value:inde , desc: $(this).parent().parent().find('label').clone().children().remove().end().text()  });
            }
            }
        });
    }
        /*Muestra es una configiuracion de reporte almacenada*/
        if(tipoD == 2){
                for(i = 0; i < filtros.length; i++){
                    if(filtros[i].value != null){
                            opc.push({  id: filtros[i].name , value: filtros[i].value , desc: filtros[i].desc   });
        
                    }
                }

        }
     
        $.ajax({
            url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getConteo2',
            type: 'POST',
            dataType: 'json',
            data: { opcion:JSON.stringify(opc), hecho:ejeY, valores:ejeX, tipo:tipo, et: et, op: operacion}
        })
        .done(function(data) {

            // Definición de los filtros seleccionados
            // Modf. 23 octubre
            var filtros = "";
            for (var i = 0; i < opc.length; i++) {
                filtros = filtros + opc[i].desc + ": " + opc[i].value + " | ";
            };
            filtros = filtros.substring(0, filtros.length-3);

            clearData();
                    
            //Si no hay registros.
            if(data[0].length == 0){
                $(".chartIcon").hide();
                $('.graphTitle').text('No hay datos con los filtros definidos');
            document.getElementById("chart-area").innerHTML = "<img src = \'/includes/img/reportesEstrategicos/noData.png\' class = \'img-responsive\' />";
                $('#tabImg').show();
            }
            else{
                $('.btn-chart').show();
                $('#tabImg').hide();

                //Título
                t_hecho = $("input[name=h]:checked").parent().parent().text().trim();
                t_operacion = $('#operacion option:selected').attr('data-tittle');
                $('.LabelDescN').text('Reportes consultados');
                $('.LabelDescT').text('Puedes navegar por distintos reportes dando click en la fila de la tabla que deseés consultar');
                
                $('.LabelDescG').text('Puedes navegar por distintos reportes dando click en la seccion de la grafica que deseés consultar');
                
                 $('.graphTitle').text('Reporte del ' + '<cfoutput>#Session.cbstorage.conjunto.TITULO#</cfoutput>');
                
                tg = t_hecho +  " por " + $('[name="ejeX"] option:selected').attr('data-name').toLowerCase();
                if($("#etiqueta").val() != 0)
                    tg = tg + " y " + $('#etiqueta option:selected').attr('data-name').toLowerCase();
                if(tipoReporte != 5)
                    tg = tg + " (" + t_operacion.toLowerCase() + ")";

                //Definir tipo de gráfica
                if($('#etiqueta').val() == 0 || $("input[name=h]:checked").val() == 501)
                    tipoGrupo = 0;
                else{
                    tipoGrupo = 1;
                    titulo = [];
                    titulo.push(tipo);
                    for(i = 0; i < data[data.length-1].length; i ++)
                        titulo.push(data[data.length-1][i]);
                }

                //$("#tipoGrafica1 img:first").addClass('iconactive').removeClass("iconunactive");
                //Definir dimension de acuerdo al tipo d grafica y configuraciones establecidas
                cambiarTipoGrafica();
                if ($("#etiqueta").val() != 0)
                    setClassIcon(tipoGrafica, 'tipoGrafica2');
                else
                    setClassIcon(tipoGrafica, 'tipoGrafica1');
               // createChart(data, tg, filtros, tipoGrafica, dimGrafica, tipoReporte, config);
                obtieneTiposFormato(ejeY,titulo, data, tipoGrupo,tg, filtros, tipoGrafica, dimGrafica, tipoReporte, config);
                //function llenarTabla(titulo, q, tipo){
                 //   llenarTabla(titulo, data, tipoGrupo);

            }

        })
        .fail(function() {
            console.log("Error.");
        });
}

function setClassIcon(grafica, grupo){
    $("#" + grupo + " .iconactive").removeClass("iconactive").addClass("iconunactive");
    $("#" + grafica).addClass("iconactive").removeClass("iconunactive");
}

<!---
 * Descripcion: Crea la tabla de datos correspondiente a la consulta definida por el usuario.
--->

function getFormato(ejeY){


        $.ajax({
            url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getTipoDato',
            type: 'POST',
            dataType: 'json',
            data: {hecho: ejeY}
        })
        .done(function(data) {

             formato = {mascara: data.DATA.CTI_MASCARA[0], modificador:data.DATA.CTI_MODIFICADOR[0], remp:data.DATA.CTI_REMPLAZO[0], icon:data.DATA.CTI_ICONO[0]};
          return formato;
    });



}
function obtieneTiposFormato(ejeY, titulo, q, tipo, tg, filtros, tipoGrafica, dimGrafica, tipoReporte, config){
        
        $.ajax({
            url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getTipoDato',
            type: 'POST',
            dataType: 'json',
            data: {hecho: ejeY}
        })
        .done(function(data) {
        mascara = data.DATA.CTI_MASCARA[0];
        modificador = data.DATA.CTI_MODIFICADOR[0];
        remp = data.DATA.CTI_REMPLAZO[0];
        icon = data.DATA.CTI_ICONO[0];

        var reg;
       if(mascara == null)
         reg = null;
       else
        reg = new RegExp(mascara, modificador);
        

        var formato = {

            remp : data.DATA.CTI_REMPLAZO[0],
            icon : data.DATA.CTI_ICONO[0],
            regE : reg
        };

         if(ejeY==501)
             llenarTabla(formato,titulo,q,tipo);
         else{
             createChart(formato, q, tg, filtros, tipoGrafica, dimGrafica, tipoReporte, config);
             llenarTabla(formato,titulo,q,tipo);
         }
       
    });



}


function consultaRelacionReporte(valor){

    $.ajax({
                url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getReportRelated',
                type: 'POST',
                data: {pkReporte:num_reporte},
                dataType: 'json'
            })
            .done(function(data) {
                if(data.val > 0){

                    var ejeX = $('[name="ejeX"]').val();
                    var valA = [];
                    var descA =  $('[name="ejeX"] option:selected').text();
                    var tipoA = $('#'+ejeX).closest('div .tipo').attr('data-type');
                    valA.push(valor);
                    var objA = {desc: descA, name: ejeX, tipo : tipoA, value: valA};
                    filtrosA.push(objA);
                    num_reporte = data.val;
                    searchReport(data.val, data.desc, 1, 1,objA);
                }
                else{
                    toastr.success('Ya no hay mas reportes relacionados.','Reporte estratégico');
                }
        });

}

function llenarTabla(formato,titulo, q, tipo){
//function llenarTabla(titulo, q, tipo){
//  var ejeY = $("input[name=h]:checked").val();

   // obtieneTiposFormato(ejeY);

    var columnas=[];
    var filas=[];
    // var $table = $('#tab');
    var encabezado = $("<tr>");
    var datos = $("<tbody>");
    $('#tab').bootstrapTable('destroy');
    $('#tab').remove();
    $('#contTable').append($('<table>').attr({
        'id': 'tab',
        'data-pagination': true,
        'data-search': true,
        'data-show-export': true,
        'data-search-accent-neutralise': true,
        'data-row-style': 'rowStyle',        
        'data-export-types': "['excel']"
    }));

    encabezado.append($("<th data-sortable='true' data-switchable='false'>").text(titulo[0]));
    columnas.push(titulo[0]);
    for (i=1; i < titulo.length; i++)
    {
        encabezado.append($("<th data-sortable='true'>").text(titulo[i]).addClass('text-right'));
        columnas.push(titulo[i]);
    }
    $('#tab').append($("<thead>").append(encabezado));
  
    if(tipo == 0){
        for (var i = 0; i < q[0].length; i++){
            filas[i]=[];
             if (!isNaN(q[1][i])){
                 q[1][i] =  q[1][i].toFixed(2);   
             }
            var dat_n = formatoGeneral(formato,q[1][i]);
            datos.append("<tr><td>" + q[0][i] + 
                        "</td><td>" + dat_n + "</td></tr>");
            filas[i].push(q[0][i]);
            filas[i].push(q[1][i]);

    
            }
    }else{
        $('#tab').attr('data-show-columns', "true");
        for (var j = 0; j < q[0].length; j++) {
            var fila = $("<tr>");
            filas[j]=[];
            for (var i = 0; i < q.length-1; i++){
                valCel = q[i][j];
                filas[j].push(q[i][j]);
                
                if( i!= 0)
                        valCel = formatoGeneral(formato,valCel.toFixed(2));
                  //  valCel = formatoGeneral(valCel,"$");
                    
                
                var valor = $("<td>").text(valCel);
                fila.append(valor);
                
            
                
            }
            datos.append(fila);
        }
    }
    //dibujarGrafico(columnas,filas);
    $('#tab').append(datos);
    $('#tab').bootstrapTable('refresh');
    $('#tab').bootstrapTable({
        exportDataType: "all",
        exportOptions: {
            fileName: 'Reporte estratégico',
            worksheetName: 'Plazas'
        }
    });
     $('#tab').on('click-row.bs.table', function (e,row, $element) {
         if(!($("input[name=h]:checked").val()==501))
             consultaRelacionReporte(row[0]);
         else
             //window.open("ftp://148.204.77.94/Horas.xlsx","Enlace","width=900, height=900");
             document.location=row[1];

   });
}
/*
function format2(n, currency) {
    return currency + " " + n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
}*/

function formatoGeneral(formato, dato){
   if(formato.regE == null)
    return dato;
   var valor = dato.toString().replace(formato.regE,formato.remp);
   if(formato.icon != null)
    return formato.icon+" "+  valor;
    return valor;
}


function rowStyle(row, index) {
    var color = ['custom'];
    if (index % 2 != 0 ) {
        return {
            classes: color[0]
        };
    }
    return {};
}

////////////////////////////////////////////////////
//<< FUNCIONES PARA GRAFICAR CON FUSION CHARTS >> //
////////////////////////////////////////////////////
function getElementos(conjunto){
    var values = [];
    for(i=0; conjunto.length; i++){
        obj = {};
        obj["value"] = conjunto[i];
        var aux = conjunto[i];
        values.push(obj);
    }
    return values;
}

/* OBTENER CONJUNTOS DE DATOS */
/*
* Descripcion de la modificacion: Despliegue de suma
* Fecha de la modificacion: Febrero 17, 2017
* Autor de la modificacion: Alejandro Rosales    
*/    

function getDataset(formato,conjuntosDatos){
    var totalValues = [];
    var datasets = [];
    var contEltos = 0;
    if (conjuntosDatos.length == 2)
        contEltos = conjuntosDatos.length;
    else
        contEltos = conjuntosDatos.length-1;
  /*Valores que tomara cada una de las graficas*/
    for( i= 1; i < contEltos; i++){                    
        var values = [];
        for(j=0; j < conjuntosDatos[i].length; j++){
            obj = {};
            obj["value"] = conjuntosDatos[i][j];
            var aux = conjuntosDatos[i][j];
            values.push(obj);
        }
        totalValues.push(values);
    }
      
    for( i= 1; i< contEltos; i++){
        var currentDataset = {
            "visible": "0",
            "data": totalValues[i-1]
        }
        datasets.push(currentDataset);
    }

    //Definir etiqueta para cada conjunto de datos
    if(conjuntosDatos.length > 2){
        $.each(datasets, function (i, obj) {
                total = 0;
                for(y=0; y < conjuntosDatos[i].length; y++){
                    //if(y == i)
                    total =  total + conjuntosDatos[i+1][y];
                }
                total = total.toFixed(2);
                total = formatoGeneral(formato,total);
            //total = total.toFixed(2);
            //total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            obj["seriesname"] = conjuntosDatos[conjuntosDatos.length-1][i].toString() + ": " + total;
        });
    }
    return datasets;
}

/* OBTENER CATEGORÍAS */
function getCategories(conjuntosDatos){
    var categories = [];
    for( i= 0; i< conjuntosDatos[0].length; i++){
        obj = {};
        obj["label"] = conjuntosDatos[0][i].toString();
        categories.push(obj);
    }
    return categories;
}

/* OBTENER CONJUNTO DE DATOS PARA GRÁFICA DE COLUMNAS */
function getData(conjuntosDatos){
    var data = [];
    for(i=0; i < conjuntosDatos[0].length; i++){
        obj = {};
        obj["label"] = conjuntosDatos[0][i].toString();
        obj["value"] = conjuntosDatos[1][i];
        data.push(obj);
    }
    return data;
}

/* Multilevel */
function getCategory(conjuntosDatos){
    if(conjuntosDatos.length > 2){
        var nivel1 = [];
        var nivelX = [];
        for( i= 0; i< conjuntosDatos[0].length; i++){
            obj = {};
            obj["label"] = conjuntosDatos[0][i].toString();
            nivel1.push(obj);
        }

        $.each(nivel1, function (i, obj) {
            obj["category"] = getNivel2(conjuntosDatos, i);
            total = 0;
            for (var j = 0; j < nivel1[i].category.length; j++) {
                total = total + nivel1[i].category[j].value;
            }
            obj["value"] = total;
        });

        obj = {};
        obj["label"] = $("input[name=h]:checked").parent().parent().text();
        obj["category"] = nivel1;
        total = 0;
        for (var j = 0; j < nivel1.length; j++) {
            total = total + nivel1[j].value;
        }
        obj["value"] = total;
        nivelX.push(obj);
    }
    return nivelX;
}

function getNivel2(conjuntosDatos, index){
    var nivel2 = [];
    for(j=0; j < conjuntosDatos[conjuntosDatos.length-1].length; j++){
            obj = {};
            obj["label"] = conjuntosDatos[conjuntosDatos.length-1][j].toString();
            obj["value"] = conjuntosDatos[j+1][index];
            nivel2.push(obj);
        }
    return nivel2;
}
function getPrefijo(formato){
    if(formato.icon != null)
        return formato.icon;
    else
        return "";
}

function Cadena(data){
   var ix = $(data).attr("data-val");
   var dc = $(data).attr("data-desc");
 

   if(ix < (pathindex-1) ){
        var ht = "";
        for(i = 0; i <= ix ;i++){
            ht = ht + "<button   style=\"height:30px\"  data-val = \""+i+"\" data-desc = \""+path[i].desc+"\" onclick = \"Cadena(this)\" type=\"button\" class=\"btn btn-primary pad\"> <span class=\"badge\">"+(i+1)+"</span>  "+path[i].desc+"</button>";
        }
          pathindex = Number(ix) +1;
   }
   else
    return;
   document.getElementById("path").innerHTML = ht;
   num_reporte = path[Number(ix)].pk;
   searchReport(path[Number(ix)].pk, dc,1,2,path[Number(ix)].filtro);
}

function searchReport(option, txt, privilegio, kindof,auxiliar){
        $.post('consultaVistaMat/cambiarConfiguracion', {
            config: option}, function(data){

            document.getElementById("descRepG").innerHTML = "<h5>Reporte Generado / "+txt+"</h5>";
            document.getElementById("descGrafica").innerHTML = "<h5>Gráfica / "+txt+"</h5>";
            if(data != 0){
                if(kindof == 1){
                    for(i = 0; i < filtrosA.length;i++){
                        data.filtros.push(filtrosA[i]);
                    }
                    $("<button style=\"height:30px\"  data-val = \""+pathindex+"\" data-desc = \""+txt+"\" onclick = \"Cadena(this)\" type=\"button\" class=\"btn btn-primary pad\"> <span class=\"badge\">"+(pathindex+1)+"</span>  "+txt+"</button>").appendTo("#path")
                    pathindex = pathindex + 1;
                    objz = { pk : num_reporte , filtro : auxiliar, desc: txt};
                    path.push(objz);
                }
                else if(kindof == 2){
                    filtrosA.splice(pathindex,filtrosA.length - pathindex);
                     for(i = 0; i < filtrosA.length;i++){
                        data.filtros.push(filtrosA[i]);
                     }    
                }
                else if(kindof == 0){
                    path = [];
                    pathindex = 0;
                    filtrosA = [];
                      document.getElementById("path").innerHTML = "<button  style=\"height:30px\"  data-val = \""+pathindex+"\" data-desc = \""+txt+"\" onclick = \"Cadena(this)\" type=\"button\" class=\"btn btn-primary pad\"> <span class=\"badge\">"+(pathindex+1)+"</span>  "+ txt +"</button>";
                      pathindex = pathindex + 1;
                      objz = { pk : option , filtro : auxiliar, desc: txt};
                      filtrosA.push(auxiliar);
                      path.push(objz);
                }

                $('[name="desc_usr"]').val(txt);

                $(".opc").each(function(){
                    $(this).val(null).trigger("change");
                });
                
                if(data.filtros.length > 0 ){
                    for(i=0; i < data.filtros.length; i++){

                        if(data.filtros[i].value != null){
                            $("#" + data.filtros[i].name).val(data.filtros[i].value).trigger("change");
                            
                        }
                    }
                }
                //Llenar parametros
                
                $('#' + data.parametros[1].value).iCheck('check');
                for (var i = data.parametros.length - 1; i >= 2; i--) {
                    // $("#" + data.parametros[i].name).val(data.parametros[i].value);
                    $("#" + data.parametros[i].name).val(data.parametros[i].value).trigger("change");
                }

                //FALTA DESACTIVAR OPCIONES EN COMBOS RELACIONADOS
                v1 = $('#etiqueta option:selected').attr('data-name');
                if (v1 != 0){
                    v2 = $('[name="ejeX"] option:selected').attr('data-name');
                    $('#etiqueta').children("option").each(function () {
                        if($(this).attr('data-name') == v2)
                            $(this).prop('disabled', true);
                    });

                    $('[name="ejeX"]').children("option").each(function () {
                        if($(this).attr('data-name') == v1)
                            $(this).prop('disabled', true);
                    });
                }

                //Llenar configuraciones
                tipoGrafica = data.parametros[0].name;
                dimGrafica = "";

                if(data.config[0].value == "on" && $("#" + tipoGrafica).attr("data-dim") == "1")
                    dimGrafica = "2d";
                else if(data.config[0].value == "off" && $("#" + tipoGrafica).attr("data-dim") == "1")
                    dimGrafica = "3d";
                /*
                 if(privilegio == 0)
                     obtenerDatos(tipoGrafica, dimGrafica, data.config,1,"");
                 else
                     obtenerDatos(tipoGrafica, dimGrafica, data.config,2,data.filtros);
                */


                /*Dimension de UR ya no necesaria por filtrado*/
                
                if(data.filtros.length > 0 && kindof == 1) {
                    tiempo = [];
                    for (var i = data.filtros.length - 1; i >= 0; i--) {
                        if (data.filtros[i].tipo == 1){
                            tiempo.push(data.filtros[i]);
                        }
                    };
                    if(tiempo.length > 0) {
                      
                        getDependencies2($("#"+tiempo[0].name).attr("data-root"),$("#"+tiempo[0].name).attr("id"),$("#"+tiempo[0].name).val());
                       // actualizaComponente(tiempo, 1, tiempo[0].name, tiempo[0].value, $(tiempo[0].name).attr("data-root"));
                    }
                }

                if(privilegio == 0 || kindof == 1)
                    obtenerDatos(tipoGrafica, dimGrafica, data.config,1,"");
                else
                    obtenerDatos(tipoGrafica, dimGrafica, data.config,2,data.filtros);
                

                if(kindof != 1 && kindof != 2)
                $('#strategicreport').modal('toggle');
            }
        });
    }




/* CREAR GRÁFICA GENERAL */
//function createChart(datos, titulo, subtitulo, tipo, dim, multi, reporte){
function createChart(formato, datos, titulo, subtitulo, tipo, dim, reporte, config){
    FusionCharts.ready(function () {
         chart = new FusionCharts({
            "type": tipo + dim,
            "renderAt": "chart-area",
            "width": "100%",
            "height": "100%",
            "dataFormat": 'json',
            "dataSource": {
                "chart": {
                    "caption": titulo,
                    "subCaption": subtitulo,
                    "captionFont": "Arial",
                    "captionFontSize": "20",
                    // "captionFontColor": "#7F2554",
                    "captionFontColor": "#423E3E",
                    "subCaptionFont": "Arial",
                    "subCaptionFontSize": "15",
                    "subCaptionFontColor": "#1E1E1E",
                    "subCaptionFontBold": "0",
                    "captionFontBold": "1",
                    //"xaxisname": $("[name=ejeX] option:selected").text(),
                    "yaxisname": $("input[name=h]:checked").parent().parent().text(),
                    "numberPrefix": getPrefijo(formato),
                    "startingAngle": "20",
                    "showValuesInTooltip": "1",
                    "formatNumberScale": "0",
                    "showPercentInTooltip": "0",
                    "showValues":"1",
                    // "showLabels": "0",
                    "placeValuesInside": "1",
                    "rotateValues": "1",
                    "showLegend": "1",
                    "legendBorderThickness": ".5",
                    // "legendPosition": "right",
                    // "labelDisplay":"rotate",
                    "bgColor" : "#ffffff",
                    "showBorder" : "0",

                    //Logo
                    "logoURL": "/includes/img/reportesEstrategicos/logo50.png",
                    "logoAlpha": "20",
                    "logoPosition": "TR",

                    "exportEnabled": "1",
                    "exportShowMenuItem": "0",

                    "base": "10",
                    "pieFillAlpha": "60",
                    "pieBorderThickness": "2",
                    "hoverFillColor": "#cccccc",
                    "formatNumberScale":"1"
                },
                "category": getCategory(datos),
                "data": getData(datos),
                "categories":[
                    {
                        "category": getCategories(datos),
                    "formatNumberScale":"1"
                    }
                ],
                "dataset": getDataset(formato,datos)
            },
            /*Seccion de eventos*/
               "events": {
                "dataPlotClick": function (eventObj, dataObj) {
               
   
                    consultaRelacionReporte(dataObj["categoryLabel"]);


            }
        }
/*Fin de la seccion de eventos*/
        });
        
        if(reporte == 5){
            chart.setChartAttribute('showPercentValues', 1);
        }
        else{
            chart.setChartAttribute('showPercentValues', 0);
        }
        chart.render();
        setConfig(tipoGrafica);
        for (var i = 0; i < config.length; i++) {
            $('#' + config[i].name).bootstrapToggle(config[i].value);
        }

        /* Descargar imagen de gráfico */
        $('#download-sr').click(function (){
            if(chart.hasRendered())
                chart.exportChart({ exportFormat:'PNG', exportFileName: titulo});
        });
    });
}

/* COLOR ALEATORIO */
function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function getColors(colors){
    var color = "";
    for (i=0; i<colors; i++){
        color += getRandomColor() + ",";
    }
    return color;
}

function cambiarTipoGrafica(){
    if ($("#etiqueta").val() != 0){
        $("#tipoGrafica1").hide();
        $("#tipoGrafica2").show();
    }
    else{
        $("#tipoGrafica2").hide();
        $("#tipoGrafica1").show();
    }
}



function setConfig(idTipo){
        multi = $("#" + idTipo).attr('data-dim');
        log = $("#" + idTipo).attr('data-log');
        rotate = $("#" + idTipo).attr('data-rotate');
        
        $('#dimension').bootstrapToggle('on');
        $('#logaritmica').bootstrapToggle('off');

        if(log == 0)
            $('#logaritmica').bootstrapToggle('disable');
        else
            $('#logaritmica').bootstrapToggle('enable');

        if(multi == 0)
            $('#dimension').bootstrapToggle('disable');
        else
            $('#dimension').bootstrapToggle('enable');

        if(rotate == 0)
            $('#rotar').bootstrapToggle('disable');
        else
            $('#rotar').bootstrapToggle('enable');
}

function hideConfig() {
    $("#leftPanel").hide();
    $("#graficar").hide();
    $("#leftPanel").switchClass("col-md-6","col-md-1");
    //$("#configPanelInformation").switchClass("showConfig","hideConfig");
    $("#rightPanel").switchClass("col-md-6","col-md-12",function(){
        for (var item in FusionCharts.items) {
            FusionCharts.items[item].lockResize(false);
        }
    });
}

function showConfig() {
    $("#leftPanel").show();
    $("#graficar").show();
    
    //$("#configPanelInformation").switchClass("hideConfig","showConfig");
    $("#leftPanel").switchClass("col-md-1","col-md-6");
    $("#rightPanel").switchClass("col-md-12","col-md-6",function(){
        for (var item in FusionCharts.items) {
            FusionCharts.items[item].lockResize(false);
        }
    });
}

// Switch action 
function  toggleButton(x, action) {
    var id = $('#buttonConfig');
    var text = id.text();
    var span = $('<span>');
    
    if(!id.hasClass(action)){
        
        if(x == 'edit-sr'){
            text = text == " Nuevo" ? " Actualizar" : " Nuevo";
        }
        else{
            text = text == " Actualizar" ? " Nuevo" : " Actualizar";
        }

        id.removeClass(x).addClass(action);
        id.text(text);
        id.prepend(span);
        span.addClass("fa fa-save fa-2x");
    }
}

function getReport(){
    $.post('consultaVistaMat/getReporte', function(data){
        $('#table-sr').html( data );
        $(".totalSR").text($('#tablaReportes').bootstrapTable('getOptions').totalRows);
    });
}

function clearData(){
    //Área de graficación y tabla de datos
    if(chart !== undefined && chart.disposed !== true){
        chart.dispose();
        $(".btn-chart").hide();
        $(".graphTitle").text('');
    }
    $('#tab').bootstrapTable('destroy');
    $('#tab').html("");
}

$(document).ready(function() {

//Checkbox
//$(':checkbox').checkboxpicker();
    //Ocultar boton de Compartir
    $('.sharereport').hide();
    $('.relationreport').hide();

    //Carga el modal de Reportes
    $('#strategicreport').modal({
            backdrop: 'static',
            keyboard: false
        });
    getReport();
   // showConfig();
    hideConfig();
    
    $('#operacion').select2({placeholder: "Elegir operación", language: "es"});
    $('#ejeX').select2({placeholder: "Seleccionar una opción", language: "es", allowClear: true});
    $('#etiqueta').select2({placeholder: "Seleccionar una opción", language: "es", allowClear: true});
    $('.btn-chart').hide();
    $('.filters').show();
    $('.pageguide').show();
    /*
    if (localStorageSupport) {
        if (collapse == 'on') {
            // Block resize
            $.each(FusionCharts.items, function (i, obj) {
                FusionCharts.items[i].lockResize(true);
            });
            hideConfig();
        }
    }
    */

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "progressBar": true,
        "preventDuplicates": false,
        "newestOnTop": true,
        "positionClass": "toast-top-right",
        "onclick": null,
        "showDuration": "400",
        "hideDuration": "1000",
        "timeOut": "4000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };

    tl.pg.init({
        "custom_open_button": "#showpageguide",
        "auto_refresh": true,
        "default_zindex": 999
    });

    /* Validar Select2 */

    // $(document).on("select2:unselect", "#ejeX", function (e) { });
    $('.singleSelect').change(function(){
        $(this).valid();
        clearData();
        $(".chartIcon").show();
    });





    $(document).on("change", ".multipleSelect", function (e) { $(this).valid(); });

    $("#depen").on("select2:select", ".multipleSelect", function (e) { getDependencies2($(this).attr("data-root"),$(this).attr("id"),$(this).val()); });
    
    $("#depen").on("select2:unselect", ".multipleSelect", function (e) { getDependencies2($(this).attr("data-root"),$(this).attr("id"),$(this).val()); });
    
    $(".hideFilter").click(function (){
        //Bloquear resize 
        $.each(FusionCharts.items, function (i, obj) {
            FusionCharts.items[i].lockResize(true);
        });
        if(showFT){
            hideConfig();
            showFT = false;
        }else{
          showConfig();
          showFT = true;  
        }
        /*
        if(localStorage.getItem("collapse_filters") == 'off'){
            hideConfig();
            $('#collapsefilters').prop('checked','checked');
            localStorage.setItem("collapse_filters",'on');
        }else{
            showConfig();
            $('#collapsefilters').prop('checked','');
            localStorage.setItem("collapse_filters",'off');
        }*/
    });

    /* Limpiar todas las opciones seleccionadas */
    $(".clearOptions").click(function (){
        cambios = 0, tipo = 0;
        desc = $(this).attr("name");
        $("#" + desc +  " .opc").each(function(){
            if($(this).val() != null ){
                $(this).val(null).trigger("change");
                cambios = 1;
            }
        });

        //Inicializar combos
        if(cambios == 1){
            if(desc == "depen")    tipo = 1;
            else if (desc == "tiempo")  tipo = 2;
            else   tipo = 4;
            $.ajax({
                url: '/index.cfm/reportesEstrategicos/consultaVistaMat/inicializaCombos',
                type: 'POST',
                data: {tipo:tipo},
                dataType: 'json'
            })
            .done(function(data) {
                for ( var i = 0; i < data.length; i++){
                    var sel = $('#' + data[i].id);
                    sel.find('option').remove();
                    sel.val(null).trigger("change");
                    var eltos = data[i].eltos;
                    $(eltos).each(function() {
                        sel.append($("<option>").attr('value',this).text(this));
                    });
                }
            });
        }

    });    
    
    // Crear pdf de reporte estratégico
    $('#btn-pdf').click(function(){
        if(chart.hasRendered()){
            $('#tmp').show();
            $('#tmp').css('visibility', 'hidden');
            var tmp = chart.clone();
            tmp.resizeTo(750, 600);
            var subCaption = chart.getChartAttribute("subCaption");
            tmp.setChartAttribute('subCaption', ' ');
            tmp.render('tmp');
            
            var svgString = tmp.getSVGString();
            $("#tmp").hide();
            imagenesSVG = "data:image/svg+xml;base64,"+ window.btoa(unescape(encodeURIComponent( svgString)));

            var ajusteImg = 2.00;
            var ajusteImg2 = 2.00;

            if (svgString === undefined){
                return false;
            }

            var img = new Image();
            var imagen = new Image();

            imagen.src = "data:image/svg+xml;base64,"+ window.btoa(unescape(encodeURIComponent( svgString)));
            imagen.onload = function() {
                var canvas = document.createElement( "canvas" );
                var ctx = canvas.getContext( "2d" );
                canvas.width = imagen.width*ajusteImg;
                canvas.height = imagen.height*ajusteImg;
                ctx.drawImage( imagen, 0, 0,imagen.width*ajusteImg2,imagen.height *ajusteImg2);
                img.src = canvas.toDataURL( "image/png" );
            };
            imagen.onerror = function() {}
            img.onload = function() {
                crearPDF(img, subCaption);
            };
        }
    });

    // $('#showreport').on('click', function () {
    $('.showreport').on('click', function () {
        getReport();
        $('#strategicreport').modal({
            backdrop: 'static',
            keyboard: false
        });
    });

// Funciones Funciones encargadas de el Proceso de Compartir
// Autor: Jonathan Martinez Fecha:21 Febrero del 2017

//Funcion que Cambia la presentacion del boton de compartir
function  buttonShare(action) {
    if(action == 'edit-sr'){
        $('.sharereport').show();
        $('.relationreport').show();
        $('#buttonConfig3').text('Actualizar');
        $('#buttonConfig3').removeClass('save-share').addClass('update-share');
    }
    else{
        $('.sharereport').hide();
        $('.relationreport').hide();
        $('#buttonConfig3').text('Guardar');
        $('#buttonConfig3').removeClass('update-share').addClass('save-share');     
    }     
   
}

// Funcion Muestra Usuarios para Compartir
function getShareUser(){
    $.post('consultaVistaMat/getShareUser',{
        idReporte : num_reporte
    }, function(data){
        $('#table-share').html( data );
    });
}

//Accion para Mostrar el Menu de Compartir
    $('.sharereport').on('click', function () {
        getShareUser();
        $('#shareConfirmation').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
 //Accion para Mostrar el Menu de Relacionar
    $('.relationreport').on('click', function () {
         $.ajax({
             url: '/index.cfm/reportesEstrategicos/consultaVistaMat/getRelationReportes',
             type: 'POST',
             data: {
             idReporte : num_reporte
             }
         }).done(function(data) {
         $('#table-relation').html( data );
         $('#relationConfirmation').modal({
            backdrop: 'static',
            keyboard: false
        });
    });
    });
//Accion para guardar la Relación
     $('#save-relation').on('click', function () {
         index=$('#reportes').children(":selected").attr("id");;
         $.ajax({
             url: '/index.cfm/reportesEstrategicos/consultaVistaMat/agregarRelacion',
             type: 'POST',
             dataType: 'json',
             data: {
             idRep : num_reporte, idRela: index 
             }
         }).done(function(data) {
             toastr.success('Relación guardada.','Reporte estratégico');
             $('#relationConfirmation').modal('hide');
         });
     });

   

    $('#buttonConfig').on('click', function () {
        if ($('#formRE').valid() && $('#formRE2').valid()) {
            
            if ($(this).hasClass('save-sr')){
                
                $('.title-save').text('Guardar reporte estratégico');
                $('#buttonConfig2').text('Guardar');
                $('#buttonConfig2').removeClass('update-sr').addClass('save-sr');
            }
            else {
                $('.title-save').text('Actualizar reporte estratégico');
                $('#buttonConfig2').text('Actualizar');
                $('#buttonConfig2').removeClass('save-sr').addClass('update-sr');
            }

            $('#saveConfirmation').modal('toggle');
        }
    });

    $('#buttonConfig2').on('click', function () {
        if ($('#formSave').valid()) {
            var reporte_Est = {};

            //guardar parametros
            var param = [];
            param.push({name: $(".list-group-item .iconactive:visible").attr("id"), value:$(".list-group-item .iconactive:visible").attr("data-type")});
            param.push({name: "ejeY", value:$("input[name=h]:checked").val()});
            param.push({name: "ejeX", value:$('[name="ejeX"]').val()});
            param.push({name: "etiqueta", value:$('#etiqueta').val()});
            param.push({name: "operacion", value:$('#operacion').val()});
            reporte_Est["parametros"] = param;

            //guardar preferencias            
            var config = [];
            var status;
            $(".config input").each(function(){
                if($(this).parent().hasClass('off'))
                    status = "off";
                else
                    status = "on";
                config.push({ name: $(this).attr("id"), value: status});
            });
            reporte_Est["config"] = config;
            
            //guardar filtros
            var filtros = [];
            $(".opc").each(function(){
                if($(this).val().length != 0){
                    
                    filtros.push({ name: $(this).attr("id"), value: $(this).val(), tipo: $(this).closest('div .tipo').attr('data-type'), desc: $(this).parent().parent().find('label').clone().children().remove().end().text() });
                }

                else{

                    
                    if ($(this).parents('#depen').length ) {
            
                       var inde = [];
                        $(this).children().each(function(){
                          inde.push($(this).val());
                     });
                        
                            filtros.push({  name: $(this).attr("id") , value:inde , tipo: $(this).closest('div .tipo').attr('data-type') , desc: $(this).parent().parent().find('label').clone().children().remove().end().text() });
                    }
                }



            });

            reporte_Est["filtros"] = filtros;
            console.log(reporte_Est["filtros"]);
            //return;
            if ($(this).hasClass('save-sr')) {
                 $.post('consultaVistaMat/agregarConfiguracion', {
                    config: JSON.stringify(reporte_Est),
                    desc: $('[name="desc_usr"]').val(),
                    nombre: chart.getChartAttribute("caption")}, function(data){
                    if(data > 0){
                        num_reporte=data; // Rescato la clave del reporte que estoy utilizando
                        $(".totalSR").text($('#tablaReportes').bootstrapTable('getOptions').totalRows+1);
                        toastr.success('Guardado exitosamente.','Reporte estratégico');
                        $('#saveConfirmation').modal('hide');
                        $('#shareConfirmation').modal('toggle');
                        getShareUser();
                    }
                });
            }
            else {
                $.post('consultaVistaMat/editarReporte', {
                        num: num_reporte,
                        name: chart.getChartAttribute("caption"),
                        desc: $('[name="desc_usr"]').val(),
                        config: JSON.stringify(reporte_Est)
                    }, function(data){
                        if(data > 0){
                            toastr.success('Actualizado exitosamente.','Reporte estratégico');
                            // Boton: guardar reporte
                            toggleButton('update-sr', 'save-sr');
                            $('#saveConfirmation').modal('toggle');
                        }
                });
            }
        }
        // else { } show notification
    });

   

    
    /* VISTA PREVIA PARA CONSULTA O BASE PARA NUEVO REPORTE */
    var tableSR = $('#table-sr');
    window.actionEvents = {
        'click .view-sr': function (e, value, row, index) {
            var option = $(this).closest('tr').find('img').attr('id');
            if(row.privilegio == ""){
                privilegio = "1";
            }
            else{
                privilegio = row.privilegio;
            }   
            num_reporte = option;  
            descRp = row.desc;      
            searchReport(option, row.desc, privilegio,0,"");
/*
            if(localStorage.getItem("collapse_filters") == 'off'){
                hideConfig();
                // localStorage.setItem("collapse_filters",'on');
                $('#collapsefilters').prop('checked','checked');
            }
*/
            if($(".parametro").find('i').hasClass('fa-chevron-up')){
                var ibox = $('.parametro');
                var button = ibox.find('i');
                var content = ibox.find('div.ibox-content');
                content.slideToggle(200);
                button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
                ibox.toggleClass('').toggleClass('border-bottom');
                setTimeout(function () {
                    ibox.resize();
                    ibox.find('[id^=map-]').resize();
                }, 70);
            }
            //Oculto el Boton de compartir y cambio label
            buttonShare("view-sr");
            toggleButton('update-sr', 'save-sr');
        },
         'click .copy-sr': function (e, value, row, index) {

            var option = $(this).closest('tr').find('img').attr('id');
            var img = row.tipo;
            var id = row.id;
            var name = row.nombre;
            var desc = row.desc;
            var date = row.fecha;

            $(".copyText").text("¿Confirma que desea copiar el reporte con nombre: " + name + "?" );
            $(".copyText").attr("id", id);
            $(".copyText").attr("num", option);
            $(".copyText").attr("name", name);
            $(".copyText").attr("desc", desc);
            $(".copyText").attr("img", img);
            $(".copyText").attr("date", date);
           
            //unique id
            $('#strategicreport').hide();
            $('#copyConfirmation').modal('toggle');
    
            
          
        },
        'click .edit-sr': function (e, value, row, index) {
            num_reporte = $(this).closest('tr').find('img').attr('id');
            descRp = row.desc;
            searchReport(num_reporte, row.desc, row.privilegio,0,"");
/*
            if(localStorage.getItem("collapse_filters") == 'on'){
                showConfig();
                // localStorage.setItem("collapse_filters",'off');
                $('#collapsefilters').prop('checked','');
            }
  */          
            if($(".parametro").find('i').hasClass('fa-chevron-down')){
                var ibox = $('.parametro');
                var button = ibox.find('i');
                var content = ibox.find('div.ibox-content');
                content.slideToggle(200);
                button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
                ibox.toggleClass('').toggleClass('border-bottom');
                setTimeout(function () {
                    ibox.resize();
                    ibox.find('[id^=map-]').resize();
                }, 50);
            }
             //Muestro el Boton de compartir y cambio label de modal
            buttonShare("edit-sr");
            toggleButton('save-sr', 'update-sr');
        },
        'click .delete-sr': function (e, value, row, index) {
            var option = $(this).closest('tr').find('img').attr('id');
            var id = row.id;
            var name = row.nombre;

            $(".deleteText").text("¿Confirma que desea eliminar el reporte con nombre: " + name + "?" );
            $(".deleteText").attr("num", option);
            //unique id
            $(".deleteText").attr("id", id);
            $('#strategicreport').hide();
             //Oculto el Boton de compartir y cambio label
            buttonShare("delete-sr");
        }
    };

//copyReporte
     $('#copyConfirmation .confirm-copy-sr').click(function() {
        var reporte = $('#copyConfirmation').find('p').attr('num');
        var id = $('#copyConfirmation').find('p').attr('id');
        var img = $('#copyConfirmation').find('p').attr('img');
        var name = $('#copyConfirmation').find('p').attr('name');
        var desc = $('#copyConfirmation').find('p').attr('desc');
        var date = $('#copyConfirmation').find('p').attr('date');
        
     //   copyTable(reporte, id, img, name, desc, date);
     //   insertCopyConfirm(reporte, id);
        copyConfirm(reporte, id, img, name, desc, date);
        $('#copyConfirmation').modal('toggle');
     
     //   toastr.success('Elemento copiado exitosamente.','Reporte estratégico',{positionClass: 'toast-top-center'});
    });


    function copyTable(reporte, id, img, name, desc, date) {
        var randomId = 10;
        $("#tablaReportes").bootstrapTable('insertRow', {
            index: 0,
            row: {
                id: reporte,
                categoria: "Propio", 
                tipo: img,
                nombre: name,
                desc: desc,
                fecha: date  
            }
        });
    }
    
    function copyConfirm(option, id, img, name, desc, date){
        $.post('consultaVistaMat/copyReporte',
            { idReporte: option }, function(data){
            if(data > 0){
          //      $("#totalSR").text($('#tablaReportes').bootstrapTable('getOptions').totalRows);
            copyTable(data, id, img, name, desc, date);
            $("#totalSR").text($('#tablaReportes').bootstrapTable('getOptions').totalRows); 
            toastr.success('Elemento copiado exitosamente.','Reporte estratégico',{positionClass: 'toast-top-center'});
            }
            else{
                toastr.success('Error al copiar elemento.','Reporte estratégico',{positionClass: 'toast-top-center'});
         
            }
        })
    }


    $('#deleteConfirmation .confirm-delete-sr').click(function() {
        var reporte = $('#deleteConfirmation').find('p').attr('num');
        var id = $('#deleteConfirmation').find('p').attr('id');
        
        deleteConfirm(reporte);
        $('#deleteConfirmation').modal('toggle');
        $("#tablaReportes").bootstrapTable('removeByUniqueId', id);
        $('#strategicreport').show();

        // Boton: guardar reporte
        toggleButton('update-sr', 'save-sr');
    });

    function deleteConfirm(option){
        $.post('consultaVistaMat/eliminarReporte',
            { reporte: option }, function(data){
            if(data > 0){
                $("#totalSR").text($('#tablaReportes').bootstrapTable('getOptions').totalRows);
                toastr.success('Eliminado exitosamente.','Reporte estratégico',{positionClass: 'toast-top-center'});
            }
        })
    }
    
    

    /* VALIDACIONES */
    $.validator.addMethod("valueNotEqual", function(value, element, arg){
        return arg != value;
    }, "Seleccione una opción.");

    $.validator.addMethod("timeNotEqual", function(value, element, arg){
        return arg != value;
    }, "Selecione una opción de tiempo para los indicadores.");

    // Validar form
    $.validator.setDefaults({
        //debug: true,
        success: "valid"
    });

    $('#formRE').validate({
        ignore: [],
        submitHandler: function(form){
            //return false;
        },
    });

    $('#formRE2').validate({
        rules: {
            ejeX:  "required",
            operacion: "required"
        },
        messages: {
            ejeX: "Seleccione una opción.",
            operacion: "Selecione una operación."
        },
        submitHandler: function(form){
            return false;
        }
    });

    $('#formSave').validate({
        rules: {
            desc_usr: "required"
        },
        messages: {
            desc_usr:  "Es necesario incluir una descripción para el reporte estratégico creado."    
        },
        submitHandler: function(form){
            // return false;
        }
    });
    
    // Validar todo el formulario
    $('#graficar').on('click', function () {
        if ($('#formRE').valid() && $('#formRE2').valid()) {
            if(dimGrafica === undefined){ 
                //Cuando no se tiene ninguna configuracion pre establecida
                if($('#etiqueta').val() == 0){
                    tipoGrafica = "pie";
                    dimGrafica = "2d";
                }
                else{
                    tipoGrafica = "msarea";
                    dimGrafica = "";
                }
            }
            else{
                if ($(".list-group-item .iconactive:visible").attr("data-dim") == 0)
                    dimGrafica = '';
                else
                    dimGrafica = '2d';    
            }

            var configInicio = [];            
            obtenerDatos(tipoGrafica, dimGrafica, configInicio,1,"");
        }
    });


    //REMOVER REGLA PARA VALIDACIÓN DE DIM TIEMPO...
    // $('[name="ejeX"]').change(function(){
    //     $("#tiempo select").rules( "remove", "timeNotEqual" );
    // });
        
    //Ocultar tipo de gráfica de acuerdo al número de parametros
    $("#tipoGrafica2").hide();
    $('#etiqueta').change(function(){
        cambiarTipoGrafica();
        tipoGrafica = $(".list-group-item .iconactive:visible").attr("data-type");
    });

    crearComponente();

    /* NO DUPLICAR VALORES EN EJE X & ETIQUETAS */
    $('.param').change(function(){
        valor = $("option:selected", this).attr('data-name');
        $elemento = $(".param").not($(this));
        $elemento.children("option").each(function () {
            if($(this).attr('data-name') == valor)
                $(this).prop('disabled', true);
            else
                $(this).prop('disabled', false);
        });
        //select
        $elemento.select2('destroy').select2({placeholder: "Seleccionar una opción", language: "es",allowClear: true});
        createLabel($elemento);
    });


    /* INVERTIR PARAMETROS EN LA GRÁFICA */
    $('#exchange').on('click', function(){
        v1 = $('[name="ejeX"]').val();
        v2 = $('#etiqueta').val();

        if(v1 != 0 && v2 !=0){
            $('[name="ejeX"] option:selected').attr('disabled','disabled').siblings().removeAttr('disabled');
            $("#etiqueta option:selected").attr('disabled','disabled').siblings().removeAttr('disabled');
            $('[name="ejeX"]').val(v2).trigger("change");
            $('#etiqueta').val(v1).trigger("change");

            if ($('#formRE').valid() && $('#formRE2').valid()) {
                if ($(".list-group-item .iconactive:visible").attr("data-dim") == 0)
                    dimGrafica = '';
                else
                    dimGrafica = '2d';
                var configInicio = [];
                obtenerDatos(tipoGrafica, dimGrafica, configInicio,1,"");
            }
        }    
    });

    ////  CONFIGURACIONES DE UNA GRÁFICA /////

    /* CONFIG */
    function configChart(tipo, dim, multi){
        if(multi == 1){
            chart.chartType(tipo+dim);
        }
        else{
            chart.chartType(tipo);
        }
    }
    
    /* DIMENSIÓN DE LA GRÁFICA */
    $('#dimension').change(function() {
        if($(this).prop('checked') == false) {
            configChart(tipoGrafica, '3d', multi);
            if (tipoGrafica == "mscolumn3d") {
                $("#logaritmica").bootstrapToggle('enable');
            }
            else
                $("#logaritmica").bootstrapToggle('disable');
        }
        else{
            configChart(tipoGrafica, '2d', multi);
            if (tipoGrafica == "mscolumn") {
                $("#logaritmica").bootstrapToggle('enable');
            }
            else
                $("#logaritmica").bootstrapToggle('disable');
        }
    });

    /* OCULTAR/MOSTRAR VALORES */
    $('#valor').change(function() {
        if($(this).prop('checked') == false)
            chart.setChartAttribute('showValues', 1);
        else
            chart.setChartAttribute('showValues', 0);
    });

    /* OCULTAR/MOSTRAR VALORES */
    $('#logaritmica').change(function() {
        //REVISAR LA COMBINACIÓN ENTRE VALOR DE DIMENSION Y DE LOGARITMICA
        if($(this).prop('checked') == false){
            configChart(tipoGrafica, '2d', multi);
            if (tipoGrafica == "mscolumn") {
                $("#dimension").bootstrapToggle('enable');
            }
            else
                $("#dimension").bootstrapToggle('disable');
        }
        else{
            configChart('Log' + tipoGrafica, '2d', multi);
            if (tipoGrafica == "mscolumn" || tipoGrafica == "msline") {
                $("#dimension").bootstrapToggle('disable');
            }
            else
                $("#dimension").bootstrapToggle('enable');
        }
    });

    /* ROTAR VALORES */
    $('#rotar').change(function() {
        if($(this).prop('checked') == false)
            chart.setChartAttribute('rotateValues', 1);
        else
            chart.setChartAttribute('rotateValues', 0);
    });

    /* TIPO DE GRÁFICA */
    $(".list-group-item").each(function(){
        $(this).click(
            function(){
                if ($('#formRE').valid() ) {
                    tipoGrafica = $(this).find("img").attr('id');
                    grupo = $(this).closest('div .list-group').attr('id');
                    setClassIcon(tipoGrafica, grupo);
                    setConfig(tipoGrafica);
                    configChart(tipoGrafica, '2d', multi);
                }
            }
        );
    });

    //Cerrar modal delete - NO
    $('#deleteConfirmation').on('hidden.bs.modal', function () {
        $('#strategicreport').show();
    })
    //Cerrar modal copy - NO
    $('#copyConfirmation').on('hidden.bs.modal', function () {
        $('#strategicreport').show();
    })

    // Descripción del reporte
    $(".descripcion textarea").blur(function(event){
        setTimeout(function(){
            var el=$("#modificar-desc");
            var descNueva=el.parent().siblings("textarea").val();
            if(descNueva.length===0){
              return;
            }
        },10);
    });

});


$(function () {

//*************** Config checkbox ***************//

    $('.button-checkbox').each(function () {

        // Settings
        var $widget = $(this),
            $button = $widget.find('button'),
            $checkbox = $widget.find('input:checkbox'),
            color = $button.data('color'),
            settings = {
                on: {
                    icon: 'glyphicon glyphicon-check'
                },
                off: {
                    icon: 'glyphicon glyphicon-unchecked'
                }
            };

        // Event Handlers
        $button.on('click', function () {
            $checkbox.prop('checked', !$checkbox.is(':checked'));
            $checkbox.triggerHandler('change');
            updateDisplay();
        });
        $checkbox.on('change', function () {
            updateDisplay();
        });

        // Actions
        function updateDisplay() {
            var isChecked = $checkbox.is(':checked');

            // Set the button's state
            $button.data('state', (isChecked) ? "on" : "off");

            // Set the button's icon
            $button.find('.state-icon')
                .removeClass()
                .addClass('state-icon ' + settings[$button.data('state')].icon);

            // Update the button's color
            if (isChecked) {
                $button
                    .removeClass('btn-default')
                    .addClass('btn-' + color + ' active');
            }
            else {
                $button
                    .removeClass('btn-' + color + ' active')
                    .addClass('btn-default');
            }
        }

        // Initialization
        function init() {

            updateDisplay();

            // Inject the icon if applicable
            if ($button.find('.state-icon').length == 0) {
                $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
            }
        }
        init();
    });

});

function crearPDF(imgData, filtroDesc){
    var filtros = "";
    // var desc = [];
    $(".opc").each(function(){
        if($(this).val() != null ){
            filtros += $(this).attr("id") + "-" + $(this).val() + "*";
            // desc.push({val: $(this).val(), text: $(this).parent().parent().find('label').clone().children().remove().end().text()});
        }
    });
    et = $('#etiqueta').val().length == 0 ? 0 : $('#etiqueta').val();
    var param = "0-" + $('[name="ejeX"]').val() + ".1-" + $("input[name=h]:checked").val() + ".2-" + $('#operacion').val() + ".3-" + et;

    $.post('consultaVistaMat/getPDF', { param : param, filtros : filtros }, function(data){
        
        $('#div_qr').html(data);
        var doc = new jsPDF();

        /* header */
        doc.addImage(logoSII,'png', 20, 15, 30, 20, 'sii');
        doc.addImage(logoIPN,'png', 175, 15.5, 12, 18, 'ipn');
        doc.setFontSize(18);
        doc.setTextColor(70);
        doc.text(72, 25, 'Instituto Politénico Nacional');
        doc.setFontSize(12);
        doc.text(77, 30, 'Sistema Institucional de Información');
        
        doc.setFontSize(10);
        doc.setTextColor(255);
        doc.setFillColor(153, 153, 153);
        doc.rect(15, 40, 180, 6, 'F');
        doc.setFont('arial', 'bold');
        doc.text(86, 44.5, 'REPORTE ESTRATÉGICO');

        /* body */
        doc.setFontSize(10);
        doc.setTextColor(70);
        doc.text(17, 55, 'Sección:');
        doc.text(17, 63, 'Descripción:');
        doc.rect(40, 51, 155, 6, 'D');
        doc.rect(40, 59, 155, 14, 'D');
        doc.setFont('arial', 'normal');
        
        <cfoutput>
        doc.text(43, 55, '#Session.cbstorage.conjunto.titulo#');
        var splitDesc = doc.splitTextToSize('#Session.cbstorage.conjunto.desc#', 132);
        doc.text(43, 63, splitDesc);
        </cfoutput>

        doc.setFillColor(153, 153, 153);
        doc.rect(15, 80, 180, 6, 'F');
        doc.setFontSize(10);
        doc.setTextColor(255);
        doc.setFont('arial', 'bold');
        doc.text(86, 84.5, 'FILTROS SELECCIONADOS');
        
        var descripcion = [];
        var valor = [];
        var elemento = filtroDesc.split(' | ');

        for (var i = 0; i < elemento.length; i++) {
            descripcion.push(elemento[i].split(': ')[0]);
            valor.push(elemento[i].split(': ')[1]);
        };

        var top = 92;
        doc.setTextColor(70);
        if (elemento[0].length == 0){
        // if (desc.length == 0){
            doc.setFont('arial','normal');
            doc.text(56, top, "Para este reporte estratégico no fue seleccionado ningún filtro.");
            top += 5;
        }
        else {
            for (var i = 0; i < descripcion.length; i++) {
                splitElto = doc.splitTextToSize(descripcion[i] + ':', 35);
                splitVal = doc.splitTextToSize(valor[i], 122);
                doc.setFont('arial','bold');
                doc.text(17, top, splitElto);
                doc.setFont('arial','normal');
                doc.text(58, top, splitVal);
                lines = Math.max(splitElto.length, splitVal.length) * 5;
                if ( lines > 1 )
                    top += lines;
            };
        }

        doc.addImage(imgData,'png', 30, top, 150, 0, 'grafica');

        /* footer */
        doc.line(15, 260, 195, 260);
        doc.setFontSize(8);
        doc.setTextColor(70);

        doc.setFillColor(206, 206, 206);
        doc.rect(15, 267, 21, 6, 'F');
        doc.rect(15, 274, 21, 6, 'F');
        doc.text(17, 271, 'Imprimió:');
        doc.text(17, 278, 'Fecha y hora:');

        doc.setFillColor(235, 235, 235);
        doc.rect(36, 267, 120, 6, 'F');
        doc.rect(36, 274, 120, 6, 'F');
        <cfoutput>
        doc.text(38, 271, '#Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT# #Session.cbstorage.usuario.AP_MAT#');
        doc.text(38, 278, '#LSDateFormat(now(),"long", "Spanish (Standard)")#, ' + '#TimeFormat(now(), "HH:mm")#');
        </cfoutput>

        doc.text(167, 288, 'Página 1 de 1');
        var imgQR = new Image();
        imgQR.src = $('#div_qr').find('img').attr('src');
        imgQR.onload = function(){
            doc.addImage(imgQR, 'png', 163, 261, 25, 25);
            doc.save('<cfoutput>#Session.cbstorage.conjunto.TITULO#</cfoutput>.pdf');
        };
    });

}

</script>