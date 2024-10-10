<%-- 
    Document   : consultar
    Created on : 1/11/2013, 06:31:09 PM
    Author     : Search
--%>

<%@page import="Mapeos.Empleado"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleado</title>
    </head>
    <body>
        <h1>Portal de modificacion de datos del empleado</h1>
        <% EmpleadoDAO empleadoDAO = new EmpleadoDAO();
            List<Empleado> listaEmpleados = empleadoDAO.obtenListaEmpleado();
            int valor = 0;
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Para modificar un empleado seleccionar las filas desde el primer empleado hasta el que se desea modificar en la columna final.<a href="AutentificarAdmon.jsp">Cerrar Sesion</a> </I>.
                </HR>
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
                    <%  for (Empleado a : listaEmpleados) {
                    %>
                    <tr>
                        <td><%= a.getNoEmpleado()%></td>
                        <td><%= a.getNombreEmpleado()%></td>
                        <td><%= a.getPassword()%></td>
                        <td><%= a.getApellPatEmpleado()%></td>
                        <td><%= a.getApellMatEmpleado()%></td>
                        <td><%= a.getFechaNac()%></td>
                        <td><%= a.getRfce()%></td>
                        <td><%= a.getSalario()%></td>
                        <td><%= a.getEstadoCivil()%></td>
                        <td><%= a.getEstatus()%></td>
                        <td><%= a.getNivelEstudio()%></td>
                        <td><%= a.getTipoUsuario()%></td>
                        <td><input type="checkbox" name="cbactores" value="<%=a.getNoEmpleado()%>"/></td>
                    </tr>
                    <%
                            valor = a.getNoEmpleado().intValue();
                        }
                    %>
                </table>
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarEmpleado.jsp">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>
                <h2>Insertar empleado</h2>
                <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25">
                    <jsp:useBean id="empleado" scope="page" class="Mapeos.Empleado" />
                    <jsp:setProperty name="empleado" property="*" />
                    <%
                        String[] chbEmpleados = request.getParameterValues("cbactores");
                        for (int i = 0; i <= chbEmpleados.length; i++) {
                            if (i == chbEmpleados.length) {
                    %>
                    <tr>
                        <td>
                            <input id="Nombre_empleado" name="nombreEmpleado" placeholder="Nombre de empleado"
                                   title="Nombre de empleado" type="text" value="<%= listaEmpleados.get(i - 1).getNombreEmpleado()%> " size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="password" name="password" placeholder="Contraseña"
                                   title="Contraseña" type="password" value="<%= listaEmpleados.get(i - 1).getPassword()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_pat_empleado" name="apellPatEmpleado" placeholder="Apellido paterno "
                                   title="Apellido paterno" type="text" value="<%= listaEmpleados.get(i - 1).getApellPatEmpleado()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_mat_empleado" name="apellMatEmpleado" placeholder="Apellido materno"
                                   title="Apellido materno" type="text" value="<%= listaEmpleados.get(i - 1).getApellMatEmpleado()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fec_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                                   title="Fecha de nacimiento" type="text" value="<%= listaEmpleados.get(i - 1).getFechaNac()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RFCE" name="rfce" placeholder="RFC empleado"
                                   title="RFC" type="text" value="<%= listaEmpleados.get(i - 1).getRfce()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Salario" name="salario" placeholder="Salario"
                                   title="Salario" type="text" value="<%= listaEmpleados.get(i - 1).getSalario()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="Edo_civil" name="estadoCivil"> 
                                <option value="Soltero">Soltero</option>
                                <option value="Casado">Casado</option>
                                <option value="Divorciado">Divorciado</option>
                                <option value="Viudo">Viudo</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="Estatus_emp" name="estatus"> 
                                <option value="Laborando">Laborando</option>
                                <option value="Desempleado">Desempleado</option>
                                <option value="Periodo Vacacional">Periodo Vacacional</option>
                                <option value="Incapacitado o lactancia">Incapacitado o lactancia</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="Nivel" name="nivelEstudio">
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
                            <select id="tipoUsuario" name="tipoUsuario" value="<%= empleado.getTipoUsuario()%>"> 
                                <option value="Administrador">Administrador</option>
                                <option value="Empleado">Empleado</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="submit" name="submit" type="submit" value="Actualizar">
                            <input type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
            </CENTER>
        </form>
        <%
            /*if (request.getParameter("submit") != null) {
             for (int j = 0; j < chbEmpleados.length; j++) {
             out.println("<li>" + chbEmpleados[j]);
             empleadoDAO.actualizaEmpleado(Short.valueOf(chbEmpleados[j]));  
             out.println(" El empleado ha sido actualizado");
             }
             }
             }*/
            if (request.getParameter("submit") != null) {%>
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
            <h2>Producto agregado</h2>
        </tbody>
    </table> 
    <a href="ModificarEmpleado.jsp">Regresar</a>
    <% }else {%>
    <h2>Lo sentimos, no se puedo actualizar el registro</h2>
    <%}
                    }
                }
            }
        }
    %>
</body>
</html>
