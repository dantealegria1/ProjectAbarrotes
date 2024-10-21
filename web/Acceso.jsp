<%@page import="java.util.List"%>
<%@page import="Beans.ClienteDAO" %>
<%@page import="Mapeos.Cliente" %>
<jsp:useBean id="uname" scope="page" class="Mapeos.Cliente" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css.css" title="style">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
</head>
<body>
<form>
    <center>
        <h1>Acceso del cliente</h1>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp" class="normalMenu">Conocenos</a></li>
                <li><a href="Productos.jsp" class="normalMenu">Productos </a></li>
                <li><a href="Contacto.jsp" class="normalMenu">Contacto</a></li>
                <li><a href="Acceso.jsp" class="normalMenu">Ingresar</a></li>
                <li><a href="registro.jsp" class="normalMenu">Registrate_Aquí</a></li>
            </ul>
        </div>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <th colspan="2">Login</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Usuario</td>
                <td><input type="text" name="usuario" value="" /></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="contrasenia" value="" /></td>
            </tr>
            <tr>
                <td><input type="submit" name="enviar" value="Entrar" /></td>
                <td><input type="reset" value="Limpiar" /></td>
            </tr>
            </tbody>
        </table>
        <a href="Principal.html">Pagina Principal</a>
    </center>
</form>

<% if (request.getParameter("enviar") != null) { %>
<jsp:setProperty name="uname" property="*" />
<%
    boolean us = false;
    ClienteDAO empDAO = new ClienteDAO();
    List<Cliente> listaClientes = empDAO.obtenListaCliente();

    // Validar usuario y contraseña
    for (Cliente cliente : listaClientes) {
        uname.setNombre(request.getParameter("usuario"));
        uname.setPassword(request.getParameter("contrasenia"));

        // Comprobar si el usuario y contraseña coinciden
        if (uname.getNombre().equals(cliente.getNombre()) &&
                uname.getPassword().equals(cliente.getPassword())) {
            us = true;
%>
<center>
    <h3>Bienvenido <% out.println(uname.getNombre()); %></h3>
    <input type="button" onclick="location.href = 'Ventas.jsp'" value="Consultar los productos" name="boton" />
</center>
<%
            break; // Salimos del bucle si encontramos el usuario
        }
    }

    // Si no se encontró el usuario, mostramos el mensaje correspondiente
    if (!us) {
%>
<center>
    <h3>Es posible que el usuario y/ó contraseña sean incorrectos.</h3>
    <h4>Si no tienes una cuenta, <a href="registro.jsp">créala ahora</a>.</h4>
    <a href="Acceso.jsp">Intentar de nuevo</a>
</center>
<%
        }
    }
%>
</body>
</html>