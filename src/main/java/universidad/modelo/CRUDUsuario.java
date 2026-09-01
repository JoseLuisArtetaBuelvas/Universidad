package universidad.modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CRUDUsuario {
    private Usuario alguien;
    private ConexionBaseDatos baseDatos;


    //Constructor por defecto
    public CRUDUsuario() throws Exception{
        this.alguien = new Usuario();
        this.baseDatos = new ConexionBaseDatos();
    }

    //Getters y Setters
    public Usuario getAlguien() {
        return alguien;
    }
    public void setAlguien(Usuario alguien) {
        this.alguien = alguien;
    }

    public ConexionBaseDatos getBaseDatos() {
        return baseDatos;
    }

    public void setBaseDatos(ConexionBaseDatos baseDatos) {
        this.baseDatos = baseDatos;
    }


    //Insertar usuarios
    public void agregarUsuario() throws Exception{
        if(alguien.getId()==null || alguien.getId().isEmpty()){
            throw new Exception("El ID del Usuario es Necesario");
        }

        //Armaar SQL Update de forma dinámica
        String sqlInsert = "INSERT INTO Usuarios "
                + "(id=?, password=?, nombre=?, rol=? )"
                + "VALUES(?,?,?,?)";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlInsert);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setString(1, alguien.getId());
            sentenciaSQL.setString(2, alguien.getClave());
            sentenciaSQL.setString(2, alguien.getNombre());
            sentenciaSQL.setString(3, alguien.getRol());

            //Actualizar la BD usando la sentenciaSQL con los datos del usuario

            baseDatos.actualizar(sentenciaSQL);
        }
        catch (Exception e) {
            throw new Exception("Error al Agregar el Usuario " + alguien.getId() + "<br/>Explicacion: "+ e.getMessage());
        }finally{
            baseDatos.desconectar();
        }
    }

    //Modificar usuarios
    public void modificarUsuario() throws Exception {
        if (alguien.getId() == null || alguien.getId().isEmpty()) {
            throw new Exception("El ID del Usuario es Necesario");
        }

        //Armaar SQL Update de forma dinámica
        String sqlUpdate = "UPDATE Usuarios "
                + "SET password=?, nombre=?, rol=? "
                + "WHERE id=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlUpdate);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setString(2, alguien.getClave());
            sentenciaSQL.setString(2, alguien.getNombre());
            sentenciaSQL.setString(3, alguien.getRol());

            //Actualizar la BD usando la sentenciaSQL con los datos del usuario

            baseDatos.actualizar(sentenciaSQL);
        } catch (Exception e) {
            throw new Exception("Error al Actualizar el Usuario " + alguien.getId() + "<br/>Explicacion: " + e.getMessage());
        } finally {
            baseDatos.desconectar();
        }
    }

    //Elimninar usuarios
    public void eliminarUsuario() throws Exception {
        if (alguien.getId() == null || alguien.getId().isEmpty()) {
            throw new Exception("El ID del Usuario es Necesario");
        }

        //Armaar SQL Update de forma dinámica
        String sqlInsert = "DELETE FROM Usuarios "
                + "WHERE id=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlInsert);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setString(1, alguien.getId());

            //Actualizar la BD usando la sentenciaSQL con los datos del usuario

            baseDatos.actualizar(sentenciaSQL);
        } catch (Exception e) {
            throw new Exception("Error al Eliminar el Usuario " + alguien.getId() + "<br/>Explicacion: " + e.getMessage());
        } finally {
            baseDatos.desconectar();
        }
    }

    //Iniciar sesion
    public Usuario iniciarSesion(String id, String password) throws Exception {
        if (id == null || id.isEmpty() || password == null || password.isEmpty()) {
            throw new Exception("El ID y el Password del Usuario es Necesarios");
        }

        //Armaar SQL Update de forma dinámica
        String sqlSelect = "SELECT * FROM Usuarios "
                + "WHERE id=? AND password=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            baseDatos = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlSelect);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setString(1, id);
            sentenciaSQL.setString(2, password);

            //Verificar el resultado de la consulta:
            ResultSet resultado = baseDatos.consultar(sentenciaSQL);
            if (resultado.next()) {
                alguien = new Usuario();
                alguien.setId(resultado.getString("id"));
                alguien.setClave(resultado.getString("clave"));
                alguien.setNombre(resultado.getString("nombre"));
                alguien.setRol(resultado.getString("rol"));
                return alguien;
            } else {
                throw new Exception("Error al consultar Usuario " + id+ "<br/>Explicacion:");
            }
        }
        catch (Exception e) {
            throw new Exception(e.getMessage()+"Error en el ID o el Password estan Errados");
        }finally{
            if(baseDatos!=null){
                baseDatos.desconectar();
            }
        }
    }

    //Consultar usuario
    public Usuario consultarUsuario(String id) throws Exception {
        if (id == null || id.isEmpty()) {
            throw new Exception("El ID del Usuario es Necesario");
        }
        Usuario alguien;
        ConexionBaseDatos baseDatos = null;
        //Armaar SQL Update de forma dinámica
        String sqlSelect = "SELECT * FROM Usuarios "
                + "WHERE id=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            baseDatos = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlSelect);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setString(1, id);

            //Verificar el resultado de la consulta:
            ResultSet resultado = baseDatos.consultar(sentenciaSQL);
            if (resultado.next()) {
                alguien = new Usuario();
                alguien.setId(resultado.getString("id"));
                alguien.setClave(resultado.getString("clave"));
                alguien.setNombre(resultado.getString("nombre"));
                alguien.setRol(resultado.getString("rol"));
                return alguien;
            } else {
                throw new Exception("Error al consultar Usuario " + id+ "<br/>Explicacion:");
            }
        }
        catch (Exception e) {
            throw new Exception(e.getMessage()+"Error en el ID o el Password estan Errados");
        }finally{
            if(baseDatos!=null){
                baseDatos.desconectar();
            }
        }
    }

    //Listar todos los usuarios
    public Usuario[] listarTodosLosusuarios() throws Exception {
        Usuario alguien;
        ConexionBaseDatos baseDatos = null;

        //Armar el SQL SELECT d e forma dinamica
        String sqlSelect = "SELECT * FROM Usuarios ";
        try {
            //Crea una sentencia JDBX mediante la sentencia SQL anterior
            baseDatos = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlSelect);
            //Verificar el Resultado de la consulta
            ResultSet resultado = baseDatos.consultar(sentenciaSQL);
            resultado.last(); // Colocamos el ultimo registro del resultado
            Usuario[] listado = new  Usuario[resultado.getRow()];//La posicion del ultimo
            resultado.beforeFirst();//Nos colocamos antes del primer registro
            while (resultado.next()) {
                alguien = new Usuario();
                alguien.setId(resultado.getString("id"));
                alguien.setClave(resultado.getString("clave"));
                alguien.setNombre(resultado.getString("nombre"));
                alguien.setRol(resultado.getString("rol"));
                listado[resultado.getRow()] = alguien;
            }if(listado.length <= 0){
                throw new Exception("Error al listar los usuarios");
            }
            return listado;
        }catch(Exception e){
            throw new Exception(e.getMessage()+"La BD esta vacia");
        }finally{
            if(baseDatos!=null){
                baseDatos.desconectar();
            }
        }
    }
}
