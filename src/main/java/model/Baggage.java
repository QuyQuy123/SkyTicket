package model;

public class Baggage {
    private int baggageId;
    private float weight;
    private double price;

    public Baggage(){};

    public Baggage(int baggageId, float weight, double price) {
        this.baggageId = baggageId;
        this.weight = weight;
        this.price = price;
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

    @Override
    public String toString() {
        return "Baggage{" +
                "baggageId=" + baggageId +
                ", weight=" + weight +
                ", price=" + price +
                '}';
    }
}
