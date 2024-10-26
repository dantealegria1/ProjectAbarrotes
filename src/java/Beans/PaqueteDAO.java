package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Paquete;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class PaqueteDAO {
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

    public int guardaPaquete(Paquete paquete) throws HibernateException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        Integer paqueteID = null;
        try {
            transaction = session.beginTransaction();
            paqueteID = (Integer) session.save(paquete);  // Guarda el producto en la base de datos
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            throw new HibernateException("Error al guardar el producto", e);
        } finally {
            session.close();
        }
        return paqueteID;
    }

    public Paquete obtenPaquete(int idPaquete) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Paquete paquete = null;
        try {
            tx = session.beginTransaction(); // Solo comienza una transacción si no hay una activa
            paquete = (Paquete) session.get(Paquete.class, idPaquete);
            tx.commit(); // Commit de la transacción
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback(); // Revertir si hay un error
            }
            e.printStackTrace();
        } finally {
            session.close(); // Asegúrate de cerrar la sesión
        }
        return paquete;
    }


    // Obtiene la lista de todos los productos
    public List<Paquete> obtenlistaPaquetes(String nombre) throws HibernateException {
        List<Paquete> listaPaquetes = null;

        try {
            iniciaOperacion();

            // Usamos un query con un criterio de búsqueda
            if (nombre == null || nombre.isEmpty()) {
                // Si el nombre está vacío o es nulo, obtenemos todos los productos
                listaPaquetes = sesion.createQuery("from Paquete").list();
            } else {
                // Si hay un nombre, buscamos por ese nombre
                listaPaquetes = sesion.createQuery("from Producto WHERE nombreProducto = :nombre")
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
        return listaPaquetes;
    }

    public List<Paquete> obtenerPaquetesPorIdentificador(int identificador) throws HibernateException {
        List<Paquete> listaPaquetes = null;
        try {
            iniciaOperacion();
            listaPaquetes = sesion.createQuery("from Paquete WHERE Identificador = :identificador")
                    .setParameter("identificador", identificador)
                    .list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return listaPaquetes;
    }
}
