<%-- Created by IntelliJ IDEA. User: Zaduke Date: 26/08/2026 Time: 02:26 p. m. To change this template use File |
    Settings | File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login</title>
        </head>

        <body>
            <h1>Iniciar Sesión en el Sistema</h1>
            <div class="content_form">
                <form action="${pageContext.request.contextPath}/usuario/" method="post">
                    <input type="hidden" name="accion" value="login">

                    <div>
                        <label for="id">Identificación/ID</label>
                        <input type="text" id="id" name="id" required><br><br>

                        <label for="clave">Contraseña:</label>
                        <input type="password" id="clave" name="clave" required><br><br>

                        <div>
                            <input type="submit" value="Iniciar Sesión">
                            <a href="web/usuario/recuperar-contrasena.jsp">Recuperar contraseña</a>
                        </div>

                    </div>
                </form>
            </div>
        </body>

        </html>