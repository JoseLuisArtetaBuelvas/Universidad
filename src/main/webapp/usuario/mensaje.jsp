<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mensaje del Sistema</title>
</head>
<body>
    <h1>Mensaje del Sistema</h1>

    <div>
        <p>
            <%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "No hay información disponible." %>
        </p>
    </div>

    <br>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a> |
        <a href="${pageContext.request.contextPath}/usuario/login.jsp">Ir al Login</a>
    </div>
</body>
</html>
