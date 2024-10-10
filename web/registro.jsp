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
            function permite(elEvento, permitidos) { // Variables que definen los caracteres permitidos 
                var numeros = "0123456789";
                var caracteres = " abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
                var numeros_caracteres = numeros + caracteres;
                var teclas_especiales = [8, 37, 39, 46];
                // 8 = BackSpace, 46 = Supr, 37 = flecha izquierda, 39 = flecha derecha 
                // Seleccionar los caracteres a partir del parámetro de la función 
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
                // Obtener la tecla pulsada
                var evento = elEvento || window.event;
                var codigoCaracter = evento.charCode || evento.keyCode;
                var caracter = String.fromCharCode(codigoCaracter);
                // Comprobar si la tecla pulsada es alguna de las teclas especiales
                // (teclas de borrado y flechas horizontales)
                var tecla_especial = false;
                for (var i in teclas_especiales) {
                    if (codigoCaracter == teclas_especiales[i]) {
                        tecla_especial = true;
                        break;
                    }
                }
                // Comprobar si la tecla pulsada se encuentra en los caracteres permitidos
                // o si es una tecla especial
                return permitidos.indexOf(caracter) != -1 || tecla_especial;
            }

            function limita(maximoCaracteres) {
                var elemento = document.getElementById("texto");
                if (elemento.value.length >= maximoCaracteres) {
                    return false;
                }
                else {
                    return true;
                }
            }
            function validacion() {

                //validamos campo1
                valor1 = document.getElementById("Nombre").value;
                if (valor1 == null || valor1.length == 0 || /^\s+$/.test(valor1))
                {
                    alert("*Falta ingresar nombre");
                    //return false; 
                }
                //validamos campo2
                valor2 = document.getElementById("Apell_pat").value;

                if (isNaN(valor2)) {
                    alert("*Ingresa Apellido");
                    //return false; 
                }

                valor3 = document.getElementById("Apell_pat").value;

                if (isNaN(valor3)) {
                    alert("*Ingresa Apellido");
                    //return false; 
                }

                valor4 = document.getElementById("Fecha_nac").value;

                if (isNaN(valor4)) {
                    alert("*Ingresa Fecha de nacimiento");
                    //return false; 
                }

                valor5 = document.getElementById("RFC").value;

                if (isNaN(valor5)) {
                    alert("*Ingresa RFC");
                    //return false; 
                }
                valor6 = document.getElementById("correo").value;

                if (isNaN(valor6)) {
                    alert("*Ingresa e-mail");
                    //return false; 
                }


                valor7 = document.getElementById("password").value;

                if (isNaN(valor7)) {
                    alert("*Ingresa Contraseña");
                    //return false; 
                }

                valor8 = document.getElementById("direccion").value;

                if (isNaN(valor8)) {
                    alert("*Ingresa Direccion");
                    //return false; 
                }
                valor9 = document.getElementById("telefono").value;

                if (isNaN(valor9)) {
                    alert("*Ingresa Teefono");
                    //return false; 
                }

                //validar email
                email = document.getElementById("correo").value;
                if (!(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)/.test(email))) {
                    alert("*Email incorrecto");
                    //return false;
                }


                //validar numero de telefono
                telefono = document.getElementById("telefono").value;
                if (!(/^\d{9}$/.test(telefono))) {
                    alert("*Telefono no valido");
                    //return false; 
                }

            }
        </script>
    </head>
    <body>
        <h1>Portal de creacion de cuenta</h1>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
            </ul>
        </div>
        <%
            if (request.getParameter("submit") == null) {
        %> 
        <form onsubmit="return validacion()">
            <CENTER>
                <HR>
                <I>Crear Cuenta Cliente</I>
                <table border="1"  cellpadding="0" cellspacing="0" 
                       height="40%" width="25">
                    <tr>
                        <td>
                            <input id="Nombre" name="nombre" placeholder="Nombre"
                                   title="Nombre del cliente" type="text" value="" size="25"
                                   onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_pat" name="apellPat" placeholder="Apellido paterno "
                                   title="Apellido Paterno" type="text" value="" size="25"
                                   onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_mat" name="apellMat" placeholder="Apellido materno"
                                   title="Apellido materno" type="text" value="" size="25"
                                   onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fecha_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                                   title="Fecha de nacimiento" type="text" value="" size="25"
                                   onkeypress="return permite(event, 'num_car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RFC" name="rfc" placeholder="RFC "
                                   title="RFC cliente" type="text" value="" size="25"
                                   onkeypress="return permite(event, 'num_car')"/>
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
                                   title="Telefono" type="text" value="" size="10" onkeypress="return limita(10);"/>
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
                    <%--<th>Dirección</th>
                    <th>Telefono</th>--%>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= cliente.getIdCliente()%></td>
                    <td><%= cliente.getNombre()%></td>
                    <td><%= cliente.getApellPat()%></td>
                    <td><%= cliente.getApellMat()%></td>
                    <td><%= cliente.getFechaNac()%></td>
                    <td><%= cliente.getRfc()%></td>
                    <td><%= cliente.getCorreo()%></td>
                    <td><%= cliente.getPassword()%></td>
                    <%--<td><%= cliente.getDireccion()%></td>
                    <td><%= cliente.getTelefono()%></td>--%>
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
