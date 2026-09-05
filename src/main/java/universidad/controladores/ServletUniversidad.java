package universidad.controladores;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import universidad.modelo.CRUDUniversidad;
import universidad.modelo.Universidad;

@WebServlet(name = "universidadServlet", urlPatterns = {"/universidad"})
public class ServletUniversidad extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String contextPath = request.getContextPath();
        String accion = request.getParameter("accion");

        // Si no se envía acción, redirigir al panel principal
        if (accion == null || accion.trim().isEmpty()) {
            response.sendRedirect(contextPath + "/index.jsp");
            return;
        }

        accion = accion.trim().toLowerCase();
        HttpSession sesion = request.getSession();

        try {
            CRUDUniversidad crudUniversidad = new CRUDUniversidad();

            switch (accion) {
                case "agregar": {
                    Universidad u = crudUniversidad.getUniversidad();
                    u.setId(request.getParameter("id"));
                    u.setNombre(request.getParameter("nombre"));
                    u.setCategoria(request.getParameter("categoria"));
                    u.setWeb(request.getParameter("web"));
                    u.setRector(request.getParameter("rector"));
                    u.setEmail(request.getParameter("email"));
                    u.setAcceso(request.getParameter("acceso"));
                    u.setTelefono(request.getParameter("telefono"));
                    u.setCiudad(request.getParameter("ciudad"));

                    String carrerasStr = request.getParameter("numeroCarreras");
                    u.setNumeroCarreras(carrerasStr != null && !carrerasStr.trim().isEmpty() ? Integer.parseInt(carrerasStr.trim()) : 0);

                    String sedesStr = request.getParameter("numSedes");
                    u.setNumSedes(sedesStr != null && !sedesStr.trim().isEmpty() ? Integer.parseInt(sedesStr.trim()) : 0);

                    crudUniversidad.agregarUniversidad();

                    String msg = URLEncoder.encode("Universidad " + u.getNombre() + " agregada exitosamente.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/universidad/agregar.jsp?mensaje=" + msg);
                    break;
                }

                case "buscar": {
                    String id = request.getParameter("id");
                    Universidad uni = crudUniversidad.consultarUniversidad(id);
                    sesion.setAttribute("universidad.buscar", uni);

                    String redireccion = request.getParameter("redirecion");
                    if ("borrar".equalsIgnoreCase(redireccion)) {
                        response.sendRedirect(contextPath + "/universidad/eliminar.jsp");
                    } else if ("modificar".equalsIgnoreCase(redireccion)) {
                        response.sendRedirect(contextPath + "/universidad/modificar.jsp");
                    } else {
                        response.sendRedirect(contextPath + "/universidad/buscar.jsp");
                    }
                    break;
                }

                case "modificar": {
                    Universidad u = crudUniversidad.getUniversidad();
                    u.setId(request.getParameter("id"));
                    u.setNombre(request.getParameter("nombre"));
                    u.setCategoria(request.getParameter("categoria"));
                    u.setWeb(request.getParameter("web"));
                    u.setRector(request.getParameter("rector"));
                    u.setEmail(request.getParameter("email"));
                    u.setAcceso(request.getParameter("acceso"));
                    u.setTelefono(request.getParameter("telefono"));
                    u.setCiudad(request.getParameter("ciudad"));

                    String carrerasStr = request.getParameter("numeroCarreras");
                    u.setNumeroCarreras(carrerasStr != null && !carrerasStr.trim().isEmpty() ? Integer.parseInt(carrerasStr.trim()) : 0);

                    String sedesStr = request.getParameter("numSedes");
                    u.setNumSedes(sedesStr != null && !sedesStr.trim().isEmpty() ? Integer.parseInt(sedesStr.trim()) : 0);

                    crudUniversidad.modificarUniversidad();

                    String msg = URLEncoder.encode("Universidad " + u.getNombre() + " modificada exitosamente.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/universidad/modificar.jsp?mensaje=" + msg);
                    break;
                }

                case "eliminar": {
                    String id = request.getParameter("id");
                    crudUniversidad.getUniversidad().setId(id);
                    crudUniversidad.eliminarUniversidad();

                    String msg = URLEncoder.encode("Universidad con ID " + id + " eliminada del sistema.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/universidad/eliminar.jsp?mensaje=" + msg);
                    break;
                }

                case "listartodo": {
                    Universidad[] listado = crudUniversidad.listarTodasLasUniversidades();
                    sesion.setAttribute("universidad.listar", listado);
                    response.sendRedirect(contextPath + "/universidad/listar.jsp");
                    break;
                }

                case "reporteciudad": {
                    String ciudad = request.getParameter("ciudad");
                    Universidad[] reporte = crudUniversidad.listarPorCiudad(ciudad);
                    sesion.setAttribute("universidad.reporte", reporte);
                    sesion.setAttribute("universidad.reporte_titulo", "Reporte de Universidades en " + ciudad);
                    response.sendRedirect(contextPath + "/universidad/reportes.jsp");
                    break;
                }

                case "reportecategoria": {
                    String categoria = request.getParameter("categoria");
                    String minCarrerasStr = request.getParameter("minCarreras");
                    int minCarreras = (minCarrerasStr != null && !minCarrerasStr.trim().isEmpty()) ? Integer.parseInt(minCarrerasStr.trim()) : 0;

                    Universidad[] reporte = crudUniversidad.listarPorCategoriaYMinCarreras(categoria, minCarreras);
                    sesion.setAttribute("universidad.reporte", reporte);
                    sesion.setAttribute("universidad.reporte_titulo", "Reporte de Universidades " + categoria + " con al menos " + minCarreras + " carreras");
                    response.sendRedirect(contextPath + "/universidad/reportes.jsp");
                    break;
                }

                default: {
                    String msg = URLEncoder.encode("La acción solicitada no es válida: " + accion, StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/usuario/mensaje.jsp?mensaje=" + msg);
                    break;
                }
            }
        } catch (Exception e) {
            String msgError = URLEncoder.encode("Error: " + e.getMessage(), StandardCharsets.UTF_8);
            response.sendRedirect(contextPath + "/usuario/mensaje.jsp?mensaje=" + msgError);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet Controlador para la entidad Universidad";
    }
}
