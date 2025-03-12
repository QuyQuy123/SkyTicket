package model;

import java.sql.Timestamp;

public class Bookings {
    private int bookingID;
    private double totalPrice;
    private Timestamp bookingDate;
    private int status;
    private int accountID;


    public Bookings() {
    }


    public Bookings(int bookingID, double totalPrice, Timestamp bookingDate, int status, int accountID) {
        this.bookingID = bookingID;
        this.totalPrice = totalPrice;
        this.bookingDate = bookingDate;
        this.status = status;
        this.accountID = accountID;
    }


    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }


    @Override
    public String toString() {
        return "Bookings{" +
                "bookingID=" + bookingID +
                ", totalPrice=" + totalPrice +
                ", bookingDate=" + bookingDate +
                ", status=" + status +
                ", accountID=" + accountID +
                '}';
    }
}
