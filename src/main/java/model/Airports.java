package model;

public class Airports {

    private int airportId;
    private String airportName;
    private int locationId;
    private int status;


    public Airports() {

    }

    // Alt + Ins


    public Airports(int airportId, String airportName,int locationId,  int status) {
        this.airportId = airportId;
        this.status = status;
        this.locationId = locationId;
        this.airportName = airportName;
    }

    public Airports(int airportId, String airportName, int locationId) {
        this.airportId = airportId;
        this.airportName = airportName;
        this.locationId = locationId;
    }

    public Airports(String airportName, int locationId, int status) {
        this.airportName = airportName;
        this.locationId = locationId;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Airports{" +
                "airportId=" + airportId +
                ", airportName='" + airportName + '\'' +
                ", locationId=" + locationId +
                ", status=" + status +
                '}';
    }

    public int getAirportId() {
        return airportId;
    }

    public void setAirportId(int airportId) {
        this.airportId = airportId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getAirportName() {
        return airportName;
    }

    public void setAirportName(String airportName) {
        this.airportName = airportName;
    }


}


