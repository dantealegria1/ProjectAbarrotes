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
<%@ page import="java.util.UUID" %>
<%@ page import="Mapeos.Pedido" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="Beans.PedidoDAO" %>
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

  // Crear el objeto Paquete y Pedido
  Paquete nuevoPaquete = new Paquete();
  Pedido nuevoPedido = new Pedido();
  int identificador = UUID.randomUUID().hashCode();

  // Asigna el cliente desde la sesión
  Integer clienteID = (Integer) session.getAttribute("clienteID");
  if (clienteID != null) {
    nuevoPaquete.setCliente(new Cliente(clienteID));
    nuevoPedido.setCliente(new Cliente(clienteID));
  } else {
    out.println("<p>Error: No se ha encontrado el ID del cliente.</p>");
    return;
  }

  // Instancia los DAOs
  PaqueteDAO paqueteDAO = new PaqueteDAO();
  ProductoDAO productoDAO = new ProductoDAO();
  PedidoDAO pedidoDAO = new PedidoDAO();

  // Inicializa el costo total
  int costoTotal = 0;

  // Guardar los productos del carrito en el paquete
  if (carrito != null && !carrito.isEmpty()) {
    for (Map.Entry<Producto, Integer> entry : carrito.entrySet()) {
      Producto prod = entry.getKey();
      int cantidad = entry.getValue();
      double precioUnitario = prod.getPrecioUni(); // Asume que el producto tiene el método getPrecioUnitario()

      // Calcula el subtotal de este producto y lo agrega al costo total
      costoTotal += precioUnitario * cantidad;

      // Configurar el paquete con los datos de producto y cantidad
      nuevoPaquete.setIdProducto(prod.getIdProducto());
      nuevoPaquete.setCantidad(cantidad);
      nuevoPaquete.setIdentificador(identificador);
      int idPaquete = paqueteDAO.guardaPaquete(nuevoPaquete);
      out.println("<p>Producto: " + prod.getNombreProducto() + " guardado con ID: " + idPaquete + "</p>");

      // Actualiza el stock del producto
      productoDAO.actualizaStock(prod.getIdProducto(), cantidad);
    }

    // Limpiar el carrito después de guardar
    carrito.clear();
    session.setAttribute("carrito", carrito);

    // Configura los datos del pedido y lo guarda en la base de datos
    try {
      nuevoPedido.setIdentificador(identificador);
      nuevoPedido.setFecha(String.valueOf(LocalDate.now()));
      nuevoPedido.setObservaciones("Entregado");
      nuevoPedido.setEdoPedido("Entregado");
      nuevoPedido.setCosto(costoTotal); // Asigna el costo total calculado

      int idPedido = pedidoDAO.guardarPedido(nuevoPedido);
      out.println("<p>Pedido confirmado con ID: " + idPedido + " y costo total: $" + costoTotal + "</p>");
    } catch (Exception e) {
      e.printStackTrace();
      out.println("<p>Ocurrió un error al procesar el pedido.</p>");
    }

    out.println("<p>Tu compra ha sido confirmada y el carrito ha sido limpiado.</p>");
  } else {
    out.println("<p>Error: Tu carrito está vacío.</p>");
  }
%>

<a href="Ventas.jsp">Comprar de nuevo</a>
<a href="Pedidos.jsp">Ver tus pedidos</a>
</body>
</html>