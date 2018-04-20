<script type="text/javascript">

	var chart;
	var chart2;
	var chart3;
	var chart4;
	var chart5;
	var chart6;
	var chart7;
	<cfif IsArray(prc.INFORMACION.CANTIDAD_ERROR)>
		chart = AmCharts.makeChart("chartdiv", {
			"type": "serial",
			"theme": "light",
			"pathToImages": "/includes/js/jquery/amcharts/images/",
			"autoMargins": true,
			"titles": [{"text": "Tipos de errores ocurridos dentro del sistema"}],
			"dataProvider": [
				<cfset separador = "">
				<cfoutput>
					<cfloop index="w" from="1" to="#ArrayLen(prc.INFORMACION.CANTIDAD_ERROR)#">
						#separador#
						{
							"country": "#prc.INFORMACION.CANTIDAD_ERROR[w].ELEMENTO#",
							"visits": #ArrayLen(prc.INFORMACION.CANTIDAD_ERROR[w].PK_ELEMENTS)#,
							"color": getColor()
						}
						<cfset separador = ",">
					</cfloop>
				</cfoutput>
			],
			"startDuration": 3,
			"depth3D": 20,
			"angle": 30,
			"chartCursor": {
				"categoryBalloonEnabled": true,
				"valueLineEnabled":true,
				"cursorAlpha": 0,
				"zoomable": true
			},
			"graphs": [{
				"alphaField": "alpha",
				"balloonText": "<b>[[value]]</b>",
				"dashLengthField": "dashLengthColumn",
				"fillAlphas": 1,
				"title": "visits",
				"type": "column",
				"valueField": "visits",
				"colorField": "color",
				"showHandOnHover": true,
				"topRadius":1
			}],
			"valueAxes": [{
				"title": "Nmero de errores"
			}],
			"categoryField": "country",
			"categoryAxis": {
				"gridPosition": "start",
				"axisAlpha":0,
				"tickLength": 0,
				"labelsEnabled": false,
				"ignoreAxisWidth":true,
				"labelRotation": 45
			},
			exportConfig: {
				menuTop: "21px",
				menuBottom: "auto",
				menuRight: "21px",
				backgroundColor: "#efefef",
				menuItemStyle	: {
				backgroundColor			: '#EFEFEF',
				rollOverBackgroundColor	: '#DDDDDD'},
				menuItems: [{
					textAlign: 'center',
					icon: '/includes/js/jquery/amcharts/images/export.png',
					iconTitle: 'Exportar grafico',
					onclick:function(){return false;},
					items: [{
						title: 'JPG',
						format: 'jpg'
					}, {
						title: 'PNG',
						format: 'png'
					}, {
						title: 'PDF',
						format: 'pdf',
						output:'save',
						fileName:"Reporte 1",
						fit: [612,792] // fit image to Letter
					}]
				}]
			}
		},0);
	</cfif>
	
	chart2 = AmCharts.makeChart("chartdiv2", {
		"type": "serial",
		"theme": "dark",
		"marginRight": 70,
		"pathToImages": "/includes/js/jquery/amcharts/images/",
		"titles": [{"text": "Tipos de navegadores empleados dentro del sistema"}],
		"dataProvider": [
			<cfset separador = "">
			<cfoutput>
				<cfloop index="w" from="1" to="#prc.INFORMACION.NAVEGADORES.USADOS.recordCount#">
					#separador#
					{
						"country": "#prc.INFORMACION.NAVEGADORES.USADOS.NAVEGADOR[w]# #prc.INFORMACION.NAVEGADORES.USADOS.VERSION[w]#",
						"visits": #prc.INFORMACION.NAVEGADORES.USADOS.TOTAL_VERSIONES[w]#,
						"color": getColor()
					}
					<cfset separador = ",">
				</cfloop>
			</cfoutput>
		],
		"valueAxes": [{
			"axisAlpha": 0,
			"position": "left",
			"title": "Total de navegadores"
		}],
		"startDuration": 1,
		"depth3D": 20,
		"angle": 30,
		"graphs": [{
			"balloonText": "<b>[[value]]</b>",
			"fillColorsField": "color",
			"fillAlphas": 0.9,
			"lineAlpha": 0.2,
			"type": "column",
			"valueField": "visits"
		}],
		"chartCursor": {
			"categoryBalloonEnabled": true,
			"cursorAlpha": 0,
			"zoomable": true
		},
		"categoryField": "country",
		"categoryAxis": {
			"gridPosition": "start",
			"labelRotation": 45
		},
		"export": {
			"enabled": true
		},
		exportConfig: {
			menuTop: "21px",
			menuBottom: "auto",
			menuRight: "21px",
			backgroundColor: "#efefef",
			menuItemStyle	: {
			backgroundColor			: '#EFEFEF',
			rollOverBackgroundColor	: '#DDDDDD'},
			menuItems: [{
				textAlign: 'center',
				icon: '/includes/js/jquery/amcharts/images/export.png',
				iconTitle: 'Exportar grafico',
				onclick:function(){return false;},
				items: [{
					title: 'JPG',
					format: 'jpg'
				}, {
					title: 'PNG',
					format: 'png'
				}, {
					title: 'PDF',
					format: 'pdf',
					output:'save',
					fileName:"Reporte 1",
					fit: [612,792] // fit image to Letter
				}]
			}]
		}
	});
	
	chart3 = AmCharts.makeChart("chartdiv3", {
		"type": "serial",
		"theme": "light",
		"pathToImages": "/includes/js/jquery/amcharts/images/",
		"autoMargins": true,
		"titles": [{"text": "Conteo de los usuarios que han generado alg�n tipo de error"}],
		"dataProvider": [
			<cfset separador = "">
			<cfoutput>
				<cfloop index="w" from="1" to="#prc.INFORMACION.CANTIDAD_USUARIO.recordCount#">
					#separador#
					{
						"category": "#prc.INFORMACION.CANTIDAD_USUARIO.NOMBRE_COMPLETO[w]#",
						"monto": #prc.INFORMACION.CANTIDAD_USUARIO.TOTAL[w]#,
						"color": getColor()
					}
					<cfset separador = ",">
				</cfloop>
			</cfoutput>
		],
		"startDuration": 1,
		"depth3D": 40,
		"angle": 30,
		"chartCursor": {
			"categoryBalloonEnabled": true,
			"cursorAlpha": 0,
			"zoomable": true
		},
		"graphs": [{
			"alphaField": "alpha",
			"balloonText": "<span style='font-size:13px;'>No. de ocasiones: <b>[[value]]</b></span>",
			"dashLengthField": "dashLengthColumn",
			"fillAlphas": 1,
			"title": "Monto",
			"type": "column",
			"valueField": "monto",
			"colorField": "color",
			"showHandOnHover": true,
			"topRadius":1,
		}],
		"valueAxes": [{
			"title": "No. de ocasiones"
		}],
		"categoryField": "category",
		"categoryAxis": {
			"gridPosition": "start",
			"axisAlpha": 0,
			"tickLength": 0,
			"labelsEnabled": false,
			"ignoreAxisWidth":true,
			"labelRotation": 45
		},
		exportConfig: {
			menuTop: "21px",
			menuBottom: "auto",
			menuRight: "21px",
			backgroundColor: "#efefef",
			menuItemStyle	: {
			backgroundColor			: '#EFEFEF',
			rollOverBackgroundColor	: '#DDDDDD'},
			menuItems: [{
				textAlign: 'center',
				icon: '/includes/js/jquery/amcharts/images/export.png',
				iconTitle: 'Exportar grafico',
				onclick:function(){return false;},
				items: [{
					title: 'JPG',
					format: 'jpg'
				}, {
					title: 'PNG',
					format: 'png'
				}, {
					title: 'PDF',
					format: 'pdf',
					output:'save',
					fileName:"Reporte 1",
					fit: [612,792] // fit image to Letter
				}]
			}]
		}
	});
	
	<cfif IsQuery(prc.INFORMACION.ERRORES_USUARIO)>
		var legend;
		var selected;
		
		var types = [
			<cfset separador = "">
			<cfset datoNRep = "">
			<cfoutput>
				<cfloop index="w" from="1" to="#prc.INFORMACION.ERRORES_USUARIO.recordCount#">
					<cfif datoNRep NEQ prc.INFORMACION.ERRORES_USUARIO.NOMBRE_COMPLETO[w]>
						#separador#
						{
							type: "#prc.INFORMACION.ERRORES_USUARIO.NOMBRE_COMPLETO[w]#",
							color: getColor(),
							subs: [
								<cfset separator = "">
								<cfset total_inf = 0>
								<cfloop index="r" from="1" to="#prc.INFORMACION.ERRORES_USUARIO.recordCount#">
									<cfif prc.INFORMACION.ERRORES_USUARIO.NOMBRE_COMPLETO[w] EQ prc.INFORMACION.ERRORES_USUARIO.NOMBRE_COMPLETO[r]>
										<cfset total_inf += prc.INFORMACION.ERRORES_USUARIO.TOTAL[r]>
										#separator#
										{
											type: "#prc.INFORMACION.ERRORES_USUARIO.CLAVE_ERROR[r]#",
											percent: #prc.INFORMACION.ERRORES_USUARIO.TOTAL[r]#
										}
										<cfset separator = ",">
									</cfif>
								</cfloop>
							],
							percent: #total_inf#
						}
						<cfset separador = ",">
					</cfif>
					<cfset datoNRep = prc.INFORMACION.ERRORES_USUARIO.NOMBRE_COMPLETO[w]>
				</cfloop>
			</cfoutput>
		];
	</cfif>
	
	chart6 = AmCharts.makeChart("chartdiv6", {
		"type": "serial",
		"theme": "light",
		"pathToImages": "/includes/js/jquery/amcharts/images/",
		"autoMargins": true,
		"titles": [{"text": "Numero de solicitudes por origen (PATH Referencia)"}],
		"dataProvider": [
			<cfset separador = "">
			<cfoutput>
				<cfloop index="w" from="1" to="#ArrayLen(prc.INFORMACION.PATHS.PATH_REF)#">
					#separador#
					{
						"category": "#prc.INFORMACION.PATHS.PATH_REF[w].ELEMENTO#",
						"monto": #ArrayLen(prc.INFORMACION.PATHS.PATH_REF[w].PK_ELEMENTS)#,
						"color": getColor()
					}
					<cfset separador = ",">
				</cfloop>
			</cfoutput>
		],
		"startDuration": 1,
		"depth3D": 20,
		"angle": 30,
		"chartCursor": {
			"categoryBalloonEnabled": true,
			"valueLineEnabled":true,
			"cursorAlpha": 0,
			"zoomable": true
		},
		"graphs": [{
			"alphaField": "alpha",
			"balloonText": "<span style='font-size:13px;'>PATH: <em><b>[[category]]</b></em>,<br />No. de ocasiones: <b>[[value]]</b></span>",
			"dashLengthField": "dashLengthColumn",
			"fillAlphas": 1,
			"title": "Monto",
			"type": "column",
			"valueField": "monto",
			"colorField": "color",
			"showHandOnHover": true,
			"topRadius":1
		}],
		"valueAxes": [{
			"title": "Numero de concurrencias"
		}],
		"categoryField": "category",
		"categoryAxis": {
			"gridPosition": "start",
			"axisAlpha": 0,
			"tickLength": 0,
			"labelsEnabled": false,
			"ignoreAxisWidth":true,
			"labelRotation": 45
		},
		exportConfig: {
			menuTop: "21px",
			menuBottom: "auto",
			menuRight: "21px",
			backgroundColor: "#efefef",
			menuItemStyle	: {
			backgroundColor			: '#EFEFEF',
			rollOverBackgroundColor	: '#DDDDDD'},
			menuItems: [{
				textAlign: 'center',
				icon: '/includes/js/jquery/amcharts/images/export.png',
				iconTitle: 'Exportar grafico',
				onclick:function(){return false;},
				items: [{
					title: 'JPG',
					format: 'jpg'
				}, {
					title: 'PNG',
					format: 'png'
				}, {
					title: 'PDF',
					format: 'pdf',
					output:'save',
					fileName:"Reporte 1",
					fit: [612,792] // fit image to Letter
				}]
			}]
		}
	},0);
	
	chart6.addListener("clickGraphItem", function (event) {
		var pksRegistros = $.trim($("#pathRef_"+replaceAll(replaceAll(replaceAll(replaceAll(event.item.category,"/","_"),".","_"),":","_")," ","")).val());
		if(pksRegistros != ""){
			$('#cargador-modal').modal('show');
			$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.consultaInformacion")#</cfoutput>',
				{pksRegistro: pksRegistros },
				function(data){
					$('#cargador-modal').modal('hide');
					$("#modal-title").html("<strong>PATH de referencia</strong>: <span class=\"label label-danger\">"+ event.item.category + "</span><br /><strong>No. concurrencias</strong>: <span class=\"badge\">" + event.item.values.value + "</span>" );
					$('#consultaRegistrosError').html( data );
					setTimeout(function(){$("#verInformacion").modal('show')},800);
			});
		}
	});
	
	chart7 = AmCharts.makeChart("chartdiv7", {
		"type": "serial",
		"theme": "light",
		"pathToImages": "/includes/js/jquery/amcharts/images/",
		"autoMargins": true,
		"titles": [{"text": "Numero de solicitudes por destino (PATH Solicitado)"}],
		"dataProvider": [
			<cfset separador = "">
			<cfoutput>
				<cfloop index="w" from="1" to="#ArrayLen(prc.INFORMACION.PATHS.PATH_SOL)#">
					#separador#
					{
						"category": "#prc.INFORMACION.PATHS.PATH_SOL[w].ELEMENTO#",
						"monto": #ArrayLen(prc.INFORMACION.PATHS.PATH_SOL[w].PK_ELEMENTS)#,
						"color": getColor()
					}
					<cfset separador = ",">
				</cfloop>
			</cfoutput>
		],
		"startDuration": 1,
		"depth3D": 20,
		"angle": 30,
		"chartCursor": {
			"categoryBalloonEnabled": true,
			"valueLineEnabled":true,
			"cursorAlpha": 0,
			"zoomable": true
		},
		"graphs": [{
			"alphaField": "alpha",
			"balloonText": "<span style='font-size:13px;'>PATH: <em><b>[[category]]</b></em>,<br />No. de ocasiones: <b>[[value]]</b></span>",
			"dashLengthField": "dashLengthColumn",
			"fillAlphas": 1,
			"title": "Monto",
			"type": "column",
			"valueField": "monto",
			"colorField": "color",
			"showHandOnHover": true,
			"topRadius":1
		}],
		"valueAxes": [{
			"title": "Numero de concurrencias"
		}],
		"categoryField": "category",
		"categoryAxis": {
			"gridPosition": "start",
			"axisAlpha": 0,
			"tickLength": 0,
			"labelsEnabled": false,
			"ignoreAxisWidth":true,
			"labelRotation": 45
		},
		exportConfig: {
			menuTop: "21px",
			menuBottom: "auto",
			menuRight: "21px",
			backgroundColor: "#efefef",
			menuItemStyle	: {
			backgroundColor			: '#EFEFEF',
			rollOverBackgroundColor	: '#DDDDDD'},
			menuItems: [{
				textAlign: 'center',
				icon: '/includes/js/jquery/amcharts/images/export.png',
				iconTitle: 'Exportar grafico',
				onclick:function(){return false;},
				items: [{
					title: 'JPG',
					format: 'jpg'
				}, {
					title: 'PNG',
					format: 'png'
				}, {
					title: 'PDF',
					format: 'pdf',
					output:'save',
					fileName:"Reporte 1",
					fit: [612,792] // fit image to Letter
				}]
			}]
		}
	},0);
	
	chart7.addListener("clickGraphItem", function (event) {
		var pksRegistros = $.trim($("#pathSol_"+replaceAll(replaceAll(replaceAll(replaceAll(event.item.category,"/","_"),".","_"),":","_")," ","")).val());
		if(pksRegistros != ""){
			$('#cargador-modal').modal('show');
			$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.consultaInformacion")#</cfoutput>',
				{pksRegistro: pksRegistros },
				function(data){
					$('#cargador-modal').modal('hide');
					$("#modal-title").html("<strong>PATH de solicitud</strong>: <span class=\"label label-danger\">"+ event.item.category + "</span><br /><strong>No. concurrencias</strong>: <span class=\"badge\">" + event.item.values.value + "</span>" );
					$('#consultaRegistrosError').html( data );
					setTimeout(function(){$("#verInformacion").modal('show')},800);
			});
		}
	});
	
	$(document).ready(function(e) {
		<cfif IsArray(prc.INFORMACION.CANTIDAD_ERROR)>
			$("#chartdiv").css("display","block");
			
			chart.addListener("clickGraphItem", function (event) {
				var pksRegistros = $.trim($("#ErrTp_"+replaceAll(replaceAll(replaceAll(replaceAll(event.item.category,"/","_"),".","_"),":","_")," ","")).val());
				if(pksRegistros != ""){
					$('#cargador-modal').modal('show');
					$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.consultaInformacion")#</cfoutput>',
						{pksRegistro: pksRegistros },
						function(data){
							$('#cargador-modal').modal('hide');
							$("#modal-title").html("<strong>Tipo de error</strong>: <span class=\"label label-danger\">"+ event.item.category + "</span><br /><strong>No. de errores</strong>: <span class=\"badge\">" + event.item.values.value + "</span>" );
							$('#consultaRegistrosError').html( data );
							setTimeout(function(){$("#verInformacion").modal('show')},800);
					});
				}
			});
			
			chart.addListener('init', function () {
				setTimeout(function() {
					chart.allLabels = [{
						x: chart.marginLeftReal + 20,
						y: chart.marginTopReal + 20,
						text: " ",
						size: 20,
						alpha: 0.3
					}];
					chart.validateNow();
				}, 100);
			});
			
			chart.startDuration = 0;
			chart.validateNow();
		</cfif>
		
		$("#chartdiv2").css("display","block");
		chart2.validateNow();
		chart2.validateData();
		chart2.animateAgain();
		$("#chartdiv3").css("display","block");
		
		<cfif IsQuery(prc.INFORMACION.ERRORES_USUARIO)>
			$("#chartdiv4").css("display","block");
			chart4 = AmCharts.makeChart("chartdiv4", {
				"type": "pie",
				"theme": "light",
				"titleField" : "type",
				"showHandOnHover": true,
				"titles": [{"text": "Porcentaje de los usuarios que generan errores / Porcentaje de los errores por usuario"}],
				"legend": {
					"markerType": "circle",
					"position": "right",
					"marginRight": 80,
					"autoMargins": false
				},
				"dataProvider":  generateChartData(),
				"valueField" : "percent",
				"outlineColor" : "#FFFFFF",
				"outlineAlpha" : 0.8,
				"outlineThickness" : 2,
				"colorField" : "color",
				"pulledField" : "pulled",
				exportConfig: {
					menuTop: "21px",
					menuBottom: "auto",
					menuRight: "21px",
					backgroundColor: "#efefef",
					menuItemStyle	: {
					backgroundColor			: '#EFEFEF',
					rollOverBackgroundColor	: '#DDDDDD'},
					menuItems: [{
						textAlign: 'center',
						icon: '/includes/js/jquery/amcharts/images/export.png',
						iconTitle: 'Exportar grafico',
						onclick:function(){return false;},
						items: [{
							title: 'JPG',
							format: 'jpg'
						}, {
							title: 'PNG',
							format: 'png'
						}, {
							title: 'PDF',
							format: 'pdf',
							output:'save',
							fileName:"Reporte 1",
							fit: [612,792] // fit image to Letter
						}]
					}]
				}
			});
			
			chart4.addListener("clickSlice", function (event) {
				if (event.dataItem.dataContext.id != undefined) {
					selected = event.dataItem.dataContext.id;
				} else {
					selected = undefined;
				}
				chart4.dataProvider = generateChartData();
				chart4.validateData();
			});
		</cfif>
		
		$("#chartdiv5").css("display","inline");
		
		chart5 = AmCharts.makeChart( "chartdiv5", {
			"type": "pie",
			"theme": "light",
			"startEffect" : "easeInSine",
			"legend": {
				"markerType": "diamond",
				"position": "left",
				"marginLeft": 80,
				"autoMargins": false
			},
			"titles": [{"text": "Informacion analizada"}],
			<cfoutput>
			"dataProvider": [{
				"REGISTROS": "Registros sin analizar",
				"VALOR": #ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_SIN_ANALIZAR)#,
				"DESC_REGISTRO" : $.trim($("##Sz_#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#").val()),
				"color": getColor()
			}, {
				"REGISTROS": "Registros analizados",
				"VALOR": #ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#,
				"DESC_REGISTRO" : $.trim($("##Az_#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#").val()),
				"color": getColor()
			}],
			</cfoutput>
			"valueField": "VALOR",
			"titleField": "REGISTROS",
			"descriptionField":"DESC_REGISTRO",
			"colorField" : "color",
			"labelsEnabled":true,
			"innerRadius":"25%",
			"outlineAlpha": 0.4,
			"depth3D": 15,
			"balloonText": "[[title]]<br /><span style='font-size:14px'><b>[[VALOR]]</b> ([[percents]]%)</span>",
			"angle": 30,
			"export": {
				"enabled": true
			},
			exportConfig: {
				menuTop: "21px",
				menuBottom: "auto",
				menuRight: "21px",
				backgroundColor: "#efefef",
				menuItemStyle	: {
				backgroundColor			: '#EFEFEF',
				rollOverBackgroundColor	: '#DDDDDD'},
				menuItems: [{
					textAlign: 'center',
					icon: '/includes/js/jquery/amcharts/images/export.png',
					iconTitle: 'Exportar grafico',
					onclick:function(){return false;},
					items: [{
						title: 'JPG',
						format: 'jpg'
					}, {
						title: 'PNG',
						format: 'png'
					}, {
						title: 'PDF',
						format: 'pdf',
						output:'save',
						fileName:"Reporte 1",
						fit: [612,792] // fit image to Letter
					}]
				}]
			}
		});
		
		chart5.addListener("clickSlice", function (event) {
			$('#cargador-modal').modal('show');
			$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.consultaInformacion")#</cfoutput>', {pksRegistro: event.dataItem.description }, function(data){
				$('#cargador-modal').modal('hide');
				$("#modal-title").html( event.dataItem.legendTextReal + " ( " + event.dataItem.value + " )" );
				$('#consultaRegistrosError').html( data );
				setTimeout(function(){$("#verInformacion").modal('show')},800);
			});
		});
		$("#chartdiv6").css("display","block");
		chart6.validateNow();
		
		$("#chartdiv7").css("display","block");
		chart7.validateNow();
	});
	
	function resetChart() {
		chart.dataProvider = chartData;
		chart.titles[0].text = ' - ';
		chart.validateData();
		chart.animateAgain();
	}
	
	function getColor(){
		var colores = ["#FF6600", "#FF9E01", "#FCD202","#2E8B57","#008080","#0000CD","#4B0082","#006400","#00008B","#DAA520","#FFA500","#B8860B","#D2691E","#008B8B","#696969","#6B8E23","#000080","#8B0000","#FFFFF0","#F8F8FF","#FFFAF0","#F0F8FF","#E0FFFF","#F0FFF0","#FFFFE0","#FFF5EE","#FFF0F5", "#DDDDDD", "#F8FF01", "#B0DE09", "#04D215", "#0D8ECF", "#0D52D1", "#2A0CD0", "#999999", "#333333", "#336699","#FFFF00","#40E0D0","#DEB887","#ADFF2F","#D2B48C","#48D1CC","#FFA07A","#66CDAA","#A9A9A9","#5F9EA0","#20B2AA","#F5F5F5","#FDF5E6","#FFF8DC","#FAF0E6","#FAFAD2","#6666CC","#6666FF","#669933", "#8A0CCF", "#FF0F00", "#CD0D74", "#754DEB","#6699CC","#6699FF","#66CC00","#66CC99"];
		return colores[Math.round(Math.random()*(colores.length/2)+5)];
	}
	
	function replaceAll(text, search, newstring ){
		while (text.toString().indexOf(search) != -1)
			text = text.toString().replace(search,newstring);
		return text;
	}
	
	function generateChartData () {
		var chartData = [];
		for (var i = 0; i < types.length; i++) {
			if (i == selected) {
				for (var x = 0; x < types[i].subs.length; x++) {
					chartData.push({
						type: types[i].subs[x].type,
						percent: types[i].subs[x].percent,
						color: types[i].color,
						pulled: true
					});
				}
			}
			else {
				chartData.push({
					type: types[i].type,
					percent: types[i].percent,
					color: types[i].color,
					id: i
				});
			}
		}
		return chartData;
	}
	
	function verDetalleError(obj){
		$('#cargador-modal').modal('show');
		$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.visualizaDetalleError")#</cfoutput>', {pkError: $(obj).attr("data-pkError") },
			function(data){
				$('#cargador-modal').modal('hide');
				$("#modal-detalle-title").html("Detalle del error" );
				$('#consultaDetalleError').html( data );
				setTimeout(function(){$("#consultarDetalleError").modal('show')},800);
		});
	}
</script>
<cfoutput>
	<form enctype="application/x-www-form-urlencoded" method="post" target="_top">
		<cfif IsArray(prc.INFORMACION.CANTIDAD_ERROR)>
			<cfloop index="w" from="1" to="#ArrayLen(prc.INFORMACION.CANTIDAD_ERROR)#">
				<textarea style="display:none;" name="ErrTp_#Replace(Replace(Replace(Replace(prc.INFORMACION.CANTIDAD_ERROR[w].ELEMENTO,'/','_','ALL'),'.','_','ALL'),' ','','ALL'),':','_','ALL')#" id="ErrTp_#Replace(Replace(Replace(Replace(prc.INFORMACION.CANTIDAD_ERROR[w].ELEMENTO,'/','_','ALL'),'.','_','ALL'),' ','','ALL'),':','_','ALL')#">
					#ArrayToList(prc.INFORMACION.CANTIDAD_ERROR[w].PK_ELEMENTS,',')#
				</textarea>
			</cfloop>
		</cfif>
		
		<cfif IsArray(prc.INFORMACION.PATHS.PATH_REF)>
			<cfloop index="w" from="1" to="#ArrayLen(prc.INFORMACION.PATHS.PATH_REF)#">
				<textarea style="display:none;" name="pathRef_#Replace(Replace(Replace(Replace(prc.INFORMACION.PATHS.PATH_REF[w].ELEMENTO,'/','_','ALL'),'.','_','ALL'),' ','','ALL'),':','_','ALL')#" id="pathRef_#Replace(Replace(Replace(Replace(prc.INFORMACION.PATHS.PATH_REF[w].ELEMENTO,'/','_','ALL'),'.','_','ALL'),' ','','ALL'),':','_','ALL')#">
					#ArrayToList(prc.INFORMACION.PATHS.PATH_REF[w].PK_ELEMENTS,',')#
				</textarea>
			</cfloop>
		</cfif>
		<cfif IsArray(prc.INFORMACION.PATHS.PATH_SOL)>
			<cfloop index="w" from="1" to="#ArrayLen(prc.INFORMACION.PATHS.PATH_SOL)#">
				<textarea style="display:none;" name="pathSol_#Replace(Replace(Replace(Replace(prc.INFORMACION.PATHS.PATH_SOL[w].ELEMENTO,'/','_','ALL'),'.','_','ALL'),' ','','ALL'),':','_','ALL')#" id="pathSol_#Replace(Replace(Replace(Replace(prc.INFORMACION.PATHS.PATH_SOL[w].ELEMENTO,'/','_','ALL'),'.','_','ALL'),' ','','ALL'),':','_','ALL')#">
					#ArrayToList(prc.INFORMACION.PATHS.PATH_SOL[w].PK_ELEMENTS,',')#
				</textarea>
			</cfloop>
		</cfif>
	</form>
	<div class="clearfix"><br /></div>
	<div class="clearfix"><br /></div>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Resultado del an&aacute;lisis</h3>
		</div>
		<div class="panel-body">
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title"><!--Informaci&oacute;n analizada--></h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div id="chartdiv5" class="chartClass" style="height:600px;"></div>
								<div class="table-responsive">
									<table class="table table-hover table-bordered">
										<tbody>
											<tr>
												<th class="text-center">Registros analizados</th>
												<td>
													<cfset analizados = ArrayToList(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS,',')>
													<textarea style="display:none;" name="Az_#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#" id="Az_#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#">
														#analizados#
													</textarea>
													#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#
												</td>
											</tr>
											<tr>
												<th class="text-center">Registros sin analizar</th>
												<td>
													<cfset sinAnalizar = ArrayToList(prc.INFORMACION.RESUMEN.REGISTROS_SIN_ANALIZAR,',')>
													<textarea style="display:none;" name="Sz_#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#" id="Sz_#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_ANALIZADOS)#">
														#sinAnalizar#
													</textarea>
													#ArrayLen(prc.INFORMACION.RESUMEN.REGISTROS_SIN_ANALIZAR)#
												</td>
											</tr>
										</tbody>
										<tfoot>
											<tr class="well well-sm">
												<th class="text-right">Total de registros:</th>
												<td><strong>#prc.INFORMACION.RESUMEN.REGISTROS_TOTAL_ANALIZAR#</strong></td>
											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title">Tipos de errores ocurridos dentro del sistema</h3>
						</div>
						<div class="panel-body">
							<div id="chartdiv" class="chartClass"  style="height:600px;" ></div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title">Tipos de navegadores empleados dentro del sistema</h3>
						</div>
						<div class="panel-body">
							<div id="chartdiv2" class="chartClass"  style="height:600px;" ></div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title">Conteo de los usuarios que han generado alg&uacute;n tipo de error</h3>
						</div>
						<div class="panel-body">
							<div id="chartdiv3" class="chartClass"  style="height:600px;" ></div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title">Porcentaje de los usuarios que generan errores / Porcentaje de los errores por usuario</h3>
						</div>
						<div class="panel-body">
							<div id="chartdiv4" class="chartClass" style="height:600px;"></div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title">Usuarios / Navegadores-versi&oacute;n empleados para el uso del SIPIFIFE</h3>
						</div>
						<div class="panel-body " style="height:600px;>
							<div class="table-responsive">
								<table class="table table-hover table-striped">
									<thead>
										<tr>
											<th class="text-center">No.</th>
											<th class="text-center">Usuario</th>
											<th class="text-center">Navegador</th>
											<th class="text-center">Total</th>
										</tr>
									</thead>
									<tbody>
										<cfloop index="q" from="1" to="#prc.INFORMACION.NAVEGADORES.POR_USUARIO.recordCount#">
											<tr>
												<td class="text-center">#q#</td>
												<td>#prc.INFORMACION.NAVEGADORES.POR_USUARIO.USUARIO[q]#</td>
												<td>#prc.INFORMACION.NAVEGADORES.POR_USUARIO.NAVEGADOR[q]# #prc.INFORMACION.NAVEGADORES.POR_USUARIO.VERSION[q]#</td>
												<td class="text-center">#prc.INFORMACION.NAVEGADORES.POR_USUARIO.TOTAL_NAVEGADOR[q]#</td>
											</tr>
										</cfloop>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title"><!--N&uacute;mero de solicitudes por origen (PATH Referencia)--></h3>
						</div>
						<div class="panel-body">
							<div id="chartdiv6" class="chartClass" style="height:600px;"></div>
							<div class="table-responsive">
								<table class="table table-hover table-bordered">
									<thead>
										<tr>
											<th class="text-center">Usuario</th>
											<th class="text-center">PATH Referencia</th>
											<th class="text-center">Total</th>
										</tr>
									</thead>
									<tbody>
										<cfset numReg = 0>
										<cfloop index="q" from="1" to="#prc.INFORMACION.PATHS.PATH_USR.P_REF.recordCount#">
											<tr>
												<td>#prc.INFORMACION.PATHS.PATH_USR.P_REF.USUARIO[q]#</td>
												<td class="text-left">#prc.INFORMACION.PATHS.PATH_USR.P_REF.P_REFERENCIA[q]#</td>
												<td class="text-right">#prc.INFORMACION.PATHS.PATH_USR.P_REF.TOTAL_REFERENCIA[q]#</td>
											</tr>
											<cfset numReg += prc.INFORMACION.PATHS.PATH_USR.P_REF.TOTAL_REFERENCIA[q]>
										</cfloop>
									</tbody>
									<tfoot>
										<tr class="well well-sm">
											<th class="text-right" colspan="2">Total de registros:</th>
											<td><strong>#numReg#</strong></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
				<div class="row">
					<div class="panel panel-success text-center">
						<div class="panel-heading">
							<h3 class="panel-title"><!--N&uacute;mero de solicitudes por destino (PATH Solicitado)--></h3>
						</div>
						<div class="panel-body">
							<div id="chartdiv7" class="chartClass" style="height:600px;"></div>
							<div class="table-responsive">
								<table class="table table-hover table-bordered">
									<thead>
										<tr>
											<th class="text-center">Usuario</th>
											<th class="text-center">PATH Solicitado</th>
											<th class="text-center">Total</th>
										</tr>
									</thead>
									<tbody>
										<cfset numReg = 0>
										<cfloop index="q" from="1" to="#prc.INFORMACION.PATHS.PATH_USR.P_SOL.recordCount#">
											<tr>
												<td>#prc.INFORMACION.PATHS.PATH_USR.P_SOL.USUARIO[q]#</td>
												<td class="text-left">#prc.INFORMACION.PATHS.PATH_USR.P_SOL.P_SOLICITADO[q]#</td>
												<td class="text-right">#prc.INFORMACION.PATHS.PATH_USR.P_SOL.TOTAL_SOLICITADO[q]#</td>
											</tr>
											<cfset numReg += prc.INFORMACION.PATHS.PATH_USR.P_SOL.TOTAL_SOLICITADO[q]>
										</cfloop>
									</tbody>
									<tfoot>
										<tr class="well well-sm">
											<th class="text-right" colspan="2">Total de registros:</th>
											<td><strong>#numReg#</strong></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="clearfix"><br /></div>
			</div>
		</div>
	</div>
</cfoutput>