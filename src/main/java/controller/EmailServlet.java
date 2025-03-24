/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;


import java.util.Date;
import java.util.Properties;
import java.util.Random;

import dal.FlightsDAO;
import dal.LocationsDAO;
import dal.SeatsDAO;
import dal.TicketsDAO;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import model.Bookings;

public class EmailServlet {
    SeatsDAO seatsDAO = new SeatsDAO();
    TicketsDAO ticketsDAO = new TicketsDAO();
    FlightsDAO flightsDAO = new FlightsDAO();
    LocationsDAO locationsDAO = new LocationsDAO();


    final String from = "skyticket.work@gmail.com";
    final String passWord = "hzxd bxzv pmsm grut";

    public void sendBookingEmail(String to, Bookings b) {
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
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //The subject of email
            msg.setSubject("The Order Has Been Successfully Submitted", "UTF-8");
            //date
            msg.setSentDate(new Date());

            //msg.setReplyTo(InternetAddress.parse(from, false));

            //content
            msg.setContent(
                    "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;'>"
                            + "<h2 style='color: #007bff; text-align: center;'>Booking Confirmation</h2>"
                            + "<p><strong>Customer:</strong> <span style='color: #333;'>" + b.getContactName() + "</span></p>"
                            + "<p><strong>Order Code:</strong> <span style='color: #333; font-weight: bold;'>" + b.getCode() + "</span></p>"
                            + "<p><strong>Total Cost:</strong> <span style='color: #28a745; font-size: 18px; font-weight: bold;'>" + b.getTotalPrice() + " USD</span></p>"
                            + "<p style='margin-top: 20px;'>"
                            + "Please make the payment at least <strong>10 days</strong> before your flight to secure your booking."
                            + "</p>"
                            + "<div style='text-align: center; margin-top: 30px;'>"
                            + "<a href='https://yourwebsite.com/payment' style='background-color: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;'>Make Payment Now</a>"
                            + "</div>"
                            + "<p style='font-size: 12px; color: #777; text-align: center; margin-top: 20px;'>"
                            + "If you have any questions, please contact our support team."
                            + "</p>"
                            + "</div>",
                    "text/html"
            );


            //send email
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }

    public String generateOTP(int length) {
        StringBuilder otp = new StringBuilder();
        Random rand = new Random();
        for (int i = 0; i < length; i++) {
            otp.append(rand.nextInt(10));
        }
        return otp.toString();
    }

    public void sendOTPEmail(String to, String otp) {
        if (to == null || to.isEmpty()) {
            throw new IllegalArgumentException("Email người nhận không thể là null hoặc rỗng.");
        }
        if (otp == null || otp.isEmpty()) {
            throw new IllegalArgumentException("OTP không thể là null hoặc rỗng.");
        }
        if (from == null || from.isEmpty()) {
            throw new IllegalArgumentException("Email người gửi không thể là null hoặc rỗng.");
        }
        if (passWord == null || passWord.isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không thể là null hoặc rỗng.");
        }

        Properties pro = new Properties();
        pro.put("mail.smtp.host", "smtp.gmail.com");
        pro.put("mail.smtp.port", "587");
        pro.put("mail.smtp.auth", "true");
        pro.put("mail.smtp.starttls.enable", "true");

        Authenticator authen = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passWord);
            }
        };

        Session session = Session.getInstance(pro, authen);

        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Mã OTP Xác Thực Của Bạn", "UTF-8");
            msg.setSentDate(new Date());

            // Nội dung email bao gồm mã OTP
            msg.setText("Mã OTP của bạn là: " + otp + "\nMã này có hiệu lực trong vòng 5 phút.", "UTF-8");

            Transport.send(msg);
            System.out.println("Email OTP đã được gửi thành công!");
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }


    public static void main(String[] args) {
            EmailServlet em = new EmailServlet();
            em.sendOTPEmail("quyhslc11@gmail.com", "123456");

    }
}