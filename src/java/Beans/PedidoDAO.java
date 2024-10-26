package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Pedido;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class PedidoDAO {
    private Session sesion;
    private Transaction tx;

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

    public int guardarPedido(Pedido pedido) throws HibernateException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        Integer paqueteID = null;
        try {
            transaction = session.beginTransaction();
            paqueteID = (Integer) session.save(pedido);  // Guarda el producto en la base de datos
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            throw new HibernateException("Error al guardar el producto", e);
        } finally {
            session.close();
        }
        return paqueteID;
    }

    public Pedido obtenPedido(int idPedido) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Pedido pedido = null;
        try {
            tx = session.beginTransaction(); // Solo comienza una transacción si no hay una activa
            pedido = (Pedido) session.get(Pedido.class, idPedido);
            tx.commit(); // Commit de la transacción
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback(); // Revertir si hay un error
            }
            e.printStackTrace();
        } finally {
            session.close(); // Asegúrate de cerrar la sesión
        }
        return pedido;
    }

    // Obtiene la lista de todos los productos
    public List<Pedido> obtenlistaPedidos(int idCliente) throws HibernateException {
        List<Pedido> listaPedidos = null;

        try {
            iniciaOperacion();

            // Usamos un query con un criterio de búsqueda
            if (idCliente == 0) {
                // Si el nombre está vacío o es nulo, obtenemos todos los productos
                listaPedidos = sesion.createQuery("from Pedido").list();
            } else {
                // Si hay un nombre, buscamos por ese nombre
                listaPedidos = sesion.createQuery("from Pedido WHERE idCliente = :idCliente")
                        .setParameter("idCliente", idCliente)
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
        return listaPedidos;
    }


}
