package universidad.controladores;

import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.*;
import universidad.modelo.CRUDUsuario;
import universidad.modelo.Usuario;
//Generar archivo de despligue de nuestra aplicación (inicial o index.html)
@WebServlet(name = "usuarioServlet", value = "/usuario")

public class ServletUsuario extends HttpServlet {

    //Metodo para procesar las peticiones
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            CRUDUsuario crudUsuario = new CRUDUsuario();
            String accion = request.getParameter("accion"); //capturar la accion
            if(accion.equals("agregar")) {
                crudUsuario.getAlguien().setId(request.getParameter("id"));
                crudUsuario.getAlguien().setClave(request.getParameter("clave"));
                crudUsuario.getAlguien().setNombre(request.getParameter("nombre"));
                crudUsuario.getAlguien().setRol(request.getParameter("rol"));
                crudUsuario.agregarUsuario();
            }else if(accion.equals("buscar")) {
                Usuario usuario = crudUsuario.consultarUsuario(request.getParameter("id"));
                request.getSession().setAttribute("usuario.buscar", usuario);
                String redirecion = request.getParameter("redirecion");
                if(redirecion.equals("borrar")) {
                    response.sendRedirect("web/usuario/eliminar.jsp");
                }else if(redirecion.equals("modificar")) {
                    response.sendRedirect("web/usuario/modificar.jsp");
                }else{
                    response.sendRedirect("web/usuario/buscar.jsp");
                }
            }else if(accion.equals("modificar")) {
                crudUsuario.getAlguien().setId(request.getParameter("id"));
                crudUsuario.getAlguien().setClave(request.getParameter("clave"));
                crudUsuario.getAlguien().setNombre(request.getParameter("nombre"));
                crudUsuario.getAlguien().setRol(request.getParameter("rol"));
                response.sendRedirect("web/usuario/modificar.jsp?mensaje=Usuario"+request.getParameter("id")+ "Modificado en el sistema");
            }else if(accion.equals("eliminar")) {
                crudUsuario.getAlguien().setId(request.getParameter("id"));
                crudUsuario.eliminarUsuario();
                response.sendRedirect("web/usuario/eliminar.jsp?mensaje=Usuario"+request.getParameter("id")+ "Eliminado del sistema");
            }else if(accion.equals("listartodo")) {
                Usuario[] listado = crudUsuario.listarTodosLosusuarios();
                request.getSession().setAttribute("usuario.listar", listado);
                response.sendRedirect("web/usuario/listar.jsp");
            }else if(accion.equals("login")) {
                Usuario alguien = crudUsuario.iniciarSesion(request.getParameter("id"), request.getParameter("clave"));
                request.getSession().setAttribute("usuario.login", alguien);
                response.sendRedirect("index.jsp?mensaje=Bienvenido al Sistema");
            }else if(accion.equals("salir")) {
                request.getSession().setAttribute("usuario.login", null);
                request.getSession().invalidate();
                response.sendRedirect("index.jsp>?mensaje=Bienvenido al Sistema");
            }else {
                response.sendRedirect("web/usuario/mensaje.jsp?mensaje=La Accion Solicitada no es Correcta");
            }
        } catch (Exception e) {
            response.sendRedirect("web/usuario/mensaje.jsp?mensaje=Error"+e.getMessage());
        }finally {
            out.close();
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
        return "Short description";
    }
}
