/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Cliente;
import Mapeos.Empleado;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Search
 */
public class ClienteDAO {
    private Session sesion;
    private Transaction tx;

    public int guardarCliente(Mapeos.Cliente cliente) throws HibernateException {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(cliente);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.close();
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
            sesion.close();
        }
    }

    public Cliente obtenCliente(int ID_Cliente) throws HibernateException {
        Cliente cliente = null;
        try {
            iniciaOperacion();
            cliente = (Cliente) sesion.get(Cliente.class, ID_Cliente);
        } finally {
            sesion.close();
        }
        return cliente;
    }

    public List<Cliente> obtenListaCliente() throws HibernateException {
        List<Cliente> listaClientes = null;

        try {
            iniciaOperacion();
            listaClientes = sesion.createQuery("from Cliente").list();
        } finally {
            sesion.close();
        }
        return listaClientes;
    }

    public int actualizaCliente(Mapeos.Cliente carrito) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(carrito);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return 0;
    }

    /* forma de actualizar 2 */
//    public void updateEmpleado(Integer NoEmpleado, String NombreEmpleado) {
//        iniciaOperacion();
//        try {
//            Empleado empleado =
//                    (Empleado) sesion.get(Empleado.class, NoEmpleado);
//            Empleado.setFirstName(nombre);
//            sesion.update(empleado);
//            tx.commit();
//        } catch (HibernateException he) {
//            manejaExcepcion(he);
//        } finally {
//            sesion.close();
//        }
//    }

    private void iniciaOperacion(){
       try{
           
       
        sesion = HibernateUtil.getSessionFactory().openSession();
        tx = sesion.beginTransaction();
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        tx.rollback();
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }
}
