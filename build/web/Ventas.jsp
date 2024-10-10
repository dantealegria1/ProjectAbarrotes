<%-- 
    Document   : Ventas
    Created on : 3/01/2014, 12:53:47 PM
    Author     : Search
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="Mapeos.Cliente"%> 
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page import="Beans.ClienteDAO"%>
<jsp:useBean id="var1" scope="page" class="Mapeos.Producto" />
<jsp:useBean id="var2" scope="page" class="Mapeos.Cliente" />
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>producto</title>
    </head>
    <body>
        <h1>Portal de información del producto</h1>
                <div id="menu">
                    <ul>
                            <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                            <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                            <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                            <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                            <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
                    </ul>
                </div>

        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaproductos = productoDAO.obtenListaProducto();

            ClienteDAO clienteDAO = new ClienteDAO();
            List<Cliente> listaclientes = clienteDAO.obtenListaCliente();
            int valor = 0;
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Selecciona en la columna final el producto que deseas comprar.</I>.
                </HR>
                <%  for (Cliente b : listaclientes) {
                %>
                <I>----------  </I><tr><I>BIENBENID@</I>.<%= b.getNombre()%><I></tr> 
                    <I>----------  </I><th>SU CARRITO</I>. <%= b.getCarrito()%></th>
                <I>----------  </I><a href="Acceso.jsp">Cerrar Sesion</a>
                    <% }
                    %>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Unitario</th>
                            <th>Fecha</th>
                            <th>Marca</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  for (Producto a : listaproductos) {
                        %>
                        <tr>
                            <td><%= a.getNombreProducto()%></td>
                            <td><%= a.getPresentacion()%></td>
                            <td><%= a.getCaducidad()%></td>
                            <td><%= a.getPrecioUni()%></td>
                            <td><%= a.getFech()%></td>
                            <td><%= a.getMarca()%></td>
                            <td><input type="checkbox" name="cbactores" value="<%=a.getIdProducto()%>"/></td>
                        </tr>
                        <%
                                valor = a.getIdProducto();
                            }
                        %>
                    </tbody>
                </table>
                <input type="submit" value="Comprar" name="comprar" />
                <%
                    int compra = 0;
                    if (request.getParameter("comprar") != null) {
                %>
                <table border="1">
                    <jsp:useBean id="producto" scope="page" class="Mapeos.Producto" />
                    <jsp:setProperty name="producto" property="*" />
                    <%
                        String[] chbproductos = request.getParameterValues("cbactores");
                        for (int i = 0; i <= chbproductos.length; i++) {
                            if (i == chbproductos.length) {
                                compra = listaclientes.get(i - 1).getCarrito() - listaproductos.get(i - 1).getExistencias().intValue();
                                listaclientes.get(i - 1).setCarrito(compra);
                                //listaclientes.remove(i - 1).getCarrito();
                                out.println("*Compra efectuada*  " + "Carrito actual: " + compra);
                                //var1.setExistencias(var1.getExistencias() - 1);
                    %>
                    <thead>
                        <tr>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Unitario</th>
                            <th>Marca</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= listaproductos.get(i - 1).getNombreProducto()%></td>
                            <td><%= listaproductos.get(i - 1).getPresentacion()%></td>
                            <td><%= listaproductos.get(i - 1).getCaducidad()%></td>
                            <td><%= listaproductos.get(i - 1).getPrecioUni()%></td>
                            <td><%= listaproductos.get(i - 1).getMarca()%></td>
                        </tr>
                    </tbody>
                </table>
                <a href="Ventas.jsp">Realizar otra compra.</a>
            </CENTER>
        </form>
        <%
                    }
                }
            }
        %>
    </body>
</html>
