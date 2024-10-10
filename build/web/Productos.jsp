<%-- 
    Document   : Productos
    Created on : 2/11/2013, 03:30:21 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>producto</title>
    </head>
    <script type="text/javascript" src="XHR.js"></script>
    <script type="text/javascript">
        //Defino Variables Globales
        var peticion;
        peticion = obtenerXHR();
        function completapalabra(elemento) {

            peticion.open("POST", "servletAjax", true);
            peticion.onreadystatechange = procesarPeticion;

            //Definimos cabecera obligatoria para enviar POST
            peticion.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            //Enviamos los parametros
            var parametros = "nombre=" + elemento.value;
            peticion.send(parametros);
        }
        function procesarPeticion() {
            var div = document.getElementById("resultados");
            if (peticion.readyState == 1) {
                //document.getElementById("mensaje").innerHTML="<img src=\"loading.gif\" align=\"center\" /> Aguarde por favor...";
                div.innerHTML = "<img src=\"loading.gif\" align=\"center\" /> Aguarde por favor...";
            }
            if (peticion.readyState == 4) {
                //La peticion termino
                if (peticion.status == 200) {
                    //Mostramos el texto dentro del DIV
                    div.innerHTML = peticion.responseText;
                }
            }
        }

    </script> 
    <body>
        <h1>Portal de información del producto.</h1>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
            </ul>
        </div>

        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaproductos = productoDAO.obtenListaProducto();
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Para poder comprar un producto es necesario tener un cuenta.</I>.<a href="Principal.html"> Regresar</a>
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Unitario</th>
                            <th>Fecha</th>
                            <th>Marca</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  for (Producto a : listaproductos) {
                        %>
                        <tr>
                            <td><%= a.getNombreProducto()%></td>
                            <td><%= a.getPresentacion()%></td>
                            <td><%= a.getCaducidad()%></td>
                            <td><%= a.getPrecioUni()%></td>
                            <td><%= a.getFech()%></td>
                            <td><%= a.getMarca()%></td>
                        </tr>
                        <% }
                        %>
                    </tbody>
                </table>
                <input type="button" onclick=" location.href = 'registro.jsp'" value="Registrarse" name="boton" />
                <input type="button" onclick=" location.href = 'buscador.jsp'" value="Buscar" name="boton" />
            </CENTER>
        </form>
    </body>
</html>
