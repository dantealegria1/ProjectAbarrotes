<%-- 
    Document   : InsertarCliente
    Created on : 2/01/2014, 03:53:37 PM
    Author     : Search
--%>

<%@page import="Beans.ClienteDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.ParseException"%>
<%@ page import="Mapeos.Cliente" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Clientes</title>
</head>
<body>
<h1>Portal de creación de cuenta</h1>
<%
    // Inicializamos las variables de error
    String errorMessage = null;
    String successMessage = null;

    // Si el formulario aún no ha sido enviado
    if (request.getParameter("submit") == null) {
%>
<form>
    <CENTER>
        <HR>
        <I>Crear Cuenta Cliente<a href="AutentificarCliente.jsp">Cerrar Sesión</a></I>
        <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25">
            <tr>
                <td>
                    <input id="Nombre" name="nombre" placeholder="Nombre"
                           title="Nombre del cliente" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Apell_pat" name="apellPat" placeholder="Apellido paterno "
                           title="Apellido Paterno" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Apell_mat" name="apellMat" placeholder="Apellido materno"
                           title="Apellido materno" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Fecha_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                           title="Fecha de nacimiento" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="RFC" name="rfc" placeholder="RFC "
                           title="RFC cliente" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Correo" name="correo" placeholder="Email"
                           title="Correo electrónico" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Password" name="password" placeholder="Contraseña"
                           title="Contraseña" type="password" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="direccion" name="direccion" placeholder="Dirección"
                           title="Dirección" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="telefono" name="telefono" placeholder="Teléfono"
                           title="Teléfono" type="text" value="<%= request.getParameter("telefono") %>" size="10"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="submit" name="submit" type="submit" value="Crear">
                    <input id="limpiar" name="limpiar" type="reset" value="Limpiar">
                </td>
            </tr>
        </table>
        <a href="Principal.html">Regresar</a>
    </CENTER>
</form>
<%
} else {
    try {
        // Intentamos guardar los datos del cliente
        Cliente cliente = new Cliente();
        cliente.setNombre(request.getParameter("nombre"));
        cliente.setApellPat(request.getParameter("apellPat"));
        cliente.setApellMat(request.getParameter("apellMat"));
        cliente.setFechaNac(request.getParameter("fechaNac"));
        cliente.setRfc(request.getParameter("rfc"));
        cliente.setCorreo(request.getParameter("correo"));
        cliente.setPassword(request.getParameter("password"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setTelefono(request.getParameter("telefono"));

        ClienteDAO registro = new ClienteDAO();
        int id_cliente = registro.guardarCliente(cliente);

        if (id_cliente > 0) {
            successMessage = "Registro completado exitosamente.";
%>
<table border="1">
    <thead>
    <tr>
        <th>ID del cliente</th>
        <th>Nombre cliente</th>
        <th>Apellido paterno</th>
        <th>Apellido materno</th>
        <th>Fecha de nacimiento</th>
        <th>RFC</th>
        <th>Email</th>
        <th>Contraseña</th>
        <th>Dirección</th>
        <th>Teléfono</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><%= cliente.getIdCliente() %></td>
        <td><%= cliente.getNombre() %></td>
        <td><%= cliente.getApellPat() %></td>
        <td><%= cliente.getApellMat() %></td>
        <td><%= cliente.getFechaNac() %></td>
        <td><%= cliente.getRfc() %></td>
        <td><%= cliente.getCorreo() %></td>
        <td><%= cliente.getPassword() %></td>
        <td><%= cliente.getDireccion() %></td>
        <td><%= cliente.getTelefono() %></td>
    </tr>
    </tbody>
</table>
<h2><%= successMessage %></h2>
<%
            } else {
                throw new Exception("No se pudo guardar el cliente en la base de datos.");
            }
        } catch (SQLException e) {
            errorMessage = "Error de base de datos: " + e.getMessage();
        } catch (ParseException e) {
            errorMessage = "Error en el formato de fecha: " + e.getMessage();
        } catch (Exception e) {
            errorMessage = "Error: " + e.getMessage();
        }
    }
%>
<% if (errorMessage != null) { %>
<h2><%= errorMessage %></h2>
<% } %>
</body>
</html>