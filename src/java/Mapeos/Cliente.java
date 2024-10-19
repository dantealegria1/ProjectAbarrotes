package Mapeos;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Cliente")
public class Cliente implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCliente")  // Clave primaria
    private Integer idCliente;

    @Column(name = "nombre", nullable = false)  // Campo obligatorio
    private String nombre;

    @Column(name = "apellPat", nullable = false)  // Campo obligatorio
    private String apellPat;

    @Column(name = "apellMat", nullable = false)  // Campo obligatorio
    private String apellMat;

    @Column(name = "fechaNac", nullable = false)  // Campo obligatorio
    private String fechaNac;

    @Column(name = "rfc", nullable = false, unique = true)  // Campo obligatorio y único
    private String rfc;

    @Column(name = "correo", nullable = false, unique = true)  // Campo obligatorio y único
    private String correo;

    @Column(name = "password", nullable = false)  // Campo obligatorio
    private String password;

    @Column(name = "direccion", nullable = false)
    private String direccion;

    @Column(name = "telefono", nullable = false)
    private Integer telefono;

    @Column(name = "carrito", nullable = false)
    private Integer carrito;


//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "idPaquete", referencedColumnName = "idPaquete")
//    private Paquete paquete;
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "idPedido", referencedColumnName = "idPedido")
//    private Pedido pedido;

    // Constructor por defecto
    public Cliente() {}

    // Constructor con parámetros
    public Cliente(String nombre, String apellPat, String apellMat, String fechaNac, String rfc, String correo, String password, String direccion,Integer telefono,
                    Integer carrito ,Paquete paquete, Pedido pedido) {
        this.nombre = nombre;
        this.apellPat = apellPat;
        this.apellMat = apellMat;
        this.fechaNac = fechaNac;
        this.rfc = rfc;
        this.correo = correo;
        this.password = password;
        this.direccion = direccion;
        this.telefono = telefono;
        this.carrito = carrito;
//        this.paquete = paquete;
//        this.pedido = pedido;
    }

    // Getters y Setters

    public Integer getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellPat() {
        return apellPat;
    }

    public void setApellPat(String apellPat) {
        this.apellPat = apellPat;
    }

    public String getApellMat() {
        return apellMat;
    }

    public void setApellMat(String apellMat) {
        this.apellMat = apellMat;
    }

    public String getFechaNac() {
        return fechaNac;
    }

    public void setFechaNac(String fechaNac) {
        this.fechaNac = fechaNac;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDireccion() {
        return direccion;
    }

    public Integer getTelefono() {
        return telefono;
    }

    public Integer getCarrito() {
        return 1;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setTelefono(String telefono) {
        if (telefono != null && !telefono.isEmpty()) {
            try {
                this.telefono = Integer.valueOf(telefono);
            } catch (NumberFormatException e) {
                // Maneja el caso en que la cadena no es un número válido
                this.telefono = 0; // O cualquier otro valor predeterminado
            }
        } else {
            this.telefono = 0; // O un valor por defecto si es null o está vacío
        }
    }

    public void setCarrito(Integer carrito) {
        this.carrito = carrito;
    }

//    public Paquete getPaquete() {
//        return paquete;
//    }
//
//    public void setPaquete(Paquete paquete) {
//        this.paquete = paquete;
//    }
//
//    public Pedido getPedido() {
//        return pedido;
//    }
//
//    public void setPedido(Pedido pedido) {
//        this.pedido = pedido;
//    }
}
