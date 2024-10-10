package Beans;

import java.beans.Beans;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

/**
 *
 * @author Sergio
 */
import java.lang.reflect.*;

public class Reflection {

    public static void main(String arg[]) {
        Class clase;
        Field campo, campos[];
        Method metodo, metodos[];
        try {
            // Cargamos la clase
            clase = Class.forName("Mapeos.Paquete");
            // Recorremos los campos
            System.out.println("Lista de campos:\n");
            campos = clase.getFields();
            for (int i = 0; i < campos.length; i++) {
                campo = campos[i];
                System.out.println("\t" + campo.getName());
            }
            // Recorremos los metodos
            System.out.println("\nLista de metodos:\n");
            metodos = clase.getMethods();
            for (int i = 0; i < metodos.length; i++) {
                metodo = metodos[i];
                System.out.println("\t" + metodo.getName());
            }
        } catch (ClassNotFoundException e) {
            System.out.println("No se ha encontrado la clase. " + e);
        }
    }
}

/*public class Reflection {
 public static void main(String arg[]){
 Class clase; 
 Field campo, campos[];
 Method metodo, metodos[];
 try{
 clase = Class.forName("ClienteDAO");
 campos  = clase.getFields();
 for(int i = 0; i<campos.length; i++){
 campo = campos[i];
 System.out.println(campo.getName());
 }
 metodos  = clase.getMethods();
 for(int i = 0; i<metodos.length; i++){
 metodo = metodos[i];
 System.out.println(metodo.getName());
 }
 }catch (ClassNotFoundException e){
 System.out.println("No se encontro clase" + e);
 e.printStackTrace();
 }
 
        
 }
 }
 */
