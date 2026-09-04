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
        if(alguien.getId()==null || alguien.getId().trim().isEmpty()){
            throw new Exception("El ID del Usuario es Necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(alguien.getId().trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID del Usuario debe ser un número entero válido");
        }

        //Armar SQL Insert de forma dinámica
        String sqlInsert = "INSERT INTO usuarios "
                + "(id, clave, nombre, rol) "
                + "VALUES(?,?,?,?)";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlInsert);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setInt(1, idNumerico);
            sentenciaSQL.setString(2, alguien.getClave());
            sentenciaSQL.setString(3, alguien.getNombre());
            sentenciaSQL.setString(4, alguien.getRol());

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
        if (alguien.getId() == null || alguien.getId().trim().isEmpty()) {
            throw new Exception("El ID del Usuario es Necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(alguien.getId().trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID del Usuario debe ser un número entero válido");
        }

        //Armar SQL Update de forma dinámica
        String sqlUpdate = "UPDATE usuarios "
                + "SET clave=?, nombre=?, rol=? "
                + "WHERE id=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlUpdate);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setString(1, alguien.getClave());
            sentenciaSQL.setString(2, alguien.getNombre());
            sentenciaSQL.setString(3, alguien.getRol());
            sentenciaSQL.setInt(4, idNumerico);

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
        if (alguien.getId() == null || alguien.getId().trim().isEmpty()) {
            throw new Exception("El ID del Usuario es Necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(alguien.getId().trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID del Usuario debe ser un número entero válido");
        }

        //Armar SQL Delete de forma dinámica
        String sqlDelete = "DELETE FROM usuarios "
                + "WHERE id=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlDelete);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setInt(1, idNumerico);

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
        if (id == null || id.trim().isEmpty() || password == null || password.isEmpty()) {
            throw new Exception("El ID y la Clave del Usuario son necesarios");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(id.trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID del Usuario debe ser un número entero válido");
        }

        //Armar SQL Select de forma dinámica
        String sqlSelect = "SELECT * FROM usuarios "
                + "WHERE id=? AND clave=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            baseDatos = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlSelect);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setInt(1, idNumerico);
            sentenciaSQL.setString(2, password);

            //Verificar el resultado de la consulta:
            ResultSet resultado = baseDatos.consultar(sentenciaSQL);
            if (resultado.next()) {
                alguien = new Usuario();
                alguien.setId(String.valueOf(resultado.getInt("id")));
                alguien.setClave(resultado.getString("clave"));
                alguien.setNombre(resultado.getString("nombre"));
                alguien.setRol(resultado.getString("rol"));
                return alguien;
            } else {
                throw new Exception("El ID o la Clave son incorrectos");
            }
        }
        catch (Exception e) {
            throw new Exception("Error al iniciar sesión: " + e.getMessage());
        }finally{
            if(baseDatos!=null){
                baseDatos.desconectar();
            }
        }
    }

    //Consultar usuario
    public Usuario consultarUsuario(String id) throws Exception {
        if (id == null || id.trim().isEmpty()) {
            throw new Exception("El ID del Usuario es Necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(id.trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID del Usuario debe ser un número entero válido");
        }

        Usuario alguien;
        ConexionBaseDatos baseDatos = null;
        //Armar SQL Select de forma dinámica
        String sqlSelect = "SELECT * FROM usuarios "
                + "WHERE id=?";

        try {
            //Crear una sentencia JDBC mediante la sentencia SQL anterior
            baseDatos = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlSelect);
            //Pasarle los datos del usuario a la sentencia SQL
            sentenciaSQL.setInt(1, idNumerico);

            //Verificar el resultado de la consulta:
            ResultSet resultado = baseDatos.consultar(sentenciaSQL);
            if (resultado.next()) {
                alguien = new Usuario();
                alguien.setId(String.valueOf(resultado.getInt("id")));
                alguien.setClave(resultado.getString("clave"));
                alguien.setNombre(resultado.getString("nombre"));
                alguien.setRol(resultado.getString("rol"));
                return alguien;
            } else {
                throw new Exception("Error al consultar Usuario " + id+ "<br/>Explicacion: Usuario no encontrado");
            }
        }
        catch (Exception e) {
            throw new Exception("Error al consultar: " + e.getMessage());
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

        //Armar el SQL SELECT de forma dinamica
        String sqlSelect = "SELECT * FROM usuarios ";
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
                alguien.setId(String.valueOf(resultado.getInt("id")));
                alguien.setClave(resultado.getString("clave"));
                alguien.setNombre(resultado.getString("nombre"));
                alguien.setRol(resultado.getString("rol"));
                listado[resultado.getRow()-1] = alguien;
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

    //Recuperar contraseña
    public void recuperarContrasena(String id, String email) throws Exception {
        if (id == null || id.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            throw new Exception("El ID y el correo electrónico son necesarios");
        }

        Usuario usuario = consultarUsuario(id).trim();
        if(usuario == null) {
            throw new Exception("No existe el usuario con el ID: " + id);
        }

        //Diseño del correo electrónico
        String asunto = "Recuperación de Contraseña - Sistema Universidad";                                                                                                                           
        String cuerpoHtml = "<h2>Recuperación de Credenciales</h2>"                                                                                                                                   
                + "<p>Hola <strong>" + usuario.getNombre() + "</strong>,</p>"                                                                                                                         
                + "<p>Hemos recibido una solicitud para recuperar tu contraseña de acceso.</p>"                                                                                                       
                + "<p>Tu contraseña actual es: <strong style='color:blue; font-size:16px;'>" + usuario.getClave() + "</strong></p>"                                                                   
                + "<p>Te sugerimos cambiarla una vez inicies sesión en el sistema.</p>"                                                                                                               
                + "<br><hr><small>Este correo fue generado automáticamente por el Sistema Universidad.</small>";     

        ServicioCorreo.enviarCorreo(email, asunto, cuerpoHtml);
    }
}
