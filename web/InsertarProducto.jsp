<%@page import="Beans.ProductoDAO"%>
<%@ page import="org.hibernate.HibernateException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;">
    <title>Nuevo Producto</title>
    <script type="text/javascript">
        function validacion() {
            let valor1 = document.getElementById("Nombre_producto").value;
            if (valor1 == null || valor1.length == 0 || /^\s+$/.test(valor1)) {
                alert("*Falta el Nombre");
                return false;
            }

            let valor9 = document.getElementById("IdProveedor").value;
            if (isNaN(valor9)) {
                alert("*Indica ID del Proveedor");
                return false;
            }

            // Updated IDs to match the form
            let precioProveedor = document.getElementById("pproveedor").value;
            let precioUnitario = document.getElementById("punitario").value;
            if (precioProveedor == null || precioProveedor <= 0 || isNaN(precioProveedor)) {
                alert("*Precio Proveedor no es válido");
                return false;
            }
            if (precioUnitario == null || precioUnitario <= 0 || isNaN(precioUnitario)) {
                alert("*Precio Unitario no es válido");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<h1>Portal de registro de nuevos productos</h1>
<% if (request.getParameter("submit") == null) { %>
<form method="post" action="guardarProducto.jsp" onsubmit="return validacion()">
    <center>
        <hr>
        <i>Insertar Producto.<a href="AutentificarEmpleado.jsp">Cerrar Sesion</a></i>
        <hr>
        <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25%">
            <tr>
                <td>
                    <input id="Nombre_producto" name="nombreProducto" placeholder="Nombre de producto"
                           title="Nombre de producto" type="text" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Presentacion" name="presentacion" placeholder="Presentación"
                           title="Presentación" type="text" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Caducidad" name="caducidad" placeholder="Caducidad"
                           title="Caducidad" type="date" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="pproveedor" name="precioProv" placeholder="Precio Proveedor"
                           title="Precio Proveedor" type="number" step="0.01" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="punitario" name="precioUni" placeholder="Precio Unitario"
                           title="Precio Unitario" type="number" step="0.01" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Fech" name="fech" placeholder="Fecha"
                           title="Fecha" type="date" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Marca" name="marca" placeholder="Marca"
                           title="Marca" type="text" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="Existencias" name="existencias" placeholder="Existencias"
                           title="Existencias" type="number" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="IdProveedor" name="idProveedor" placeholder="Id Proveedor"
                           title="Id Proveedor" type="number" size="25" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="hidden" name="accion" value="insertar" />
                    <input id="submit" name="submit" type="submit" value="Guardar" />
                    <input type="reset" value="Limpiar" />
                </td>
            </tr>
        </table>
    </center>
</form>
<% } %>
</body>
</html>