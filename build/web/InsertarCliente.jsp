<%-- 
    Document   : InsertarCliente
    Created on : 2/01/2014, 03:53:37 PM
    Author     : Search
--%>

<%@page import="Beans.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
    </head>
    <body>
        <h1>Portal de creacion de cuenta</h1>
        <%
            if (request.getParameter("submit") == null) {
        %> 
        <form>
            <CENTER>
                <HR>
                 <I>Crear Cuanta Cliente<a href="AutentificarCliente.jsp">Cerrar Sesion</a></I>
                <table border="1"  cellpadding="0" cellspacing="0" 
                       height="40%" width="25">
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
                                   title="Correo electronico" type="text" value="" size="25"/>
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
                            <input id="telefono" name="telefono" placeholder="Telefono"
                                   title="Telefono" type="text" value="" size="10"/>
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
        <%        } else {%>
        <jsp:useBean id="cliente" scope="page" class="Mapeos.Cliente" />
        <jsp:setProperty name="cliente" property="*" />
        <%
            ClienteDAO registro = new ClienteDAO();
            int id_cliente = registro.guardarCliente(cliente);
            if (id_cliente > 0) {
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
                    <th>Telefono</th>
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
            <h2>Registro completado</h2>
        </tbody>
    </table> 
    <% } else {%>
    <h2>Lo sentimos, no se pudo crear la cuenta</h2>
    <%}
        }
    %>
</body>
</html>
