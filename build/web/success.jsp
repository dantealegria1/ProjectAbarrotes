<%-- 
    Document   : sucess
    Created on : 3/11/2013, 02:39:21 PM
    Author     : USUARIO
--%>

<%
    if ((session.getAttribute("Nombre") == null) || (session.getAttribute("Nombre") == "")) {
%>
No estas registrado<br/>
<a href="registro.jsp"> Login</a>
<%} else {
%>
Bienvenido <%=session.getAttribute("Nombre")%>
<a href='logout.jsp'>Terminar Sesion</a>
<%
    }
%>