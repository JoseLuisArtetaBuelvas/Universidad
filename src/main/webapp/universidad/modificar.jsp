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
    <title>Modificar Universidad - Sistema Universidad</title>
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
            max-width: 720px;
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
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 18px;
            margin-bottom: 20px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-size: 14px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            background-color: #f8fafc;
            color: #1e293b;
            transition: all 0.2s;
        }
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #059669;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }
        .form-group input[readonly] {
            background-color: #e2e8f0;
            color: #64748b;
            cursor: not-allowed;
        }
        .btn-submit {
            width: 100%;
            background-color: #059669;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 13px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #047857;
        }
        .btn-submit:active {
            transform: scale(0.99);
        }
        .btn-cancel {
            display: block;
            text-align: center;
            margin-top: 14px;
            color: #64748b;
            text-decoration: none;
            font-size: 14px;
        }
        .btn-cancel:hover {
            color: #1e293b;
            text-decoration: underline;
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
                <h1>Modificar Universidad</h1>
                <p>Edita la información de una institución registrada</p>
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
                Universidad uniModificar = (Universidad) session.getAttribute("universidad.buscar");
                if (uniModificar == null) {
            %>
                <form action="${pageContext.request.contextPath}/universidad" method="post">
                    <input type="hidden" name="accion" value="buscar">
                    <input type="hidden" name="redirecion" value="modificar">

                    <div class="search-group">
                        <input type="number" id="id" name="id" placeholder="ID de la universidad a modificar..." required>
                        <button type="submit" class="btn-search">Buscar</button>
                    </div>
                </form>
            <%
                } else {
            %>
                <form action="${pageContext.request.contextPath}/universidad" method="post">
                    <input type="hidden" name="accion" value="modificar">

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="id">Identificación / ID (no editable):</label>
                            <input type="number" id="id" name="id" value="<%= uniModificar.getId() %>" readonly>
                        </div>

                        <div class="form-group">
                            <label for="nombre">Nombre de la Universidad:</label>
                            <input type="text" id="nombre" name="nombre" value="<%= uniModificar.getNombre() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="categoria">Categoría:</label>
                            <select id="categoria" name="categoria" required>
                                <option value="Pública" <%= "Pública".equalsIgnoreCase(uniModificar.getCategoria()) ? "selected" : "" %>>Pública</option>
                                <option value="Privada" <%= "Privada".equalsIgnoreCase(uniModificar.getCategoria()) ? "selected" : "" %>>Privada</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="ciudad">Ciudad Sede Principal:</label>
                            <input type="text" id="ciudad" name="ciudad" value="<%= uniModificar.getCiudad() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="rector">Nombre del Rector:</label>
                            <input type="text" id="rector" name="rector" value="<%= uniModificar.getRector() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Correo Institucional:</label>
                            <input type="email" id="email" name="email" value="<%= uniModificar.getEmail() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="telefono">Teléfono de Contacto:</label>
                            <input type="text" id="telefono" name="telefono" value="<%= uniModificar.getTelefono() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="web">Sitio Web Oficial:</label>
                            <input type="url" id="web" name="web" value="<%= uniModificar.getWeb() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="acceso">Modalidad de Acceso / Admisión:</label>
                            <select id="acceso" name="acceso" required>
                                <option value="Examen de Admisión" <%= "Examen de Admisión".equalsIgnoreCase(uniModificar.getAcceso()) ? "selected" : "" %>>Examen de Admisión</option>
                                <option value="Pruebas Saber 11 / ICFES" <%= "Pruebas Saber 11 / ICFES".equalsIgnoreCase(uniModificar.getAcceso()) ? "selected" : "" %>>Pruebas Saber 11 / ICFES</option>
                                <option value="Ingreso Directo" <%= "Ingreso Directo".equalsIgnoreCase(uniModificar.getAcceso()) ? "selected" : "" %>>Ingreso Directo</option>
                                <option value="Mixto" <%= "Mixto".equalsIgnoreCase(uniModificar.getAcceso()) ? "selected" : "" %>>Mixto</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="numeroCarreras">Número de Carreras / Programas:</label>
                            <input type="number" id="numeroCarreras" name="numeroCarreras" min="1" value="<%= uniModificar.getNumeroCarreras() %>" required>
                        </div>

                        <div class="form-group">
                            <label for="numSedes">Número de Sedes:</label>
                            <input type="number" id="numSedes" name="numSedes" min="1" value="<%= uniModificar.getNumSedes() %>" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">Guardar Cambios</button>
                    <a href="${pageContext.request.contextPath}/universidad/modificar.jsp" class="btn-cancel">Buscar otra universidad</a>
                </form>
            <%
                    session.removeAttribute("universidad.buscar");
                }
            %>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/universidad/buscar.jsp">Buscar Universidad</a> |
                <a href="${pageContext.request.contextPath}/universidad?accion=listartodo">Listar Universidades</a> |
                <a href="${pageContext.request.contextPath}/universidad/reportes.jsp">Reportes Parametrizados</a>
            </div>
        </div>
    </div>
</body>
</html>
