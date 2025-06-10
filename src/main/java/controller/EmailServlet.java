/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;


import java.util.Date;
import java.util.List;
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
import model.*;

public class EmailServlet {
    SeatsDAO sd = new SeatsDAO();
    TicketsDAO td = new TicketsDAO();
    FlightsDAO fd = new FlightsDAO();
    LocationsDAO ld = new LocationsDAO();


    final String from = "skyticket.work@gmail.com";
    final String passWord = "gnwb uglr iyda idhi";

    public void sendBookingEmail(String to, Bookings b) {
        new Thread(() -> {
            sendEmail(to, b);
        }).start();
    }

    private void sendEmail(String to, Bookings b) {
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
    /*
        Session session = Session.getInstance(pro, authen);
        try {
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/HTML");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("The Order Has Been Successfully Submitted", "UTF-8");
            msg.setSentDate(new Date());
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
                            + "<a href='https://ve247vn.com/bookingFlightTicketsURL' style='background-color: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;'>Make Payment Now</a>"
                            + "</div>"
                            + "<p style='font-size: 12px; color: #777; text-align: center; margin-top: 20px;'>"
                            + "If you have any questions, please contact our support team."
                            + "</p>"
                            + "</div>",
                    "text/html"
            );
            Transport.send(msg);
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }

     */
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
            msg.setText("Mã OTP của bạn là: " + otp + "\nMã này có hiệu lực trong vòng 5 phút.", "UTF-8");
            Transport.send(msg);
            System.out.println("Email OTP đã được gửi thành công!");
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }

    }

    /*
    public void sendPaymentSuccessfulbyEmail(String to, Bookings b) {

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
            msg.setSubject("Payment Successful Notification", "UTF-8");
            msg.setSentDate(new Date());

            StringBuilder content = new StringBuilder();
            content.append("The customer: <b>" + b.getContactName() + "</b><br>"
                    + "Your code order is: " + b.getCode() + "<br>"
                    + "You have paid successfully total price of flight is: " + b.getTotalPrice() + " VND<br>"
                    + "Payment time: " + b.getBookingDate() + "<br>");

            List<Tickets> ticket = td.getAllTicketSuccessfulPaymentByBookingId(b.getBookingID());
            for (Tickets t : ticket) {
                Seats s = sd.getSeatById(t.getSeatId());
                Flights f = fd.getFlightById(t.getFlightId());
                Locations dep = ld.getLocationById(f.getDepartureAirportId());
                Locations des = ld.getLocationById(f.getArrivalAirportId());
                long flightTimeMillis = f.getArrivalTime().getTime() - f.getDepartureTime().getTime();
                long flightTimeMinutes = flightTimeMillis / (1000 * 60);

                content.append("<br> Ticket has seat type: <b>" + s.getSeatClass() + "</b><br>"
                        + "Your position on the flight is: " + t.getCode() + "<br>"
                        + "Flight date: " + f.getDepartureTime() + "<br>"
                        + "The flight time is: " + flightTimeMinutes + " minutes<br>"
                        + "The flight departs from " + dep.getLocationName() + " to destination " + des.getLocationName() + "<br>");
            }

            content.append("Please check in for your flight on time.");
            msg.setContent(content.toString(), "text/html; charset=UTF-8");
            Transport.send(msg);

        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
    }
*/
}