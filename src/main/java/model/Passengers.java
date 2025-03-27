package model;

import java.sql.Timestamp;
import java.util.Date;


public class Passengers {
    private int passengerID;
    private String passengerName;
    private String phone;
    private String address;
    private Date dateOfBirth;
    private String gender;
    private int accountID;
    private int bookingId;

    public Passengers() {}

    public Passengers(int passengerID, String passengerName, String phone) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.phone = phone;
    }
    public Passengers(int passengerID, String passengerName, Date dateOfBirth, String gender, int accountID) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.accountID = accountID;
    }

    public Passengers(int passengerID, String passengerName, String phone, String address, Date dateOfBirth, String gender, int accountID) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.phone = phone;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.accountID = accountID;
    }

    public Passengers(int passengerID, String passengerName, String phone, String address, Date dateOfBirth, String gender, int accountID, int bookingId) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.phone = phone;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.accountID = accountID;
        this.bookingId = bookingId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getPassengerID() {
        return passengerID;
    }

    public void setPassengerID(int passengerID) {
        this.passengerID = passengerID;
    }

    public String getPassengerName() {
        return passengerName;
    }

    public void setPassengerName(String passengerName) {
        this.passengerName = passengerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    @Override
    public String toString() {
        return "Passengers{" +
                "passengerID=" + passengerID +
                ", passengerName='" + passengerName + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender=" + gender +
                ", accountID=" + accountID +
                '}';
    }
}