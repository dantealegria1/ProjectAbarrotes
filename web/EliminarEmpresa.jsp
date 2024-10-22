<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 21/10/24
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Beans.EmpresaDAO"%>
<%@page import="java.util.List"%>
<%@page import="Mapeos.Empresa"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Empresas</title>
</head>
<body>
<h1>Portal de información de las empresas</h1>
<%
    EmpresaDAO empresaDAO = new EmpresaDAO();
    List<Empresa> listaEmpresas = empresaDAO.obtenListaEmpresa();
%>
<form method="post">
    <HR>
    <I>Para eliminar una empresa, seleccionarla en la columna final. <a href="AutentificarEmpleado.jsp">Cerrar Sesión</a></I>.
    </HR>
    <table border="1">
        <thead>
        <tr>
            <th>ID Empresa</th>
            <th>Nombre Empresa</th>
            <th>Razón Social</th>
            <th>Giro</th>
        </tr>
        </thead>
        <tbody>
        <% for (Empresa e : listaEmpresas) { %>
        <tr>
            <td><%= e.getIdEmpresa() %></td>
            <td><%= e.getNombreEmpresa() %></td>
            <td><%= e.getRazonSocial() %></td>
            <td><%= e.getGiro() %></td>
            <td><input type="checkbox" name="cbempresas" value="<%= e.getIdEmpresa() %>"/></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
    <input type="button" onclick=" location.href='ModificarEmpresa.jsp' " value="Actualizar Empresa" name="boton" />
    <input type="button" onclick=" location.href = 'InsertarEmpresa.jsp' " value="Nueva Empresa" name="boton" />
</form>
<%
    if (request.getParameter("eliminar") != null) {
        String[] chbEmpresas = request.getParameterValues("cbempresas");
        if (chbEmpresas != null) {
            for (int i = 0; i < chbEmpresas.length; i++) {
                empresaDAO.eliminaEmpresa(Integer.valueOf(chbEmpresas[i]));
            }
            // Recargar la página después de la eliminación
            out.println("<script>window.location.reload();</script>");
        }
    }
%>
</body>
</html>
