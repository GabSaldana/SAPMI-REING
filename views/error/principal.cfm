    <!-- Load modernizr or html5shiv -->
    <script src="//cdn.jsdelivr.net/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
    <script>window.modernizr || document.write('<script src="http://chartinator.com/lib/modernizr/modernizr-custom.js"><\/script>')</script>
    <!--<script src="lib/html5shiv/html5shiv.js"></script>-->

    <!-- Chartinator  -->
    <script src="http://chartinator.com/js/chartinator.js" ></script>
    <script type="text/javascript">
        jQuery(function ($) {
            var chart2 = $('#pieChart').chartinator({
                createTable: true,
                dataTitle: 'Informaci&oacute;n',
                chartType: 'PieChart',
                chartClass: 'col',
                tableClass: 'table table-hover',
                pieChart: {
                    width: '100%',
                    height: 390,
                    chartArea: {
                        left: "6%",
                        top: 30,
                        width: "100%",
                        height: "100%"
                    },
                    fontSize: 'body',
                    fontName: 'Arial',
                    titleTextStyle: {
                        fontSize: 'h3'
                    },
                    legend: {
                        position: 'right'
                    },
                    colors: ['#336699', '#3691ff', '#CC2200', '#f58327', '#bf5cff'],
                    is3D: true,
                    tooltip: {
                        trigger: 'focus'
                    }
                },
                showTable: 'show'
            });
        });
    </script>
	<style type="text/css">
	<!--
		.col {
			flex-basis: 100%;
			padding: 2%;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}
		.rm-nav {
			letter-spacing: 1px;
		}
		.rm-toggle.rm-button {
			margin-top: 25px;
		}
		
		.rm-css-animate.rm-menu-expanded {
			max-height: none;
			display: block;
		}
		.rm-container.rm-layout-expanded {
			float: right;
			padding-right: 2%;
		}
		.rm-nav ul {
			margin-bottom: 0;
		}
		.rm-nav a,
		.rm-top-menu a {
			font-size: .9em;
			text-transform: uppercase;
		}
		.rm-container.rm-layout-expanded .rm-nav > ul > li > a,
		.rm-container.rm-layout-expanded .rm-top-menu > .rm-menu-item > a {
			height: 80px;
			line-height: 80px;
		}
		.main {
			padding-top: 1px;
		}
		.chart {
			width: 100%;
		}
		
		.dev-output {
			background-color: rgba(255,255,255,.85);
			color: #000;
			padding: 0 2em 2em;
			margin-bottom: 2em;
		}
		
		@media screen and ( min-width: 769px ) {
			.col {
				flex-basis: 50%;
			}
		}
		@media screen and ( min-width: 1401px ) {
			.col {
				flex-basis: 33.3333%;
			}
		}
	-->
	</style>
	<cfoutput>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Tipos de errores</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table id="pieChart" class="table table-hover">
						<thead>
							<caption>Informaci&oacute;n</caption>
							<tr>
								<th scope="col" data-type="string">Error</th>
								<th scope="col" data-type="number">Concurrencia</th>
							</tr>
						</thead>
						<tbody>
							<cfloop index="w" from="1" to="#prc.tiposErrores.recordCount#">
								<tr>
									<td align="left">#prc.tiposErrores.CLAVE_ERROR[w]#</td>
									<td align="right">#prc.tiposErrores.TOTAL[w]#</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix"><br /></div>
	</cfoutput>