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
    <title>Modificar Usuario</title>
</head>
<body>
    <h1>Modificar Usuario</h1>

    <%
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null && !mensaje.isEmpty()) {
    %>
        <p><strong><%= mensaje %></strong></p>
    <%
        }
    %>

    <%
        Usuario usuarioModificar = (Usuario) session.getAttribute("usuario.buscar");
        if (usuarioModificar == null) {
    %>
        <h2>Buscar Usuario a Modificar</h2>
        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="buscar">
            <input type="hidden" name="redirecion" value="modificar">

            <div>
                <label for="id">Identificación / ID del Usuario:</label><br>
                <input type="number" id="id" name="id" required><br><br>

                <input type="submit" value="Buscar para Modificar">
            </div>
        </form>
    <%
        } else {
    %>
        <h2>Editar Datos del Usuario</h2>
        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="modificar">

            <div>
                <label for="id">Identificación / ID (no editable):</label><br>
                <input type="number" id="id" name="id" value="<%= usuarioModificar.getId() %>" readonly><br><br>

                <label for="clave">Nueva Contraseña / Clave:</label><br>
                <input type="password" id="clave" name="clave" value="<%= usuarioModificar.getClave() %>" required><br><br>

                <label for="nombre">Nombre Completo:</label><br>
                <input type="text" id="nombre" name="nombre" value="<%= usuarioModificar.getNombre() %>" required><br><br>

                <label for="rol">Rol:</label><br>
                <select id="rol" name="rol" required>
                    <option value="Administrador" <%= "Administrador".equals(usuarioModificar.getRol()) ? "selected" : "" %>>Administrador</option>
                    <option value="Docente" <%= "Docente".equals(usuarioModificar.getRol()) ? "selected" : "" %>>Docente</option>
                    <option value="Estudiante" <%= "Estudiante".equals(usuarioModificar.getRol()) ? "selected" : "" %>>Estudiante</option>
                </select><br><br>

                <input type="submit" value="Guardar Cambios">
            </div>
        </form>
        <br>
        <a href="${pageContext.request.contextPath}/usuario/modificar.jsp">Buscar otro usuario</a>
    <%
            session.removeAttribute("usuario.buscar");
        }
    %>

    <br><br>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a> |
        <a href="${pageContext.request.contextPath}/usuario?accion=listartodo">Listar Usuarios</a>
    </div>
</body>
</html>
