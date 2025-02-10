package model;

import java.util.Date;

public class Flights {

    private int FlightId;
    private Date ArrivalTime;
    private Date DepartureTime;
    private int ArrivalAirportId;
    private int DepartureAirportId;
    private String Status;
    private int AirlineId;
    private double ClassVipPrice;
    private double ClassEconomyPrice;

    public Flights(int flightId, Date arrivalTime, Date departureTime, int arrivalAirportId, int departureAirportId, String status, int airlineId, double classVipPrice, double classEconomyPrice) {
        this.FlightId = flightId;
        this.ArrivalTime = arrivalTime;
        this.DepartureTime = departureTime;
        this.ArrivalAirportId = arrivalAirportId;
        this.DepartureAirportId = departureAirportId;
        this.Status = status;
        this.AirlineId = airlineId;
        this.ClassVipPrice = classVipPrice;
        this.ClassEconomyPrice = classEconomyPrice;
    }

    public Flights() {
    }

    public int getFlightId() {
        return FlightId;
    }

    public void setFlightId(int flightId) {
        FlightId = flightId;
    }

    public Date getArrivalTime() {
        return ArrivalTime;
    }

    public void setArrivalTime(Date arrivalTime) {
        ArrivalTime = arrivalTime;
    }

    public Date getDepartureTime() {
        return DepartureTime;
    }

    public void setDepartureTime(Date departureTime) {
        DepartureTime = departureTime;
    }

    public int getArrivalAirportId() {
        return ArrivalAirportId;
    }

    public void setArrivalAirportId(int arrivalAirportId) {
        ArrivalAirportId = arrivalAirportId;
    }

    public int getDepartureAirportId() {
        return DepartureAirportId;
    }

    public void setDepartureAirportId(int departureAirportId) {
        DepartureAirportId = departureAirportId;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public int getAirlineId() {
        return AirlineId;
    }

    public void setAirlineId(int airlineId) {
        AirlineId = airlineId;
    }

    public double getClassVipPrice() {
        return ClassVipPrice;
    }

    public void setClassVipPrice(double classVipPrice) {
        ClassVipPrice = classVipPrice;
    }

    public double getClassEconomyPrice() {
        return ClassEconomyPrice;
    }

    public void setClassEconomyPrice(double classEconomyPrice) {
        ClassEconomyPrice = classEconomyPrice;
    }

    @Override
    public String toString() {
        return "Flights{" +
                "FlightId=" + FlightId +
                ", ArrivalTime=" + ArrivalTime +
                ", DepartureTime=" + DepartureTime +
                ", ArrivalAirportId=" + ArrivalAirportId +
                ", DepartureAirportId=" + DepartureAirportId +
                ", Status='" + Status + '\'' +
                ", AirlineId=" + AirlineId +
                ", ClassVipPrice=" + ClassVipPrice +
                ", ClassEconomyPrice=" + ClassEconomyPrice +
                '}';
    }
}