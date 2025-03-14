package model;

public class Airlines {
    private int airlineId;
    private String airlineName;
    private String image;
    private String information;
    private int status;
    private int numberOfSeatsOnVipRow;
    private int numberOfSeatsOnVipColumn;
    private int numberOfSeatsOnEconomyRow;
    private int numberOfSeatsOnEconomyColumn;


    public Airlines() {
    }

    public Airlines(String airlineName, String image, String information, int status, int numberOfSeatsOnVipRow, int numberOfSeatsOnVipColumn, int numberOfSeatsOnEconomyRow, int numberOfSeatsOnEconomyColumn) {
        this.airlineName = airlineName;
        this.image = image;
        this.information = information;
        this.status = status;
        this.numberOfSeatsOnVipRow = numberOfSeatsOnVipRow;
        this.numberOfSeatsOnVipColumn = numberOfSeatsOnVipColumn;
        this.numberOfSeatsOnEconomyRow = numberOfSeatsOnEconomyRow;
        this.numberOfSeatsOnEconomyColumn = numberOfSeatsOnEconomyColumn;
    }

    public Airlines(int airlineId, String airlineName, String image, String information, int status, int numberOfSeatsOnVipRow, int numberOfSeatsOnVipColumn, int numberOfSeatsOnEconomyRow, int numberOfSeatsOnEconomyColumn) {
        this.airlineId = airlineId;
        this.airlineName = airlineName;
        this.image = image;
        this.information = information;
        this.status = status;
        this.numberOfSeatsOnVipRow = numberOfSeatsOnVipRow;
        this.numberOfSeatsOnVipColumn = numberOfSeatsOnVipColumn;
        this.numberOfSeatsOnEconomyRow = numberOfSeatsOnEconomyRow;
        this.numberOfSeatsOnEconomyColumn = numberOfSeatsOnEconomyColumn;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAirlineName() {
        return airlineName;
    }

    public void setAirlineName(String airlineName) {
        this.airlineName = airlineName;
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

    public int getNumberOfSeatsOnVipRow() {
        return numberOfSeatsOnVipRow;
    }

    public void setNumberOfSeatsOnVipRow(int numberOfSeatsOnVipRow) {
        this.numberOfSeatsOnVipRow = numberOfSeatsOnVipRow;
    }

    public int getNumberOfSeatsOnVipColumn() {
        return numberOfSeatsOnVipColumn;
    }

    public void setNumberOfSeatsOnVipColumn(int numberOfSeatsOnVipColumn) {
        this.numberOfSeatsOnVipColumn = numberOfSeatsOnVipColumn;
    }

    public int getNumberOfSeatsOnEconomyRow() {
        return numberOfSeatsOnEconomyRow;
    }

    public void setNumberOfSeatsOnEconomyRow(int numberOfSeatsOnEconomyRow) {
        this.numberOfSeatsOnEconomyRow = numberOfSeatsOnEconomyRow;
    }

    public int getNumberOfSeatsOnEconomyColumn() {
        return numberOfSeatsOnEconomyColumn;
    }

    public void setNumberOfSeatsOnEconomyColumn(int numberOfSeatsOnEconomyColumn) {
        this.numberOfSeatsOnEconomyColumn = numberOfSeatsOnEconomyColumn;
    }
}
