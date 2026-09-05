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
    <title>Reportes Parametrizados - Sistema Universidad</title>
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
            color: #065f46;
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
            border-color: #059669;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }
        .btn-report {
            width: 100%;
            background-color: #059669;
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
            background-color: #047857;
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
            background-color: #ecfdf5;
            color: #065f46;
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
                <h1>Reportes Parametrizados de Universidades</h1>
                <p>Genera consultas con filtros específicos de negocio sobre las instituciones</p>
            </div>

            <div class="reports-grid">
                <!-- Reporte 1: Filtrar por Ciudad -->
                <div class="report-box">
                    <h3>Reporte N.º 1: Por Ciudad</h3>
                    <p>Muestra las universidades cuya sede principal se ubica en una ciudad específica.</p>

                    <form action="${pageContext.request.contextPath}/universidad" method="post">
                        <input type="hidden" name="accion" value="reporteciudad">

                        <div class="form-group">
                            <label for="ciudad">Ciudad a Consultar:</label>
                            <input type="text" id="ciudad" name="ciudad" placeholder="Ej. Cartagena, Bogotá, Medellín..." required>
                        </div>

                        <button type="submit" class="btn-report">Generar Reporte por Ciudad</button>
                    </form>
                </div>

                <!-- Reporte 2: Filtrar por Categoría y Mínimo de Carreras -->
                <div class="report-box">
                    <h3>Reporte N.º 2: Categoría y Mínimo de Carreras</h3>
                    <p>Filtra universidades por su carácter público/privado con una cantidad mínima de programas.</p>

                    <form action="${pageContext.request.contextPath}/universidad" method="post">
                        <input type="hidden" name="accion" value="reportecategoria">

                        <div class="form-group">
                            <label for="categoria">Categoría:</label>
                            <select id="categoria" name="categoria" required>
                                <option value="Pública">Pública</option>
                                <option value="Privada">Privada</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="minCarreras">Número Mínimo de Carreras:</label>
                            <input type="number" id="minCarreras" name="minCarreras" min="1" placeholder="Ej. 10" required>
                        </div>

                        <button type="submit" class="btn-report">Generar Reporte por Categoría</button>
                    </form>
                </div>
            </div>

            <%
                Universidad[] reporte = (Universidad[]) session.getAttribute("universidad.reporte");
                String tituloReporte = (String) session.getAttribute("universidad.reporte_titulo");
                if (reporte != null) {
            %>
                <div class="results-section">
                    <div class="results-header">
                        <h2><%= tituloReporte != null ? tituloReporte : "Resultados de la Consulta" %></h2>
                        <span class="results-badge"><%= reporte.length %> <%= reporte.length == 1 ? "institución encontrada" : "instituciones encontradas" %></span>
                    </div>

                    <% if (reporte.length == 0) { %>
                        <p style="color: #64748b; padding: 20px; text-align: center; background: #f8fafc; border-radius: 8px;">
                            No se encontraron universidades que cumplan con los parámetros seleccionados.
                        </p>
                    <% } else { %>
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
                                        <th>Contacto</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Universidad u : reporte) { %>
                                    <tr>
                                        <td><strong><%= u.getId() %></strong></td>
                                        <td><strong><%= u.getNombre() %></strong></td>
                                        <td><%= u.getCategoria() %></td>
                                        <td><%= u.getCiudad() %></td>
                                        <td><%= u.getRector() %></td>
                                        <td style="text-align: center;"><%= u.getNumeroCarreras() %></td>
                                        <td style="text-align: center;"><%= u.getNumSedes() %></td>
                                        <td><%= u.getEmail() %></td>
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
                <a href="${pageContext.request.contextPath}/universidad?accion=listartodo">Listado General</a> |
                <a href="${pageContext.request.contextPath}/index.jsp">Volver al Inicio</a>
            </div>
        </div>
    </div>
</body>
</html>
