<%@page import="Beans.EstadoDAO"%>
<%@page import="Mapeos.Estado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;">
    <title>Registro de Estado</title>
    <script type="text/javascript">

        function permite(elEvento, permitidos) {
            const numeros = "0123456789";
            const caracteres = " abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
            let permitidosChars = "";

            switch (permitidos) {
                case 'num':
                    permitidosChars = numeros;
                    break;
                case 'car':
                    permitidosChars = caracteres;
                    break;
                case 'num_car':
                    permitidosChars = numeros + caracteres;
                    break;
                default:
                    permitidosChars = ""; // No permitir nada si el tipo no es válido
            }

            const evento = elEvento || window.event;
            const codigoCaracter = evento.charCode || evento.keyCode;
            const caracter = String.fromCharCode(codigoCaracter);

            // Comprobar si el carácter está permitido
            if (permitidosChars.indexOf(caracter) === -1) {
                // Si el carácter no está permitido, prevenir la acción
                return false;
            }
            return true; // Permitir la entrada
        }


        function validacion() {
            let errores = "";

            // Validamos campo1 (Nombre del Estado)
            const valor1 = document.getElementById("nombreEstado").value;
            if (valor1 == null || valor1.length === 0 || /^\s+$/.test(valor1)) {
                errores += "*Campo vacío... Debes colocar el nombre del estado\n";
            }

            if (errores !== "") {
                alert(errores);
                return false;
            }
        }
    </script>
</head>
<body>
<h1>Portal de registro de estados</h1>
<%
    // Verifica si se ha enviado el formulario
    if (request.getParameter("submit") != null) {
        // Obtiene el nombre del estado del formulario
        String nombreEstado = request.getParameter("nombreEstado");

        // Crea una instancia del objeto Estado y lo inicializa
        Estado estado = new Estado();
        estado.setNombreEstado(nombreEstado); // Asigna el nombre al estado

        // Crea una instancia de EstadoDAO y registra el nuevo estado
        EstadoDAO estadoDAO = new EstadoDAO();
        int id = estadoDAO.guardaEstado(estado); // Llama a tu método guardaEstado

        // Mensaje de confirmación
        if (id != -1) {
            out.println("<script>alert('Estado registrado exitosamente.');</script>");
            out.println("<script>setTimeout(function(){ window.location.href='EliminarEstado.jsp'; }, 1000);</script>");
        } else {
            out.println("<script>alert('Error al registrar el estado.');</script>");
        }
    }
%>
<form method="post" onsubmit="return validacion()">
    <CENTER>
        <HR>
        <I>Insertar estado.<a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>
        <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25">
            <tr>
                <td>
                    <input id="nombreEstado" name="nombreEstado" placeholder="Nombre del Estado"
                           title="Nombre Estado" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
                </td>
            </tr>

            <tr>
                <td>
                    <input id="submit" name="submit" type="submit" value="Registrar">
                    <input id="limpiar" name="limpiar" type="reset" value="Limpiar">
                </td>
            </tr>
        </table>
    </CENTER>
</form>
</body>
</html>
