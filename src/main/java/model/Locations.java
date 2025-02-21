package model;

public class Locations {
    private int locationId;
    private String locationName;
    private int countryId;
    private int status;
    private Countries country;


    public Locations() {
    }

    public Locations(String locationName, int countryId, int status) {
        this.locationName = locationName;
        this.countryId = countryId;
        this.status = status;
    }

    public Locations(int locationId, String locationName, String countryName, int status) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.status = status;
    }

    public Locations(int locationId, String locationName, int countryId, int status) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.countryId = countryId;
        this.status = status;
    }

    public Locations(int locationId, String locationName, Countries country, int status) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.country = country;
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

    public Countries getCountry() {
        return country;
    }

    public void setCountry(Countries country) {
        this.country = country;
    }

    // Lấy tên quốc gia từ đối tượng Countries
    public String getCountryName() {
        return country != null ? country.getCountryName() : "Unknown";
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
