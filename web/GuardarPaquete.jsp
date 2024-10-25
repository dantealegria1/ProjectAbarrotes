<%--
  Created by IntelliJ IDEA.
  User: dantealegria
  Date: 24/10/24
  Time: 8:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Mapeos.Paquete"%>
<%@page import="Beans.PaqueteDAO"%>
<%@page import="Mapeos.Producto"%>
<%@page import="java.util.Map"%>
<%@ page import="Mapeos.Cliente" %>
<%@ page import="Beans.ProductoDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Confirmación de Compra</title>
</head>
<body>
<h1>Confirmación de Compra</h1>

<%
  // Obtener el carrito de la sesión
  session = request.getSession();
  Map<Producto, Integer> carrito = (Map<Producto, Integer>) session.getAttribute("carrito");

  // Crear el objeto Paquete
  Paquete nuevoPaquete = new Paquete();

  // Asigna el cliente desde la sesión
  Integer clienteID = (Integer) session.getAttribute("clienteID");
  if (clienteID != null) {
    nuevoPaquete.setCliente(new Cliente(clienteID));
  } else {
    out.println("<p>Error: No se ha encontrado el ID del cliente.</p>");
    return;
  }

  // Instancia el DAO
  PaqueteDAO paqueteDAO = new PaqueteDAO();
  ProductoDAO productoDAO = new ProductoDAO(); // Crear instancia de ProductoDAO

  // Guardar los productos del carrito en el paquete
  if (carrito != null && !carrito.isEmpty()) {
    for (Map.Entry<Producto, Integer> entry : carrito.entrySet()) {
      Producto prod = entry.getKey();
      int cantidad = entry.getValue();

      // Aquí puedes ajustar el objeto Paquete según tu modelo
      nuevoPaquete.setIdProducto(prod.getIdProducto());
      nuevoPaquete.setCantidad(cantidad);

      // Guarda el paquete en la base de datos
      int idPaquete = paqueteDAO.guardaPaquete(nuevoPaquete);
      out.println("<p>Producto: " + prod.getNombreProducto() + " guardado con ID: " + idPaquete + "</p>");

      // Actualiza el stock del producto
      productoDAO.actualizaStock(prod.getIdProducto(), cantidad); // Actualiza el stock
    }

    // Limpiar el carrito después de guardar
    carrito.clear();
    session.setAttribute("carrito", carrito);
    out.println("<p>Tu compra ha sido confirmada y el carrito ha sido limpiado.</p>");
  } else {
    out.println("<p>Error: Tu carrito está vacío.</p>");
  }
%>

<a href="Ventas.jsp.jsp">Comprar de nuevo</a>
<a href="Pedidos.jsp.jsp.jsp">Ver tus pedidos</a>
</body>
</html>