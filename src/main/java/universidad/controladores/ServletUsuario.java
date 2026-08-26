package universidad.controladores;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

//Generar archivo de despligue de nuestra aplicación (inicial o index.html)
@WebServlet(name = "usuarioServlet", value = "/usuario")

public class ServletUsuario extends HttpServlet {
    private  String message;

    public void init() {message = "Esto es la vista del usuario";}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>"+message+"</h1>");
        out.println("</body></html>");
    }

    public void destroy(){

    }
}
