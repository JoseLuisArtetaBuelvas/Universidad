<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="universidad.modelo.Usuario" %>
<%
    //Obtener al usuario guardado en la sesión
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario.login");
    //Si no hay una sesion iniciada, redirigir al login
    if(usuarioLogueado == null){
        response.sendRedirect(request.getContextPath() + "/usuario/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Principal - Sistema Universidad</title>
</head>
<body>
    <header>
        <h2>Bienvenido, <%= usuarioLogueado.getNombre() %> (<%= usuarioLogueado.getRol() %>)</h2>
        <a href="<%= request.getContextPath()%>/usuario?accion=salir">Cerrar Sesión</a>
    </header>

    <%
        String mensaje = request.getParameter("mensaje");
        if (mensaje != null && !mensaje.isEmpty()) {
    %>
        <p><strong><%= mensaje %></strong></p>
    <%
        }
    %>

    <main>
        <ul>
            <li>
                <strong>Módulo Usuarios</strong>
                <a href="<%= request.getContextPath()%>/usuario/agregar.jsp">Crear Usuario</a>
                <a href="<%= request.getContextPath()%>/usuario/buscar.jsp">Buscar Usuarios</a>
                <a href="<%= request.getContextPath()%>/usuario/modificar.jsp">Modificar Usuario</a>
                <a href="<%= request.getContextPath()%>/usuario/eliminar.jsp">Eliminar Usuario</a>
                <a href="<%= request.getContextPath()%>/usuario?accion=listartodo">Listar Usuarios</a>
            </li>
            <li>
                <strong>Módulo Universidades</strong>
                <a href="<%= request.getContextPath()%>/universidad/agregar.jsp">Crear Universidad</a>
                <a href="<%= request.getContextPath()%>/universidad/buscar.jsp">Buscar Universidades</a>
                <a href="<%= request.getContextPath()%>/universidad/modificar.jsp">Modificar Universidad</a>
                <a href="<%= request.getContextPath()%>/universidad/eliminar.jsp">Eliminar Universidad</a>
                <a href="<%= request.getContextPath()%>/universidad?accion=listartodo">Listar Universidades</a>
            </li>
        </ul>
    </main>
<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>