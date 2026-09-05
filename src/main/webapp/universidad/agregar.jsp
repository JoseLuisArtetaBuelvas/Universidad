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
    <title>Crear Universidad - Sistema Universidad</title>
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
        .form-group.full-width {
            grid-column: 1 / -1;
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
                <h1>Registrar Nueva Universidad</h1>
                <p>Ingresa la información completa de la institución de educación superior</p>
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
                <input type="hidden" name="accion" value="agregar">

                <div class="form-grid">
                    <div class="form-group">
                        <label for="id">Identificación / ID:</label>
                        <input type="number" id="id" name="id" placeholder="Ej. 101" required>
                    </div>

                    <div class="form-group">
                        <label for="nombre">Nombre de la Universidad:</label>
                        <input type="text" id="nombre" name="nombre" placeholder="Ej. Universidad de Cartagena" required>
                    </div>

                    <div class="form-group">
                        <label for="categoria">Categoría:</label>
                        <select id="categoria" name="categoria" required>
                            <option value="">-- Seleccione una categoría --</option>
                            <option value="Pública">Pública</option>
                            <option value="Privada">Privada</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="ciudad">Ciudad Sede Principal:</label>
                        <input type="text" id="ciudad" name="ciudad" placeholder="Ej. Cartagena" required>
                    </div>

                    <div class="form-group">
                        <label for="rector">Nombre del Rector:</label>
                        <input type="text" id="rector" name="rector" placeholder="Ej. Willian Malkún Castillejo" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Correo Institucional:</label>
                        <input type="email" id="email" name="email" placeholder="contacto@unicartagena.edu.co" required>
                    </div>

                    <div class="form-group">
                        <label for="telefono">Teléfono de Contacto:</label>
                        <input type="text" id="telefono" name="telefono" placeholder="Ej. (605) 6698177" required>
                    </div>

                    <div class="form-group">
                        <label for="web">Sitio Web Oficial:</label>
                        <input type="url" id="web" name="web" placeholder="https://www.unicartagena.edu.co" required>
                    </div>

                    <div class="form-group">
                        <label for="acceso">Modalidad de Acceso / Admisión:</label>
                        <select id="acceso" name="acceso" required>
                            <option value="">-- Seleccione el tipo de acceso --</option>
                            <option value="Examen de Admisión">Examen de Admisión</option>
                            <option value="Pruebas Saber 11 / ICFES">Pruebas Saber 11 / ICFES</option>
                            <option value="Ingreso Directo">Ingreso Directo</option>
                            <option value="Mixto">Mixto</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="numeroCarreras">Número de Carreras / Programas:</label>
                        <input type="number" id="numeroCarreras" name="numeroCarreras" min="1" placeholder="Ej. 45" required>
                    </div>

                    <div class="form-group">
                        <label for="numSedes">Número de Sedes:</label>
                        <input type="number" id="numSedes" name="numSedes" min="1" placeholder="Ej. 5" required>
                    </div>
                </div>

                <button type="submit" class="btn-submit">Registrar Universidad</button>
            </form>

            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/universidad?accion=listartodo">Ver Listado de Universidades</a> |
                <a href="${pageContext.request.contextPath}/universidad/reportes.jsp">Reportes Parametrizados</a>
            </div>
        </div>
    </div>
</body>
</html>
