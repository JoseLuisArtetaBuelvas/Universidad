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
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Sistema Universidad</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f1f5f9;
            color: #1e293b;
            min-height: 100vh;
        }
        .navbar {
            background-color: #1e3a8a;
            color: #ffffff;
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar h2 {
            font-size: 18px;
            font-weight: 600;
        }
        .navbar-user {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .btn-logout {
            background-color: #dc2626;
            color: #ffffff;
            text-decoration: none;
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            transition: background-color 0.2s;
        }
        .btn-logout:hover {
            background-color: #b91c1c;
        }
        .main-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .alert {
            background-color: #eff6ff;
            border-left: 4px solid #3b82f6;
            color: #1e40af;
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 15px;
        }
        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
            gap: 24px;
        }
        .module-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            padding: 28px 24px;
            border-top: 4px solid #2563eb;
        }
        .module-card.universidad-card {
            border-top-color: #059669;
        }
        .module-card h3 {
            font-size: 20px;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .module-card p.desc {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
        }
        .links-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .links-list li a {
            display: block;
            padding: 10px 14px;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            color: #1e293b;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .links-list li a:hover {
            background-color: #eff6ff;
            border-color: #bfdbfe;
            color: #1d4ed8;
            padding-left: 18px;
        }
    </style>
</head>
<body>
    <header class="navbar">
        <h2>Sistema Universidad</h2>
        <div class="navbar-user">
            <span>Bienvenido, <strong><%= usuarioLogueado.getNombre() %></strong> (<%= usuarioLogueado.getRol() %>)</span>
            <a href="<%= request.getContextPath()%>/usuario?accion=salir" class="btn-logout">Cerrar Sesión</a>
        </div>
    </header>

    <div class="main-container">
        <%
            String mensaje = request.getParameter("mensaje");
            if (mensaje != null && !mensaje.isEmpty()) {
        %>
            <div class="alert">
                <%= mensaje %>
            </div>
        <%
            }
        %>

        <main class="modules-grid">
            <div class="module-card">
                <h3>Módulo Usuarios</h3>
                <p class="desc">Administración de cuentas, roles y accesos</p>
                <ul class="links-list">
                    <li><a href="<%= request.getContextPath()%>/usuario/agregar.jsp">➕ Crear Nuevo Usuario</a></li>
                    <li><a href="<%= request.getContextPath()%>/usuario/buscar.jsp">🔍 Buscar Usuario</a></li>
                    <li><a href="<%= request.getContextPath()%>/usuario/modificar.jsp">✏️ Modificar Usuario</a></li>
                    <li><a href="<%= request.getContextPath()%>/usuario/eliminar.jsp">🗑️ Eliminar Usuario</a></li>
                    <li><a href="<%= request.getContextPath()%>/usuario?accion=listartodo">📋 Listar Todos los Usuarios</a></li>
                </ul>
            </div>

            <div class="module-card universidad-card">
                <h3>Módulo Universidades</h3>
                <p class="desc">Gestión de instituciones, sedes y carreras</p>
                <ul class="links-list">
                    <li><a href="<%= request.getContextPath()%>/universidad/agregar.jsp">➕ Crear Universidad</a></li>
                    <li><a href="<%= request.getContextPath()%>/universidad/buscar.jsp">🔍 Buscar Universidades</a></li>
                    <li><a href="<%= request.getContextPath()%>/universidad/modificar.jsp">✏️ Modificar Universidad</a></li>
                    <li><a href="<%= request.getContextPath()%>/universidad/eliminar.jsp">🗑️ Eliminar Universidad</a></li>
                    <li><a href="<%= request.getContextPath()%>/universidad?accion=listartodo">📋 Listar Universidades</a></li>
                </ul>
            </div>
        </main>
    </div>
</body>
</html>