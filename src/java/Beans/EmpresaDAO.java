package Beans;

import Hibernate.HibernateUtil;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import Mapeos.Empleado;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import Mapeos.Empresa;

public class EmpresaDAO {

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

    public List<Empresa> obtenListaEmpresa() throws HibernateException {
        List<Empresa> listaEmpresa = null;
        try {
            iniciaOperacion();
            listaEmpresa = sesion.createQuery("FROM Empresa").list();  // Usar HQL en lugar de SQL
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return listaEmpresa;
    }


    public Empresa obtenEmpresaPorId(int idEmpresa) throws HibernateException {
        Empresa empresa = null;
        try {
            iniciaOperacion();
            empresa = (Empresa) sesion.get(Empresa.class, idEmpresa);  // Obtener la empresa por su id
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return empresa;
    }

    public void actualizaEmpresa(Empresa empresa) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(empresa);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
    }

    public void eliminaEmpresa(int idEmpresa) throws HibernateException {
        try {
            iniciaOperacion();
            Empresa empleado = (Empresa) sesion.get(Empresa.class, idEmpresa);
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

    public int guardaEmpresa(Empresa empresa) {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(empresa);
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
