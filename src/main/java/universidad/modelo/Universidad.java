package universidad.modelo;

public class Universidad {

    private String id;
    private String nombre;
    private String categoria;
    private String web;
    private String rector;
    private String email;
    private String acceso;
    private String telefono;
    private String ciudad;
    private int numeroCarreras;
    private int numSedes;

    // Constructor por defecto
    public Universidad() {
    }

    // Constructor con parámetros
    public Universidad(String id, String nombre, String categoria, String web, String rector, 
                       String email, String acceso, String telefono, String ciudad, 
                       int numeroCarreras, int numSedes) {
        this.id = id;
        this.nombre = nombre;
        this.categoria = categoria;
        this.web = web;
        this.rector = rector;
        this.email = email;
        this.acceso = acceso;
        this.telefono = telefono;
        this.ciudad = ciudad;
        this.numeroCarreras = numeroCarreras;
        this.numSedes = numSedes;
    }

    // Getters
    public String getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public String getWeb() {
        return web;
    }

    public String getRector() {
        return rector;
    }

    public String getEmail() {
        return email;
    }

    public String getAcceso() {
        return acceso;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getCiudad() {
        return ciudad;
    }

    public int getNumeroCarreras() {
        return numeroCarreras;
    }

    public int getNumSedes() {
        return numSedes;
    }

    // Setters
    public void setId(String id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public void setWeb(String web) {
        this.web = web;
    }

    public void setRector(String rector) {
        this.rector = rector;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAcceso(String acceso) {
        this.acceso = acceso;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public void setNumeroCarreras(int numeroCarreras) {
        this.numeroCarreras = numeroCarreras;
    }

    public void setNumSedes(int numSedes) {
        this.numSedes = numSedes;
    }
}
