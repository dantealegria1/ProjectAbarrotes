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
<h1>Portal de modificación de datos del cliente</h1>
<%
    ClienteDAO clienteDAO = new ClienteDAO();
    List<Cliente> listaClientes = clienteDAO.obtenListaCliente();
%>

<form method="POST">
    <CENTER>
        <HR>
        <I>Para modificar un cliente seleccionar las filas desde el primer cliente hasta el que se desea modificar en la columna final.<a href="AutentificarEmpleado.jsp">Cerrar Sesion</a></I>
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
                <th>Dirección</th>
                <th>Teléfono</th>
                <th>Carrito</th>
                <th>Seleccionar</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Cliente a : listaClientes) {
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
                <td><label>
                    <input type="checkbox" name="cbactores" value="<%= a.getIdCliente() %>"/>
                </label></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <input type="submit" value="Actualizar seleccionado" name="actualizar" />
        <a href="EliminarCliente.jsp">Regresar</a>
    </CENTER>
</form>

<%
    if (request.getParameter("actualizar") != null) {
        String[] chbProductos = request.getParameterValues("cbactores");
        if (chbProductos != null) {
            for (String chbProducto : chbProductos) {
                int clienteId = Integer.parseInt(chbProducto);
                Cliente cliente = clienteDAO.obtenClientePorId(clienteId);
%>
<h2>Modificar Cliente ID: <%= clienteId %></h2>
<form method="POST" action="ModificarCliente.jsp">
    <table border="1">
        <tr><td>Nombre: <label>
            <input name="nombre" value="<%= cliente.getNombre() %>" />
        </label></td></tr>
        <tr><td>Apellido Paterno: <label>
            <input name="apellPat" value="<%= cliente.getApellPat() %>" />
        </label></td></tr>
        <tr><td>Apellido Materno: <label>
            <input name="apellMat" value="<%= cliente.getApellMat() %>" />
        </label></td></tr>
        <tr><td>Fecha Nac: <label>
            <input name="fechaNac" value="<%= cliente.getFechaNac() %>" />
        </label></td></tr>
        <tr><td>RFC: <label>
            <input name="rfc" value="<%= cliente.getRfc() %>" />
        </label></td></tr>
        <tr><td>Correo: <label>
            <input name="correo" value="<%= cliente.getCorreo() %>" />
        </label></td></tr>
        <tr><td>Contraseña: <label>
            <input name="password" value="<%= cliente.getPassword() %>" type="password" />
        </label></td></tr>
        <tr><td>Dirección: <label>
            <input name="direccion" value="<%= cliente.getDireccion() %>" />
        </label></td></tr>
        <tr><td>Teléfono: <label>
            <input name="telefono" value="<%= cliente.getTelefono() %>" />
        </label></td></tr>
        <tr><td>Carrito: <label>
            <input name="carrito" value="<%= cliente.getCarrito() %>" />
        </label></td></tr>
        <tr><td><input type="submit" name="submit" value="Actualizar" /></td></tr>
        <input type="hidden" name="clienteId" value="<%= clienteId %>" />
    </table>
</form>
<%
            }
        }
    }
%>

<%
    // Manejo de la actualización de cliente
    if (request.getParameter("submit") != null) {
        int clienteId = Integer.parseInt(request.getParameter("clienteId"));
        Cliente cliente = new Cliente();
        cliente.setIdCliente(clienteId);
        cliente.setNombre(request.getParameter("nombre"));
        cliente.setApellPat(request.getParameter("apellPat"));
        cliente.setApellMat(request.getParameter("apellMat"));
        cliente.setFechaNac(request.getParameter("fechaNac"));
        cliente.setRfc(request.getParameter("rfc"));
        cliente.setCorreo(request.getParameter("correo"));
        cliente.setPassword(request.getParameter("password"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setTelefono(request.getParameter("telefono"));
        cliente.setCarrito(Integer.valueOf(request.getParameter("carrito")));

        try {
            clienteDAO.actualizaCliente(cliente);
            response.sendRedirect("ModificarCliente.jsp"); // Redirigir para evitar reenvío de formulario
        } catch (Exception e) {
            e.printStackTrace(); // Manejar la excepción según sea necesario
            request.setAttribute("error", "No se pudo actualizar el cliente: " + e.getMessage());
        }
    }
%>
</body>
</html>
