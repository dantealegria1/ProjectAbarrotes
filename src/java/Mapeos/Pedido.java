package Mapeos;
// Generated 27/10/2014 08:16:01 AM by Hibernate Tools 4.3.1

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Pedido")
public class Pedido implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPedido")  // Clave primaria
    private Integer idPedido;

    @ManyToOne // Relación muchos a uno con Cliente
    @JoinColumn(name = "idCliente", nullable = false)
    private Cliente cliente;

    @Column(name = "fecha", nullable = false)  // Campo obligatorio
    private String fecha;

    @Column(name = "observaciones")
    private String observaciones;

    @Column(name = "edoPedido", length = 50) // Longitud máxima de 50
    private String edoPedido;

    @Column(name = "Identificador",nullable = false)
    private int identificador;
    // Constructor por defecto
    public Pedido() {
    }

    @Column(name="Costo",nullable = false)
    private double costo;

    public Pedido(Cliente cliente, String observaciones, int idCliente) {
        this.cliente = cliente;
        this.observaciones = observaciones;
    }

    public Pedido(Cliente cliente, String fecha, String observaciones, String edoPedido, int identificador, double costo) {
        this.cliente = cliente;
        this.fecha = fecha;
        this.observaciones = observaciones;
        this.edoPedido = edoPedido;
        this.identificador = identificador;
        this.costo = costo;
    }

    // Getters y Setters

    public Integer getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(Integer idPedido) {
        this.idPedido = idPedido;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getEdoPedido() {
        return edoPedido;
    }

    public void setEdoPedido(String edoPedido) {
        this.edoPedido = edoPedido;
    }

    public int getIdentificador() {
        return identificador;
    }

    public void setIdentificador(int identificador) {
        this.identificador = identificador;
    }

    public double getCosto() {return costo;}

    public void setCosto(double costo) {this.costo = costo;}
}