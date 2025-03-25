package model;

import java.sql.Timestamp;
import java.util.Date;

public class Payments {
    private int paymentID;
    private int bookingID;
    private String PaymentMethod;
    private int PaymentStatus;
    private Timestamp PaymentDate;
    private double TotalPrice;

    public Payments() {
    }

    public Payments(int paymentID, String paymentMethod, int paymentStatus, Timestamp paymentDate, double totalPrice) {
        this.paymentID = paymentID;
        this.PaymentMethod = paymentMethod;
        this.PaymentStatus = paymentStatus;
        this.PaymentDate = paymentDate;
        this.TotalPrice = totalPrice;
    }

    public Payments(int paymentID, int bookingID, String paymentMethod, int paymentStatus, Timestamp paymentDate, double totalPrice) {
        this.paymentID = paymentID;
        this.bookingID = bookingID;
        this.PaymentMethod = paymentMethod;
        this.PaymentStatus = paymentStatus;
        this.PaymentDate = paymentDate;
        this.TotalPrice = totalPrice;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public String getPaymentMethod() {
        return PaymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        PaymentMethod = paymentMethod;
    }

    public int getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        PaymentStatus = paymentStatus;
    }

    public Timestamp getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        PaymentDate = paymentDate;
    }

    public double getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        TotalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "Payments{" +
                "paymentID=" + paymentID +
                ", bookingID=" + bookingID +
                ", PaymentMethod='" + PaymentMethod + '\'' +
                ", PaymentStatus='" + PaymentStatus + '\'' +
                ", PaymentDate=" + PaymentDate +
                ", TotalPrice=" + TotalPrice +
                '}';
    }
}
