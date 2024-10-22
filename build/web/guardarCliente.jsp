<%@page import="Mapeos.Cliente"%>
<%@page import="Beans.ClienteDAO"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int clienteId = Integer.parseInt(chbProducto);
        Cliente cliente = clienteDAO.obtenClientePorId(clienteId);
        String nombre = request.getParameter("nombre");
        String apellPat = request.getParameter("apellPat");
        String apellMat = request.getParameter("apellMat");
        String fechaNac = request.getParameter("fechaNac");
        String rfc = request.getParameter("rfc");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String carrito = request.getParameter("carrito");

        // Crear y actualizar el cliente
        Cliente cliente = new Cliente();
        cliente.setIdCliente(idCliente);
        cliente.setNombreCliente(nombreCliente);
        cliente.setDireccion(direccion);
        cliente.setTelefono(telefono);
        cliente.setEmail(email);

        ClienteDAO clienteDAO = new ClienteDAO();
        int resultado = clienteDAO.actualizaCliente(cliente);

        if (resultado != 0) {
            out.println("<h2>Cliente actualizado con éxito.</h2>");
            out.println("<script type='text/javascript'>");
            out.println("setTimeout(function(){ window.location.href='EliminarCliente.jsp'; }, 3000);");
            out.println("</script>");
        } else {
            out.println("<h2>Error al actualizar el cliente. Por favor intenta nuevamente.</h2>");
        }
    }
%>
