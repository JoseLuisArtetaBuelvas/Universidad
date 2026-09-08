package universidad.config;

import org.junit.jupiter.api.Test;
import universidad.modelo.ConexionBaseDatos;

import static org.junit.jupiter.api.Assertions.*;

public class EnvConfigTest {

    @Test
    public void testLecturaVariables() {
        String dbDriver = EnvConfig.get("DB_DRIVER", "fallback");
        assertEquals("org.postgresql.Driver", dbDriver);

        int dbPort = EnvConfig.getInt("DB_PORT", 0);
        assertEquals(5432, dbPort);

        String host = EnvConfig.get("DB_HOST", "localhost");
        assertEquals("localhost", host);
    }

    @Test
    public void testConexionBaseDatos() throws Exception {
        ConexionBaseDatos conexion = new ConexionBaseDatos();
        assertNotNull(conexion.getConnection(), "La conexión debe ser exitosa");
        conexion.desconectar();
    }
}
