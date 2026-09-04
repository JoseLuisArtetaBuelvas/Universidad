<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
</head>
<body>
    <h1>Iniciar Sesión en el Sistema</h1>

    <%
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null && !mensaje.isEmpty()) {
    %>
        <p><strong><%= mensaje %></strong></p>
    <%
        }
    %>

    <div class="content_form">
        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="login">

            <div>
                <label for="id">Identificación / ID:</label><br>
                <input type="number" id="id" name="id" required><br><br>

                <label for="clave">Contraseña:</label><br>
                <input type="password" id="clave" name="clave" required><br><br>

                <div>
                    <input type="submit" value="Iniciar Sesión">
                    <a href="${pageContext.request.contextPath}/usuario/recuperar-contrasena.jsp">Recuperar contraseña</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>