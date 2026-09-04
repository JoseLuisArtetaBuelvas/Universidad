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
    <title>Modificar Usuario - Sistema Universidad</title>
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
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            background-color: #f8fafc;
            color: #1e293b;
            transition: all 0.2s;
        }
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #2563eb;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .form-group input[readonly] {
            background-color: #e2e8f0;
            color: #64748b;
            cursor: not-allowed;
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
        .btn-submit {
            width: 100%;
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #1d4ed8;
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
                <h1>Modificar Usuario</h1>
                <p><%= usuarioModificar == null ? "Busca el usuario que deseas actualizar" : "Edita los datos del usuario seleccionado" %></p>
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
                if (usuarioModificar == null) {
            %>
                <form action="${pageContext.request.contextPath}/usuario" method="post">
                    <input type="hidden" name="accion" value="buscar">
                    <input type="hidden" name="redirecion" value="modificar">

                    <div class="search-group">
                        <input type="number" id="id" name="id" placeholder="ID / Identificación a modificar..." required>
                        <button type="submit" class="btn-search">Buscar</button>
                    </div>
                </form>
            <%
                } else {
            %>
                <form action="${pageContext.request.contextPath}/usuario" method="post">
                    <input type="hidden" name="accion" value="modificar">

                    <div class="form-group">
                        <label for="id">Identificación / ID (no editable):</label>
                        <input type="number" id="id" name="id" value="<%= usuarioModificar.getId() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="clave">Nueva Contraseña / Clave:</label>
                        <input type="password" id="clave" name="clave" value="<%= usuarioModificar.getClave() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="nombre">Nombre Completo:</label>
                        <input type="text" id="nombre" name="nombre" value="<%= usuarioModificar.getNombre() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="rol">Rol del Sistema:</label>
                        <select id="rol" name="rol" required>
                            <option value="Administrador" <%= "Administrador".equals(usuarioModificar.getRol()) ? "selected" : "" %>>Administrador</option>
                            <option value="Docente" <%= "Docente".equals(usuarioModificar.getRol()) ? "selected" : "" %>>Docente</option>
                            <option value="Estudiante" <%= "Estudiante".equals(usuarioModificar.getRol()) ? "selected" : "" %>>Estudiante</option>
                        </select>
                    </div>

                    <button type="submit" class="btn-submit">Guardar Cambios</button>
                    <a href="${pageContext.request.contextPath}/usuario/modificar.jsp" class="btn-cancel">Buscar otro usuario</a>
                </form>
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
