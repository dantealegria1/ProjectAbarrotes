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

    public List<Empresa> obtenListaEmpresa(Integer idEmpresa) throws HibernateException {
        List<Empresa> listaEmpresas = null;
        try {
            iniciaOperacion();

            if (idEmpresa == null) {
                // Si no se pasa id, devolver todas las empresas
                listaEmpresas = sesion.createQuery("FROM Empresa").list();  // Usar HQL para obtener todas las empresas
            } else {
                // Si se pasa un id, buscar solo esa empresa
                Empresa empresa = (Empresa) sesion.get(Empresa.class, idEmpresa);  // Obtener la empresa por id
                if (empresa != null) {
                    listaEmpresas = new List<Empresa>() {
                        @Override
                        public int size() {
                            return 0;
                        }

                        @Override
                        public boolean isEmpty() {
                            return false;
                        }

                        @Override
                        public boolean contains(Object o) {
                            return false;
                        }

                        @Override
                        public Iterator<Empresa> iterator() {
                            return null;
                        }

                        @Override
                        public Object[] toArray() {
                            return new Object[0];
                        }

                        @Override
                        public <T> T[] toArray(T[] a) {
                            return null;
                        }

                        @Override
                        public boolean add(Empresa empresa) {
                            return false;
                        }

                        @Override
                        public boolean remove(Object o) {
                            return false;
                        }

                        @Override
                        public boolean containsAll(Collection<?> c) {
                            return false;
                        }

                        @Override
                        public boolean addAll(Collection<? extends Empresa> c) {
                            return false;
                        }

                        @Override
                        public boolean addAll(int index, Collection<? extends Empresa> c) {
                            return false;
                        }

                        @Override
                        public boolean removeAll(Collection<?> c) {
                            return false;
                        }

                        @Override
                        public boolean retainAll(Collection<?> c) {
                            return false;
                        }

                        @Override
                        public void clear() {

                        }

                        @Override
                        public Empresa get(int index) {
                            return null;
                        }

                        @Override
                        public Empresa set(int index, Empresa element) {
                            return null;
                        }

                        @Override
                        public void add(int index, Empresa element) {

                        }

                        @Override
                        public Empresa remove(int index) {
                            return null;
                        }

                        @Override
                        public int indexOf(Object o) {
                            return 0;
                        }

                        @Override
                        public int lastIndexOf(Object o) {
                            return 0;
                        }

                        @Override
                        public ListIterator<Empresa> listIterator() {
                            return null;
                        }

                        @Override
                        public ListIterator<Empresa> listIterator(int index) {
                            return null;
                        }

                        @Override
                        public List<Empresa> subList(int fromIndex, int toIndex) {
                            return List.of();
                        }
                    };
                    listaEmpresas.add(empresa);  // Añadir la empresa a la lista
                }
            }

        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null && sesion.isOpen()) {
                sesion.close();
            }
        }
        return listaEmpresas;
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

}
