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
    <title>Eliminar Usuario</title>
</head>
<body>
    <h1>Eliminar Usuario</h1>

    <%
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null && !mensaje.isEmpty()) {
    %>
        <p><strong><%= mensaje %></strong></p>
    <%
        }
    %>

    <%
        Usuario usuarioEliminar = (Usuario) session.getAttribute("usuario.buscar");
        if (usuarioEliminar == null) {
    %>
        <h2>Buscar Usuario a Eliminar</h2>
        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="buscar">
            <input type="hidden" name="redirecion" value="borrar">

            <div>
                <label for="id">Identificación / ID del Usuario:</label><br>
                <input type="number" id="id" name="id" required><br><br>

                <input type="submit" value="Buscar para Eliminar">
            </div>
        </form>
    <%
        } else {
    %>
        <h2>Confirmación de Eliminación</h2>
        <p>¿Está seguro de que desea eliminar permanentemente al siguiente usuario?</p>
        <p><strong>ID:</strong> <%= usuarioEliminar.getId() %></p>
        <p><strong>Nombre:</strong> <%= usuarioEliminar.getNombre() %></p>
        <p><strong>Rol:</strong> <%= usuarioEliminar.getRol() %></p>

        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="eliminar">
            <input type="hidden" name="id" value="<%= usuarioEliminar.getId() %>">

            <input type="submit" value="Confirmar y Eliminar">
            <a href="${pageContext.request.contextPath}/usuario/eliminar.jsp">Cancelar</a>
        </form>
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
