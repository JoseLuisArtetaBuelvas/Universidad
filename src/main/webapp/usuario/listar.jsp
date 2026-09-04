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
    <title>Listado de Usuarios</title>
</head>
<body>
    <h1>Listado General de Usuarios</h1>

    <%
        Usuario[] listado = (Usuario[]) session.getAttribute("usuario.listar");
        if (listado == null) {
    %>
        <p>No se ha cargado el listado actualmente.</p>
        <form action="${pageContext.request.contextPath}/usuario" method="post">
            <input type="hidden" name="accion" value="listartodo">
            <input type="submit" value="Cargar Usuarios">
        </form>
    <%
        } else if (listado.length == 0) {
    %>
        <p>No existen usuarios registrados en la base de datos.</p>
    <%
        } else {
    %>
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Usuario u : listado) {
                %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getNombre() %></td>
                    <td><%= u.getRol() %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/usuario?accion=buscar&id=<%= u.getId() %>&redirecion=modificar">Modificar</a> |
                        <a href="${pageContext.request.contextPath}/usuario?accion=buscar&id=<%= u.getId() %>&redirecion=borrar">Eliminar</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        }
    %>

    <br><br>
    <div>
        <a href="${pageContext.request.contextPath}/usuario/agregar.jsp">Agregar Nuevo Usuario</a> |
        <a href="${pageContext.request.contextPath}/usuario?accion=listartodo">Actualizar Lista</a> |
        <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a>
    </div>
</body>
</html>
