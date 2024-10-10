<%-- 
    Document   : AutentificarAdmon
    Created on : 19/11/2013, 07:12:35 PM
    Author     : USUARIO
--%>

<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@page import="Mapeos.Empleado"%>
<jsp:useBean id="uname" scope="page" class="Mapeos.Empleado" />
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acceso</title>
    </head>
    <body>
        <form>
            <center>
                <h1>Acceso del empleado</h1>
                <div id="menu">
                    <ul>
                            <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                            <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                            <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                            <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                            <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
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
                            <td>Nombre</td>
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
        <% if (request.getParameter("enviar") != null) {
        %>
        <jsp:setProperty name="uname" property="*" />
        <%
            int i = 1;
            boolean us = false;
            EmpleadoDAO empDAO = new EmpleadoDAO();
            List<Empleado> listaEmpleados = empDAO.obtenListaEmpleado();
            for (i = 0; i < listaEmpleados.size(); i++) {
                uname.setNombreEmpleado(request.getParameter("usuario"));
                uname.setPassword(request.getParameter("contrasenia"));
                if ((uname.getNombreEmpleado().toString().equals(listaEmpleados.get(i).getNombreEmpleado().toString()))
                        && (uname.getPassword().toString().equals(listaEmpleados.get(i).getPassword().toString()))) {
                    if (listaEmpleados.get(i).getTipoUsuario().toString().equals("Empleado") || listaEmpleados.get(i).getTipoUsuario().toString().equals("Administrador")) {
                        us = true;
        %>
    <center>
        <h3>Bienvenido <% out.println(uname.getNombreEmpleado().toString());%></h3>
        <P> <B>PORTAL PARA LOS PRODUCTOS</B> </P>
        <input type="button" onclick=" location.href = 'EliminarProducto.jsp' " value="Productos" name="boton" />
        <P> <B>PORTAL PARA LA CONFIGURACION DE CLIENTES</B> </P>
        <input type="button" onclick=" location.href = 'EliminarCliente.jsp' " value="Clientes" name="boton" />
    </center>
    <%  break;
    } else {
        us = true;
    %>
    <center>
        <h3>ACCESO DENEGADO - SOLO PERSONAL AUTORIZADO</h3>
        <a href="Principal.html">Pagina Principal</a>
    </center>
    <%   break;
                }
            }
        }
        if (us == false) {
    %>
    <center>
        <h3>El usuario y/ó contraseña son incorrectos.</h3>
        <a href="AutentificarEmpleado.jsp">Intentar de nuevo</a>
    </center>
    <%                }
        }

    %>
</body>
</html>