package model;

public class Airlines {
    private int airlineId;
    private String airlineName;
    private String image;
    private String information;
    private int status;
    private int ClassVipCapacity;
    private int ClassEconomyCapacity;


    public Airlines() {
    }

    public Airlines(String airlineName, String image, String information, int status, int classVipCapacity, int classEconomyCapacity) {
        this.airlineName = airlineName;
        this.image = image;
        this.information = information;
        this.status = status;
        ClassVipCapacity = classVipCapacity;
        ClassEconomyCapacity = classEconomyCapacity;
    }


    public Airlines(int airlineId, int classEconomyCapacity, int classVipCapacity, String information, String image, String airlineName, int status) {
        this.airlineId = airlineId;
        ClassEconomyCapacity = classEconomyCapacity;
        ClassVipCapacity = classVipCapacity;
        this.information = information;
        this.image = image;
        this.airlineName = airlineName;
        this.status = status;
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

    public int getClassVipCapacity() {
        return ClassVipCapacity;
    }

    public void setClassVipCapacity(int classVipCapacity) {
        ClassVipCapacity = classVipCapacity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getClassEconomyCapacity() {
        return ClassEconomyCapacity;
    }

    public void setClassEconomyCapacity(int classEconomyCapacity) {
        ClassEconomyCapacity = classEconomyCapacity;
    }
}
