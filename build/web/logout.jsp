

<%@page import="Beans.Cliente"%>
<%@page import="java.util.ArrayList"%>
<%
    session.setAttribute("id_cliente", null);
    session.invalidate();


    if (application.getAttribute("clientes") != null) {
        ArrayList listaClientes = (ArrayList) application.getAttribute("clientes");
        for (int b = 0; b < listaClientes.size(); b++) {
            Cliente usr = (Cliente) listaClientes.get(b);
            if (usr.getNombre().equals(session.getAttribute("Nombre"))) {
                listaClientes.add(b, null);
            }
        }
        response.sendRedirect("index.jsp");
%>