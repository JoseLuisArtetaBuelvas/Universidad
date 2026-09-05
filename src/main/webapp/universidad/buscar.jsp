<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="universidad.modelo.Usuario" %>
<%@ page import="universidad.modelo.Universidad" %>
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
    <title>Buscar Universidad - Sistema Universidad</title>
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
            max-width: 680px;
        }
        .nav-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .nav-header a {
            color: #059669;
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
            border-top: 4px solid #059669;
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
            background-color: #ecfdf5;
            border-left: 4px solid #10b981;
            color: #065f46;
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
            border-color: #059669;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }
        .btn-search {
            background-color: #059669;
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
            background-color: #047857;
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
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 12px;
            margin-bottom: 20px;
        }
        .info-item {
            padding: 8px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }
        .info-label {
            display: block;
            color: #64748b;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 2px;
        }
        .info-value {
            color: #0f172a;
            font-weight: 600;
        }
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-publica {
            background-color: #d1fae5;
            color: #065f46;
        }
        .badge-privada {
            background-color: #e0e7ff;
            color: #3730a3;
        }
        .result-actions {
            display: flex;
            gap: 12px;
            border-top: 1px solid #e2e8f0;
            padding-top: 16px;
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
            text-align: center;
        }
        .btn-edit {
            background-color: #059669;
            color: #ffffff;
        }
        .btn-edit:hover {
            background-color: #047857;
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
                <h1>Buscar Universidad</h1>
                <p>Ingresa el ID de la institución para consultar su información completa</p>
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

            <form action="${pageContext.request.contextPath}/universidad" method="post">
                <input type="hidden" name="accion" value="buscar">

                <div class="search-group">
                    <input type="number" id="id" name="id" placeholder="ID de la universidad a buscar..." required>
                    <button type="submit" class="btn-search">Buscar</button>
                </div>
            </form>

            <%
                Universidad uniEncontrada = (Universidad) session.getAttribute("universidad.buscar");
                if (uniEncontrada != null) {
            %>
                <div class="result-card">
                    <h2><%= uniEncontrada.getNombre() %></h2>

                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Identificación (ID)</span>
                            <span class="info-value"><%= uniEncontrada.getId() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Categoría</span>
                            <span class="badge <%= "Pública".equalsIgnoreCase(uniEncontrada.getCategoria()) ? "badge-publica" : "badge-privada" %>">
                                <%= uniEncontrada.getCategoria() %>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Ciudad Sede Principal</span>
                            <span class="info-value"><%= uniEncontrada.getCiudad() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Rector</span>
                            <span class="info-value"><%= uniEncontrada.getRector() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Correo Electrónico</span>
                            <span class="info-value"><%= uniEncontrada.getEmail() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Teléfono</span>
                            <span class="info-value"><%= uniEncontrada.getTelefono() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Modalidad de Acceso</span>
                            <span class="info-value"><%= uniEncontrada.getAcceso() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Carreras / Programas</span>
                            <span class="info-value"><%= uniEncontrada.getNumeroCarreras() %> programas</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Número de Sedes</span>
                            <span class="info-value"><%= uniEncontrada.getNumSedes() %> sedes</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Sitio Web</span>
                            <span class="info-value"><a href="<%= uniEncontrada.getWeb() %>" target="_blank" style="color:#059669;"><%= uniEncontrada.getWeb() %></a></span>
                        </div>
                    </div>

                    <div class="result-actions">
                        <form action="${pageContext.request.contextPath}/universidad" method="post" style="flex: 1;">
                            <input type="hidden" name="accion" value="buscar">
                            <input type="hidden" name="id" value="<%= uniEncontrada.getId() %>">
                            <input type="hidden" name="redirecion" value="modificar">
                            <button type="submit" class="btn-action btn-edit" style="width: 100%;">Modificar</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/universidad" method="post" style="flex: 1;">
                            <input type="hidden" name="accion" value="buscar">
                            <input type="hidden" name="id" value="<%= uniEncontrada.getId() %>">
                            <input type="hidden" name="redirecion" value="borrar">
                            <button type="submit" class="btn-action btn-delete" style="width: 100%;">Eliminar</button>
                        </form>
                    </div>
                </div>
            <%
                    session.removeAttribute("universidad.buscar");
                }
            %>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/universidad/agregar.jsp">Crear Universidad</a> |
                <a href="${pageContext.request.contextPath}/universidad?accion=listartodo">Listar Universidades</a> |
                <a href="${pageContext.request.contextPath}/universidad/reportes.jsp">Reportes Parametrizados</a>
            </div>
        </div>
    </div>
</body>
</html>
