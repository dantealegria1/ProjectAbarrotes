package Beans;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import Hibernate.HibernateUtil;
import Mapeos.Estado;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class EstadoDAO {
    private Session sesion;
    private Transaction tx;

    private void iniciaOperacion() throws HibernateException {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            tx = sesion.beginTransaction();
        } catch (HibernateException e) {
            System.out.println("Error al iniciar la sesión: " + e.getMessage());
            throw e;
        }
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        if (tx != null) {
            tx.rollback();  // Rollback de la transacción en caso de error
        }
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }

    public List<Estado> obtenListaEstado() throws HibernateException {
        List<Estado> listaEstado = null;
        try {
            iniciaOperacion();
            listaEstado = sesion.createQuery("FROM Estado").list();  // Usar HQL en lugar de SQL
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return listaEstado;
    }

    public Estado obtenEstadoPorId(int idEstado) throws HibernateException {
        Estado estado = null;
        try {
            iniciaOperacion();
            estado = (Estado) sesion.get(Estado.class, idEstado);  // Obtener el estado por su id
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return estado;
    }

    public void actualizaEstado(Estado estado) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(estado);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
    }

    public void eliminaEstado(int idEstado) throws HibernateException {
        try {
            iniciaOperacion();
            Estado estado = (Estado) sesion.get(Estado.class, idEstado);
            if (estado != null) {
                sesion.delete(estado);
                tx.commit();
            }
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
    }

    public int guardaEstado(Estado estado) {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(estado);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return id;
    }
}
