package model;


import java.sql.Timestamp;

public class Flights {

    private int flightId;
    private Timestamp arrivalTime;
    private Timestamp departureTime;
    private int arrivalAirportId;
    private int departureAirportId;
    private int status;
    private int airlineId;
    private double classVipPrice;
    private double classEconomyPrice;

    public Flights() {
    }

    public Flights(int flightId, Timestamp arrivalTime, Timestamp departureTime, int arrivalAirportId, int departureAirportId, int status, int airlineId, double classVipPrice, double classEconomyPrice) {
        this.flightId = flightId;
        this.arrivalTime = arrivalTime;
        this.departureTime = departureTime;
        this.departureAirportId = departureAirportId;
        this.arrivalAirportId = arrivalAirportId;
        this.status = status;
        this.airlineId = airlineId;
        this.classVipPrice = classVipPrice;
        this.classEconomyPrice = classEconomyPrice;
    }

    public Flights(Timestamp arrivalTime, Timestamp departureTime, int arrivalAirportId, int departureAirportId, int status, int airlineId, double classVipPrice, double classEconomyPrice) {
        this.arrivalTime = arrivalTime;
        this.departureTime = departureTime;
        this.arrivalAirportId = arrivalAirportId;
        this.departureAirportId = departureAirportId;
        this.status = status;
        this.airlineId = airlineId;
        this.classVipPrice = classVipPrice;
        this.classEconomyPrice = classEconomyPrice;
    }

    public int getFlightId() {
        return flightId;
    }

    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }

    public double getClassVipPrice() {
        return classVipPrice;
    }

    public void setClassVipPrice(double classVipPrice) {
        this.classVipPrice = classVipPrice;
    }

    public double getClassEconomyPrice() {
        return classEconomyPrice;
    }

    public void setClassEconomyPrice(double classEconomyPrice) {
        this.classEconomyPrice = classEconomyPrice;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getDepartureAirportId() {
        return departureAirportId;
    }

    public void setDepartureAirportId(int departureAirportId) {
        this.departureAirportId = departureAirportId;
    }

    public int getArrivalAirportId() {
        return arrivalAirportId;
    }

    public void setArrivalAirportId(int arrivalAirportId) {
        this.arrivalAirportId = arrivalAirportId;
    }

    public Timestamp getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Timestamp departureTime) {
        this.departureTime = departureTime;
    }

    public Timestamp getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Timestamp arrivalTime) {
        this.arrivalTime = arrivalTime;
    }
}