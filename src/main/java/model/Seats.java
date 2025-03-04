package model;

public class Seats {
    private int seatId;
    private int flightId;
    private int status;
    private int seatNumber;
    private String seatClass;
    private int isBooked;


    public Seats(int seatId, int flightId, int status, int seatNumber, String seatClass, int isBooked) {
        this.seatId = seatId;
        this.flightId = flightId;
        this.status = status;
        this.seatNumber = seatNumber;
        this.seatClass = seatClass;
        this.isBooked = isBooked;
    }

    public Seats(int flightId, int status, int seatNumber, String seatClass, int isBooked) {
        this.flightId = flightId;
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

    public int getFlightId() {
        return flightId;
    }

    public void setFlightId(int flightId) {
        this.flightId = flightId;
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
                ", flightId=" + flightId +
                ", status=" + status +
                ", seatNumber=" + seatNumber +
                ", seatClass='" + seatClass + '\'' +
                ", isBooked=" + isBooked +
                '}';
    }
}
