<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Portal de Modificación de Productos</title>
</head>
<body>
<h1>Portal de Modificación de Datos del Producto</h1>
<%
    ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> listaProductos = productoDAO.obtenListaProducto("");
%>

<form method="post">
    <center>
        <hr>
        <i>Para modificar un producto, seleccionar las filas desde el primer producto hasta el que se desea modificar en la columna final. <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></i>
        <hr>
        <table border="1">
            <thead>
            <tr>
                <th>Numero producto</th>
                <th>Nombre producto</th>
                <th>Presentación</th>
                <th>Caducidad</th>
                <th>P. Proveedor</th>
                <th>P. Unitario</th>
                <th>Existencias</th>
                <th>Fecha</th>
                <th>Marca</th>
                <th>Seleccionar</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Producto a : listaProductos) {
            %>
            <tr>
                <td><%= a.getIdProducto() %></td>
                <td><%= a.getNombreProducto() %></td>
                <td><%= a.getPresentacion() %></td>
                <td><%= a.getCaducidad() %></td>
                <td><%= a.getPrecioProv() %></td>
                <td><%= a.getPrecioUni() %></td>
                <td><%= a.getExistencias() %></td>
                <td><%= a.getFech() %></td>
                <td><%= a.getMarca() %></td>
                <td><input type="checkbox" name="cbactores" value="<%= a.getIdProducto() %>"/></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <input type="submit" value="Actualizar Seleccionados" name="actualizar" />
        <a href="EliminarProducto.jsp">Regresar</a>
    </center>
</form>

<%
    if (request.getParameter("actualizar") != null) {
        String[] chbProductos = request.getParameterValues("cbactores");
        if (chbProductos != null && chbProductos.length > 0) {
            Producto productoSeleccionado = productoDAO.obtenProducto(Integer.parseInt(chbProductos[0])); // Cargar el primer producto seleccionado para modificar
%>
<h2>Modificar Producto</h2>
<form action="guardarProducto.jsp" method="post"> <!-- Cambiado a guardarProducto.jsp -->
    <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25%">
        <jsp:useBean id="producto" scope="page" class="Mapeos.Producto" />
        <jsp:setProperty name="producto" property="*" />

        <tr>
            <td>
                <input id="Nombre_producto" name="nombreProducto" placeholder="Nombre de producto"
                       title="Nombre de producto" type="text" value="<%= productoSeleccionado.getNombreProducto() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="Presentacion" name="presentacion" placeholder="Presentación"
                       title="Presentación" type="text" value="<%= productoSeleccionado.getPresentacion() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="Caducidad" name="caducidad" placeholder="Caducidad"
                       title="Caducidad" type="date" value="<%= productoSeleccionado.getCaducidad() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="PProveedor" name="pproveedor" placeholder="Precio Proveedor"
                       title="Precio Proveedor" type="number" step="0.01" value="<%= productoSeleccionado.getPrecioProv() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="PUnitario" name="punitario" placeholder="Precio Unitario"
                       title="Precio Unitario" type="number" step="0.01" value="<%= productoSeleccionado.getPrecioUni() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="Fech" name="fech" placeholder="Fecha"
                       title="Fecha" type="date" value="<%= productoSeleccionado.getFech() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="Marca" name="marca" placeholder="Marca"
                       title="Marca" type="text" value="<%= productoSeleccionado.getMarca() %>" size="25" required />
            </td>
        </tr>
        <tr>
            <td>
                <input id="IdProveedor" name="idProveedor" placeholder="Id Proveedor"
                       title="Id Proveedor" type="text" value="<%= productoSeleccionado.getIdProveedor() %>" size="25" readonly />
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" name="idProducto" value="<%= productoSeleccionado.getIdProducto() %>" />
                <input id="submit" name="submit" type="submit" value="Guardar" />
                <input type="reset" value="Limpiar" />
            </td>
        </tr>
    </table>
</form>
<%
        } else {
            out.println("<h2>No se ha seleccionado ningún producto para modificar.</h2>");
        }
    }
%>
</body>
</html>
