package model;

public class Seats {
    private int seatId;
    private int airlineId;
    private int status;
    private int seatNumber;
    private String seatClass;
    private int isBooked;


    public Seats(int seatId, int airlineId, int status, int seatNumber, String seatClass, int isBooked) {
        this.seatId = seatId;
        this.airlineId = airlineId;
        this.status = status;
        this.seatNumber = seatNumber;
        this.seatClass = seatClass;
        this.isBooked = isBooked;
    }

    public Seats(int airlineId, int status, int seatNumber, String seatClass, int isBooked) {
        this.airlineId = airlineId;
        this.status = status;
        this.seatNumber = seatNumber;
        this.seatClass = seatClass;
        this.isBooked = isBooked;
    }
    public Seats() {

    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
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

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getSeatClass() {
        return seatClass;
    }

    public void setSeatClass(String seatClass) {
        this.seatClass = seatClass;
    }

    public int getIsBooked() {
        return isBooked;
    }

    public void setIsBooked(int isBooked) {
        this.isBooked = isBooked;
    }


    @Override
    public String toString() {
        return "Seats{" +
                "seatId=" + seatId +
                ", airlineId=" + airlineId +
                ", status=" + status +
                ", seatNumber=" + seatNumber +
                ", seatClass='" + seatClass + '\'' +
                ", isBooked=" + isBooked +
                '}';
    }
}
