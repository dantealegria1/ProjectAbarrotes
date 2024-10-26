<%--
  Created by IntelliJ IDEA.
  User: dantealegria
  Date: 25/10/24
  Time: 9:29 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Beans.PaqueteDAO" %>
<%@ page import="Mapeos.Paquete" %>
<%@ page import="java.util.List" %>
<%@ page import="Mapeos.Producto" %>
<%@ page import="Beans.ProductoDAO" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detalles del Paquete</title>
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

<h1>Detalles del Paquete</h1>

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
    String identificadorParam = request.getParameter("identificador");
    if (identificadorParam != null) {
        PaqueteDAO paqueteDAO = new PaqueteDAO();
        ProductoDAO productoDAO = new ProductoDAO();
        List<Paquete> paquetes = paqueteDAO.obtenerPaquetesPorIdentificador(Integer.parseInt(identificadorParam));

        if (paquetes != null && !paquetes.isEmpty()) {
%>
<table>
    <thead>
    <tr>
        <th>ID Paquete</th>
        <th>Descripción</th>
        <th>Cantidad</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (Paquete paquete : paquetes) {
            Producto producto = productoDAO.obtenProducto(paquete.getIdProducto());
            String descripcion = producto != null ? producto.getNombreProducto() : "Producto no encontrado";
    %>
    <tr>
        <td><%= paquete.getIdPaquete() %></td>
        <td><%= descripcion %></td>
        <td><%= paquete.getCantidad() %></td>
    </tr>
    <%
        } // Fin del for
    %>
    </tbody>
</table>
<%
} else {
%>
<p>No se encontraron detalles para este paquete.</p>
<%
    }
} else {
%>
<p>Error: Identificador del paquete no especificado.</p>
<%
    }
%>

<a href="Pedidos.jsp">Regresar a tus pedidos</a>

</body>
</html>