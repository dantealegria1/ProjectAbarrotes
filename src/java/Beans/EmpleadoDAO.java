package Beans;

import Hibernate.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import Mapeos.Empleado;

public class EmpleadoDAO {

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

    public int guardaEmpleado(Empleado empleado) throws HibernateException {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(empleado);
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

    public void eliminaEmpleado(int EmpleadoNo) throws HibernateException {
        try {
            iniciaOperacion();
            Empleado empleado = (Empleado) sesion.get(Empleado.class, EmpleadoNo);
            if (empleado != null) {
                sesion.delete(empleado);
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

    public Empleado obtenEmpleado(int NoEmpleado) throws HibernateException {
        Empleado empleado = null;
        try {
            iniciaOperacion();
            empleado = (Empleado) sesion.get(Empleado.class, NoEmpleado);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return empleado;
    }

    public List<Empleado> obtenListaEmpleado() throws HibernateException {
        List<Empleado> listaEmpleados = null;
        try {
            iniciaOperacion();
            listaEmpleados = sesion.createQuery("FROM Empleado").list();  // Usar HQL en lugar de SQL
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return listaEmpleados;
    }

    public void actualizaEmpleado(Empleado empleado) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(empleado);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
    }

    public Empleado obtenEmpleadoPorId(int empleadoId) {
        Empleado empleado = null;
        try {
            iniciaOperacion();
            // Usar HQL para buscar un empleado por su ID
            empleado = (Empleado) sesion.createQuery("FROM Empleado WHERE noEmpleado = :empleadoId")
                    .setParameter("empleadoId", empleadoId)
                    .uniqueResult();  // Devuelve un único resultado o null si no se encuentra
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return empleado;  // Devuelve el empleado encontrado o null
    }
}
