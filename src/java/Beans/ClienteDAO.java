package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Cliente;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class ClienteDAO {
    private Session sesion;
    private Transaction tx;

    public int guardarCliente(Cliente cliente) throws HibernateException {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(cliente);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            finalizaOperacion();
        }
        return id;
    }

    public void eliminaCliente(int ID_Cliente) {
        try {
            iniciaOperacion();
            Cliente cliente = (Cliente) sesion.get(Cliente.class, ID_Cliente);
            sesion.delete(cliente);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            finalizaOperacion();
        }
    }

    public Cliente obtenCliente(int ID_Cliente) throws HibernateException {
        Cliente cliente = null;
        try {
            iniciaOperacion();
            cliente = (Cliente) sesion.get(Cliente.class, ID_Cliente);
        } finally {
            finalizaOperacion();
        }
        return cliente;
    }

    public List<Cliente> obtenListaCliente() throws HibernateException {
        List<Cliente> listaClientes = null;
        try {
            iniciaOperacion();
            listaClientes = sesion.createQuery("from Cliente").list();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            finalizaOperacion();
        }
        return listaClientes;
    }

    public Cliente obtenClientePorId(int id) throws HibernateException {
        Cliente cliente = null;
        try {
            iniciaOperacion();
            cliente = (Cliente) sesion.get(Cliente.class, id); // Busca por ID usando el método get
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            finalizaOperacion();
        }
        return cliente;
    }


    public int actualizaCliente(Cliente cliente) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(cliente);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            finalizaOperacion();
        }
        return 0;
    }

    private void iniciaOperacion() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            tx = sesion.beginTransaction();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        }
    }

    private void finalizaOperacion() {
        if (sesion != null && sesion.isOpen()) {
            sesion.close();
        }
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        if (tx != null) {
            tx.rollback();
        }
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }
}

