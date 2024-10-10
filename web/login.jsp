<%-- 
    Document   : login
    Created on : 2/11/2013, 02:13:10 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Empleado"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="login" class="Mapeos.Empleado" scope="page"/>
<jsp:setProperty name="login" property="*"/>
<%
    int existe = 0;
    if (application.getAttribute("empleado") == null) {
        application.setAttribute("empleado", new ArrayList());
    }

    ArrayList listaEmpleados = (ArrayList) application.getAttribute("empleado");
      for (int b = 0; b < listaEmpleados.size(); b++) {
        Empleado clt = (Empleado) listaEmpleados.get(b);
        if (clt.getNombreEmpleado().equals(login.getNombreEmpleado())
                && clt.getPassword().equals(login.getPassword())) {
            existe = 1;
        }
    }     
    /*
     String userid = request.getParameter("uname");
     String pwd = request.getParameter("pass");
     */
    /*if (existe == 1) {
        session.setAttribute("NombreEmpleado", login.getNombreEmpleado());
        //out.println("welcome " + login.getUname());
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("compra.jsp");
    } else {
        out.println("Datos no validos <a href='AutentificarAdmon.jsp'>Intenta de nuevo</a>");
    }*/
%>