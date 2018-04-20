<!---
========================================================================
* IPN - CSII
* Sistema: CRUD 
* Modulo: Consultar productos
* Sub modulo: -
* Fecha: octubre/2017
* Descripcion: Model CN
* Autor: Gabriela Saldaña Aguilar
=========================================================================
--->

<cfcomponent displayname = "action" output = "false">

	<cfproperty name="dao" inject="CVU.DAO_Productos">
	<cfproperty name="cache" 		inject="cachebox:default">
	<!---
    * Descripcion:    Trae las clasifiaciones de los productos
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->
    <cffunction name="getClasificacion" hint="Trae las clasifiaciones de los productos">    
        <cfscript>
			
			var clasificacion = cache.get("clasificacionProductos");
			if (isNull(clasificacion)){
				clasificacion = dao.obtenerClasificacion();
				cache.set("clasificacionProductos", clasificacion, 120, 20);
        	}
        	return clasificacion;
		</cfscript>
    </cffunction>

    <!---
    * Descripcion:    Trae las subclasifiaciones de un producto padre
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabriela Saldaña Aguilar
    ** comentarios 
    --->
    <cffunction name="getSubclasificacion" hint="Trae las subclasifiaciones de los productos">   
    <cfargument name="pkPadre"> 
        <cfscript>
			var clasificacion = cache.get("clasificacionProductos_"&pkPadre);
			if (isNull(clasificacion)){
				clasificacion = dao.obtenerSubclasificacion(pkPadre);
				cache.set("clasificacionProductos_"&pkPadre, clasificacion, 120, 20);
        	}
        	return clasificacion;
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Trae las subclasifiaciones de un producto padre
    * Fecha creacion: 17 de octubre de 2017
    * @author:        Gabs
    ** comentarios 
    --->
    <cffunction name="getFiltros" hint="Trae las subclasifiaciones de los productos">   
    <cfargument name="pkPadre"> 
        <cfscript>
            var filtros = cache.get("clasificacionProductosFiltros_"&pkPadre);
			if (isNull(filtros)){
				filtros = dao.obtenerFiltros(pkPadre);
				cache.set("clasificacionProductosFiltros_"&pkPadre, filtros, 120, 20);
        	}
        	return filtros;
        </cfscript>
    </cffunction>

   <!---
    * Descripcion:    Trae el pk del reporte y del formato perteneciente a un producto [:
    * Fecha creacion: 30 de octubre de 2017
    * @author:        Ana B J M
    ** comentarios 
    --->
    <cffunction name="getReporteFormato" hint="Trae el pk del reporte y del formato perteneciente a un producto">   
    <cfargument name="pkProducto"> 
        <cfscript>
            return dao.getReporteFormato(pkProducto);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Trae el pk del producto correspondiente al tipo de revista asignada al issn [:
    * Fecha creacion: 30 de octubre de 2017
    * @author:        Ana B J M
    ** comentarios 
    --->
    <cffunction name="traeTipoRevista" hint="Trae el pk del producto correspondiente al tipo de revista asignada al issn">   
    <cfargument name="issn"> 
        <cfscript>

            var respuesta = dao.traeTipoRevista(issn);
        
             return respuesta;
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Edita el nombre del producto
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarProductoNombre" hint="Edita el nombre del producto">
        <cfargument name="pkProducto"     type="numeric" required="yes" hint="Pk del producto">
        <cfargument name="productoNombre" type="string"  required="yes" hint="Nombre del producto">
        <cfscript>
            // cache.clear("clasificacionProductos");
            // cache.clear("clasificacionProductos_"&pkProducto);
            // cache.clear("clasificacionProductosFiltros_"&pkProducto);
            cache.clearAll();
            return DAO.editarProductoNombre(pkProducto, productoNombre);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Edita la descripcion del producto
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarProductoDescripcion" hint="Edita la descripcion del producto">
        <cfargument name="pkProducto"          type="numeric" required="yes" hint="Pk del producto">
        <cfargument name="productoDescripcion" type="string"  required="yes" hint="Descripcion del producto">
        <cfscript>
            // cache.clear("clasificacionProductos");
            // cache.clear("clasificacionProductos_"&pkProducto);
            // cache.clear("clasificacionProductosFiltros_"&pkProducto);
            cache.clearAll();
            return DAO.editarProductoDescripcion(pkProducto, productoDescripcion);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion: Obtiene las revistas y llena la tabla de la vista
    * Fecha:       13 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaRevistas" hint="Obtiene las revistas y llena la tabla de la vista">
        <cfargument name="pais"      type="string" required="true" hint="Nombre del pais"> 
        <cfargument name="editorial" type="string" required="true" hint="Nombre de la editorial"> 
        <cfscript>
            return DAO.getTablaRevistas(pais, editorial);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la informacion de la revista seleccionada
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    * @param:         pkRevista
    --->
    <cffunction name="getRevistabyPKRevista" hint="Obtiene la informacion de la revista seleccionada">
        <cfargument name="pkRevista" type="numeric" required="true" hint="PK de la revista"> 
        <cfscript>
            return DAO.getRevistabyPKRevista(pkRevista);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la informacion clasificada por pais
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getPais" hint="Obtiene la informacion clasificada por pais">
        <cfscript>
            return DAO.getPais();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene la informacion clasificada por editorial
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getEditorial" access="public" returntype="query" hint="Obtiene la informacion clasificada por editorial">
        <cfargument name="pais" type="string" required="true" hint="Nombre del pais"> 
        <cfscript>
            return DAO.getEditorial(pais);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nueva revista
    * Fecha creacion: 14 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarRevista" hint="Guarda nueva revista">
        <cfargument name="Nombre"    type="string" required="yes" hint="Titulo de la revista">
        <cfargument name="Editorial" type="string" required="yes" hint="Editorial de la revista">
        <cfargument name="Pais"      type="string" required="yes" hint="País de la revista">
        <cfargument name="ISSN"      type="string" required="yes" hint="ISSN de la revista">
        <cfscript>
            var revista = DAO.agregarRevista(Nombre, Editorial, Pais, ISSN);
            return revista;
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita revista seleccionada
    * Fecha creacion: 14 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarRevista" hint="Edita revista seleccionada">
        <cfargument name="PkRevista" type="numeric" required="yes" hint="PK de la revista">
        <cfargument name="Nombre"    type="string"  required="yes" hint="Titulo de la revista">
        <cfargument name="Editorial" type="string"  required="yes" hint="Editorial de la revista">
        <cfargument name="Pais"      type="string"  required="yes" hint="País de la revista">
        <cfargument name="ISSN"      type="string"  required="yes" hint="ISSN de la revista">
        <cfscript>
            return DAO.editarRevista(PkRevista, Nombre, Editorial, Pais, ISSN);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion: Obtiene los niveles de la revista seleccionada y llena la tabla
    * Fecha:       18 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaNivelesByRevista" hint="Obtiene las revistas y llena la tabla de la vista">
        <cfargument name="PkRevista" type="numeric" required="yes" hint="PK de la revista"> 
        <cfscript>
            return DAO.getTablaNivelesByRevista(PkRevista);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nuevo nivel para la revista
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarNivel" hint="Guarda nueva revista">
        <cfargument name="PkRevista" type="numeric" required="yes" hint="PK de la revista">
        <cfargument name="Nivel"     type="string"  required="yes" hint="Nivel de la revista">
        <cfargument name="Anio"      type="numeric" required="yes" hint="Año de la revista">
        <cfargument name="Producto"  type="numeric" required="yes" hint="Producto asociado">
        <cfscript>
            var revista = DAO.agregarNivel(PkRevista, Nivel, Anio, Producto);
            return revista;
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita el nivel de la revista seleccionada
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarNivel" hint="Edita revista seleccionada">
        <cfargument name="PkNivel"   type="numeric" required="yes" hint="PK del nivel">
        <cfargument name="Nivel"     type="string"  required="yes" hint="Nivel de la revista">
        <cfargument name="Anio"      type="numeric" required="yes" hint="Año de la revista">
        <cfargument name="Producto"  type="numeric" required="yes" hint="Producto asociado">
        <cfscript>
            return DAO.editarNivel(PkNivel, Nivel, Anio, Producto);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene los años registrados de los niveles en la revista
    * Fecha creacion: 19 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getAnios" access="public" returntype="query" hint="Obtiene los años registrados de los niveles en la revista">
        <cfargument name="pkRevista" type="numeric" required="true" hint="PK de la revista"> 
        <cfscript>
            return DAO.getAnios(pkRevista);
        </cfscript>
    </cffunction>

     <!--- 
    * Descripcion:    Elimina el nivel de la revista seleccionada
    * Fecha creacion: 26 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="eliminarNivel" hint="Elimina el nivel de la revista seleccionada">
        <cfargument name="PkNivel" type="numeric" required="yes" hint="PK del nivel">
        <cfscript>
            return DAO.eliminarNivel(PkNivel);
        </cfscript>
    </cffunction>

</cfcomponent>