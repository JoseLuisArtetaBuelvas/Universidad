<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="universidad.modelo.Usuario" %>
<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario.login");
    if (usuarioLogueado == null) {
        response.sendRedirect(request.getContextPath() + "/usuario/login.jsp");
        return;
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Usuario</title>
</head>
<body>
    <h1>Agregar Nuevo Usuario</h1>

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
            <input type="hidden" name="accion" value="agregar">

            <div>
                <label for="id">Identificación / ID:</label><br>
                <input type="number" id="id" name="id" required><br><br>

                <label for="clave">Contraseña / Clave:</label><br>
                <input type="password" id="clave" name="clave" required><br><br>

                <label for="nombre">Nombre Completo:</label><br>
                <input type="text" id="nombre" name="nombre" required><br><br>

                <label for="rol">Rol:</label><br>
                <select id="rol" name="rol" required>
                    <option value="">-- Seleccione un rol --</option>
                    <option value="Administrador">Administrador</option>
                    <option value="Docente">Docente</option>
                    <option value="Estudiante">Estudiante</option>
                </select><br><br>

                <input type="submit" value="Registrar Usuario">
            </div>
        </form>
    </div>

    <br>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a> |
        <a href="${pageContext.request.contextPath}/usuario?accion=listartodo">Listar Usuarios</a>
    </div>
</body>
</html>
