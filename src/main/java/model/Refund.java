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
    private String accountHolder;
    private String TicketCode;
    private String CreatedBy;

    public Refund() {
    }



    public Refund(int ticketId, String bankAccount, String bankName, Timestamp requestDate, double refundPrice, int status, String accountHolder) {
        this.ticketId = ticketId;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
        this.requestDate = requestDate;
        this.refundPrice = refundPrice;
        this.status = status;
        this.accountHolder = accountHolder;
    }

    public String getTicketCode() {
        return TicketCode;
    }

    public void setTicketCode(String ticketCode) {
        TicketCode = ticketCode;
    }

    public Refund(int refundId, int ticketId, String bankAccount, String bankName, Timestamp requestDate, Timestamp refundDate, double refundPrice, int status, String accountHolder) {
        this.refundId = refundId;
        this.ticketId = ticketId;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.refundPrice = refundPrice;
        this.status = status;
        this.accountHolder = accountHolder;
    }

    public Refund(int refundId, int ticketId, String bankAccount, String bankName, Timestamp requestDate, Timestamp refundDate, double refundPrice, int status, String accountHolder, String CreatedBy) {
        this.refundId = refundId;
        this.ticketId = ticketId;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
        this.requestDate = requestDate;
        this.refundDate = refundDate;
        this.refundPrice = refundPrice;
        this.status = status;
        this.accountHolder = accountHolder;
        this.CreatedBy = CreatedBy;

    }

    public Refund(int ticketId, String bankAccount, String bank, Timestamp requestDate, Timestamp refundDate, double refundPrice, int i, String accountHolder) {
    }

    public int getRefundId() {
        return refundId;
    }

    public String getCreatedBy() {
        return CreatedBy;
    }

    public void setCreatedBy(String createdBy) {
        CreatedBy = createdBy;
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
        this.requestDate = requestDate;
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

    public String getAccountHolder() {
        return accountHolder;
    }

    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }
}
