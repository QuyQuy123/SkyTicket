package model;

public class Countries {
    private int countryId;
    private String countryName;
    private int status;


    public Countries() {
    }

    public Countries(int countryId, int status, String countryName) {
        this.countryId = countryId;
        this.status = status;
        this.countryName = countryName;
    }

    public Countries(int countryId, String countryName) {
        this.countryId = countryId;
        this.countryName = countryName;
    }

    public int getCountryId() {
        return countryId;
    }

    public void setCountryId(int countryId) {
        this.countryId = countryId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    @Override
    public String toString() {
        return "Countries{" +
                "countryid=" + countryId +
                ", countryname='" + countryName + '\'' +
                ", status=" + status +
                '}';
    }
}
