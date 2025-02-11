package model;

public class Airlines {
    private int airlineId;
    private String airlineName;
    private String imageName;
    private String imagePath;
    private String information;
    private int status;
    private int ClassVipCapacity;
    private int ClassEconomyCapacity;

    public Airlines() {
    }

    public Airlines(String airlineName, String imageName, String imagePath, String information, int status, int classVipCapacity, int classEconomyCapacity) {
        this.airlineName = airlineName;
        this.imageName = imageName;
        this.imagePath = imagePath;
        this.information = information;
        this.status = status;
        ClassVipCapacity = classVipCapacity;
        ClassEconomyCapacity = classEconomyCapacity;
    }

    public Airlines(int airlineId, String airlineName, String imageName, String imagePath, String information, int status, int classVipCapacity, int classEconomyCapacity) {
        this.airlineId = airlineId;
        this.airlineName = airlineName;
        this.imageName = imageName;
        this.imagePath = imagePath;
        this.information = information;
        this.status = status;
        ClassVipCapacity = classVipCapacity;
        ClassEconomyCapacity = classEconomyCapacity;
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

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
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
        return ClassVipCapacity;
    }

    public void setClassVipCapacity(int classVipCapacity) {
        ClassVipCapacity = classVipCapacity;
    }

    public int getClassEconomyCapacity() {
        return ClassEconomyCapacity;
    }

    public void setClassEconomyCapacity(int classEconomyCapacity) {
        ClassEconomyCapacity = classEconomyCapacity;
    }
}


