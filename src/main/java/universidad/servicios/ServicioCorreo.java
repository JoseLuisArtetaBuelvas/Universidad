package universidad.servicios;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import universidad.config.EnvConfig;

public class ServicioCorreo {

    public static void enviarCorreo(String destinatario, String asunto, String mensaje) throws MessagingException {
        String remitente = EnvConfig.get("MAIL_USER", "josex.developer@gmail.com");
        String claveAplicacion = EnvConfig.get("MAIL_PASSWORD", "yyss bqhm knnv cdrg");
        String host = EnvConfig.get("MAIL_HOST", "smtp.gmail.com");
        String port = EnvConfig.get("MAIL_PORT", "587");

        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.auth", "true");
        propiedades.put("mail.smtp.starttls.enable", "true");
        propiedades.put("mail.smtp.host", host);
        propiedades.put("mail.smtp.port", port);

        Session session = Session.getInstance(propiedades, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(remitente, claveAplicacion);
            }
        });

        Message mensajeCorreo = new MimeMessage(session);
        mensajeCorreo.setFrom(new InternetAddress(remitente));
        mensajeCorreo.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensajeCorreo.setSubject(asunto);
        mensajeCorreo.setContent(mensaje, "text/html; charset=UTF-8");

        Transport.send(mensajeCorreo);
    }
}