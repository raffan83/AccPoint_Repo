package it.portaleSTI.bo;

import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;

import java.util.Properties;

public class EmailWithCalendarInvite {
    public static void main(String[] args) throws Exception {
        // Configurazione SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtps.aruba.it");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("https.protocols", "TLSv1.2");
        props.put("mail.smtp.starttls.enable", "true");

        // Autenticazione
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("calver@accpoint.it", "bDBH34GM2!");
            }
        });

        // Composizione della mail
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress("calver@accpoint.it"));
       // message.addRecipient(Message.RecipientType.TO, new InternetAddress("segreteria@crescosrl.net"));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress("antonio.dicivita@ncsnetwork.it"));
        message.setSubject("Corso formazione corso XXX");

        // Costruzione del contenuto ICS (con \r\n)
        StringBuilder sb = new StringBuilder();
        sb.append("BEGIN:VCALENDAR\r\n");
        sb.append("METHOD:REQUEST\r\n");
        sb.append("PRODID:-//CRESCO//FORMAZIONE//IT\r\n");
        sb.append("VERSION:2.0\r\n");
        sb.append("BEGIN:VEVENT\r\n");
        sb.append("UID:meeting-20250924-001@mycalendar.app\r\n");
        sb.append("DTSTAMP:20250924T120000Z\r\n");
        sb.append("DTSTART:20251001T140000Z\r\n");
        sb.append("DTEND:20251001T150000Z\r\n");
        sb.append("SUMMARY:Corso di Formazione -XXXX\r\n");
        sb.append("DESCRIPTION:Formazione Corso pereposto\r\n");
        sb.append("LOCATION:Presenza - Virtuale - Indirizzo\r\n");
        sb.append("ORGANIZER;CN=Raffaele Fantini:mailto:raffaele.fantini@ncsnnetwork.it\r\n");
        sb.append("ATTENDEE;CN=Lisa Lombardozzi;RSVP=TRUE:mailto:lisa.lombardozzi@crescosrl.net\r\n");
        sb.append("END:VEVENT\r\n");
        sb.append("END:VCALENDAR\r\n");

        String icsContent = sb.toString();

        // Parte testuale
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText("Ciao,\necco l'invito alla riunione.\nA presto!", "utf-8");

        // Parte calendario
        MimeBodyPart calendarPart = new MimeBodyPart();
        calendarPart.setDataHandler(new DataHandler(
                new ByteArrayDataSource(icsContent, "text/calendar;method=REQUEST;charset=UTF-8")));
        calendarPart.setHeader("Content-Class", "urn:content-classes:calendarmessage");

        // Multipart/alternative: text + calendar
        Multipart multipart = new MimeMultipart("alternative");
        multipart.addBodyPart(textPart);
        multipart.addBodyPart(calendarPart);

        message.setContent(multipart);

        // Invio
        Transport.send(message);
        System.out.println("Email inviata con invito calendario!");
    }
}