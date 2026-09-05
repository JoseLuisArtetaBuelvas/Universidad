package universidad.modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CRUDUniversidad {
    private Universidad universidad;
    private ConexionBaseDatos baseDatos;

    // Constructor por defecto
    public CRUDUniversidad() throws Exception {
        this.universidad = new Universidad();
        this.baseDatos = new ConexionBaseDatos();
    }

    // Getters y Setters
    public Universidad getUniversidad() {
        return universidad;
    }

    public void setUniversidad(Universidad universidad) {
        this.universidad = universidad;
    }

    public ConexionBaseDatos getBaseDatos() {
        return baseDatos;
    }

    public void setBaseDatos(ConexionBaseDatos baseDatos) {
        this.baseDatos = baseDatos;
    }

    // 1. Insertar universidad
    public void agregarUniversidad() throws Exception {
        if (universidad.getId() == null || universidad.getId().trim().isEmpty()) {
            throw new Exception("El ID de la Universidad es necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(universidad.getId().trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID de la Universidad debe ser un número entero válido");
        }

        String sqlInsert = "INSERT INTO universidades "
                + "(id, nombre, categoria, web, rector, email, acceso, telefono, ciudad, numeroCarreras, numSedes) "
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlInsert);
            sentenciaSQL.setInt(1, idNumerico);
            sentenciaSQL.setString(2, universidad.getNombre());
            sentenciaSQL.setString(3, universidad.getCategoria());
            sentenciaSQL.setString(4, universidad.getWeb());
            sentenciaSQL.setString(5, universidad.getRector());
            sentenciaSQL.setString(6, universidad.getEmail());
            sentenciaSQL.setString(7, universidad.getAcceso());
            sentenciaSQL.setString(8, universidad.getTelefono());
            sentenciaSQL.setString(9, universidad.getCiudad());
            sentenciaSQL.setInt(10, universidad.getNumeroCarreras());
            sentenciaSQL.setInt(11, universidad.getNumSedes());

            baseDatos.actualizar(sentenciaSQL);
        } catch (Exception e) {
            throw new Exception("Error al agregar la Universidad " + universidad.getId() + "<br/>Explicación: " + e.getMessage());
        } finally {
            baseDatos.desconectar();
        }
    }

    // 2. Modificar universidad
    public void modificarUniversidad() throws Exception {
        if (universidad.getId() == null || universidad.getId().trim().isEmpty()) {
            throw new Exception("El ID de la Universidad es necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(universidad.getId().trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID de la Universidad debe ser un número entero válido");
        }

        String sqlUpdate = "UPDATE universidades "
                + "SET nombre=?, categoria=?, web=?, rector=?, email=?, acceso=?, telefono=?, ciudad=?, numeroCarreras=?, numSedes=? "
                + "WHERE id=?";

        try {
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlUpdate);
            sentenciaSQL.setString(1, universidad.getNombre());
            sentenciaSQL.setString(2, universidad.getCategoria());
            sentenciaSQL.setString(3, universidad.getWeb());
            sentenciaSQL.setString(4, universidad.getRector());
            sentenciaSQL.setString(5, universidad.getEmail());
            sentenciaSQL.setString(6, universidad.getAcceso());
            sentenciaSQL.setString(7, universidad.getTelefono());
            sentenciaSQL.setString(8, universidad.getCiudad());
            sentenciaSQL.setInt(9, universidad.getNumeroCarreras());
            sentenciaSQL.setInt(10, universidad.getNumSedes());
            sentenciaSQL.setInt(11, idNumerico);

            baseDatos.actualizar(sentenciaSQL);
        } catch (Exception e) {
            throw new Exception("Error al actualizar la Universidad " + universidad.getId() + "<br/>Explicación: " + e.getMessage());
        } finally {
            baseDatos.desconectar();
        }
    }

    // 3. Eliminar universidad
    public void eliminarUniversidad() throws Exception {
        if (universidad.getId() == null || universidad.getId().trim().isEmpty()) {
            throw new Exception("El ID de la Universidad es necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(universidad.getId().trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID de la Universidad debe ser un número entero válido");
        }

        String sqlDelete = "DELETE FROM universidades WHERE id=?";

        try {
            PreparedStatement sentenciaSQL = baseDatos.crearSentencia(sqlDelete);
            sentenciaSQL.setInt(1, idNumerico);

            baseDatos.actualizar(sentenciaSQL);
        } catch (Exception e) {
            throw new Exception("Error al eliminar la Universidad " + universidad.getId() + "<br/>Explicación: " + e.getMessage());
        } finally {
            baseDatos.desconectar();
        }
    }

    // 4. Consultar universidad por ID
    public Universidad consultarUniversidad(String id) throws Exception {
        if (id == null || id.trim().isEmpty()) {
            throw new Exception("El ID de la Universidad es necesario");
        }
        int idNumerico;
        try {
            idNumerico = Integer.parseInt(id.trim());
        } catch (NumberFormatException e) {
            throw new Exception("El ID de la Universidad debe ser un número entero válido");
        }

        ConexionBaseDatos bd = null;
        String sqlSelect = "SELECT * FROM universidades WHERE id=?";

        try {
            bd = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = bd.crearSentencia(sqlSelect);
            sentenciaSQL.setInt(1, idNumerico);

            ResultSet resultado = bd.consultar(sentenciaSQL);
            if (resultado.next()) {
                return mapearUniversidad(resultado);
            } else {
                throw new Exception("Error al consultar Universidad " + id + "<br/>Explicación: Universidad no encontrada");
            }
        } catch (Exception e) {
            throw new Exception("Error al consultar: " + e.getMessage());
        } finally {
            if (bd != null) {
                bd.desconectar();
            }
        }
    }

    // 5. Listar todas las universidades
    public Universidad[] listarTodasLasUniversidades() throws Exception {
        ConexionBaseDatos bd = null;
        String sqlSelect = "SELECT * FROM universidades ORDER BY id";

        try {
            bd = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = bd.crearSentencia(sqlSelect);
            ResultSet resultado = bd.consultar(sentenciaSQL);

            resultado.last();
            Universidad[] listado = new Universidad[resultado.getRow()];
            resultado.beforeFirst();

            while (resultado.next()) {
                listado[resultado.getRow() - 1] = mapearUniversidad(resultado);
            }
            return listado;
        } catch (Exception e) {
            throw new Exception("Error al listar las universidades: " + e.getMessage());
        } finally {
            if (bd != null) {
                bd.desconectar();
            }
        }
    }

    // 6. Reporte 1: Listar por ciudad
    public Universidad[] listarPorCiudad(String ciudad) throws Exception {
        if (ciudad == null || ciudad.trim().isEmpty()) {
            throw new Exception("La ciudad es requerida para el reporte");
        }

        ConexionBaseDatos bd = null;
        String sqlSelect = "SELECT * FROM universidades WHERE LOWER(ciudad) = LOWER(?) ORDER BY id";

        try {
            bd = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = bd.crearSentencia(sqlSelect);
            sentenciaSQL.setString(1, ciudad.trim());
            ResultSet resultado = bd.consultar(sentenciaSQL);

            resultado.last();
            Universidad[] listado = new Universidad[resultado.getRow()];
            resultado.beforeFirst();

            while (resultado.next()) {
                listado[resultado.getRow() - 1] = mapearUniversidad(resultado);
            }
            return listado;
        } catch (Exception e) {
            throw new Exception("Error al generar reporte por ciudad: " + e.getMessage());
        } finally {
            if (bd != null) {
                bd.desconectar();
            }
        }
    }

    // 7. Reporte 2: Listar por categoría y mínimo de carreras
    public Universidad[] listarPorCategoriaYMinCarreras(String categoria, int minCarreras) throws Exception {
        ConexionBaseDatos bd = null;
        String sqlSelect = "SELECT * FROM universidades WHERE LOWER(categoria) = LOWER(?) AND numeroCarreras >= ? ORDER BY numeroCarreras DESC";

        try {
            bd = new ConexionBaseDatos();
            PreparedStatement sentenciaSQL = bd.crearSentencia(sqlSelect);
            sentenciaSQL.setString(1, categoria.trim());
            sentenciaSQL.setInt(2, minCarreras);
            ResultSet resultado = bd.consultar(sentenciaSQL);

            resultado.last();
            Universidad[] listado = new Universidad[resultado.getRow()];
            resultado.beforeFirst();

            while (resultado.next()) {
                listado[resultado.getRow() - 1] = mapearUniversidad(resultado);
            }
            return listado;
        } catch (Exception e) {
            throw new Exception("Error al generar reporte por categoría y carreras: " + e.getMessage());
        } finally {
            if (bd != null) {
                bd.desconectar();
            }
        }
    }

    // Método auxiliar para mapear ResultSet a Universidad
    private Universidad mapearUniversidad(ResultSet rs) throws Exception {
        Universidad uni = new Universidad();
        uni.setId(String.valueOf(rs.getInt("id")));
        uni.setNombre(rs.getString("nombre"));
        uni.setCategoria(rs.getString("categoria"));
        uni.setWeb(rs.getString("web"));
        uni.setRector(rs.getString("rector"));
        uni.setEmail(rs.getString("email"));
        uni.setAcceso(rs.getString("acceso"));
        uni.setTelefono(rs.getString("telefono"));
        uni.setCiudad(rs.getString("ciudad"));
        uni.setNumeroCarreras(rs.getInt("numeroCarreras"));
        uni.setNumSedes(rs.getInt("numSedes"));
        return uni;
    }
}
