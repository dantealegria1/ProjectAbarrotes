<%@page import="Beans.ProductoDAO"%>
<%@ page import="org.hibernate.HibernateException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;">
    <title>Nuevo Producto</title>
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
                if (codigoCaracter == teclas_especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }
            return permitidos.indexOf(caracter) != -1 || tecla_especial;
        }

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

            // Realizar validaciones adicionales si es necesario
            return true;
        }
    </script>
</head>
<body>
<h1>Portal de registro de nuevos productos</h1>
<%
    if (request.getParameter("submit") == null) {
%>
<form onsubmit="return validacion()">
    <center>
        <hr>
        <i>Insertar Producto.<a href="AutentificarEmpleado.jsp">Cerrar Sesion</a></i>
        <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25">
            <tr>
                <td><input id="Nombre_producto" name="nombreProducto" placeholder="Nombre de producto" title="Nombre de producto" type="text" value="" size="25" onkeypress="return permite(event, 'car')" /></td>
            </tr>
            <tr>
                <td><input id="Presentacion" name="presentacion" placeholder="Presentacion" title="Presentacion" type="text" value="" size="25" onkeypress="return permite(event, 'num_car')" /></td>
            </tr>
            <tr>
                <td><input id="Caducidad" name="caducidad" placeholder="Caducidad" title="Caducidad" type="text" value="" size="25" onkeypress="return permite(event, 'num_car')" /></td>
            </tr>
            <tr>
                <td><input id="PProveedor" name="pproveedor" placeholder="Precio Proveedor" title="PrecioProveedor" type="text" value="" size="25" onkeypress="return permite(event, 'num')" /></td>
            </tr>
            <tr>
                <td><input id="PUnitario" name="punitario" placeholder="Precio Unitario" title="Precio Unitario" type="text" value="" size="25" onkeypress="return permite(event, 'num')" /></td>
            </tr>
            <tr>
                <td><input id="Existencias" name="existencias" placeholder="Existencias" title="Existencias" type="text" value="" size="25" onkeypress="return permite(event, 'num')" /></td>
            </tr>
            <tr>
                <td><input id="Fech" name="fech" placeholder="Fecha" title="Fecha" type="text" value="" size="25" onkeypress="return permite(event, 'num_car')" /></td>
            </tr>
            <tr>
                <td><input id="Marca" name="marca" placeholder="Marca" title="Marca" type="text" value="" size="25" onkeypress="return permite(event, 'num_car')" /></td>
            </tr>
            <tr>
                <td><input id="IdProveedor" name="idProveedor" placeholder="IdProveedor" title="ID de Proveedor" type="text" value="" size="25" onkeypress="return permite(event, 'num')" /></td>
            </tr>
            <tr>
                <td><input id="submit" name="submit" type="submit" value="Crear"><input id="limpiar" name="limpiar" type="reset" value="Limpiar"></td>
            </tr>
        </table>
        <a href="EliminarProducto.jsp">Regresar</a>
    </center>
</form>
<% } else { %>
<jsp:useBean id="producto" scope="page" class="Mapeos.Producto" />
<jsp:setProperty name="producto" property="*" />
<%
    int NoProducto = 0;
    ProductoDAO pregistro = new ProductoDAO();

    try {
        NoProducto = pregistro.guardaProducto(producto);
        out.println("Producto guardado con ID: " + NoProducto);
    } catch (HibernateException e) {
        out.println("Error al guardar el producto: " + e.getMessage());
        e.printStackTrace();
    }

    if (NoProducto > 0) {
%>
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
        <th>Id proveedor</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><%= producto.getIdProducto()%></td>
        <td><%= producto.getNombreProducto()%></td>
        <td><%= producto.getPresentacion()%></td>
        <td><%= producto.getCaducidad()%></td>
        <td><%= producto.getPrecioProv()%></td>
        <td><%= producto.getPrecioUni()%></td>
        <td><%= producto.getExistencias()%></td>
        <td><%= producto.getFech()%></td>
        <td><%= producto.getMarca()%></td>
        <td><%= producto.getIdProveedor()%></td>
    </tr>
    </tbody>
</table>
<h2>Producto agregado</h2>
<% } else { %>
<h2>Lo sentimos, no se pudo insertar el registro</h2>
<% } } %>
</body>
</html>
