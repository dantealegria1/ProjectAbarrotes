<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 22/10/24
  Time: 08:31
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Mapeos.Estado"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EstadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modificar Estado</title>
</head>
<body>
<h1>Portal de modificación de datos del estado</h1>
<%
    EstadoDAO estadoDAO = new EstadoDAO();
    List<Estado> listaEstados = estadoDAO.obtenListaEstado();
%>
<form method="POST">
    <CENTER>
        <HR>
        <I>Para modificar un estado, selecciona el estado de la lista y actualiza sus datos. <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>
        </HR>
        <table border="1">
            <thead>
            <tr>
                <th>ID Estado</th>
                <th>Nombre Estado</th>
                <th>Seleccionar</th>
            </tr>
            </thead>
            <% for (Estado estado : listaEstados) { %>
            <tr>
                <td><%= estado.getIdEstado()%></td>
                <td><%= estado.getNombreEstado()%></td>
                <td><input type="checkbox" name="cbestados" value="<%=estado.getIdEstado()%>"/></td>
            </tr>
            <% } %>
        </table>
        <input type="submit" value="Actualizar seleccionado" name="actualizar" />
        <a href="EliminarEstado.jsp">Regresar</a>
    </CENTER>
</form>

<%
    if (request.getParameter("actualizar") != null) {
        String[] chbEstados = request.getParameterValues("cbestados");
        if (chbEstados != null && chbEstados.length > 0) {
            Estado estadoSeleccionado = estadoDAO.obtenEstadoPorId(Integer.parseInt(chbEstados[0]));
%>
<h2>Modificar Estado</h2>
<form method="POST">
    <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25%">
        <tr>
            <td>Nombre Estado:</td>
            <td><input type="text" name="nombreEstado" value="<%= estadoSeleccionado.getNombreEstado() %>" size="25"/></td>
        </tr>
        <tr>
            <td><input type="hidden" name="estadoId" value="<%= estadoSeleccionado.getIdEstado() %>"/></td>
            <td><input type="submit" name="submit" value="Guardar Cambios"/></td>
        </tr>
    </table>
</form>
<%
        }
    }

    if (request.getParameter("submit") != null) {
        int estadoId = Integer.parseInt(request.getParameter("estadoId"));
        Estado estadoActualizado = estadoDAO.obtenEstadoPorId(estadoId);

        String nuevoNombreEstado = request.getParameter("nombreEstado");

        // Validar campos no vacíos
        if (nuevoNombreEstado != null && !nuevoNombreEstado.isEmpty()) {
            estadoActualizado.setNombreEstado(nuevoNombreEstado);

            estadoDAO.actualizaEstado(estadoActualizado);
            out.println("<h2>El estado ha sido actualizado exitosamente.</h2>");

            // Redirigir a EliminarEstado.jsp después de la actualización
            response.sendRedirect("EliminarEstado.jsp");
        } else {
            out.println("<h2>Por favor, completa todos los campos.</h2>");
        }
    }
%>
</body>
</html>

