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
    <title>Reportes Parametrizados - Módulo Usuario</title>
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
            max-width: 1050px;
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
            border-top: 4px solid #2563eb;
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
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .report-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
        }
        .report-box h3 {
            font-size: 16px;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 6px;
        }
        .report-box p {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 16px;
        }
        .form-group {
            margin-bottom: 14px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            background-color: #ffffff;
            color: #1e293b;
        }
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .btn-report {
            width: 100%;
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-report:hover {
            background-color: #1d4ed8;
        }
        .results-section {
            border-top: 2px dashed #e2e8f0;
            padding-top: 24px;
            margin-top: 10px;
        }
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .results-header h2 {
            font-size: 18px;
            color: #0f172a;
        }
        .results-badge {
            background-color: #eff6ff;
            color: #1e40af;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
        }
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 13px;
        }
        thead {
            background-color: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        th {
            padding: 10px 12px;
            font-weight: 600;
            color: #475569;
            text-transform: uppercase;
            font-size: 11px;
        }
        td {
            padding: 11px 12px;
            border-bottom: 1px solid #f1f5f9;
        }
        tr:hover {
            background-color: #f8fafc;
        }
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-admin {
            background-color: #fef3c7;
            color: #92400e;
        }
        .badge-docente {
            background-color: #e0e7ff;
            color: #3730a3;
        }
        .badge-estudiante {
            background-color: #dcfce7;
            color: #166534;
        }
        .badge-default {
            background-color: #f1f5f9;
            color: #475569;
        }
        .action-links {
            display: flex;
            gap: 8px;
        }
        .link-action {
            text-decoration: none;
            padding: 3px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .link-edit {
            background-color: #eff6ff;
            color: #2563eb;
        }
        .link-edit:hover {
            background-color: #dbeafe;
        }
        .link-delete {
            background-color: #fef2f2;
            color: #dc2626;
        }
        .link-delete:hover {
            background-color: #fee2e2;
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
                <h1>Reportes Parametrizados de Usuarios</h1>
                <p>Genera consultas con filtros específicos sobre las cuentas y roles del sistema</p>
            </div>

            <div class="reports-grid">
                <!-- Reporte 1: Filtrar por Rol -->
                <div class="report-box">
                    <h3>Reporte N.º 1: Por Rol del Sistema</h3>
                    <p>Muestra todos los usuarios que pertenecen a un rol determinado (Administrador, Docente o Estudiante).</p>

                    <form action="${pageContext.request.contextPath}/usuario" method="post">
                        <input type="hidden" name="accion" value="reporterol">

                        <div class="form-group">
                            <label for="rol">Rol a Consultar:</label>
                            <select id="rol" name="rol" required>
                                <option value="Administrador">Administrador</option>
                                <option value="Docente">Docente</option>
                                <option value="Estudiante">Estudiante</option>
                            </select>
                        </div>

                        <button type="submit" class="btn-report">Generar Reporte por Rol</button>
                    </form>
                </div>

                <!-- Reporte 2: Filtrar por Rol y Coincidencia en Nombre/Correo -->
                <div class="report-box">
                    <h3>Reporte N.º 2: Rol y Coincidencia de Nombre/Correo</h3>
                    <p>Filtra usuarios por su rol y coincidencia de texto en su nombre completo o correo electrónico.</p>

                    <form action="${pageContext.request.contextPath}/usuario" method="post">
                        <input type="hidden" name="accion" value="reportenombre">

                        <div class="form-group">
                            <label for="rol2">Rol del Sistema:</label>
                            <select id="rol2" name="rol" required>
                                <option value="Administrador">Administrador</option>
                                <option value="Docente">Docente</option>
                                <option value="Estudiante">Estudiante</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="criterio">Texto a buscar (Nombre o Correo):</label>
                            <input type="text" id="criterio" name="criterio" placeholder="Ej. Maria, Juan, @gmail.com...">
                        </div>

                        <button type="submit" class="btn-report">Generar Reporte Combinado</button>
                    </form>
                </div>
            </div>

            <%
                Usuario[] reporte = (Usuario[]) session.getAttribute("usuario.reporte");
                String tituloReporte = (String) session.getAttribute("usuario.reporte_titulo");
                if (reporte != null) {
            %>
                <div class="results-section">
                    <div class="results-header">
                        <h2><%= tituloReporte != null ? tituloReporte : "Resultados de la Consulta" %></h2>
                        <span class="results-badge"><%= reporte.length %> <%= reporte.length == 1 ? "usuario encontrado" : "usuarios encontrados" %></span>
                    </div>

                    <% if (reporte.length == 0) { %>
                        <p style="color: #64748b; padding: 20px; text-align: center; background: #f8fafc; border-radius: 8px;">
                            No se encontraron usuarios que cumplan con los parámetros seleccionados.
                        </p>
                    <% } else { %>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Identificación</th>
                                        <th>Nombre Completo</th>
                                        <th>Rol</th>
                                        <th>Correo Electrónico</th>
                                        <th style="text-align: right;">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Usuario u : reporte) {
                                        String badgeClass = "badge-default";
                                        if ("Administrador".equalsIgnoreCase(u.getRol())) {
                                            badgeClass = "badge-admin";
                                        } else if ("Docente".equalsIgnoreCase(u.getRol())) {
                                            badgeClass = "badge-docente";
                                        } else if ("Estudiante".equalsIgnoreCase(u.getRol())) {
                                            badgeClass = "badge-estudiante";
                                        }
                                    %>
                                    <tr>
                                        <td><strong><%= u.getId() %></strong></td>
                                        <td><%= u.getNombre() %></td>
                                        <td><span class="badge <%= badgeClass %>"><%= u.getRol() %></span></td>
                                        <td><%= (u.getEmail() != null && !u.getEmail().isEmpty()) ? u.getEmail() : "<span style='color: #94a3b8;'>Sin registrar</span>" %></td>
                                        <td>
                                            <div class="action-links" style="justify-content: flex-end;">
                                                <a href="${pageContext.request.contextPath}/usuario?accion=buscar&id=<%= u.getId() %>&redirecion=modificar" class="link-action link-edit">Modificar</a>
                                                <a href="${pageContext.request.contextPath}/usuario?accion=buscar&id=<%= u.getId() %>&redirecion=borrar" class="link-action link-delete">Eliminar</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } %>
                </div>
            <%
                }
            %>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/usuario/buscar.jsp">Buscar Usuario</a> |
                <a href="${pageContext.request.contextPath}/usuario?accion=listartodo">Listar Usuarios</a> |
                <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a>
            </div>
        </div>
    </div>
</body>
</html>
