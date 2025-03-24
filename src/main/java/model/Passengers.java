package model;

import java.util.Date;


public class Passengers {
    private int passengerID;
    private String passengerName;
    private String phone;
    private String email;
    private String numberID;
    private String address;
    private Date dateOfBirth;
    private String gender;
    private int accountID;
    private int bookingId;

    public Passengers() {}

    public Passengers(int passengerID, String passengerName, String phone, String email, String numberID) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.phone = phone;
        this.email = email;
        this.numberID = numberID;
    }
    public Passengers(int passengerID, String passengerName, Date dateOfBirth, String gender, int accountID) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.accountID = accountID;
    }

    public Passengers(int passengerID, String passengerName, String phone, String email, String numberID, String address, Date dateOfBirth, String gender, int accountID) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.phone = phone;
        this.email = email;
        this.numberID = numberID;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.accountID = accountID;
    }

    public Passengers(int passengerID, String passengerName, String phone, String email, String numberID, String address, Date dateOfBirth, String gender, int accountID, int bookingId) {
        this.passengerID = passengerID;
        this.passengerName = passengerName;
        this.phone = phone;
        this.email = email;
        this.numberID = numberID;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNumberID() {
        return numberID;
    }

    public void setNumberID(String numberID) {
        this.numberID = numberID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public java.sql.Date getDateOfBirth() {
        return (java.sql.Date) dateOfBirth;
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
                ", email='" + email + '\'' +
                ", numberID='" + numberID + '\'' +
                ", address='" + address + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender=" + gender +
                ", accountID=" + accountID +
                '}';
    }
}