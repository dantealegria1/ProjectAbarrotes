<%--
  Created by IntelliJ IDEA.
  User: dantealegria
  Date: 24/10/24
  Time: 8:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Beans.PedidoDAO" %>
<%@ page import="Mapeos.Pedido" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Beans.PedidoDAO" %>
<%@ page import="Mapeos.Pedido" %>
<html>
<head>
    <title>Pedidos del Cliente</title>
    <link rel="stylesheet" type="text/css" href="css.css" title="style">
    <style>
        /* Estilos generales para la página */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Estilos para el menú de navegación */
        #menu {
            text-align: center;
            margin-bottom: 20px;
        }

        #menu ul {
            list-style-type: none;
            padding: 0;
        }

        #menu ul li {
            display: inline;
            margin-right: 10px;
        }

        #menu ul li a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }

        /* Estilos para la tabla */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        thead {
            background-color: #4CAF50;
            color: #fff;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tbody tr:hover {
            background-color: #e2f7d9;
        }

        /* Estilo para botones */
        input[type="submit"] {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<h1>Lista de Pedidos del Cliente</h1>

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
    Integer clienteID = (Integer) session.getAttribute("clienteID");
    if (clienteID != null) {
        PedidoDAO pedidoDAO = new PedidoDAO();
        List<Pedido> pedidos = pedidoDAO.obtenlistaPedidos(clienteID);

        if (pedidos != null && !pedidos.isEmpty()) {
%>
<table>
    <thead>
    <tr>
        <th>ID Pedido</th>
        <th>Fecha</th>
        <th>Estado</th>
        <th>Precio</th>
        <th>Identificador</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (Pedido pedido : pedidos) {
            Integer idPedido = pedido.getIdPedido();
            String fecha = pedido.getFecha();
            String estado = pedido.getEdoPedido();
            Double precio = pedido.getCosto();
            Integer identificador = pedido.getIdentificador();
    %>
    <tr>
        <td><%= idPedido %></td>
        <td><%= fecha %></td>
        <td><%= estado %></td>
        <td>$<%= precio %></td>
        <td><%= identificador %></td>
        <td>
            <form action="detallePedido.jsp" method="get">
                <input type="hidden" name="identificador" value="<%= identificador %>"/>
                <input type="submit" value="Ver Detalles"/>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
} else {
%>
<p>No se encontraron pedidos para este cliente.</p>
<%
    }
} else {
%>
<p>Error: El ID del cliente no está disponible.</p>
<%
    }
%>

</body>
</html>