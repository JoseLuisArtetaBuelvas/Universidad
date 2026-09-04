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
import universidad.modelo.CRUDUsuario;
import universidad.modelo.Usuario;

@WebServlet(name = "usuarioServlet", urlPatterns = {"/usuario"})
public class ServletUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String contextPath = request.getContextPath();
        String accion = request.getParameter("accion");

        // Si no se envía acción, redirigir al login
        if (accion == null || accion.trim().isEmpty()) {
            response.sendRedirect(contextPath + "/usuario/login.jsp");
            return;
        }

        accion = accion.trim().toLowerCase();
        HttpSession sesion = request.getSession();

        try {
            CRUDUsuario crudUsuario = new CRUDUsuario();

            switch (accion) {
                case "agregar": {
                    crudUsuario.getAlguien().setId(request.getParameter("id"));
                    crudUsuario.getAlguien().setClave(request.getParameter("clave"));
                    crudUsuario.getAlguien().setNombre(request.getParameter("nombre"));
                    crudUsuario.getAlguien().setRol(request.getParameter("rol"));
                    crudUsuario.agregarUsuario();

                    String msg = URLEncoder.encode("Usuario " + request.getParameter("id") + " agregado exitosamente.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/usuario/agregar.jsp?mensaje=" + msg);
                    break;
                }

                case "buscar": {
                    String id = request.getParameter("id");
                    Usuario usuario = crudUsuario.consultarUsuario(id);
                    sesion.setAttribute("usuario.buscar", usuario);

                    String redireccion = request.getParameter("redirecion");
                    if ("borrar".equalsIgnoreCase(redireccion)) {
                        response.sendRedirect(contextPath + "/usuario/eliminar.jsp");
                    } else if ("modificar".equalsIgnoreCase(redireccion)) {
                        response.sendRedirect(contextPath + "/usuario/modificar.jsp");
                    } else {
                        response.sendRedirect(contextPath + "/usuario/buscar.jsp");
                    }
                    break;
                }

                case "modificar": {
                    crudUsuario.getAlguien().setId(request.getParameter("id"));
                    crudUsuario.getAlguien().setClave(request.getParameter("clave"));
                    crudUsuario.getAlguien().setNombre(request.getParameter("nombre"));
                    crudUsuario.getAlguien().setRol(request.getParameter("rol"));
                    crudUsuario.modificarUsuario();

                    String msg = URLEncoder.encode("Usuario " + request.getParameter("id") + " modificado exitosamente.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/usuario/modificar.jsp?mensaje=" + msg);
                    break;
                }

                case "eliminar": {
                    crudUsuario.getAlguien().setId(request.getParameter("id"));
                    crudUsuario.eliminarUsuario();

                    String msg = URLEncoder.encode("Usuario " + request.getParameter("id") + " eliminado del sistema.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/usuario/eliminar.jsp?mensaje=" + msg);
                    break;
                }

                case "listartodo": {
                    Usuario[] listado = crudUsuario.listarTodosLosusuarios();
                    sesion.setAttribute("usuario.listar", listado);
                    response.sendRedirect(contextPath + "/usuario/listar.jsp");
                    break;
                }

                case "login": {
                    String id = request.getParameter("id");
                    String clave = request.getParameter("clave");
                    Usuario usuarioAutenticado = crudUsuario.iniciarSesion(id, clave);

                    sesion.setAttribute("usuario.login", usuarioAutenticado);
                    String msg = URLEncoder.encode("Bienvenido al Sistema, " + usuarioAutenticado.getNombre(), StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/index.jsp?mensaje=" + msg);
                    break;
                }

                case "salir": {
                    sesion.removeAttribute("usuario.login");
                    sesion.invalidate();
                    String msg = URLEncoder.encode("Sesión cerrada correctamente.", StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/usuario/login.jsp?mensaje=" + msg);
                    break;
                }

                case "recuperar": {
                    String id = request.getParameter("id");
                    String email = request.getParameter("email");
                    crudUsuario.recuperarContrasena(id, email);
                    String msg = URLEncoder.encode("Solicitud recibida para el usuario " + id + " con correo " + email, StandardCharsets.UTF_8);
                    response.sendRedirect(contextPath + "/usuario/recuperar-contrasena.jsp?mensaje=" + msg);
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
        return "Servlet Controlador para la entidad Usuario";
    }
}
