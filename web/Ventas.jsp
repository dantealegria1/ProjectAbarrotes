<%@page import="Mapeos.Producto"%>
<%@page import="Mapeos.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page import="Beans.ClienteDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<jsp:useBean id="productoBean" class="Mapeos.Producto" scope="page" />
<jsp:useBean id="clienteBean" class="Mapeos.Cliente" scope="page" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Portal de Productos</title>
    <link rel="stylesheet" type="text/css" href="css.css" title="style">
</head>
<body>
<h1>Portal de Información del Producto</h1>

<!-- Navigation Menu -->
<div id="menu">
    <ul>
        <li><a href="Conocenos.jsp">Conócenos</a></li>
        <li><a href="Productos.jsp">Productos</a></li>
        <li><a href="Contacto.jsp">Contacto</a></li>
        <li><a href="Acceso.jsp">Ingresar</a></li>
        <li><a href="registro.jsp">Regístrate Aquí</a></li>
    </ul>
</div>

<%
    ProductoDAO productoDAO = new ProductoDAO();
    if (session.getAttribute("listaProductos") == null) {
        List<Producto> listaProductos = productoDAO.obtenListaProducto("");
        session.setAttribute("listaProductos", listaProductos);
    }

    List<Producto> listaProductos = (List<Producto>) session.getAttribute("listaProductos");

    ClienteDAO clienteDAO = new ClienteDAO();
    Integer clienteID = (Integer) session.getAttribute("clienteID");

    if (session.getAttribute("carrito") == null) {
        session.setAttribute("carrito", new HashMap<Producto, Integer>());
    }

    Map<Producto, Integer> carrito = (Map<Producto, Integer>) session.getAttribute("carrito");

    if (request.getParameter("comprar") != null) {
        String[] seleccionados = request.getParameterValues("productosSeleccionados");

        if (seleccionados != null) {
            for (String idProducto : seleccionados) {
                Producto p = productoDAO.obtenProducto(Integer.parseInt(idProducto));
                int cantidad = Integer.parseInt(request.getParameter("cantidad_" + idProducto));

                for (Producto producto : listaProductos) {
                    if (producto.getIdProducto() == p.getIdProducto()) {
                        int nuevasExistencias = producto.getExistencias() - cantidad;
                        producto.setExistencias(nuevasExistencias);
                    }
                }

                carrito.put(p, cantidad);
            }
        }
        session.setAttribute("carrito", carrito);
    }

    if (request.getParameter("limpiarCarrito") != null) {
        for (Map.Entry<Producto, Integer> entry : carrito.entrySet()) {
            Producto prod = entry.getKey();
            int cantidadCarrito = entry.getValue();

            for (Producto producto : listaProductos) {
                if (producto.getIdProducto() == prod.getIdProducto()) {
                    int nuevasExistencias = producto.getExistencias() + cantidadCarrito;
                    producto.setExistencias(nuevasExistencias);
                }
            }
        }

        carrito.clear();
        session.setAttribute("carrito", carrito);
    }

%>

<h2>Bienvenid@</h2>
<h3>Tu Carrito</h3>
<table border="1">
    <thead>
    <tr>
        <th>Nombre Producto</th>
        <th>Precio Unitario</th>
        <th>Cantidad</th>
    </tr>
    </thead>
    <tbody>
    <% if (carrito != null && !carrito.isEmpty()) {
        for (Map.Entry<Producto, Integer> entry : carrito.entrySet()) {
            Producto prod = entry.getKey();
            int cantidad = entry.getValue();
    %>
    <tr>
        <td><%= prod.getNombreProducto() %></td>
        <td><%= prod.getPrecioUni() %></td>
        <td><%= cantidad %></td>
    </tr>
    <% } } else { %>
    <tr>
        <td colspan="3">Tu carrito está vacío.</td>
    </tr>
    <% } %>
    </tbody>
</table>

<!-- Botón para limpiar carrito -->
<form method="post">
    <input type="submit" name="limpiarCarrito" value="Limpiar Carrito">
</form>

<h3>Selecciona Productos</h3>
<form method="post">
    <table border="1">
        <thead>
        <tr>
            <th>Nombre Producto</th>
            <th>Presentación</th>
            <th>Caducidad</th>
            <th>Precio Unitario</th>
            <th>Existencias</th>
            <th>Cantidad</th>
            <th>Seleccionar</th>
        </tr>
        </thead>
        <tbody>
        <% for (Producto prod : listaProductos) { %>
        <tr>
            <td><%= prod.getNombreProducto() %></td>
            <td><%= prod.getPresentacion() %></td>
            <td><%= prod.getCaducidad() %></td>
            <td><%= prod.getPrecioUni() %></td>
            <td><%= (prod.getExistencias() != null ? prod.getExistencias() : "No disponible") %></td>
            <td>
                <select name="cantidad_<%= prod.getIdProducto() %>"
                        <%= (prod.getExistencias() != null && prod.getExistencias() == 0) ? "disabled" : "" %>>
                    <%
                        if (prod.getExistencias() != null && prod.getExistencias() > 0) {
                            for (int i = 1; i <= prod.getExistencias(); i++) {
                    %>
                    <option value="<%= i %>"><%= i %></option>
                    <%
                        }
                    } else {
                    %>
                    <option value="0" disabled>No disponible</option>
                    <%
                        }
                    %>
                </select>
            </td>
            <td><input type="checkbox" name="productosSeleccionados" value="<%= prod.getIdProducto() %>" <%= (prod.getExistencias() == null || prod.getExistencias() == 0) ? "disabled" : "" %>></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <input type="submit" name="comprar" value="Añadir al Carrito">
</form>

<!-- Purchase Confirmation -->
<form action="GuardarPaquete.jsp" method="post">
    <input type="submit" value="Confirmar Compra" />
</form>
<a href="Pedidos.jsp">Ver tus pedidos</a>
</body>
</html>