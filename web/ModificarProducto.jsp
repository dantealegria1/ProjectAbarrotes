<%-- 
    Document   : ModificarProducto
    Created on : 26/12/2013, 08:01:41 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto</title>
    </head>
    <body>
        <h1>Portal de modificacion de datos del producto</h1>
        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaProductos = productoDAO.obtenListaProducto();
            int valor = 0;
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Para modificar un producto seleccionar las filas desde el primer producto hasta el que se desea modificar en la columna final.<a href="AutentificarAdmon.jsp">Cerrar Sesion</a> </I>.
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Numero producto</th>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Proveedor</th>
                            <th>P. Unitario</th>
                            <th>Existencias</th>
                            <th>Fecha</th>
                            <th>Marca</th>
                        </tr>
                    </thead>
                    <%  for (Producto a : listaProductos) {
                    %>
                    <tr>
                        <td><%= a.getIdProducto()%></td>
                        <td><%= a.getNombreProducto()%></td>
                        <td><%= a.getPresentacion()%></td>
                        <td><%= a.getCaducidad()%></td>
                        <td><%= a.getPrecioProv()%></td>
                        <td><%= a.getPrecioUni()%></td>
                        <td><%= a.getExistencias()%></td>
                        <td><%= a.getFech()%></td>
                        <td><%= a.getMarca()%></td>
                        <td><input type="checkbox" name="cbactores" value="<%=a.getIdProducto()%>"/></td>
                    </tr>
                    <%
                            valor = a.getIdProducto().intValue();
                        }
                    %>
                </table>
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarProducto.jsp">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>
                <h2>Insertar producto</h2>
                <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25">
                    <jsp:useBean id="producto" scope="page" class="Mapeos.Producto" />
                    <jsp:setProperty name="producto" property="*" />
                    <%
                        String[] chbProductos = request.getParameterValues("cbactores");
                        for (int i = 0; i <= chbProductos.length; i++) {
                            if (i == chbProductos.length) {
                    %>
                    <tr>
                        <td>
                            <input id="Nombre_producto" name="nombreProducto" placeholder="Nombre de producto"
                                   title="Nombre de producto" type="text" value="<%= listaProductos.get(i - 1).getNombreProducto()%> " size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Presentacion" name="presentacion" placeholder="Presentacion"
                                   title="Presentacion" type="text" value="<%= listaProductos.get(i - 1).getPresentacion()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Caducidad" name="caducidad" placeholder="Caducidad"
                                   title="Caducidad" type="text" value="<%= listaProductos.get(i - 1).getCaducidad()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="PProveedor" name="pproveedor" placeholder="Precio Proveedor"
                                   title="PrecioProveedor" type="text" value="<%= listaProductos.get(i - 1).getPrecioProv()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="PUnitario" name="punitario" placeholder="Precio Unitario"
                                   title="PrecioUnitario" type="text" value="<%= listaProductos.get(i - 1).getPrecioUni()%>" size="25"/>
                        </td>
                    </tr>
                    <td>
                        <input id="Fech" name="fech" placeholder="Fech"
                               title="Fech" type="text" value="<%= listaProductos.get(i - 1).getFech()%>" size="25"/>
                    </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Marca" name="marca" placeholder="Marca"
                                   title="Marca" type="text" value="<%= listaProductos.get(i - 1).getMarca()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="IdProveedor" name="idProveedor" placeholder="IdProveedor"
                                   title="IdProveedor" type="text" value="<%= listaProductos.get(i - 1).getIdProveedor()%>" size="25"/>
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
