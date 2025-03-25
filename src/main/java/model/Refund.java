package model;

import java.sql.Timestamp;

public class Refund {
    private int refundId;
    private int ticketId;
    private String bankAccount;
    private String bankName;
    private Timestamp requestDate;
    private Timestamp refundDate;
    private double refundPrice;
    private int status;
    private String ticketCode;

    public Refund() {
    }

    public Refund(int refundId, int ticketId, String bankAccount, String bankName, Timestamp requestDate, Timestamp refundDate, double refundPrice, int status, String ticketCode) {
        this.refundId = refundId;
        this.ticketId = ticketId;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.refundPrice = refundPrice;
        this.status = status;
        this.ticketCode = ticketCode;
    }

    public int getRefundId() {
        return refundId;
    }

    public void setRefundId(int refundId) {
        this.refundId = refundId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public Timestamp getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Timestamp requestDate) {
       this.requestDate=requestDate;
    }

    public Timestamp getRefundDate() {
        return refundDate;
    }

    public void setRefundDate(Timestamp refundDate) {
        this.refundDate = refundDate;
    }

    public double getRefundPrice() {
        return refundPrice;
    }

    public void setRefundPrice(double refundPrice) {
        this.refundPrice = refundPrice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    @Override
    public String toString() {
        return "Refund{" +
                "refundId=" + refundId +
                ", ticketId=" + ticketId +
                ", bankAccount='" + bankAccount + '\'' +
                ", bankName='" + bankName + '\'' +
                ", requestDate=" + requestDate +
                ", refundDate=" + refundDate +
                ", refundPrice=" + refundPrice +
                ", status=" + status +
                ", ticketCode='" + ticketCode + '\'' +
                '}';
    }
}
