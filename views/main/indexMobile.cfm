<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Vista del menu principal.
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Vista
* Autor: GSA
=========================================================================
--->
<cfoutput>
<cfinclude template="indexMobile_JS.cfm">
<cfinclude template="login_js.cfm">
</cfoutput>
<!---Lista de acciones--->
<div class="container">
	<div class="row">
		<div class="col-xs-12 col-md-12 col-sm-12" style="top:100px;">
		<!--- Titulo --->
		<div class="row">
			<div class="col-xs-12 col-md-12 col-sm-12" style= "border-bottom: 1px solid #720030; ">
				<center>
					<p id="th_acciones" style="font-size: 5vw;">
						Por favor selecciona los ejes en los cuales deseas realizar tu aportaci&oacute;n:
					</p>
				</center>
			</div>
		</div>
		<!--- Registros de ejes --->
		<div class="row">
			<div class="col-xs-12 col-md-12 col-sm-12"  id="tr_acciones" >
				<!---EJE 1--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[1] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="E1" name="Eje 1: Calidad y Pertinencia Educativa" >
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile">
								<img src="/includes/images/menu_principal/icono-02.png" class="im img-responsive ">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class="containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje 1: Calidad y Pertinencia Educativa</span>
								</p>
							</div>
						</div>
					</div>
				<!---</cfif>--->
				<!---EJE 2--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[2] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="E2" name="Eje 2: Cobertura y Atenci&oacute;n Estudiantil" >
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile" >
								<img src="/includes/images/menu_principal/icono-03.png" class="im img-responsive ">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class= "containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje 2: Cobertura y Atenci&oacute;n Estudiantil</span>
								</p>
							</div>
						</div>
					</div>
                <!---</cfif>--->
				<!---EJE 3--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[3] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="E3" name="Eje 3: Conocimiento para la Soluci&oacute;n de Problemas Nacionales" >
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile">
							<img src="/includes/images/menu_principal/icono-04.png" class="im img-responsive">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class= "containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje 3: Conocimiento para la Soluci&oacute;n de Problemas Nacionales</span>
								</p>
							</div>
						</div>
					</div>
                <!---</cfif>--->
				<!---EJE 4--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[4] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="E4" name="Eje 4: Cumplimiento del Compromiso Social" >
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile">
								<img src="/includes/images/menu_principal/icono-05.png" class="im img-responsive">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class= "containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje 4: Cumplimiento del Compromiso Social</span>
								</p>
							</div>
						</div>
					</div>
				<!---</cfif>--->
				<!---EJE 5--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[5] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="E5" name="Eje 5: Gobernanza y Gesti&oacute;n Institucional" >
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile">
								<img src="/includes/images/menu_principal/icono-06.png" class="im img-responsive">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class= "containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje 5: Gobernanza y Gesti&oacute;n Institucional</span>
								</p>
							</div>
						</div>
					</div>
				<!---</cfif>--->
				<!---EJE 6--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[6] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="ET1" name="Eje T 1: Sustentabilidad">
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile">
								<img src="/includes/images/menu_principal/icono-07.png" class="im img-responsive">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class= "containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje T 1: Sustentabilidad</span>
								</p>
							</div>
						</div>
					</div>
				<!---</cfif>--->
				<!---EJE 7--->
				<!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[7] GT 0>--->
					<div class="row celdaMenuMobile menu-it" id="ET2" name="Eje T 2: Perspectiva de G&eacute;nero">
						<div class="col-xs-3 col-md-3 col-sm-3 imgdiv">
							<div class="imgwrap imgCeldaMenuMobile">
								<img src="/includes/images/menu_principal/icono-08.png" class="im img-responsive">
							</div>
						</div>
						<div class="col-xs-9 col-md-9 col-sm-9">
							<div class= "containerTxtCeldaMenuMobile">
								<p class="txtCeldaMenuMobile">
									<span>Eje T 2: Perspectiva de G&eacute;nero</span>
								</p>
							</div>
						</div>
					</div>
				<!---</cfif>--->
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="ct col-12" style="margin-top: 100px !important; border-radius: 0px 0px 5px 5px;  padding-bottom: 25px !important;  ">
		<center>
			<cfoutput><a href="#event.buildLink('login.cerrarSesion')#" style=" font-size: 20px; text-decoration: none;"></cfoutput>
			Terminar consulta
			</a>
		</center>
	</div>
  </div>
</div>
<div class="row">
   <div id="login_registrado" class="modal fade" role="dialog">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header" style=" background-color: #B1075E;" >
             <button type="button" class="close" data-dismiss="modal">&times;</button>
             <h4 style="color:white;" class="modal-title"><center>Usuario registrado</center></h4>
         </div>
         <div class="modal-body" >
             <div class="middle-box text-center loginscreen animated fadeInDown">
                 <div class="middle-box text-center">
                 <center>
                    <cfoutput>
                        <form class="m-t" action="#event.buildLink('login.autenticacion')#" method="post">
                             <div class="form-group" style="width: 30%;">
                                 <img class="pull-center" style="width:100%; margin-top: 20%;" src="/includes/img/login/PPI2018Logo.png">
                            </div>
                            <div class="form-group" style="width: 30%; margin-top: 5%">
                                <input type="text" name="user" class="form-control usuario" placeholder="Usuario">
                            </div>
                            <div class="form-group" style="width: 30%;">
                                <input type="password" name="password" class="form-control pass" placeholder="Contraseña">
                            </div>
                            <button type="submit" class="btn" style="color:white;background-color: ##B1075E;">Entrar</button>
                        </form>
                    </cfoutput>
                 </center>
                 </div>
                 <div align="center">
                     <a style="cursor: pointer" onclick="modalRecuperar();">Recuperar Contraseña</a>
                 </div>
             </div>
         </div>
       </div>
     </div>
  </div>
</div>

<div id="mdl-recuperar-pwd" class="modal fade" tabindex="-1" role="dialog">
 <div class="modal-dialog" role="document">
   <div class="modal-content">
       <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4>Recuperar contraseña</h4>
       </div>
       <div class="modal-body">
           <div class="form-group">
               <p class="continuar">¿Este es su correo?</p>
               <div class="col-sm-10">
                   <form id="userName" role="form" onsubmit="return false;">
                       <input name="nomUser" id="nomUser" type="text" class="form-control" maxlength="35" placeholder="Ingrese su nombre de usuario"/>
                       <input name="email" id="email" type="text" class="form-control"/>

                   </form>
               </div>
           </div>
       </div>
       <br>
       <div class="modal-footer">
           <div class="enviar">
               <button class="btn btn-primary btn-lg btn-block" onclick="consultarEmail();">Enviar</button>
           </div>
           <div class="continuar">
              <button type="button" class="btn btn-primary btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
              <button type="button" class="btn btn-default btn-lg pull-right" onclick="recuperar()"><span class="fa fa-arrow-right"></span> Continuar</button>
           </div>
       </div>
   </div>
 </div>
</div>
