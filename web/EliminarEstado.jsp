<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 22/10/24
  Time: 08:05
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Beans.EstadoDAO"%>
<%@page import="java.util.List"%>
<%@page import="Mapeos.Estado"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Estados</title>
</head>
<body>
<h1>Portal de información de los estados</h1>
<%
    EstadoDAO estadoDAO = new EstadoDAO();
    List<Estado> listaEstados = estadoDAO.obtenListaEstado();
%>
<form method="post">
    <HR>
    <I>Para eliminar un estado, seleccionarlo en la columna final. <a href="AutentificarEmpleado.jsp">Cerrar Sesión</a></I>.
    </HR>
    <table border="1">
        <thead>
        <tr>
            <th>ID Estado</th>
            <th>Nombre Estado</th>
            <th>Eliminar</th> <!-- Añadido para la columna de eliminar -->
        </tr>
        </thead>
        <tbody>
        <% for (Estado e : listaEstados) { %>
        <tr>
            <td><%= e.getIdEstado() %></td> <!-- Mostrar el ID del estado -->
            <td><%= e.getNombreEstado() %></td> <!-- Mostrar el nombre del estado -->
            <td><input type="checkbox" name="cbestados" value="<%= e.getIdEstado() %>" /></td> <!-- Checkbox para eliminar -->
        </tr>
        <% } %>
        </tbody>
    </table>
    <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
    <input type="button" onclick="location.href='ModificarEstado.jsp'" value="Actualizar Estado" name="boton" />
    <input type="button" onclick="location.href='InsertarEstado.jsp'" value="Nuevo Estado" name="boton" />
</form>

<%
    if (request.getParameter("eliminar") != null) {
        String[] chbEstados = request.getParameterValues("cbestados");
        if (chbEstados != null) {
            for (int i = 0; i < chbEstados.length; i++) {
                estadoDAO.eliminaEstado(Integer.valueOf(chbEstados[i]));
            }
            // Recargar la página después de la eliminación
            out.println("<script>window.location.reload();</script>");
        }
    }
%>

</body>
</html>
