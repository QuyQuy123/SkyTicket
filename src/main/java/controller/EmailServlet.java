/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;


import java.util.Date;
import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailServlet {


    final String from = "skyticket.work@gmail.com";
    final String passWord = "hzxd bxzv pmsm grut";

    public void sendPasswordEmail(String to, String newPassword) {
        //Properties: khai bao cac thuoc tinh
        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        //port tls 587
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        //create Authenticator
        Authenticator authen = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passWord);
            }
        };

        //sesion
        Session session = Session.getInstance(pro, authen);

        //send email
        //final String to = "chunloveptht@gmail.com";
        //create to message email
        MimeMessage msg = new MimeMessage(session);
        try {
            //content style
            msg.addHeader("Content-type", "text/HTML");
            //the person send and receiver:
            msg.setFrom();
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //The subject of email
            msg.setSubject("Khôi Phục Lại Mật Khẩu Của Bạn", "UTF-8");
            //date
            msg.setSentDate(new Date());
            //quy dinh email phan hoi
            //msg.setReplyTo(InternetAddress.parse(from, false));

            //content
            msg.setText("Mật Khẩu Mới của bạn là: " + newPassword, "UTF-8");

            //send email
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }


    public static void main(String[] args) {
            EmailServlet em = new EmailServlet();
            em.sendPasswordEmail("quynvhe186703@fpt.edu.vn", "123456");

    }
}