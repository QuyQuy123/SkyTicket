package model;

public class Discounts {
    private int discountId;
    private double percent;
    private int accountId;
    private int points;

    public Discounts() {
    }

    public Discounts(int discountId, double percent, int accountId, int points) {
        this.discountId = discountId;
        this.percent = percent;
        this.accountId = accountId;
        this.points = points;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    @Override
    public String toString() {
        return "Discounts{" +
                "discountId=" + discountId +
                ", percent=" + percent +
                ", accountId=" + accountId +
                ", points=" + points +
                '}';
    }
}
