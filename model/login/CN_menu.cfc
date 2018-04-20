<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS 
* Modulo: Principal
* Sub modulo: Login
* Fecha: agosto, 2015
* Descripcion: Genera el menú principal dinámicamente
* =========================================================================
--->

<cfcomponent>
	
	<!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->    
    <cffunction name="getMenu" access="remote" hint="Obtiene las secciones del menu de acuerdo al rol de usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfset daoMenu = CreateObject('component', 'DAO_menu')>
        <cfset menuRol = daoMenu.getMenu(rol)>

        <cfset arrayLev2 = ArrayNew(1)>
        <cfset arrayIndexLev2 = ArrayNew(1)>
        <cfloop index="nivel2" from="1" to="#menuRol.recordcount#">
        	<cfif menuRol.NIVEL[nivel2] EQ 2>
        		<cfset arrayAppend(arrayLev2,menuRol.FK_MODULO[nivel2])>
        		<cfset arrayAppend(arrayIndexLev2,nivel2)>
			</cfif>
		</cfloop>
		<cfset arrayLev3 = ArrayNew(1)>
		<cfset arrayIndexLev3 = ArrayNew(1)>
        <cfloop index="nivel3" from="1" to="#menuRol.recordcount#">
        	<cfif menuRol.NIVEL[nivel3] EQ 3>
        		<cfset arrayAppend(arrayLev3,menuRol.FK_MODULO[nivel3])>
        		<cfset arrayAppend(arrayIndexLev3,nivel3)>
			</cfif>
		</cfloop>

		<cfset menuFinal = ArrayNew(1)>
		<cfset menuNivel2 = ArrayNew(1)>
		<cfset menuNivel3 = ArrayNew(1)>
		<cfset contenido = StructNew()>
		<cfloop index="menu" from="1" to="#menuRol.recordcount#">
			<cfif menuRol.NIVEL[menu] EQ 1>
				<cfset ArrayClear(menuNivel2)>
				<cfset ArrayClear(menuNivel3)>
				<cfset auxLevel2 = ArrayFindAll(arrayLev2,menuRol.CVE[menu])>
				<cfif ArrayLen(auxLevel2) GT 0>
					<cfloop array="#auxLevel2#" index="nivel2">
						<cfset indexLevel2 = arrayIndexLev2[nivel2]>
						<cfset auxLevel3 = ArrayFindAll(arrayLev3,menuRol.CVE[indexLevel2])>
						<cfif ArrayLen(auxLevel3) GT 0>
							<cfloop array="#auxLevel3#" index="nivel3">
								<cfset auxiliarIndex = arrayIndexLev3[nivel3]>
								<cfset contenido.url = menuRol.URL[auxiliarIndex]>
								<cfset contenido.icono = menuRol.ICON[auxiliarIndex]>
								<cfset contenido.nombre = menuRol.MODULO[auxiliarIndex]>
								<cfset arrayAppend(menuNivel3,StructCopy(contenido))>
								<cfset StructClear(contenido)>
							</cfloop>
						</cfif>
						<cfset contenido.nivel3 = menuNivel3>
						<cfset auxiliarIndex = arrayIndexLev2[nivel2]>
						<cfset contenido.url = menuRol.URL[auxiliarIndex]>
						<cfset contenido.icono = menuRol.ICON[auxiliarIndex]>
						<cfset contenido.nombre = menuRol.MODULO[auxiliarIndex]>
						<cfset arrayAppend(menuNivel2,StructCopy(contenido))>
						<cfset StructClear(contenido)>
					</cfloop>
				</cfif>
				<cfset contenido.nivel2 = menuNivel2>
				<cfset contenido.url = menuRol.URL[menu]>
				<cfset contenido.icono = menuRol.ICON[menu]>
				<cfset contenido.nombre = menuRol.MODULO[menu]>
				<cfset arrayAppend(menuFinal,StructCopy(contenido))>
				<cfset StructClear(contenido)>
			<cfelse>
				<cfbreak>
			</cfif>
		</cfloop>
		<cfreturn menuFinal>
    </cffunction>

    <!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->    
    <cffunction name="getPrivilegios" hint="Obtiene las acciones permitidas de acuerdo al rol de usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
		<cfscript>
			permisos = [];
			daoMenu = CreateObject('component', 'DAO_menu');		
			privilegios = daoMenu.getPrivilegios(rol);			
			for (var i = 1; i <= privilegios.recordcount; i++){
				arrayAppend(permisos, privilegios.CLAVE[i]);
			}
			return permisos;
		</cfscript>

    </cffunction>

</cfcomponent>