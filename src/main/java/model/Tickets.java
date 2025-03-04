package model;

import java.sql.Timestamp;

public class Tickets{

    private int ticketId;
    private int seatId;
    private String code;
    private double totalPrice;
    private int bookingDetailId;
    private int status;
    private Timestamp createAt;

    public Tickets(int ticketId, int seatId, String code, double totalPrice, int bookingDetailId, int status, Timestamp createAt) {
        this.ticketId = ticketId;
        this.seatId = seatId;
        this.code = code;
        this.totalPrice = totalPrice;
        this.bookingDetailId = bookingDetailId;
        this.status = status;
        this.createAt = createAt;
    }

    public Tickets() {
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

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getBookingDetailId() {
        return bookingDetailId;
    }

    public void setBookingDetailId(int bookingDetailId) {
        this.bookingDetailId = bookingDetailId;
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
                ", code='" + code + '\'' +
                ", totalPrice=" + totalPrice +
                ", bookingDetailId=" + bookingDetailId +
                ", status=" + status +
                ", createAt=" + createAt +
                '}';
    }
}
