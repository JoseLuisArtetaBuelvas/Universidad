<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="universidad.modelo.Usuario" %>
<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario.login");
    if (usuarioLogueado == null) {
        response.sendRedirect(request.getContextPath() + "/usuario/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Usuario - Sistema Universidad</title>
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
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        .container {
            width: 100%;
            max-width: 580px;
        }
        .nav-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .nav-header a {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }
        .nav-header a:hover {
            text-decoration: underline;
        }
        .card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            padding: 36px 32px;
        }
        .card-header {
            margin-bottom: 24px;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 16px;
        }
        .card-header h1 {
            font-size: 22px;
            font-weight: 700;
            color: #dc2626;
            margin-bottom: 4px;
        }
        .card-header p {
            font-size: 14px;
            color: #64748b;
        }
        .alert {
            background-color: #eff6ff;
            border-left: 4px solid #3b82f6;
            color: #1e40af;
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .search-group {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
        }
        .search-group input {
            flex: 1;
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            background-color: #f8fafc;
        }
        .search-group input:focus {
            outline: none;
            border-color: #dc2626;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.15);
        }
        .btn-search {
            background-color: #dc2626;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 11px 22px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-search:hover {
            background-color: #b91c1c;
        }
        .warning-box {
            background-color: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
        }
        .warning-box h2 {
            font-size: 18px;
            color: #991b1b;
            margin-bottom: 10px;
        }
        .warning-box p.warning-text {
            font-size: 14px;
            color: #b91c1c;
            margin-bottom: 16px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #fee2e2;
            font-size: 14px;
        }
        .info-label {
            color: #7f1d1d;
            font-weight: 500;
        }
        .info-value {
            color: #991b1b;
            font-weight: 600;
        }
        .actions-group {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }
        .btn-danger {
            flex: 1;
            background-color: #dc2626;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
        }
        .btn-cancel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            padding: 12px;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.2s;
        }
        .btn-cancel:hover {
            background-color: #e2e8f0;
            color: #1e293b;
        }
        .footer-nav {
            margin-top: 24px;
            display: flex;
            justify-content: center;
            gap: 16px;
        }
        .footer-nav a {
            color: #64748b;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.2s;
        }
        .footer-nav a:hover {
            color: #1e293b;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="nav-header">
            <a href="${pageContext.request.contextPath}/index.jsp">← Panel Principal</a>
            <span style="font-size: 13px; color: #64748b;">Sesión: <strong><%= usuarioLogueado.getNombre() %></strong></span>
        </div>

        <div class="card">
            <div class="card-header">
                <h1>Eliminar Usuario</h1>
                <p><%= usuarioEliminar == null ? "Busca el usuario que deseas remover" : "Confirma la eliminación del usuario" %></p>
            </div>

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

            <%
                if (usuarioEliminar == null) {
            %>
                <form action="${pageContext.request.contextPath}/usuario" method="post">
                    <input type="hidden" name="accion" value="buscar">
                    <input type="hidden" name="redirecion" value="borrar">

                    <div class="search-group">
                        <input type="number" id="id" name="id" placeholder="ID / Identificación a eliminar..." required>
                        <button type="submit" class="btn-search">Buscar</button>
                    </div>
                </form>
            <%
                } else {
            %>
                <div class="warning-box">
                    <h2>Confirmación de Eliminación</h2>
                    <p class="warning-text">¿Estás seguro de que deseas eliminar permanentemente a este usuario? Esta acción no se puede deshacer.</p>

                    <div class="info-row">
                        <span class="info-label">Identificación:</span>
                        <span class="info-value"><%= usuarioEliminar.getId() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Nombre Completo:</span>
                        <span class="info-value"><%= usuarioEliminar.getNombre() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Rol:</span>
                        <span class="info-value"><%= usuarioEliminar.getRol() %></span>
                    </div>

                    <form action="${pageContext.request.contextPath}/usuario" method="post">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id" value="<%= usuarioEliminar.getId() %>">

                        <div class="actions-group">
                            <button type="submit" class="btn-danger">Confirmar y Eliminar</button>
                            <a href="${pageContext.request.contextPath}/usuario/eliminar.jsp" class="btn-cancel">Cancelar</a>
                        </div>
                    </form>
                </div>
            <%
                    session.removeAttribute("usuario.buscar");
                }
            %>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/usuario/buscar.jsp">Buscar Usuario</a> |
                <a href="${pageContext.request.contextPath}/usuario?accion=listartodo">Listar Usuarios</a>
            </div>
        </div>
    </div>
</body>
</html>
