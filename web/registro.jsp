<%-- 
    Document   : registro
    Created on : 3/01/2014, 11:04:00 AM
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
    <script type="text/javascript">
        function permite(elEvento, permitidos) {
            var numeros = "0123456789";
            var caracteres = " abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
            var numeros_caracteres = numeros + caracteres;
            var teclas_especiales = [8, 37, 39, 46];
            switch (permitidos) {
                case 'num':
                    permitidos = numeros;
                    break;
                case 'car':
                    permitidos = caracteres;
                    break;
                case 'num_car':
                    permitidos = numeros_caracteres;
                    break;
            }
            var evento = elEvento || window.event;
            var codigoCaracter = evento.charCode || evento.keyCode;
            var caracter = String.fromCharCode(codigoCaracter);
            var tecla_especial = false;
            for (var i in teclas_especiales) {
                if (codigoCaracter === teclas_especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }
            return permitidos.indexOf(caracter) != -1 || tecla_especial;
        }

        function limita(maximoCaracteres) {
            var elemento = document.getElementById("texto");
            if (elemento.value.length >= maximoCaracteres) {
                return false;
            } else {
                return true;
            }
        }

        function validacion() {
            var errores = "";
            var valor1 = document.getElementById("Nombre").value;
            if (valor1 == null || valor1.length == 0 || /^\s+$/.test(valor1)) {
                errores += "* Falta ingresar nombre\n";
            }

            var valor2 = document.getElementById("Apell_pat").value;
            if (valor2 == null || valor2.length == 0 || /^\s+$/.test(valor2)) {
                errores += "* Falta ingresar apellido paterno\n";
            }

            var valor3 = document.getElementById("Apell_mat").value;
            if (valor3 == null || valor3.length == 0 || /^\s+$/.test(valor3)) {
                errores += "* Falta ingresar apellido materno\n";
            }

            var valor4 = document.getElementById("Fecha_nac").value;
            if (valor4 == null || valor4.length == 0 || /^\s+$/.test(valor4)) {
                errores += "* Falta ingresar fecha de nacimiento\n";
            }

            var valor5 = document.getElementById("RFC").value;
            if (valor5 == null || valor5.length == 0 || /^\s+$/.test(valor5)) {
                errores += "* Falta ingresar RFC\n";
            }

            email = document.getElementById("correo").value;
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                alert("*Email incorrecto");
                return false;
            }

            var valor7 = document.getElementById("Password").value;
            if (valor7 == null || valor7.length == 0 || /^\s+$/.test(valor7)) {
                errores += "* Falta ingresar contraseña\n";
            }

            var valor8 = document.getElementById("direccion").value;
            if (valor8 == null || valor8.length == 0 || /^\s+$/.test(valor8)) {
                errores += "* Falta ingresar dirección\n";
            }

            var valor9 = document.getElementById("telefono").value;
            if (!(/^\d{10}$/.test(valor9))) {
                errores += "* Teléfono no válido (debe ser de 10 dígitos)\n";
            }

            if (errores.length > 0) {
                alert(errores);
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<h1>Portal de creación de cuenta</h1>
<div id="menu">
    <ul>
        <li><a href="Conocenos.jsp" class="normalMenu">Conocenos</a></li>
        <li><a href="Productos.jsp" class="normalMenu">Productos</a></li>
        <li><a href="Contacto.jsp" class="normalMenu">Contacto</a></li>
        <li><a href="Acceso.jsp" class="normalMenu">Ingresar</a></li>
        <li><a href="registro.jsp" class="normalMenu">Registrate_Aquí</a></li>
    </ul>
</div>
<%
    if (request.getParameter("submit") == null) {
%>
<form onsubmit="return validacion()">
    <CENTER>
        <HR>
        <I>Crear Cuenta Cliente</I>
        <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25">
            <tr>
                <td>
                    <input id="Nombre" name="nombre" placeholder="Nombre" title="Nombre del cliente" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Apell_pat" name="apellPat" placeholder="Apellido paterno" title="Apellido Paterno" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Apell_mat" name="apellMat" placeholder="Apellido materno" title="Apellido materno" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Fecha_nac" name="fechaNac" placeholder="Fecha de nacimiento" title="Fecha de nacimiento" type="date" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="RFC" name="rfc" placeholder="RFC" title="RFC cliente" type="text" value="" size="25" onkeypress="return permite(event, 'num_car')"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Correo" name="correo" placeholder="Email" title="Correo electronico" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Password" name="password" placeholder="Contraseña" title="Contraseña" type="password" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="direccion" name="direccion" placeholder="Dirección" title="Dirección" type="text" value="" size="25"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="telefono" name="telefono" placeholder="Teléfono" title="Teléfono" type="number" value="" size="10" min="0" max="9999999999" onkeypress="return limita(10);"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="submit" name="submit" type="submit" value="Crear">
                    <input id="limpiar" name="limpiar" type="reset" value="Limpiar">
                </td>
            </tr>
        </table>
        <a href="Principal.html">Pagina Principal</a>
    </CENTER>
</form>
<% } else { %>
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
<%
        } else {
            out.println("Error al registrar el cliente");
        }
    }
%>
</body>
</html>