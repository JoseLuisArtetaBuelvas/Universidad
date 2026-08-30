package universidad.modelo;

public class Usuario {

    private String id;
    private String clave;
    private String nombre;
    private String rol;


    //Getters
    public String  getId() {
        return id;
    }

    public String getClave() {
        return clave;
    }

    public String getNombre() {
        return nombre;
    }

    public String getRol() {
        return rol;
    }

    //Setters

    public void setId(String id) {
        this.id = id;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}
