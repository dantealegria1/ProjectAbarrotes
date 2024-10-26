<%--
  Created by IntelliJ IDEA.
  User: dantealegria
  Date: 11/10/24
  Time: 11:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Mapeos.Producto"%>
<%@page import="Beans.ProductoDAO"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Guardar Producto</title>
</head>
<body>
<%
    try {
        if (request.getMethod().equalsIgnoreCase("POST")) {
            // Get form parameters
            String nombreProducto = request.getParameter("nombreProducto");
            String presentacion = request.getParameter("presentacion");
            String caducidad = request.getParameter("caducidad");
            String precioProvStr = request.getParameter("precioProv");
            String precioUniStr = request.getParameter("precioUni");
            String fech = request.getParameter("fech");
            String marca = request.getParameter("marca");
            String existenciasStr = request.getParameter("existencias");
            String idProveedorStr = request.getParameter("idProveedor");
            String accion = request.getParameter("accion");

            // Create Producto object
            Producto producto = new Producto();

            // Set string values
            producto.setNombreProducto(nombreProducto);
            producto.setPresentacion(presentacion);
            producto.setCaducidad(caducidad);
            producto.setFech(fech);
            producto.setMarca(marca);

            // Parse and set numeric values
            try {
                producto.setPrecioProv(Float.parseFloat(precioProvStr));
                producto.setPrecioUni(Float.parseFloat(precioUniStr));
                producto.setExistencias(Integer.parseInt(existenciasStr));
                producto.setIdProveedor(Integer.parseInt(idProveedorStr));
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Error en formato de números: " + e.getMessage());
            }

            // Create DAO instance
            ProductoDAO productoDAO = new ProductoDAO();

            // Determine if inserting or updating
            int resultado;
            if ("insertar".equals(accion)) {
                resultado = productoDAO.guardaProducto(producto);
            } else {
                String idProductoStr = request.getParameter("idProducto");
                if (idProductoStr != null && !idProductoStr.isEmpty()) {
                    producto.setIdProducto(Integer.parseInt(idProductoStr));
                    resultado = productoDAO.actualizaProducto(producto);
                } else {
                    throw new IllegalArgumentException("ID de producto requerido para actualización");
                }
            }

            if (resultado != 0) {
%>
<div style="text-align: center; margin-top: 20px;">
    <h2>Operación realizada con éxito.</h2>
    <p>Redirigiendo en 3 segundos...</p>
</div>
<script type="text/javascript">
    setTimeout(function(){
        window.location.href='EliminarProducto.jsp';
    }, 3000);
</script>
<%
        } else {
            throw new Exception("Error al procesar la operación en la base de datos");
        }
    }
} catch (Exception e) {
%>
<div style="text-align: center; margin-top: 20px; color: red;">
    <h2>Error en el sistema</h2>
    <p>Ha ocurrido un error al procesar la solicitud: <%= e.getMessage() %></p>
    <p><a href="javascript:history.back()">Volver al formulario</a></p>
</div>
<%
    }
%>
</body>
</html>