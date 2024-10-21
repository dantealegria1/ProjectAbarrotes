package Mapeos;
// Generated 27/10/2014 08:16:01 AM by Hibernate Tools 4.3.1


import javax.persistence.*;

/**
 * Empresa generated by hbm2java
 */
@Entity
@Table(name = "Empresa")
public class Empresa  implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="idEmpresa")
     private Integer idEmpresa;
    @Column(name="nombre")
     private String nombreEmpresa;
     private String razonSocial;
     private String giro;

    public Empresa() {
    }

    public Empresa(String nombreEmpresa, String razonSocial, String giro) {
       this.nombreEmpresa = nombreEmpresa;
       this.razonSocial = razonSocial;
       this.giro = giro;
    }
   
    public Integer getIdEmpresa() {
        return this.idEmpresa;
    }
    
    public void setIdEmpresa(Integer idEmpresa) {
        this.idEmpresa = idEmpresa;
    }
    public String getNombreEmpresa() {
        return this.nombreEmpresa;
    }
    
    public void setNombreEmpresa(String nombreEmpresa) {
        this.nombreEmpresa = nombreEmpresa;
    }
    public String getRazonSocial() {
        return this.razonSocial;
    }
    
    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }
    public String getGiro() {
        return this.giro;
    }
    
    public void setGiro(String giro) {
        this.giro = giro;
    }




}


