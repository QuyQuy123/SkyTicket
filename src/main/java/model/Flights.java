package model;


import java.sql.Timestamp;

public class Flights {

    private int FlightId;
    private Timestamp ArrivalTime;
    private Timestamp DepartureTime;
    private int ArrivalAirportId;
    private int DepartureAirportId;
    private String Status;
    private int AirlineId;
    private double ClassVipPrice;
    private double ClassEconomyPrice;

    public Flights() {
    }

    public Flights(int flightId, Timestamp arrivalTime, Timestamp departureTime, int arrivalAirportId, int departureAirportId, String status, int airlineId, double classVipPrice, double classEconomyPrice) {
        FlightId = flightId;
        ArrivalTime = arrivalTime;
        DepartureTime = departureTime;
        ArrivalAirportId = arrivalAirportId;
        DepartureAirportId = departureAirportId;
        Status = status;
        AirlineId = airlineId;
        ClassVipPrice = classVipPrice;
        ClassEconomyPrice = classEconomyPrice;
    }

    public int getFlightId() {
        return FlightId;
    }

    public void setFlightId(int flightId) {
        FlightId = flightId;
    }

    public Timestamp getArrivalTime() {
        return ArrivalTime;
    }

    public void setArrivalTime(Timestamp arrivalTime) {
        ArrivalTime = arrivalTime;
    }

    public Timestamp getDepartureTime() {
        return DepartureTime;
    }

    public void setDepartureTime(Timestamp departureTime) {
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