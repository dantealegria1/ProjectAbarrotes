<%-- 
    Document   : ModificarCliente
    Created on : 4/01/2014, 05:24:56 PM
    Author     : Search
--%>

<%@page import="Mapeos.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cliente</title>
    </head>
    <body>
        <h1>Portal de modificacion de datos del cliente</h1>
        <% ClienteDAO clienteDAO = new ClienteDAO();
            List<Cliente> listaClientes = clienteDAO.obtenListaCliente();
            int valor = 0;
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Para modificar un cliente seleccionar las filas desde el primer cliente hasta el que se desea modificar en la columna final.<a href="AutentificarEmpleado.jsp">Cerrar Sesion</a> </I>.
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID cliente</th>
                        <th>Nombre</th>
                        <th>Apellido paterno</th>
                        <th>Apellido materno</th>
                        <th>Fecha de nacimiento</th>
                        <th>RFC</th>
                        <th>Correo</th>
                        <th>Contraseña</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                        <th>Carrito</th>
                        </tr>
                    </thead>
                    <%  for (Cliente a : listaClientes) { 
                    %>
                    <tr>
                        <td><%= a.getIdCliente() %></td>
                        <td><%= a.getNombre() %></td>
                        <td><%= a.getApellPat() %></td>
                        <td><%= a.getApellMat() %></td>
                        <td><%= a.getFechaNac() %></td>
                        <td><%= a.getRfc() %></td>
                        <td><%= a.getCorreo() %></td>
                        <td><%= a.getPassword() %></td>
                        <td><%= a.getDireccion() %></td>
                        <td><%= a.getTelefono() %></td>
                        <td><%= a.getCarrito() %></td>
                        <td><input type="checkbox" name="cbactores" value="<%=a.getIdCliente()%>"/></td>
                    </tr>
                    <%
                            valor = a.getIdCliente().intValue();
                        }
                    %>
                </table>
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarCliente.jsp">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>
                <h2>Insertar producto</h2>
                <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25">
                    <jsp:useBean id="producto" scope="page" class="Mapeos.Cliente" />
                    <jsp:setProperty name="producto" property="*" />
                    <%
                        String[] chbProductos = request.getParameterValues("cbactores");
                        for (int i = 0; i <= chbProductos.length; i++) {
                            if (i == chbProductos.length) {
                    %>
                    <tr>
                        <td>
                            <input id="Nombre" name="nombre" placeholder="Nombre"
                                   title="Nombre del cliente" type="text" value="<%= listaClientes.get(i - 1).getNombre() %> " size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_pat" name="apellPat" placeholder="Apellido paterno "
                                   title="Apellido Paterno" type="text" value="<%= listaClientes.get(i - 1).getApellPat() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_mat" name="apellMat" placeholder="Apellido materno"
                                   title="Apellido materno" type="text" value="<%= listaClientes.get(i - 1).getApellMat() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fecha_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                                   title="Fecha de nacimiento" type="text" value="<%= listaClientes.get(i - 1).getFechaNac() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RFC" name="rfc" placeholder="RFC "
                                   title="RFC cliente" type="text" value="<%= listaClientes.get(i - 1).getRfc() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Correo" name="correo" placeholder="Email"
                                   title="Correo electronico" type="text" value="<%= listaClientes.get(i - 1).getCorreo() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Password" name="password" placeholder="Contraseña"
                                   title="Contraseña" type="password" value="<%= listaClientes.get(i - 1).getPassword() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="direccion" name="direccion" placeholder="Dirección"
                                   title="Dirección" type="text" value="<%= listaClientes.get(i - 1).getDireccion() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="telefono" name="telefono" placeholder="Telefono"
                                   title="Telefono" type="text" value="<%= listaClientes.get(i - 1).getTelefono() %>" size="10"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="carrito" name="carrito" placeholder="Carrito"
                                   title="Carrito" type="text" value="<%= listaClientes.get(i - 1).getCarrito() %>" size="10"/>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input id="submit" name="submit" type="submit" value="Crear">
                            <input type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
            </CENTER>
        </form>
        <%
                    }
                }
            }
        %>
    </body>
</html>
