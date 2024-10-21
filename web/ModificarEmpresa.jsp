<%@page import="Mapeos.Empresa"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpresaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modificar Empresa</title>
</head>
<body>
<h1>Portal de modificación de datos de la empresa</h1>
<%
    EmpresaDAO empresaDAO = new EmpresaDAO();
    List<Empresa> listaEmpresas = empresaDAO.obtenListaEmpresa(null);
%>
<form method="POST">
    <CENTER>
        <HR>
        <I>Para modificar una empresa, selecciona la empresa de la lista y actualiza sus datos. <a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>.
        </HR>
        <table border="1">
            <thead>
            <tr>
                <th>ID Empresa</th>
                <th>Nombre Empresa</th>
                <th>Razón Social</th>
                <th>Giro</th>
                <th>Seleccionar</th>
            </tr>
            </thead>
            <%  for (Empresa empresa : listaEmpresas) { %>
            <tr>
                <td><%= empresa.getIdEmpresa()%></td>
                <td><%= empresa.getNombreEmpresa()%></td>
                <td><%= empresa.getRazonSocial()%></td>
                <td><%= empresa.getGiro()%></td>
                <td><input type="checkbox" name="cbempresas" value="<%=empresa.getIdEmpresa()%>"/></td>
            </tr>
            <% } %>
        </table>
        <input type="submit" value="Actualizar seleccionado" name="actualizar" />
        <a href="EliminarEmpresa.jsp">Regresar</a>
        <%
            if (request.getParameter("actualizar") != null) {
                String[] chbEmpresas = request.getParameterValues("cbempresas");
                if (chbEmpresas != null && chbEmpresas.length > 0) {
                    Empresa empresaSeleccionada = empresaDAO.obtenEmpresaPorId(Integer.parseInt(chbEmpresas[0]));
        %>
        <h2>Modificar Empresa</h2>
        <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25%">
            <tr>
                <td>Nombre Empresa:</td>
                <td><input type="text" name="nombreEmpresa" value="<%= empresaSeleccionada.getNombreEmpresa() %>" size="25"/></td>
            </tr>
            <tr>
                <td>Razón Social:</td>
                <td><input type="text" name="razonSocial" value="<%= empresaSeleccionada.getRazonSocial() %>" size="25"/></td>
            </tr>
            <tr>
                <td>Giro:</td>
                <td><input type="text" name="giro" value="<%= empresaSeleccionada.getGiro() %>" size="25"/></td>
            </tr>
            <tr>
                <td><input type="submit" name="submit" value="Guardar Cambios"/></td>
            </tr>
        </table>
        <%
                    if (request.getParameter("submit") != null) {
                        String nuevoNombre = request.getParameter("nombreEmpresa");
                        String nuevaRazonSocial = request.getParameter("razonSocial");
                        String nuevoGiro = request.getParameter("giro");

                        empresaSeleccionada.setNombreEmpresa(nuevoNombre);
                        empresaSeleccionada.setRazonSocial(nuevaRazonSocial);
                        empresaSeleccionada.setGiro(nuevoGiro);

                        empresaDAO.actualizaEmpresa(empresaSeleccionada);
                        out.println("<h2>La empresa ha sido actualizada exitosamente.</h2>");
                    }
                }
            }
        %>
    </CENTER>
</form>
</body>
</html>
