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
    <title>Buscar Usuario</title>
</head>
<body>
    <h1>Buscar Usuario por ID</h1>

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
            <input type="hidden" name="accion" value="buscar">

            <div>
                <label for="id">Identificación / ID del Usuario:</label><br>
                <input type="number" id="id" name="id" required><br><br>

                <input type="submit" value="Buscar">
            </div>
        </form>
    </div>

    <%
        Usuario usuarioEncontrado = (Usuario) session.getAttribute("usuario.buscar");
        if (usuarioEncontrado != null) {
    %>
        <hr>
        <h2>Usuario Encontrado</h2>
        <p><strong>ID:</strong> <%= usuarioEncontrado.getId() %></p>
        <p><strong>Nombre:</strong> <%= usuarioEncontrado.getNombre() %></p>
        <p><strong>Rol:</strong> <%= usuarioEncontrado.getRol() %></p>

        <div>
            <form action="${pageContext.request.contextPath}/usuario" method="post" style="display:inline;">
                <input type="hidden" name="accion" value="buscar">
                <input type="hidden" name="id" value="<%= usuarioEncontrado.getId() %>">
                <input type="hidden" name="redirecion" value="modificar">
                <input type="submit" value="Modificar este Usuario">
            </form>

            <form action="${pageContext.request.contextPath}/usuario" method="post" style="display:inline;">
                <input type="hidden" name="accion" value="buscar">
                <input type="hidden" name="id" value="<%= usuarioEncontrado.getId() %>">
                <input type="hidden" name="redirecion" value="borrar">
                <input type="submit" value="Eliminar este Usuario">
            </form>
        </div>
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
