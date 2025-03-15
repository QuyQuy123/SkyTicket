package model;

import java.util.Date;

public class Bookings {
    private int bookingID;
    private String code;
    private String contactName;
    private String contactPhone;
    private String contactEmail;
    private double totalPrice;
    private Date bookingDate;
    private String status;
    private int accountID;

    public Bookings() {
    }

    public Bookings(int bookingID, String code, String contactName, String contactPhone, String contactEmail, double totalPrice, Date bookingDate, String status, int accountID) {
        this.bookingID = bookingID;
        this.code = code;
        this.contactName = contactName;
        this.contactPhone = contactPhone;
        this.contactEmail = contactEmail;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
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
                ", code='" + code + '\'' +
                ", contactName='" + contactName + '\'' +
                ", contactPhone='" + contactPhone + '\'' +
                ", contactEmail='" + contactEmail + '\'' +
                ", totalPrice=" + totalPrice +
                ", bookingDate=" + bookingDate +
                ", status='" + status + '\'' +
                ", accountID=" + accountID +
                '}';
    }
}
