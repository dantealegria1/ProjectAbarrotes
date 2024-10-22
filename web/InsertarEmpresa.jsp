<%--
  Created by IntelliJ IDEA.
  User: dantealegria
  Date: 21/10/24
  Time: 5:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Beans.EmpresaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;">
  <title>Registro de Empresa</title>
  <script type="text/javascript">
    function permite(elEvento, permitidos) {
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
      const evento = elEvento || window.event;
      const codigoCaracter = evento.charCode || evento.keyCode;
      const caracter = String.fromCharCode(codigoCaracter);
      let tecla_especial = false;
      for (const i in teclas_especiales) {
        if (codigoCaracter === teclas_especiales[i]) {
          tecla_especial = true;
          break;
        }
      }
      return permitidos.indexOf(caracter) !== -1 || tecla_especial;
    }

    function validacion() {
      let errores = "";

      // Validamos campo1 (Nombre de la Empresa)
      const valor1 = document.getElementById("nombreEmpresa").value;
      if (valor1 == null || valor1.length === 0 || /^\s+$/.test(valor1)) {
        errores += "*Campo vacío... Debes colocar el nombre de la empresa\n";
      }

      // Validamos campo2 (Razón Social)
      const valor2 = document.getElementById("razonSocial").value;
      if (valor2 == null || valor2.length === 0 || /^\s+$/.test(valor2)) {
        errores += "*Campo vacío... Debes colocar la razón social\n";
      }

      // Validamos campo3 (Giro)
      const valor3 = document.getElementById("giro").value;
      if (valor3 == null || valor3.length === 0 || /^\s+$/.test(valor3)) {
        errores += "*Campo vacío... Debes colocar el giro de la empresa\n";
      }

      if (errores !== "") {
        alert(errores);
        return false;
      }
    }
  </script>
</head>
<body>
<h1>Portal de registro de empresas</h1>
<%
  if (request.getParameter("submit") == null) {
%>
<form onsubmit="return validacion()">
  <CENTER>
    <HR>
    <I>Insertar empresa.<a href="AutentificarAdmon.jsp">Cerrar Sesión</a></I>
    <table border="1" cellpadding="0" cellspacing="0" height="40%" width="25">
      <tr>
        <td>
          <input id="nombreEmpresa" name="nombreEmpresa" placeholder="Nombre de la Empresa"
                 title="Nombre Empresa" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
        </td>
      </tr>
      <tr>
        <td>
          <input id="razonSocial" name="razonSocial" placeholder="Razón Social"
                 title="Razón Social" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
        </td>
      </tr>
      <tr>
        <td>
          <input id="giro" name="giro" placeholder="Giro de la Empresa"
                 title="Giro" type="text" value="" size="25" onkeypress="return permite(event, 'car')"/>
        </td>
      </tr>
      <tr>
        <td>
          <input id="submit" name="submit" type="submit" value="Registrar">
          <input id="limpiar" name="limpiar" type="reset" value="Limpiar">
        </td>
      </tr>
    </table>
    <a href="EliminarEmpresa.jsp">Regresar</a>
  </CENTER>
</form>
<% } else { %>
<jsp:useBean id="empresa" scope="page" class="Mapeos.Empresa" />
<jsp:setProperty name="empresa" property="*" />
<%
  EmpresaDAO empRegistro = new EmpresaDAO();
  int idEmpresa = empRegistro.guardaEmpresa(empresa);
  if (idEmpresa > 0) {
%>
<table border="1">
  <thead>
  <tr>
    <th>ID Empresa</th>
    <th>Nombre</th>
    <th>Razón Social</th>
    <th>Giro</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td><%= empresa.getIdEmpresa() %></td>
    <td><%= empresa.getNombreEmpresa() %></td>
    <td><%= empresa.getRazonSocial() %></td>
    <td><%= empresa.getGiro() %></td>
  </tr>
  </tbody>
</table>
<h2>Empresa agregada exitosamente</h2>
<a href="EliminarEmpresa.jsp">Regresar</a>
<% } else { %>
<h2>Lo sentimos, no se pudo insertar el registro</h2>
<% }
}
%>
</body>
</html>