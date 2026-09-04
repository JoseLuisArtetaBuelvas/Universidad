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
    <title>Buscar Usuario - Sistema Universidad</title>
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
            color: #0f172a;
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
            margin-bottom: 24px;
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
            border-color: #2563eb;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .btn-search {
            background-color: #2563eb;
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
            background-color: #1d4ed8;
        }
        .result-card {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            margin-top: 10px;
        }
        .result-card h2 {
            font-size: 18px;
            color: #0f172a;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }
        .info-label {
            color: #64748b;
            font-weight: 500;
        }
        .info-value {
            color: #0f172a;
            font-weight: 600;
        }
        .badge {
            background-color: #dbeafe;
            color: #1e40af;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 13px;
        }
        .result-actions {
            margin-top: 20px;
            display: flex;
            gap: 12px;
        }
        .btn-action {
            flex: 1;
            padding: 10px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }
        .btn-edit {
            background-color: #2563eb;
            color: #ffffff;
        }
        .btn-edit:hover {
            background-color: #1d4ed8;
        }
        .btn-delete {
            background-color: #fee2e2;
            color: #dc2626;
        }
        .btn-delete:hover {
            background-color: #fecaca;
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
                <h1>Buscar Usuario</h1>
                <p>Ingresa el número de identificación para consultar la información</p>
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

            <form action="${pageContext.request.contextPath}/usuario" method="post">
                <input type="hidden" name="accion" value="buscar">

                <div class="search-group">
                    <input type="number" id="id" name="id" placeholder="ID / Identificación a buscar..." required>
                    <button type="submit" class="btn-search">Buscar</button>
                </div>
            </form>

            <%
                Usuario usuarioEncontrado = (Usuario) session.getAttribute("usuario.buscar");
                if (usuarioEncontrado != null) {
            %>
                <div class="result-card">
                    <h2>Resultado de la Búsqueda</h2>
                    <div class="info-row">
                        <span class="info-label">Identificación:</span>
                        <span class="info-value"><%= usuarioEncontrado.getId() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Nombre Completo:</span>
                        <span class="info-value"><%= usuarioEncontrado.getNombre() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Rol del Sistema:</span>
                        <span class="badge"><%= usuarioEncontrado.getRol() %></span>
                    </div>

                    <div class="result-actions">
                        <form action="${pageContext.request.contextPath}/usuario" method="post" style="flex: 1;">
                            <input type="hidden" name="accion" value="buscar">
                            <input type="hidden" name="id" value="<%= usuarioEncontrado.getId() %>">
                            <input type="hidden" name="redirecion" value="modificar">
                            <button type="submit" class="btn-action btn-edit" style="width: 100%;">Modificar</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/usuario" method="post" style="flex: 1;">
                            <input type="hidden" name="accion" value="buscar">
                            <input type="hidden" name="id" value="<%= usuarioEncontrado.getId() %>">
                            <input type="hidden" name="redirecion" value="borrar">
                            <button type="submit" class="btn-action btn-delete" style="width: 100%;">Eliminar</button>
                        </form>
                    </div>
                </div>
            <%
                    session.removeAttribute("usuario.buscar");
                }
            %>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/usuario/agregar.jsp">Agregar Usuario</a> |
                <a href="${pageContext.request.contextPath}/usuario?accion=listartodo">Listar Usuarios</a>
            </div>
        </div>
    </div>
</body>
</html>
