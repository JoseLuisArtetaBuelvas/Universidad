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
    <title>Listado de Universidades - Sistema Universidad</title>
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
            max-width: 1100px;
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
        .card-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 16px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .card-header-flex h1 {
            font-size: 22px;
            font-weight: 700;
            color: #0f172a;
        }
        .card-header-flex p {
            font-size: 14px;
            color: #64748b;
        }
        .header-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn-top {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }
        .btn-primary {
            background-color: #059669;
            color: #ffffff;
        }
        .btn-primary:hover {
            background-color: #047857;
        }
        .btn-secondary {
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
        }
        .btn-secondary:hover {
            background-color: #e2e8f0;
            color: #1e293b;
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
            font-size: 14px;
        }
        thead {
            background-color: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        th {
            padding: 12px 14px;
            font-weight: 600;
            color: #475569;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: 0.05em;
            white-space: nowrap;
        }
        td {
            padding: 13px 14px;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
        }
        tr:last-child td {
            border-bottom: none;
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
        .badge-publica {
            background-color: #d1fae5;
            color: #065f46;
        }
        .badge-privada {
            background-color: #e0e7ff;
            color: #3730a3;
        }
        .action-links {
            display: flex;
            gap: 6px;
            justify-content: flex-end;
        }
        .link-action {
            text-decoration: none;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.2s;
            white-space: nowrap;
        }
        .link-edit {
            background-color: #ecfdf5;
            color: #059669;
        }
        .link-edit:hover {
            background-color: #d1fae5;
        }
        .link-delete {
            background-color: #fef2f2;
            color: #dc2626;
        }
        .link-delete:hover {
            background-color: #fee2e2;
        }
        .empty-box {
            text-align: center;
            padding: 40px 20px;
            color: #64748b;
        }
        .empty-box p {
            margin-bottom: 16px;
            font-size: 15px;
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
            <div class="card-header-flex">
                <div>
                    <h1>Listado de Universidades</h1>
                    <p>Instituciones de educación superior registradas en el sistema</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/universidad/agregar.jsp" class="btn-top btn-primary">+ Nueva Universidad</a>
                    <a href="${pageContext.request.contextPath}/universidad/reportes.jsp" class="btn-top btn-secondary">Reportes</a>
                    <a href="${pageContext.request.contextPath}/universidad?accion=listartodo" class="btn-top btn-secondary">Actualizar</a>
                </div>
            </div>

            <%
                Universidad[] listado = (Universidad[]) session.getAttribute("universidad.listar");
                if (listado == null) {
            %>
                <div class="empty-box">
                    <p>No se ha cargado el listado actualmente.</p>
                    <form action="${pageContext.request.contextPath}/universidad" method="post">
                        <input type="hidden" name="accion" value="listartodo">
                        <button type="submit" class="btn-top btn-primary">Cargar Universidades</button>
                    </form>
                </div>
            <%
                } else if (listado.length == 0) {
            %>
                <div class="empty-box">
                    <p>No existen universidades registradas en la base de datos.</p>
                    <a href="${pageContext.request.contextPath}/universidad/agregar.jsp" class="btn-top btn-primary">Registrar Primera Universidad</a>
                </div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Categoría</th>
                                <th>Ciudad</th>
                                <th>Rector</th>
                                <th>Carreras</th>
                                <th>Sedes</th>
                                <th>Web</th>
                                <th style="text-align: right;">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Universidad u : listado) {
                                    String badgeClass = "Pública".equalsIgnoreCase(u.getCategoria()) ? "badge-publica" : "badge-privada";
                            %>
                            <tr>
                                <td><strong><%= u.getId() %></strong></td>
                                <td><strong><%= u.getNombre() %></strong></td>
                                <td><span class="badge <%= badgeClass %>"><%= u.getCategoria() %></span></td>
                                <td><%= u.getCiudad() %></td>
                                <td><%= u.getRector() %></td>
                                <td style="text-align: center;"><%= u.getNumeroCarreras() %></td>
                                <td style="text-align: center;"><%= u.getNumSedes() %></td>
                                <td>
                                    <% if (u.getWeb() != null && !u.getWeb().isEmpty()) { %>
                                        <a href="<%= u.getWeb() %>" target="_blank" style="color: #059669; text-decoration: none;">Visitar ↗</a>
                                    <% } else { %>
                                        -
                                    <% } %>
                                </td>
                                <td>
                                    <div class="action-links">
                                        <a href="${pageContext.request.contextPath}/universidad?accion=buscar&id=<%= u.getId() %>&redirecion=modificar" class="link-action link-edit">Modificar</a>
                                        <a href="${pageContext.request.contextPath}/universidad?accion=buscar&id=<%= u.getId() %>&redirecion=borrar" class="link-action link-delete">Eliminar</a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            <%
                }
            %>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/universidad/buscar.jsp">Buscar Universidad</a> |
                <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a>
            </div>
        </div>
    </div>
</body>
</html>
