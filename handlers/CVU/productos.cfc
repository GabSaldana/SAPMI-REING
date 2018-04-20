<!---
========================================================================
* IPN - CSII
* Sistema: SIIP
* Modulo: CVU
* Sub modulo: -
* Fecha: 17/octubre/2017
* Descripcion: Handler para el modulo de CVU/productos
=========================================================================
--->

<cfcomponent>

	<cfproperty name="CNProductos" inject="CVU.CN_Productos">
	
	<!---
    * Descripcion:    Carga la vista del menu principal para el catalogo de productos
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->

	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfset event.setView("CVU/productos/menu")>
	</cffunction>

	<!---
    * Descripcion:    Obtiene las clasificaciones generales
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->

	<cffunction name="listaClasificacion" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">

        <cfscript>
            prc.resultado  = CNProductos.getClasificacion();               
            event.setView("CVU/productos/clasificacion").noLayout();
        </cfscript>
	</cffunction>
    
	<!---
    * Descripcion:    Obtiene las subclasificaiones 
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->

    <cffunction name="listaSubclasificacion" access="remote" returntype="void" hint="Trae las subcategorias de cada producto">
		<cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">

        <cfset resultado = CNProductos.getSubclasificacion()>
        <!--cfdump var="#resultado#"--><!--cfabort-->
		<cfset event.renderData(type="json", data=resultado)>
	</cffunction>

	<!---
    * Descripcion:    Obtiene la vista de las opciones a seleccionar de un producto padre dado 
    * Fecha creacion: 19 de octubre de 2017
    * @author:        Ana Belem Juarez Mendez
    ** comentarios 
    --->

    <cffunction name="getSeleccion" access="remote" returntype="void" hint="Obtiene la vista de las opciones a seleccionar de un producto padre dado">
		<cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
		<cfscript>
			prc.opcionesProductos  = CNProductos.getSubclasificacion(rc.pkPadre); 
            prc.vista = rc.vista;			
            var pkproducto = rc.pkPadre;

            if(prc.opcionesProductos.recordCount < 1 ){
                event.renderData(type = "json", data = 0);
            } else{
			event.setView("CVU/productos/seleccion").noLayout();}
		</cfscript>
	</cffunction>
	
	<cffunction name="getSeleccionCaptura" access="remote" returntype="void" hint="Obtiene la vista de las opciones a seleccionar de un producto padre dado">
		<cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
		<cfscript>
			prc.opcionesProductos  = CNProductos.getSubclasificacion(rc.pkPadre); 
            prc.vista = rc.vista;			
            var pkproducto = rc.pkPadre;

            if(prc.opcionesProductos.recordCount < 1 ){
                event.renderData(type = "json", data = 0);
            } else{
			event.setView("CVU/productos/seleccionCap").noLayout();}
		</cfscript>
	</cffunction>

    <!---
    * Descripcion:    Obtiene la vista de las opciones a seleccionar de un producto padre dado 
    * Fecha creacion: 19 de octubre de 2017
    * @author:        Gabs
    ** comentarios 
    --->

    <cffunction name="cargahistorial" access="remote" returntype="void" hint="Obtiene la vista de los filtros seleccionadas para un producto dado">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
        <cfscript>
            prc.resultado  = CNProductos.getFiltros(rc.pkPadre);               
            event.setView("CVU/productos/filtros").noLayout();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la vista de las opciones a seleccionar de un producto padre dado 
    * Fecha creacion: 19 de octubre de 2017
    * @author:        Ana Belem Juarez Mendez
    ** comentarios 
    --->

    <cffunction name="agregarProducto" access="remote" returntype="void" hint="Obtiene la vista de las opciones a seleccionar de un producto padre dado">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
        <cfscript>         
            prc.pkproducto = #rc.pkproducto#;  
            prc.revistaissn = #rc.revistaissn#;
            event.setView("CVU/productos/capturarProducto").noLayout();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la vista de las opciones a seleccionar de un producto padre dado 
    * Fecha creacion: 19 de octubre de 2017
    * @author:        Ana Belem Juarez Mendez
    ** comentarios 
    --->

    <cffunction name="cargaTabs" access="remote" returntype="void" hint="Obtiene la vista de las opciones a seleccionar de un producto padre dado">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
        <cfset CNFormatos =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
        <cfscript>         
            prc.pkproducto = rc.pkproducto; 
            prc.revistaissn = rc.revistaissn; 
            prc.resultado  = CNProductos.getFiltros(rc.pkproducto);
            prc.formato = CNProductos.getReporteFormato(rc.pkproducto);
            if(prc.formato.PKFORMATO[1] > 0){
                prc.reporte = CNFormatos.getInfoReporte(prc.formato.PKFORMATO[1], prc.formato.PERIODO[1]);
            } else{
                
                prc.reporte = CNFormatos.getInfoReporte(0, 0);
            }
            event.setView("CVU/productos/tabsProducto").noLayout();
        </cfscript>
    </cffunction>

     <!---
    * Descripcion:    Trae el tipo de la revista según el ISSN dado 
    * Fecha creacion: 13 de noviembre de 2017
    * @author:        Ana Belem Juarez Mendez
    ** comentarios 
    --->

    <cffunction name="traeTipoRevista" access="remote" returntype="void" hint="Obtiene la vista de las opciones a seleccionar de un producto padre dado">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
        <cfscript>  

            var resultado  = CNProductos.traeTipoRevista(rc.issn);  
            event.renderData(type="json", data=resultado);    
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Carga la vista del menu principal para el catalogo de productos editables (copia de Index)
    * Fecha creacion: 04 de diciembre de 2017
    * @author:        JLGC
    ** comentarios 
    --->

    <cffunction name="textosProductos" access="remote" returntype="void" output="false">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">
        <cfset event.setView("CVU/adminEDI/textosProductos/menu")>
    </cffunction>

    <!---
    * Descripcion:    Obtiene las clasificaciones generales editables (copia de listaClasificacion)
    * Fecha creacion: 04 de diciembre de 2017
    * @author:        JLGC
    ** comentarios 
    --->

    <cffunction name="textosListaClasificacion" access="remote" returntype="void" output="false">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">

        <cfscript>
            prc.resultado  = CNProductos.getClasificacion();               
            event.setView("CVU/adminEDI/textosProductos/clasificacion").noLayout();
        </cfscript>
    </cffunction>

     <!---
    * Descripcion:    Obtiene la vista de las opciones a seleccionar de un producto padre dado (copia de cargahistorial)
    * Fecha creacion: 04 de diciembre de 2017
    * @author:        JLGC
    ** comentarios 
    --->

    <cffunction name="textosCargahistorial" access="remote" returntype="void" hint="Obtiene la vista de los filtros seleccionadas para un producto dado">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
        <cfscript>
            prc.resultado  = CNProductos.getFiltros(rc.pkPadre);               
            event.setView("CVU/adminEDI/textosProductos/filtros").noLayout();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la vista de las opciones a seleccionar de un producto padre dado (copia de getSeleccion)
    * Fecha creacion: 04 de diciembre de 2017
    * @author:        JLGC
    ** comentarios 
    --->

    <cffunction name="getTextosSeleccion" access="remote" returntype="void" hint="Obtiene la vista de las opciones a seleccionar de un producto padre dado">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfargument name="prc">    
        <cfscript>
            prc.opcionesProductos  = CNProductos.getSubclasificacion(rc.pkPadre); 
            prc.vista = rc.vista;           
            var pkproducto = rc.pkPadre;

            if(prc.opcionesProductos.recordCount < 1 ){
                event.renderData(type = "json", data = 0);
            } else{
            event.setView("CVU/adminEDI/textosProductos/seleccion").noLayout();}
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita el nombre del producto
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarProductoNombre" hint="Edita el nombre del producto">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.editarProductoNombre(rc.pkProducto, rc.productoNombre);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita la descripcion del producto
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarProductoDescripcion" hint="Edita la descripcion del producto">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.editarProductoDescripcion(rc.pkProducto, rc.productoDescripcion);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Muestra la vista para la administracion del catalogo de revistas
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="revistas" hint="Muestra la vista para la administracion del catalogo de revistas">
        <cfargument name="event" type="any">
        <cfargument name="rc">
        <cfscript>
            prc.Paises      = CNProductos.getPais();
            prc.Editoriales = CNProductos.getEditorial('UNITED STATES');
            prc.Anios = CNProductos.getAnios(0);
            Event.setView("CVU/adminEDI/catalogoRevistas/V_Revistas");
        </cfscript>
    </cffunction>

    <!---
    * Descripcion: Carga listado de revistas
    * Fecha:       13 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="cargarTablaRevistas" hint="Carga listado de revistas">
        <cfargument name="Event" type="any">
        <cfscript>
            prc.tablaRevistas  = CNProductos.getTablaRevistas(rc.pais, rc.editorial);
            Event.setView("CVU/adminEDI/catalogoRevistas/T_Revistas").noLayout();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la revista de la seleccion
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getRevistabyPKRevista" hint="Obtiene la revista de la seleccion">
        <cfargument name="Event" type="any">
        <cfscript>
            var resultado = CNProductos.getRevistabyPKRevista(rc.pkRevista);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene las editoriales para llenar el combo select
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="obtenerEditoriales" access="remote" returntype="void" output="false" hint="Obtiene las editoriales para llenar el combo select">
        <cfscript>      
            resultado = CNProductos.getEditorial(rc.pais);              
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nueva revista
    * Fecha creacion: 14 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarRevista" hint="Guarda nueva revista">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.agregarRevista(rc.Nombre, rc.Editorial, rc.Pais, rc.ISSN);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita revista seleccionada
    * Fecha creacion: 14 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarRevista" hint="Edita revista seleccionada">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.editarRevista(rc.PkRevista, rc.Nombre, rc.Editorial, rc.Pais, rc.ISSN);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion: Obtiene los niveles de la revista seleccionada y llena la tabla
    * Fecha:       18 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaNivelesByRevista" hint="Obtiene las revistas y llena la tabla de la vista">
        <cfargument name="Event" type="any">
        <cfscript>
            prc.tablaNiveles  = CNProductos.getTablaNivelesByRevista(rc.PkRevista);
            Event.setView("CVU/adminEDI/catalogoRevistas/T_Niveles").noLayout();
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nuevo nivel para la revista
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarNivel" hint="Guarda nueva revista">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.agregarNivel(rc.PkRevista, rc.Nivel, rc.Anio, rc.Producto);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita el nivel de la revista seleccionada
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarNivel" hint="Edita revista seleccionada">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.editarNivel(rc.PkNivel, rc.Nivel, rc.Anio, rc.Producto);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene los años registrados de los niveles en la revista
    * Fecha creacion: 19 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="obtenerAnios" access="remote" returntype="void" output="false" hint="Obtiene los años registrados de los niveles en la revista">
        <cfscript>      
            resultado = CNProductos.getAnios(rc.pkRevista);              
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Elimina el nivel de la revista seleccionada
    * Fecha creacion: 26 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="eliminarNivel" hint="Elimina revista seleccionada">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CNProductos.eliminarNivel(rc.PkNivel);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

</cfcomponent>