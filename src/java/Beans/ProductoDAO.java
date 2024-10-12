package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Producto;

import java.sql.SQLOutput;
import java.util.List;
import org.hibernate.HibernateException;
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
    public Producto obtenProducto(int NoProducto) throws HibernateException {
        Producto producto = null;
        try {
            iniciaOperacion();
            producto = (Producto) sesion.get(Producto.class, NoProducto);
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return producto;
    }

    // Obtiene la lista de todos los productos
    public List<Producto> obtenListaProducto() throws HibernateException {
        List<Producto> listaProductos = null;

        try {
            iniciaOperacion();
            listaProductos = sesion.createQuery("from Producto").list();
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return listaProductos;
    }

    // Actualiza un producto en la base de datos
    public int actualizaProducto(Producto producto) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(producto);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return 0;
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
