package model;

import jakarta.servlet.http.HttpServlet;

public class Airports  {

    private String airportId;
    private String airportName;
    private String location;
    private boolean status;
    private String country;

    public Airports() {

    }

    // Alt + Ins

    public Airports(String airportId, String airportName, String location, boolean status, String country) {
        this.airportId = airportId;
        this.airportName = airportName;
        this.location = location;
        this.status = status;
        this.country = country;
    }

    public String getAirportId() {
        return airportId;
    }

    public void setAirportId(String airportId) {
        this.airportId = airportId;
    }

    public String getAirportName() {
        return airportName;
    }

    public void setAirportName(String airportName) {
        this.airportName = airportName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Override
    public String toString() {
        return "Airports{" +
                "airportId='" + airportId + '\'' +
                ", airportName='" + airportName + '\'' +
                ", location='" + location + '\'' +
                ", status=" + status +
                ", country='" + country + '\'' +
                '}';
    }
}


