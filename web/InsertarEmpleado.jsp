<%--
    Document   : insertarEmpleado
    Created on : 1/11/2013, 06:10:15 PM
    Author     : Search
--%>

<%@page import="Beans.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;">
        <title>JSP Page</title>
        <script type="text/javascript">
            function permite(elEvento, permitidos) { // Variables que definen los caracteres permitidos 
                const numeros = "0123456789";
                const caracteres = " abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
                const numeros_caracteres = numeros + caracteres;
                const teclas_especiales = [8, 37, 39, 46];
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
                const evento = elEvento || window.event;
                const codigoCaracter = evento.charCode || evento.keyCode;
                const caracter = String.fromCharCode(codigoCaracter);
                // Comprobar si la tecla pulsada es alguna de las teclas especiales
                // (teclas de borrado y flechas horizontales)
                let tecla_especial = false;
                for (const i in teclas_especiales) {
                    if (codigoCaracter === teclas_especiales[i]) {
                        tecla_especial = true;
                        break;
                    }
                }
                // Comprobar si la tecla pulsada se encuentra en los caracteres permitidos
                // o si es una tecla especial
                return permitidos.indexOf(caracter) !== -1 || tecla_especial;
            }

            function limita(maximoCaracteres) {
                const elemento = document.getElementById("texto");
                return elemento.value.length < maximoCaracteres;
            }
            function validacion() {
                let errores = ""; // Variable para almacenar los mensajes de error

                // Validamos campo1 (Nombre)
                const valor1 = document.getElementById("Nombre_empleado").value;
                if (valor1 == null || valor1.length === 0 || /^\s+$/.test(valor1)) {
                    errores += "*Campo vacio... Debes colocar Nombre\n";
                }

                // Validamos campo2 (Contraseña)
                const valor2 = document.getElementById("password").value;
                if (valor2 == null || valor2.length === 0 || /^\s+$/.test(valor2)) {
                    errores += "*Campo vacio... Debes colocar una contraseña\n";
                }

                // Validamos campo3 (Apellido paterno)
                const valor3 = document.getElementById("Apell_pat_empleado").value;
                if (valor3 == null || valor3.length === 0 || /^\s+$/.test(valor3)) {
                    errores += "*Campo vacio... Debes colocar apellido paterno\n";
                }

                // Validamos campo4 (Apellido materno)
                const valor4 = document.getElementById("Apell_mat_empleado").value;
                if (valor4 == null || valor4.length === 0 || /^\s+$/.test(valor4)) {
                    errores += "*Campo vacio... Debes colocar apellido materno\n";
                }

                // Validamos campo5 (Fecha de nacimiento)
                const valor5 = document.getElementById("Fec_nac").value;
                if (valor5 == null || valor5.length === 0 || /^\s+$/.test(valor5)) {
                    errores += "*Campo vacio... Debes colocar la fecha de nacimiento\n";
                }

                // Validamos campo6 (RFC)
                const valor6 = document.getElementById("RFCE").value;
                if (valor6 == null || valor6.length === 0 || /^\s+$/.test(valor6)) {
                    errores += "*Campo vacio... Debes colocar el RFC\n";
                }

                // Validamos campo7 (Salario)
                const valor7 = document.getElementById("Salario").value;
                if (valor7 == null || valor7.length === 0 || isNaN(valor7)) {
                    errores += "*Campo vacio o inválido... Debes colocar un salario válido\n";
                }

                // Validamos select (Estado Civil)
                const indice1 = document.getElementById("Edo_civil").value;
                if (indice1 == null || indice1 === 0) {
                    errores += "*No se ha seleccionado Estado Civil\n";
                }

                // Validamos select (Estatus)
                const indice2 = document.getElementById("Estatus_emp").value;
                if (indice2 == null || indice2 === 0) {
                    errores += "*No se ha seleccionado Estatus\n";
                }

                // Validamos select (Nivel de estudios)
                const indice3 = document.getElementById("Nivel").value;
                if (indice3 == null || indice3 === 0) {
                    errores += "*No se ha seleccionado Nivel de estudios\n";
                }

                // Validamos select (Tipo de Usuario)
                const indice4 = document.getElementById("tipoUsuario").value;
                if (indice4 == null || indice4 === 0) {
                    errores += "*No se ha seleccionado tipo de Usuario\n";
                }

                // Si hay errores, mostramos todos en una alerta
                if (errores !== "") {
                    alert(errores);
                    return false; // Detenemos el envío del formulario
                }
            }

        </script>


        <title>Empleado</title>
    </head>
    <body>
        <h1>Portal de registro de empleados</h1>
        <%
            if (request.getParameter("submit") == null) {
        %> 
        <form onsubmit="return validacion()">
            <CENTER>
                <HR>
                <I>Insertar empleado.<a href="AutentificarAdmon.jsp">Cerrar Sesion</a></I>
                <table border="1"  cellpadding="0" cellspacing="0" 
                       height="40%" width="25">
                    <tr>
                        <td>
                            <input id="Nombre_empleado" name="nombreEmpleado" placeholder="Nombre de empleado"
                                   title="Nombre" type="text" value="" size="25" onkeypress="return permite(event, 'car')" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="password" name="password" placeholder="Contraseña"
                                   title="Contraseña" type="password" value="" size="25" onkeypress="return permite(event, 'num_car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_pat_empleado" name="apellPatEmpleado" placeholder="Apellido paterno "
                                   title="Apellido paterno" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_mat_empleado" name="apellMatEmpleado" placeholder="Apellido materno"
                                   title="Apellido materno" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fec_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                                   title="Fecha de nacimiento" type="text" value="" size="25" onkeypress="return permite(event, 'num_car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RFCE" name="rfce" placeholder="RFC empleado"
                                   title="RFC" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Salario" name="salario" placeholder="Salario"
                                   title="Salario" type="text" value="" size="25" onkeypress="return permite(event, 'num')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Edo_civil"></label><select id="Edo_civil" name="estadoCivil">
                                <option value="Soltero">Soltero</option>
                                <option value="Casado">Casado</option>
                                <option value="Divorciado">Divorciado</option>
                                <option value="Viudo">Viudo</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Estatus_emp"></label><select id="Estatus_emp" name="estatus">
                                <option value="Laborando">Laborando</option>
                                <option value="Desempleado">Desempleado</option>
                                <option value="Periodo Vacacional">Periodo Vacacional</option>
                                <option value="Incapacitado o lactancia">Incapacitado o lactancia</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Nivel"></label><select id="Nivel" name="nivelEstudio">
                                <option value="Sin estudios">Sin estudios</option> 
                                <option value="Primaria">Primaria</option>
                                <option value="Secundaria">Secundaria</option>
                                <option value="Bachiller">Bachiller</option>
                                <option value="Universidad">Universidad</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <label for="tipoUsuario"></label><select id="tipoUsuario" name="tipoUsuario">
                                <option value="Administrador">Administrador</option>
                                <option value="Empleado">Empleado</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="submit" name="submit" type="submit" value="Crear">
                            <input id="limpiar" name="limpiar" type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
                <a href="EliminarEmpleado.jsp">Regresar</a>
            </CENTER>
        </form>
        <%        } else {%>
        <jsp:useBean id="empleado" scope="page" class="Mapeos.Empleado" />
        <jsp:setProperty name="empleado" property="*" />
        <%
            EmpleadoDAO empregistro = new EmpleadoDAO();
            int NoEmpleado = empregistro.guardaEmpleado(empleado);
            if (NoEmpleado > 0) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Numero empleado</th>
                    <th>Nombre empleado</th>
                    <th>Contraseña</th>
                    <th>Apellido paterno</th>
                    <th>Apellido materno</th>
                    <th>Fecha de nacimiento</th>
                    <th>RFC</th>
                    <th>Salario</th>
                    <th>Estado civil</th>
                    <th>Estatus</th>
                    <th>Nivel de estudio</th>
                    <th>Tipo de usuario</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= empleado.getNoEmpleado()%></td>
                    <td><%= empleado.getNombreEmpleado()%></td>
                    <td><%= empleado.getPassword()%></td>
                    <td><%= empleado.getApellPatEmpleado()%></td>
                    <td><%= empleado.getApellMatEmpleado()%></td>
                    <td><%= empleado.getFechaNac()%></td>
                    <td><%= empleado.getRfce()%></td>
                    <td><%= empleado.getSalario()%></td>
                    <td><%= empleado.getEstadoCivil()%></td>
                    <td><%= empleado.getEstatus()%></td>
                    <td><%= empleado.getNivelEstudio()%></td>
                    <td><%= empleado.getTipoUsuario()%></td>
                </tr>
            <h2>Empleado agregado</h2>
        </tbody>
    </table> 
    <a href="EliminarEmpleado.jsp">Regresar</a>
    <% } else {%>
    <h2>Lo sentimos, no se puedo insertar el registro</h2>
    <%}
        }
    %>
</body>
</html>

