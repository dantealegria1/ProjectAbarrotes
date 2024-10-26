package Mapeos;

import javax.persistence.*;

@Entity
@Table(name = "Paquete")
public class Paquete implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPaquete")  // Clave primaria
    private Integer idPaquete;

    @ManyToOne  // Relación con Cliente
    @JoinColumn(name = "idCliente", nullable = false)  // Columna que representa la relación
    private Cliente cliente;

    @Column(name = "cantidad", nullable = false)  // Cantidad de productos
    private Integer cantidad;

    @Column(name = "idProducto", nullable = false)  // ID del producto
    private int idProducto;

    @Column(name = "Identificador", nullable = false)
    private int identificador;
    // Constructor por defecto
    public Paquete() {
    }

    // Constructor con parámetros
    public Paquete(Cliente cliente, Integer cantidad, int idProducto, int identificador) {
        this.cliente = cliente;
        this.cantidad = cantidad;
        this.idProducto = idProducto;
        this.identificador = identificador;
    }

    // Getters y Setters
    public Integer getIdPaquete() {
        return idPaquete;
    }

    public void setIdPaquete(Integer idPaquete) {
        this.idPaquete = idPaquete;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdentificador() {
        return identificador;
    }
    public void setIdentificador(int identificador) {
        this.identificador = identificador;
    }
}
