<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Sistema Universidad</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: #1e293b;
        }
        .login-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.2), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            padding: 40px 32px;
        }
        .header {
            text-align: center;
            margin-bottom: 28px;
        }
        .header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #1e3a8a;
            margin-bottom: 6px;
        }
        .header p {
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
        .form-group input {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.2s, box-shadow 0.2s;
            background-color: #f8fafc;
        }
        .form-group input:focus {
            outline: none;
            border-color: #2563eb;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .btn-submit {
            width: 100%;
            background-color: #1d4ed8;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            margin-top: 8px;
        }
        .btn-submit:hover {
            background-color: #1e40af;
        }
        .btn-submit:active {
            transform: scale(0.99);
        }
        .footer-links {
            text-align: center;
            margin-top: 24px;
            padding-top: 16px;
            border-top: 1px solid #e2e8f0;
        }
        .footer-links a {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s;
        }
        .footer-links a:hover {
            color: #1d4ed8;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="header">
            <h1>Sistema Universidad</h1>
            <p>Ingresa tus credenciales para acceder</p>
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
            <input type="hidden" name="accion" value="login">

            <div class="form-group">
                <label for="id">Identificación / ID:</label>
                <input type="number" id="id" name="id" placeholder="Ej. 12345678" required>
            </div>

            <div class="form-group">
                <label for="clave">Contraseña:</label>
                <input type="password" id="clave" name="clave" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-submit">Iniciar Sesión</button>

            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/usuario/recuperar-contrasena.jsp">¿Olvidaste tu contraseña?</a>
            </div>
        </form>
    </div>
</body>
</html>