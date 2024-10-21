<%@page import="Mapeos.Empleado"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Empleado</title>
</head>
<body>
<h1>Portal de modificación de datos del empleado</h1>
<%
    EmpleadoDAO empleadoDAO = new EmpleadoDAO();
    List<Empleado> listaEmpleados = empleadoDAO.obtenListaEmpleado();
%>
<form method="POST">
    <CENTER>
        <HR>
        <I>Para modificar un empleado, selecciona las filas desde el primer empleado hasta el que deseas modificar en la columna final.<a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>.
        </HR>
        <table border="1">
            <thead>
            <tr>
                <th>Número empleado</th>
                <th>Nombre empleado</th>
                <th>Contraseña</th>
                <th>Apellido paterno</th>
                <th>Apellido materno</th>
                <th>Fecha de nacimiento</th>
                <th>RFC</th>
                <th>Salario</th>
                <th>Estado civil</th>
                <th>Estatus</th>
                <th>Nivel de estudio</th>
                <th>Tipo de usuario</th>
                <th>Seleccionar</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Empleado a : listaEmpleados) {
            %>
            <tr>
                <td><%= a.getNoEmpleado() %></td>
                <td><%= a.getNombreEmpleado() %></td>
                <td><%= a.getPassword() %></td>
                <td><%= a.getApellPatEmpleado() %></td>
                <td><%= a.getApellMatEmpleado() %></td>
                <td><%= a.getFechaNac() %></td>
                <td><%= a.getRfce() %></td>
                <td><%= a.getSalario() %></td>
                <td><%= a.getEstadoCivil() %></td>
                <td><%= a.getEstatus() %></td>
                <td><%= a.getNivelEstudio() %></td>
                <td><%= a.getTipoUsuario() %></td>
                <td><input type="checkbox" name="cbactores" value="<%= a.getNoEmpleado() %>"/></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <input type="submit" value="Actualizar seleccionado" name="actualizar" />
        <a href="EliminarEmpleado.jsp">Regresar</a>
    </CENTER>
</form>

<%
    if (request.getParameter("actualizar") != null) {
        String[] chbEmpleados = request.getParameterValues("cbactores");
        if (chbEmpleados != null) {
            for (String chbEmpleado : chbEmpleados) {
                int empleadoId = Integer.parseInt(chbEmpleado);
                Empleado empleado = empleadoDAO.obtenEmpleadoPorId(empleadoId); // Asumiendo que tienes este método en tu DAO
%>
<h2>Modificar Empleado ID: <%= empleadoId %></h2>
<form method="POST" action="ModificarEmpleado.jsp">
    <table border="1">
        <tr>
            <td>Nombre: <input name="nombreEmpleado" value="<%= empleado.getNombreEmpleado() %>" /></td>
        </tr>
        <tr>
            <td>Contraseña: <input name="password" type="password" value="<%= empleado.getPassword() %>" /></td>
        </tr>
        <tr>
            <td>Apellido Paterno: <input name="apellPatEmpleado" value="<%= empleado.getApellPatEmpleado() %>" /></td>
        </tr>
        <tr>
            <td>Apellido Materno: <input name="apellMatEmpleado" value="<%= empleado.getApellMatEmpleado() %>" /></td>
        </tr>
        <tr>
            <td>Fecha Nac: <input name="fechaNac" value="<%= empleado.getFechaNac() %>" /></td>
        </tr>
        <tr>
            <td>RFC: <input name="rfce" value="<%= empleado.getRfce() %>" /></td>
        </tr>
        <tr>
            <td>Salario: <input name="salario" value="<%= empleado.getSalario() %>" /></td>
        </tr>
        <tr>
            <td>
                Estado Civil:
                <select name="estadoCivil">
                    <option value="Soltero" <%= empleado.getEstadoCivil().equals("Soltero") ? "selected" : "" %>>Soltero</option>
                    <option value="Casado" <%= empleado.getEstadoCivil().equals("Casado") ? "selected" : "" %>>Casado</option>
                    <option value="Divorciado" <%= empleado.getEstadoCivil().equals("Divorciado") ? "selected" : "" %>>Divorciado</option>
                    <option value="Viudo" <%= empleado.getEstadoCivil().equals("Viudo") ? "selected" : "" %>>Viudo</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                Estatus:
                <select name="estatus">
                    <option value="Laborando" <%= empleado.getEstatus().equals("Laborando") ? "selected" : "" %>>Laborando</option>
                    <option value="Desempleado" <%= empleado.getEstatus().equals("Desempleado") ? "selected" : "" %>>Desempleado</option>
                    <option value="Periodo Vacacional" <%= empleado.getEstatus().equals("Periodo Vacacional") ? "selected" : "" %>>Periodo Vacacional</option>
                    <option value="Incapacitado" <%= empleado.getEstatus().equals("Incapacitado") ? "selected" : "" %>>Incapacitado</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>Nivel de Estudio: <input name="nivelEstudio" value="<%= empleado.getNivelEstudio() %>" /></td>
        </tr>
        <tr>
            <td>Tipo de Usuario: <input name="tipoUsuario" value="<%= empleado.getTipoUsuario() %>" /></td>
        </tr>
        <tr>
            <td><input type="submit" name="submit" value="Actualizar" /></td>
        </tr>
        <input type="hidden" name="empleadoId" value="<%= empleadoId %>" />
    </table>
</form>
<%
            }
        }
    }

    // Manejo de la actualización de empleado
    if (request.getParameter("submit") != null) {
        int empleadoId = Integer.parseInt(request.getParameter("empleadoId"));
        Empleado empleado = new Empleado();
        empleado.setNoEmpleado(empleadoId);
        empleado.setNombreEmpleado(request.getParameter("nombreEmpleado"));
        empleado.setPassword(request.getParameter("password"));
        empleado.setApellPatEmpleado(request.getParameter("apellPatEmpleado"));
        empleado.setApellMatEmpleado(request.getParameter("apellMatEmpleado"));
        empleado.setFechaNac(request.getParameter("fechaNac"));
        empleado.setRfce(request.getParameter("rfce"));
        empleado.setSalario((int) Double.parseDouble(request.getParameter("salario")));
        empleado.setEstadoCivil(request.getParameter("estadoCivil"));
        empleado.setEstatus(request.getParameter("estatus"));
        empleado.setNivelEstudio(request.getParameter("nivelEstudio"));
        empleado.setTipoUsuario(request.getParameter("tipoUsuario"));

        try {
            empleadoDAO.actualizaEmpleado(empleado); // Asegúrate de que este método esté implementado en tu DAO
            response.sendRedirect("ModificarEmpleado.jsp"); // Redirigir para evitar reenvío de formulario
        } catch (Exception e) {
            e.printStackTrace(); // Manejar la excepción según sea necesario
            request.setAttribute("error", "No se pudo actualizar el empleado: " + e.getMessage());
        }
    }
%>
</body>
</html>