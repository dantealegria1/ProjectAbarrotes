<%--
    Document   : Productos
    Created on : 2/11/2013, 03:30:21 PM
    Author     : USUARIO
    Modificacion: Dante, 11/10
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
    <title>Producto</title>
</head>
<body>
<h1>Portal de información del producto.</h1>
<div id="menu">
    <ul>
        <li><a href="Conocenos.jsp" class="normalMenu">Conócenos</a></li>
        <li><a href="Productos.jsp" class="normalMenu">Productos</a></li>
        <li><a href="Contacto.jsp" class="normalMenu">Contacto</a></li>
        <li><a href="Acceso.jsp" class="normalMenu">Ingresar</a></li>
        <li><a href="registro.jsp" class="normalMenu">Regístrate Aquí</a></li>
    </ul>
</div>

<%
    // Crear instancia de ProductoDAO
    ProductoDAO productoDAO = new ProductoDAO();
    String searchTerm = request.getParameter("palabra"); // Obtener el término de búsqueda
    List<Producto> listaproductos = productoDAO.obtenListaProducto(searchTerm); // Obtener productos según el término de búsqueda
%>

<form method="GET" action="buscador.jsp"> <!-- Cambiar la acción a buscador.jsp -->
    <center>
        <hr>
        <i>Para poder comprar un producto es necesario tener una cuenta.</i>
        <a href="Principal.html"> Regresar</a>
        <hr>
        <label for="palabra">Nombre del producto:</label>
        <input type="text" id="palabra" name="palabra" placeholder="Buscar producto..." value="<%= searchTerm != null ? searchTerm : "" %>" />
        <input type="submit" value="Buscar" />
    </center>
</form>

<%
    // Mostrar resultados solo si hay un término de búsqueda
    if (searchTerm != null && !searchTerm.isEmpty()) {
%>
<h2>Resultados de Búsqueda para: <%= searchTerm %></h2>
<table border="1">
    <thead>
    <tr>
        <th>Nombre producto</th>
        <th>Presentación</th>
        <th>Caducidad</th>
        <th>P. Unitario</th>
        <th>Fecha</th>
        <th>Marca</th>
    </tr>
    </thead>
    <tbody>
    <%
        // Iterar a través de la lista de productos y mostrarlos
        for (Producto a : listaproductos) {
            // Filtrar productos según el término de búsqueda
            if (a.getNombreProducto().toLowerCase().contains(searchTerm.toLowerCase())) {
    %>
    <tr>
        <td><%= a.getNombreProducto() %></td>
        <td><%= a.getPresentacion() %></td>
        <td><%= a.getCaducidad() %></td>
        <td><%= a.getPrecioUni() %></td>
        <td><%= a.getFech() %></td>
        <td><%= a.getMarca() %></td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
<%
    } else {
        // Mensaje si no hay resultados
        out.print("<p>No se encontraron resultados para la búsqueda.</p>");
    }
%>

<input type="button" onclick="location.href='registro.jsp'" value="Registrarse" name="boton" />
</body>
</html>
