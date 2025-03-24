package model;

import java.sql.Timestamp;

public class PaymenTs {
    private int paymen_id;
    private int booking_id;
    private String paymen_method;
    private int paymentStatus;
    private Timestamp paymen_date;
    private String email;
    private double totalPrice;


    public PaymenTs(int paymen_id, int booking_id, String paymen_method, int paymentStatus, Timestamp paymen_date, String email, double totalPrice) {
        this.paymen_id = paymen_id;
        this.booking_id = booking_id;
        this.paymen_method = paymen_method;
        this.paymentStatus = paymentStatus;
        this.paymen_date = paymen_date;
        this.email = email;
        this.totalPrice = totalPrice;
    }

    public int getPaymen_id() {
        return paymen_id;
    }

    public void setPaymen_id(int paymen_id) {
        this.paymen_id = paymen_id;
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public String getPaymen_method() {
        return paymen_method;
    }

    public void setPaymen_method(String paymen_method) {
        this.paymen_method = paymen_method;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getPaymen_date() {
        return paymen_date;
    }

    public void setPaymen_date(Timestamp paymen_date) {
        this.paymen_date = paymen_date;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "PaymenTs{" +
                "paymen_id=" + paymen_id +
                ", booking_id=" + booking_id +
                ", paymen_method='" + paymen_method + '\'' +
                ", paymentStatus=" + paymentStatus +
                ", paymen_date=" + paymen_date +
                ", email='" + email + '\'' +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
