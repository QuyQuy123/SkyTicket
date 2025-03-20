package model;

import java.sql.Timestamp;
import java.time.Duration;

public class Tickets {

    private int ticketId;
    private int seatId;
    private int passengerId;
    private String code;
    private int status;
    private Timestamp createAt;
    private int bookingId;
    private int flightId;
    private int baggageId;
    private float price;
    private Timestamp CancelledAt;

    public Tickets(int ticketId, int seatId, int passengerId, String code, int status, Timestamp createAt, int bookingId, int flightId, int baggageId, Timestamp cancelledAt) {
        this.ticketId = ticketId;
        this.seatId = seatId;
        this.passengerId = passengerId;
        this.code = code;
        this.status = status;
        this.createAt = createAt;
        this.bookingId = bookingId;
        this.flightId = flightId;
        this.baggageId = baggageId;
        CancelledAt = cancelledAt;
    }

    public Tickets(int ticketId, int seatId, String code, int status, Timestamp createAt) {
        this.ticketId = ticketId;
        this.seatId = seatId;
        this.code = code;

        this.status = status;
        this.createAt = createAt;
    }

    public Tickets(int ticketId, int seatId, int passengerId, String code, int status, Timestamp createAt, int bookingId, int flightId, int baggageId, float price, Timestamp cancelledAt) {
        this.ticketId = ticketId;
        this.seatId = seatId;
        this.passengerId = passengerId;
        this.code = code;
        this.status = status;
        this.createAt = createAt;
        this.bookingId = bookingId;
        this.flightId = flightId;
        this.baggageId = baggageId;
        this.price = price;
        CancelledAt = cancelledAt;
    }

    public Tickets() {
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getFlightId() {
        return flightId;
    }

    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }

    public int getBaggageId() {
        return baggageId;
    }

    public void setBaggageId(int baggageId) {
        this.baggageId = baggageId;
    }

    public Timestamp getCancelledAt() {
        return CancelledAt;
    }

    public void setCancelledAt(Timestamp cancelledAt) {
        CancelledAt = cancelledAt;
    }

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }


    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "Tickets{" +
                "ticketId=" + ticketId +
                ", seatId=" + seatId +
                ", passengerId=" + passengerId +
                ", code='" + code + '\'' +
                ", status=" + status +
                ", createAt=" + createAt +
                ", bookingId=" + bookingId +
                ", flightId=" + flightId +
                ", baggageId=" + baggageId +
                ", price=" + price +
                ", CancelledAt=" + CancelledAt +
                '}';
    }


}
