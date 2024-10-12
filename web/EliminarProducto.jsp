<%-- 
    Document   : EliminarProducto
    Created on : 19/11/2013, 07:11:05 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>producto</title>
    </head>
    <body>
        <h1>Portal de información del producto</h1>
        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaproductos = productoDAO.obtenListaProducto("");
        %>
        <form>
            <HR> 
            <I>Para eliminar un producto seleccionarlo en la columna final <a href="AutentificarEmpleado.jsp">  Cerrar Sesion</a></I>.
            </HR>
            <table border="1">
                <thead>
                    <tr>
                        <th>Numero producto</th>
                        <th>Nombre producto</th>
                        <th>Presentacion</th>
                        <th>Caducidad</th>
                        <th>P. Proveedor</th>
                        <th>P. Unitario</th>
                        <th>Existencias</th>
                        <th>Fecha</th>
                        <th>Marca</th>
                    </tr>
                </thead>
                <tbody>
                    <%  for (Producto a : listaproductos) {
                    %>
                    <tr>
                        <td><%= a.getIdProducto()%></td>
                        <td><%= a.getNombreProducto()%></td>
                        <td><%= a.getPresentacion()%></td>
                        <td><%= a.getCaducidad()%></td>
                        <td><%= a.getPrecioProv()%></td>
                        <td><%= a.getPrecioUni()%></td>
                        <td><%= a.getExistencias()%></td>
                        <td><%= a.getFech()%></td>
                        <td><%= a.getMarca()%></td>
                        <td><input type="checkbox" name="cbactores" value="<%=a.getIdProducto()%>"/></td>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
            <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
            <input type="button" onclick=" location.href = 'InsertarProducto.jsp' " value="Nuevo Producto" name="boton" />
            <input type="button" onclick=" location.href = 'ModificarProducto.jsp' " value="Actualizar Producto" name="boton" />
        </form>
        <%
            if (request.getParameter("eliminar") != null) {
                String[] chbproductos = request.getParameterValues("cbactores");
                if (chbproductos != null) { // Verificar que hay productos seleccionados
                    for (String productoId : chbproductos) {
                        productoDAO.eliminaProducto(Short.valueOf(productoId));
                        out.println("<li>El producto con ID " + productoId + " ha sido eliminado</li>");
                    }
                    out.println("<li>Todos los productos seleccionados han sido eliminados.</li>");
                } else {
                    out.println("<li>No se seleccionó ningún producto para eliminar.</li>");
                }

                // Redirigir a la misma página para recargar
                response.sendRedirect("EliminarProducto.jsp");
                return; // Asegúrate de salir del script después de la redirección
            }
        %>
    </body>
</html>
