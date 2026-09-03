<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="universidad.modelo.Usuario" %>
<%
    //Obtener al usuario guardado en la sesión
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario.login");
    //If no hay una sesion iniciada, redirigir al login
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

    <main>
        <ul>
            <li>
                <strong>Módulo Usuarios</strong>
                <a href="<%= request.getContextPath()%>/usuario/agregar">Crear Usuario</a>
                <a href="<%= request.getContextPath()%>/usuario/buscar">Buscar Usuarios</a>
                <a href="<%= request.getContextPath()%>/usuario?accion=listarTodo">Listar Usuarios</a>
            </li>
            <li>
                <strong>Módulo Universidades</strong>
                <a href="<%= request.getContextPath()%>/universidad/agregar">Crear Universidad</a>
                <a href="<%= request.getContextPath()%>/universidad/buscar">Buscar Universidades</a>
                <a href="<%= request.getContextPath()%>/universidad?accion=listarTodo">Listar Universidades</a>
            </li>
        </ul>
    </main>
<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>