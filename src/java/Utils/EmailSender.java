/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.ResourceBundle;

/**
 *
 * @author Hung
 */
public class EmailSender {

    static ResourceBundle bundle = ResourceBundle.getBundle("Config.EmailService");

    public static boolean sendEmail(String toEmail, String subject, String content) {
        boolean send = false;

        String fromEmail = bundle.getString("account");
        String password = bundle.getString("password");
        String toEmmail = toEmail;
        Properties pr = new Properties();
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");

        //get Session
        Session session = Session.getInstance(pr, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }

        });

        try {
            Message mess = new MimeMessage(session);
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmmail));
            mess.setSubject(subject);
            mess.setText(content);
            Transport.send(mess);
            send = true;
        } catch (MessagingException e) {
            System.err.println(e.getMessage());
        }
        return send;
    }

    public static void main(String[] args) {
        EmailSender.sendEmail("hungtthe161889@fpt.edu.vn", "test", "test");
    }
}
