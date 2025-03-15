package model;

import java.util.Date;

public class Payments {
    private int paymentID;
    private int bookingID;
    private String PaymentMethod;
    private String PaymentStatus;
    private Date PaymentDate;
    private double TotalPrice;

    public Payments() {
    }

    public Payments(int paymentID, String paymentMethod, String paymentStatus, Date paymentDate, double totalPrice) {
        this.paymentID = paymentID;
        this.PaymentMethod = paymentMethod;
        this.PaymentStatus = paymentStatus;
        this.PaymentDate = paymentDate;
        this.TotalPrice = totalPrice;
    }

    public Payments(int paymentID, int bookingID, String paymentMethod, String paymentStatus, Date paymentDate, double totalPrice) {
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

    public String getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        PaymentStatus = paymentStatus;
    }

    public Date getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
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
