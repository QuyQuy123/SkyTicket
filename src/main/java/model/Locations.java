package model;

public class Locations {
    private int locationId;
    private String locationName;
    private int countryId;
    private int status;


    public Locations() {
    }

    public Locations(int locationId, int status, int countryId, String locationName) {
        this.locationId = locationId;
        this.status = status;
        this.countryId = countryId;
        this.locationName = locationName;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCountryId() {
        return countryId;
    }

    public void setCountryId(int countryId) {
        this.countryId = countryId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }






}
