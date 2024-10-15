package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Producto;

import java.sql.SQLOutput;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
/*
- Autor: Dante
- Fecha: 11/10
 */
public class ProductoDAO {

    private Session sesion;
    private Transaction tx;

    // Guarda un producto en la base de datos
    public int guardaProducto(Producto producto) throws HibernateException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        Integer productoID = null;

        System.out.print("HOLA");

        try {
            transaction = session.beginTransaction();
            System.out.print("HOLA 2");
            productoID = (Integer) session.save(producto);  // Guarda el producto en la base de datos
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            throw new HibernateException("Error al guardar el producto", e);
        } finally {
            session.close();
        }
        return productoID;
    }



    // Elimina un producto por su número
    public void eliminaProducto(int ProductoNo) {
        try {
            iniciaOperacion();
            Producto producto = (Producto) sesion.get(Producto.class, ProductoNo);
            sesion.delete(producto);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
    }

    // Obtiene un producto por su número
    public Producto obtenProducto(int idProducto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Producto producto = null;
        try {
            tx = session.beginTransaction(); // Solo comienza una transacción si no hay una activa
            producto = (Producto) session.get(Producto.class, idProducto);
            tx.commit(); // Commit de la transacción
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback(); // Revertir si hay un error
            }
            e.printStackTrace();
        } finally {
            session.close(); // Asegúrate de cerrar la sesión
        }
        return producto;
    }



    // Obtiene la lista de todos los productos
    public List<Producto> obtenListaProducto(String nombre) throws HibernateException {
        List<Producto> listaProductos = null;

        try {
            iniciaOperacion();

            // Usamos un query con un criterio de búsqueda
            if (nombre == null || nombre.isEmpty()) {
                // Si el nombre está vacío o es nulo, obtenemos todos los productos
                listaProductos = sesion.createQuery("from Producto").list();
            } else {
                // Si hay un nombre, buscamos por ese nombre
                listaProductos = sesion.createQuery("from Producto WHERE nombreProducto = :nombre")
                        .setParameter("nombre", nombre)
                        .list();
            }

            tx.commit();  // Confirmamos la transacción
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();  // Si hay un error, revertimos la transacción
            }
            throw e;  // Re-lanzamos la excepción para manejo posterior
        } finally {
            if (sesion != null) {
                sesion.close();  // Cerramos la sesión
            }
        }
        return listaProductos;
    }



    // Actualiza un producto en la base de datos
    public int actualizaProducto(Producto producto) throws HibernateException {
        int resultado = 0; // Variable para almacenar el resultado de la operación
        try {
            iniciaOperacion(); // Inicializa la sesión y la transacción
            sesion.update(producto); // Actualiza el producto en la base de datos
            tx.commit(); // Realiza el commit de la transacción
            resultado = 1; // La actualización fue exitosa
        } catch (HibernateException he) {
            manejaExcepcion(he); // Maneja la excepción
            throw he; // Vuelve a lanzar la excepción
        } finally {
            if (sesion != null) {
                sesion.close(); // Cierra la sesión si no es nula
            }
        }
        return resultado; // Retorna el resultado
    }

    // Inicia la sesión y la transacción de Hibernate
    private void iniciaOperacion() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        tx = sesion.beginTransaction(); // Inicia la transacción aquí
    }


    // Maneja las excepciones y realiza el rollback si es necesario
    private void manejaExcepcion(HibernateException he) throws HibernateException {
        if (tx != null && tx.isActive()) {
            tx.rollback(); // Solo revierte si la transacción está activa
        }
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }

}
