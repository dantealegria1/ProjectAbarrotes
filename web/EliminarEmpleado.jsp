<%-- 
    Document   : EliminarEmpleado
    Created on : 11/11/2013, 08:33:36 PM
    Author     : Search
--%>

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
        <h1>Portal de información del empleado</h1>
        <% EmpleadoDAO empleadoDAO = new EmpleadoDAO();
            List<Empleado> listaEmpleados = empleadoDAO.obtenListaEmpleado();
        %>
        <form>
            <HR> 
            <I>Para eliminar un empleado seleccionarlo en la columna final <a href="AutentificarAdmon.jsp">  Cerrar Sesion</a></I>.
            <table border="1">
                <thead>
                    <tr>
                        <th>Numero empleado</th>
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
                    </tr>
                </thead>
                <tbody>
                    <%  for (Empleado a : listaEmpleados) {
                    %>
                    <tr>
                        <td><%= a.getNoEmpleado()%></td>
                        <td><%= a.getNombreEmpleado()%></td>
                        <td><%= a.getPassword()%></td>
                        <td><%= a.getApellPatEmpleado()%></td>
                        <td><%= a.getApellMatEmpleado()%></td>
                        <td><%= a.getFechaNac()%></td>
                        <td><%= a.getRfce()%></td>
                        <td><%= a.getSalario()%></td>
                        <td><%= a.getEstadoCivil()%></td>
                        <td><%= a.getEstatus()%></td>
                        <td><%= a.getNivelEstudio()%></td>
                        <td><%= a.getTipoUsuario()%></td>
                        <td><label>
                            <input type="checkbox" name="cbactores" value="<%=a.getNoEmpleado()%>"/>
                        </label></td>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
            <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
            <input type="button" onclick=" location.href='InsertarEmpleado.jsp' " value="Insertar Empleado" name="boton" />
            <input type="button" onclick=" location.href='ModificarEmpleado.jsp' " value="Modificar Empleado " name="boton" />
        </form>
        <%
            if (request.getParameter("eliminar") != null) {
                String[] chbEmpleados = request.getParameterValues("cbactores");
                if (chbEmpleados == null || chbEmpleados.length == 0) {
        %>
        <script>
            alert("Por favor selecciona un empleado para eliminar.");
        </script>
        <%
        } else {
            for (String chbEmpleado : chbEmpleados) {
                empleadoDAO.eliminaEmpleado(Short.parseShort(chbEmpleado));
            }
        %>
        <script>
            window.location.reload(); // Recargar la página después de la eliminación
        </script>
        <%
                }
            }
        %>

    </body>
</html>
    

