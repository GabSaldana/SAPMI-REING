<!-----------------------------------------------------------------------
Template :  InfoUsuario.cfm 
Author 	 :	Sergio Eduardo Cuevas Olivares
Date     :	Marzo 30, 2015
Description :
	Plantilla que muestra informacion al usuario.
----------------------------------------------------------------------->
<!DOCTYPE html>
<html lang="en">
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>Solicitud no encontrada</title>
	
	<!-- Bootstrap Core CSS -->
	<link type="text/css" rel="stylesheet" href="/inlcudes_/bootstrap/3.3.4/css/bootstrap.min.css" />
	<script type="text/javascript" src="/includes/javascript/jquery.min.js"></script>
	<script type="text/javascript" src="/inlcudes_/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<!-- Custom CSS -->
	<style type="text/css">
	<!--
		body {
			margin-top: 100px; /* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
		}
		
		.featurette-divider {
			margin: 70px 0;
		}
		
		.featurette {
			overflow: hidden;
		}
		
		@media(max-width:768px) {
			body {
				margin-top: 150px; /* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
			}
		
			.featurette-divider {
				margin: 30px 0;
			}
		}
		
		@media(max-width:668px) {
			body {
				margin-top: 170px; /* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
			}
			.featurette-divider {
				margin: 20px 0;
			}
		}
	-->
	</style>
	
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="/includes/javascript/html5shiv.js"></script>
		<script src="/includes/javascript/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<div class="container">
		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="navbar-default">
				<div class="container navbar-default" style="padding:5px;">
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-8"><img src="/includes/images/login/sep.jpg" alt="" width="200" height="61" style="margin-left:50px;"></div>
						<div class="col-xs-6 col-md-4"><img src="/includes/images/login/ipn.png" alt="" width="215" height="71" style="margin-left:50px;"></div>
					</div>
				</div>
			</div>
			<cfoutput>
				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="##navbar-sistema">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<cfif ListFind(session.cbstorage.usuario.ROLES,session.cbstorage.rolesSistema.intranet_acceso,',')>
							<a class="navbar-brand" href="#event.buildLink('intranet.menu.index')#"><span class="glyphicon glyphicon-home"></span></a>
						<cfelse>
							<a class="navbar-brand" href="#event.buildLink('menu.index')#"><span class="glyphicon glyphicon-home"></span></a>
						</cfif>
					</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="navbar-sistema">
						<ul class="nav navbar-nav">
							<li>
								<a href="#event.buildLink('login.cerrarSesion')#">Cerrar Sesi&oacute;n&nbsp;&nbsp;<span class="glyphicon glyphicon-log-out"></span></a>
							</li>
						</ul>
					</div>
					<!-- /.navbar-collapse -->
				</div>
			</cfoutput>
			<!-- /.container -->
		</nav>
		<!-- Page Content -->
		
		<hr class="featurette-divider">
		<!-- First Featurette -->
		<div class="featurette">
			<cfoutput>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title text-center">La p&aacute;gina que solicito no se encontr&oacute;</h3>
							</div>
							<div class="panel-body text-justify">
								Su solicitud no puede ser atendida en este momento por el sistema
								<cfif prc.pkSeguimiento GT 0>, se ha levantado un reporte con el n&uacute;mero: <b>#prc.pkSeguimiento#</b> con el cual usted podr&aacute; dar seguimiento</cfif>.
								<br /><br />
								Si requiere mayor informaci&oacute;n sobre el uso del sistema o para resolver cualquier duda sobre el mismo, pongase en contacto en las siguientes direcciones de correo el&eacute;ctronico:
								<div class="clearfix"></div>
								
								<div class="list-group">
									<a href="mailto:csii@ipn.mx" class="list-group-item">csii@ipn.mx</a>
									<a href="mailto:iaguirrem@ipn.mx" class="list-group-item">iaguirrem@ipn.mx</a>
								</div>
								<div class="clearfix"></div>
								<br /><br /><br /><br />
								
								<div class="col-md-12">
									<blockquote>
										<address>
											<br />
											Coordinaci&oacute;n del Sistema Institucional de Informaci&oacute;n del Instituto Polit&eacute;cnico Nacional,<br />
											<footer><abbr title="Tel&eacute;fono">Tel.</abbr> 57-29-6000 <abbr title="Extensi&oacute;n">Exts.:</abbr> 57301, 57302, 57303, 57304, 57305, 57306, 57307, 57308, 57309, 57310, 57335, 57336, 57327, 57300</footer>
										</address>
									</blockquote>
								</div>
							</div>
						</div>
					</div>
				</div>
			</cfoutput>
		</div>
		
		<hr class="featurette-divider">
		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>Planta Baja del Edificio &quot;Adolfo Ru&iacute;z Cortines&quot; de la Unidad Profesional &quot;Adolfo L&oacute;pez Mateos&quot;, Zacatenco Av. Wilfrido Massieu S/N esquina Luis Enrique Erro C.P. 07738 Delegaci&oacute;n Gustavo A. Madero, M&eacute;xico, Distrito Federal.</p>
				</div>
			</div>
		</footer>
		
	</div>
	<!-- /.container -->
</body>
</html>