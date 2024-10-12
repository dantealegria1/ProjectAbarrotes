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
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String nombreProducto = request.getParameter("nombreProducto");
        String presentacion = request.getParameter("presentacion");
        String caducidad = request.getParameter("caducidad");
        String precioProvStr = request.getParameter("pproveedor");
        String precioUniStr = request.getParameter("punitario");
        String fech = request.getParameter("fech");
        String marca = request.getParameter("marca");
        String idProveedorStr = request.getParameter("idProveedor");
        String idProductoStr = request.getParameter("idProducto");

        double precioProv = Double.parseDouble(precioProvStr);
        double precioUni = Double.parseDouble(precioUniStr);
        int idProveedor = Integer.parseInt(idProveedorStr);
        int idProducto = Integer.parseInt(idProductoStr);

        // Crear y actualizar el producto
        Producto producto = new Producto();
        producto.setIdProducto(idProducto);
        producto.setNombreProducto(nombreProducto);
        producto.setPresentacion(presentacion);
        producto.setCaducidad(caducidad);
        producto.setPrecioProv((float) precioProv);
        producto.setPrecioUni((float) precioUni);
        producto.setFech(fech);
        producto.setMarca(marca);
        producto.setIdProveedor(idProveedor);

        ProductoDAO productoDAO = new ProductoDAO();
        int resultado = productoDAO.actualizaProducto(producto);

        if (resultado != 0) {
            out.println("<h2>Producto actualizado con éxito.</h2>");
            out.println("<script type='text/javascript'>");
            out.println("setTimeout(function(){ window.location.href='EliminarProducto.jsp'; }, 3000);");
            out.println("</script>");
        } else {
            out.println("<h2>Error al actualizar el producto. Por favor intenta nuevamente.</h2>");
        }
    }
%>
