package model;

public class Locations {
    private int locationId;
    private String locationName;
    private int countryId;
    private int status;


    public Locations() {
    }

    public Locations(int locationId, String locationName, int countryId, int status) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.countryId = countryId;
        this.status = status;
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

    @Override
    public String toString() {
        return "Locations{" +
                "locationId=" + locationId +
                ", locationName='" + locationName + '\'' +
                ", countryId=" + countryId +
                ", status=" + status +
                '}';
    }
}
