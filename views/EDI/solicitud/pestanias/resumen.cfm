<cfprocessingdirective pageEncoding="utf-8">
<cfoutput>
	<ul class="agile-list">
		<cfloop array="#prc.resumen.getREQUISITOS()#" index='requisito'>
			<li class="#requisito.getColor()#-element">
				<span class="label label-info">Articulo: #requisito.getArticulo()#</span>
				<span class="label label-info">Sección: #requisito.getSeccion()#</span>
				<span class="label label-info">Requisto obligatorio: #requisito.getC_OBLIGATORIO()#</span>
				<br>
				<br>
				<cfloop array="#requisito.getTREQUISITOS()#" index='Trequisito'>
					 <div class="alert #trim(Trequisito.getColor())#">
						Requisto obligatorio: #Trequisito.getT_OBLIGATORIO()#
						#Trequisito.getREQUISITO()#
					</div>
				</cfloop>
			</li>
		</cfloop>
	</ul>
</cfoutput>
