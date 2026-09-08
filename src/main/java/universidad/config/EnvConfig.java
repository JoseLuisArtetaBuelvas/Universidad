package universidad.config;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * Gestor de configuración y variables de entorno para el Sistema Universidad.
 * Carga configuraciones con el siguiente orden de precedencia:
 * 1. Variables de entorno del sistema (System.getenv) - ideales para producción/nube (Render, Docker, AWS).
 * 2. Propiedades del sistema Java (System.getProperty).
 * 3. Archivo .env local (si existe en el directorio de trabajo, catalina.base o classpath).
 * 4. Valor por defecto proporcionado.
 */
public class EnvConfig {

    private static final Map<String, String> ENV_CACHE = new HashMap<>();
    private static boolean cargado = false;

    private static synchronized void inicializar() {
        if (cargado) {
            return;
        }
        cargado = true;

        // 1. Intentar cargar desde rutas típicas del sistema de archivos
        String userDir = System.getProperty("user.dir", "");
        String catalinaBase = System.getProperty("catalina.base", "");

        String[] posiblesRutas = {
            ".env",
            "../.env",
            userDir + File.separator + ".env",
            catalinaBase + File.separator + ".env",
            catalinaBase + File.separator + "webapps" + File.separator + "Universidad" + File.separator + ".env"
        };

        for (String ruta : posiblesRutas) {
            if (ruta == null || ruta.trim().isEmpty()) {
                continue;
            }
            File archivo = new File(ruta);
            if (archivo.exists() && archivo.isFile()) {
                cargarDesdeArchivo(archivo);
                break;
            }
        }

        // 2. Intentar cargar desde el Classpath como fallback
        try (InputStream is = EnvConfig.class.getClassLoader().getResourceAsStream(".env")) {
            if (is != null) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                    procesarReader(reader);
                }
            }
        } catch (Exception ignored) {
        }
    }

    private static void cargarDesdeArchivo(File archivo) {
        try (BufferedReader reader = new BufferedReader(new FileReader(archivo, StandardCharsets.UTF_8))) {
            procesarReader(reader);
        } catch (Exception ignored) {
        }
    }

    private static void procesarReader(BufferedReader reader) throws Exception {
        String linea;
        while ((linea = reader.readLine()) != null) {
            linea = linea.trim();
            if (linea.isEmpty() || linea.startsWith("#")) {
                continue;
            }
            int separador = linea.indexOf('=');
            if (separador > 0) {
                String clave = linea.substring(0, separador).trim();
                String valor = linea.substring(separador + 1).trim();

                // Quitar comillas envolventes si las tiene
                if ((valor.startsWith("\"") && valor.endsWith("\"")) || (valor.startsWith("'") && valor.endsWith("'"))) {
                    if (valor.length() >= 2) {
                        valor = valor.substring(1, valor.length() - 1);
                    }
                }
                ENV_CACHE.putIfAbsent(clave, valor);
            }
        }
    }

    /**
     * Obtiene una variable de configuración como String.
     *
     * @param clave Nombre de la variable (ej. "DB_HOST")
     * @param valorPorDefecto Valor de respaldo si no está definida
     * @return El valor configurado o el valor por defecto
     */
    public static String get(String clave, String valorPorDefecto) {
        inicializar();

        // 1. Variable de entorno del sistema operativo / contenedor
        String val = System.getenv(clave);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        // 2. Propiedad del sistema Java (-Dclave=valor)
        val = System.getProperty(clave);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        // 3. Archivo .env
        val = ENV_CACHE.get(clave);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        return valorPorDefecto;
    }

    /**
     * Obtiene una variable de configuración como String sin valor por defecto.
     */
    public static String get(String clave) {
        return get(clave, null);
    }

    /**
     * Obtiene una variable de configuración convertida a entero.
     */
    public static int getInt(String clave, int valorPorDefecto) {
        String val = get(clave, null);
        if (val == null) {
            return valorPorDefecto;
        }
        try {
            return Integer.parseInt(val.trim());
        } catch (NumberFormatException e) {
            return valorPorDefecto;
        }
    }
}
