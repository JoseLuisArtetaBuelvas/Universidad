package universidad.modelo;

import java.sql.*;

public class ConexionBaseDatos {

    //Variables
    protected String driver = "com.mysql.cj.jdbc.Driver";
    protected String nombreIPServidorBD = "localhost";
    protected String url = "jdb:mysql://";
    protected int puertoServidorBD = 3306;
    protected String usuarioBD = "root";
    protected String passwordUsuarioBD = "admin";
    protected String nombreBD = "7502523005_2_Universidad";
    private Connection conexion;
    private PreparedStatement sentencia;
    private ResultSet filasConsulta;

    //Setters y Getters
    public Connection getConnection(){
        return  null;
    };
    public void setConextion(Connection conexion){}

    public String getDriver(){
        return driver;
    }

    public void setDriver(String driver){
        this.driver = driver;
    }

    public ResultSet getFilasConsulta(){
        return null;
    }
    public void setFilasConsulta(ResultSet filasConsulta){}

    public String getNombreBD(){
        return nombreBD;
    }

    public void setNombreBD(String nombreBD){
        this.nombreBD = nombreBD;
    }

   public String getNombreIPServidorBD(){
        return nombreIPServidorBD;
   }

   public void setNombreIPServidorBD(String nombreIPServidorBD){
        this.nombreIPServidorBD = nombreIPServidorBD;
   }

   public String getPasswordUsuarioBD(){
        return passwordUsuarioBD;
   }

   public void setPasswordUsuarioBD(String passwordUsuarioBD){
        this.passwordUsuarioBD = passwordUsuarioBD;
   }

   public int getPuertoServidorBD(){
        return puertoServidorBD;
   }

    public void setPuertoServidorBD(int puertoServidorBD) {
        this.puertoServidorBD = puertoServidorBD;
    }

    public PreparedStatement getSentencia(){
        return null;
    }

    public void setSentencia(PreparedStatement sentencia){}

    public String getUrl(){
        return url;
    }
    public void setUrl(String url){
        this.url = url;
    }

    public String getUsuarioBD(){
        return usuarioBD;
    }
    public void setUsuarioBD(String usuarioBD){
        this.usuarioBD = usuarioBD;
    }
    //Constructores
    public ConexionBaseDatos() throws Exception{
        url = url+nombreIPServidorBD+":"+puertoServidorBD+"/"+nombreBD;
        this.conectar();
    }

    public ConexionBaseDatos(String driver, String servidor, String url, String usuarioBD, String passwordUsuarioBD, String nombreBD) throws Exception{
        this.driver = driver;
        this.nombreIPServidorBD = servidor;
        this.url = url;
        this.usuarioBD = usuarioBD;
        this.passwordUsuarioBD = passwordUsuarioBD;
        this.nombreBD = nombreBD;
        this.conectar();
    }

    //Operaciones sobre BD

    //Conectar
    public void conectar() throws Exception{
        //código extra acá
        try{
            Class.forName(driver); // Registro el driver de la SMBD
        }
        catch(ClassNotFoundException e){
            throw  new Exception("Error al conectar el driver"+e.getMessage());
        }

        try {
            conexion = DriverManager.getConnection(url, usuarioBD, passwordUsuarioBD);
        }
        catch(SQLException e){
            throw new Exception("Error de Conexion /n Codigo:"+ e.getMessage()+ "Explicacion:"+ e.getSQLState());
        }
    }


    //Actualizar
    public void actualizar(PreparedStatement setencia) throws Exception{
        try{
            int res = setencia.executeUpdate();
        }catch(SQLException e){
            throw new Exception("Error al ejecutar la sentencia BD Conexion /n Codigo:"+ e.getErrorCode()+ "Explicacion:"+ e.getMessage());
        }
    }

    //Consultar
    public ResultSet consultar(PreparedStatement sentencia)  throws Exception{
        try {
            ResultSet filasBD = sentencia.executeQuery(); //Solo para Select
            return filasBD;
        }
        catch(SQLException e){
            throw new SQLException("Error al ejecutar la sentencia BD Conexion"+e.getMessage());
        }
    }

    //Desconectar la base de datos
    public void desconectar() throws Exception{
        try {
            conexion.close();
        }
        catch (SQLException e){
            conexion = null;
        }
    }

    //Crear la sentencia SQL
    public PreparedStatement crearSentencia(String sql) throws Exception{
        try{
            PreparedStatement sentencia = conexion.prepareStatement(sql);
            return sentencia;
        }
        catch (SQLException e){
            throw new Exception("Error al crear la sentencia DB n/ Codigo:"+ e.getErrorCode()+"Explicacion:"+ e.getMessage());
        }
    }
}
