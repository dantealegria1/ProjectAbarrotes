
package Beans;

import java.io.Serializable;

/**
 *
 * @author Search
 */
public class UsuarioDAO implements Serializable {

    private int id_cliente;
    private String Nombre;
    private String Apell_pat;
    private String Apell_mat;
    private String Fecha_nac;
    private String RFC;
    private String Correo;
    private String Password;
    private int id_nivel_estudio;
    private int id_estado_civil;

    public UsuarioDAO() {
    }

    public UsuarioDAO(int id_cliente, String Nombre, String Apell_pat, String Apell_mat, String Fecha_nac, String RFC, String Correo, String Password, int id_nivel_estudio, int id_estado_civil) {
        this.id_cliente = id_cliente;
        this.Nombre = Nombre;
        this.Apell_pat = Apell_pat;
        this.Apell_mat = Apell_mat;
        this.Fecha_nac = Fecha_nac;
        this.RFC = Correo;
        this.Password = Password;
    }

    public int getId() {
        return id_cliente;
    }
    public void setId(int id_cliente) {
        this.id_cliente = id_cliente;
    }
    
    public String getNombre() {
        return Nombre;
    }
    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getApell_pat() {
        return Apell_pat;
    }
    public void setApell_pat(String Apell_pat) {
        this.Apell_pat = Apell_pat;
    }
    
    public String getApell_mat() {
        return Apell_mat;
    }
    public void setApell_mat(String Apell_mat) {
        this.Apell_mat = Apell_mat;
    }

    public String getFecha_nac() {
        return Fecha_nac;
    }
    public void setFecha_nac(String Fecha_nac) {
        this.Fecha_nac = Fecha_nac;
    }
    
    public String getRFC() {
        return RFC;
    }
    public void setRFC(String RFC) {
        this.RFC = RFC;
    }
    
    public String getCorreo() {
        return Correo;
    }
    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }
    
    public String getPassword() {
        return Password;
    }
    public void setPassword(String Password) {
        this.Password = Password;
    }
    
    public int getid_nivel_estudio() {
        return id_nivel_estudio;
    }
    public void setid_nivel_estudio(int id_nivel_estudio) {
        this.id_nivel_estudio = id_nivel_estudio;
    }
    
    public int getid_estado_civil() {
        return id_estado_civil;
    }
    public void setid_estado_civil(int id_estado_civil) {
        this.id_estado_civil = id_estado_civil;
    }
}
