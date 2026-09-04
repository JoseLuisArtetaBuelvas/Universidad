<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Recuperar Contraseña</title>
</head>
<body>
    <h1>Recuperar Contraseña</h1>

    <%
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null && !mensaje.isEmpty()) {
    %>
        <p><strong><%= mensaje %></strong></p>
    <%
        }
    %>

    <div>
        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="recuperar">

            <div>
                <label for="id">Identificación / ID del Usuario:</label><br>
                <input type="number" id="id" name="id" required><br><br>

                <label for="email">Correo Electrónico Registrado:</label><br>
                <input type="email" id="email" name="email" required><br><br>

                <div>
                    <input type="submit" value="Recuperar Contraseña">
                    <a href="${pageContext.request.contextPath}/usuario/login.jsp">Volver al Inicio de Sesión</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
