package model;

public class Airlines {
    private int airlineId;
    private String airlineName;
    private String image;
    private String information;
    private int status;
    private int classVipCapacity;
    private int classEconomyCapacity;


    public Airlines() {
    }

    public Airlines(String airlineName, String image, String information, int status, int classVipCapacity, int classEconomyCapacity) {
        this.airlineName = airlineName;
        this.image = image;
        this.information = information;
        this.status = status;
        this.classVipCapacity = classVipCapacity;
        this.classEconomyCapacity = classEconomyCapacity;
    }

    public Airlines(int airlineId, String airlineName, String information, String image, int status, int classVipCapacity, int classEconomyCapacity) {
        this.airlineId = airlineId;
        this.airlineName = airlineName;
        this.information = information;
        this.image = image;
        this.status = status;
        this.classVipCapacity = classVipCapacity;
        this.classEconomyCapacity = classEconomyCapacity;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }

    public String getAirlineName() {
        return airlineName;
    }

    public void setAirlineName(String airlineName) {
        this.airlineName = airlineName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getInformation() {
        return information;
    }

    public void setInformation(String information) {
        this.information = information;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getClassVipCapacity() {
        return classVipCapacity;
    }

    public void setClassVipCapacity(int classVipCapacity) {
        this.classVipCapacity = classVipCapacity;
    }

    public int getClassEconomyCapacity() {
        return classEconomyCapacity;
    }

    public void setClassEconomyCapacity(int classEconomyCapacity) {
        this.classEconomyCapacity = classEconomyCapacity;
    }
}
