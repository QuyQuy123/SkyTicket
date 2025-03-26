package model;

public class Baggages {
    private int baggageId;
    private float weight;
    private double price;
    private int airlineId;
    private int status;

    public Baggages(){};

    public Baggages(int baggageId, float weight, double price, int airlineId,int status) {
        this.baggageId = baggageId;
        this.weight = weight;
        this.price = price;
        this.airlineId = airlineId;
        this.status = status;
    }
    public Baggages(float weight, double price, int airlineId,int status) {

        this.weight = weight;
        this.price = price;
        this.airlineId = airlineId;
        this.status = status;
    }

    public int getBaggageId() {
        return baggageId;
    }

    public void setBaggageId(int baggageId) {
        this.baggageId = baggageId;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


    @Override
    public String toString() {
        return "Baggages{" +
                "baggageId=" + baggageId +
                ", weight=" + weight +
                ", price=" + price +
                ", airlineId=" + airlineId +
                ", status=" + status +
                '}';
    }
}
