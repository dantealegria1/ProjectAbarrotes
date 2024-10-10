<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            #resultados {
                position:absolute;
                background:#ff0;
            }
        </style>
        <script type="text/javascript" src="XHR.js"></script>
        <script type="text/javascript">
            //Defino Variables Globales
            var peticion;
            peticion = obtenerXHR();
            function completapalabra(elemento){

                peticion.open("POST", "servletAjax", true);
                peticion.onreadystatechange = procesarPeticion;

                //Definimos cabecera obligatoria para enviar POST
                peticion.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                //Enviamos los parametros
                var parametros = "nombre="+elemento.value;
                peticion.send(parametros);
            }
            function procesarPeticion(){
                var div = document.getElementById("resultados");
                if(peticion.readyState==1){
                    //document.getElementById("mensaje").innerHTML="<img src=\"loading.gif\" align=\"center\" /> Aguarde por favor...";
                    div.innerHTML="<img src=\"loading.gif\" align=\"center\" /> Aguarde por favor...";
                }
                if(peticion.readyState==4){
                    //La peticion termino
                    if(peticion.status==200){
                        //Mostramos el texto dentro del DIV
                        div.innerHTML = peticion.responseText;
                    }
                }
            }

        </script>      
        <title>JSP Page</title>
    </head>
    <body>
        <h1></h1>
        <form action="#">
            Ingrese el nombre del producto que desea buscar:<br>
            <input type="text" id="palabra" onkeyup="completapalabra(this);">
            <br/>
            <div id="resultados"></div>
            <input type="submit" value="buscar">
        </form>
    </body>
</html>