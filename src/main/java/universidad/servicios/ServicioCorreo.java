package universidad.servicios;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class ServicioCorreo {

    private static final String REMITENTE = "josex.developer@gmail.com";
    private static final String  CLAVE_APLICACION = "yyss bqhm knnv cdrg";

    public static void enviarCorreo(String destinatario, String asunto, String mensaje) throws MessagingException {
        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.auth", "true");
        propiedades.put("mail.smtp.starttls.enable", "true");
        propiedades.put("mail.smtp.host", "smtp.gmail.com");
        propiedades.put("mail.smtp.port", "587");

        Session session = Session.getInstance(propiedades, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(REMITENTE, CLAVE_APLICACION);
            }
        });

        Message mensajeCorreo = new MimeMessage(session);
        mensajeCorreo.setFrom(new InternetAddress(REMITENTE));
        mensajeCorreo.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensajeCorreo.setSubject(asunto);
        mensajeCorreo.setText(mensaje);

        Transport.send(mensajeCorreo);
    }
}