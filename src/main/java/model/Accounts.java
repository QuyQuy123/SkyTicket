package model;

import java.sql.Date;

public class Accounts {
    private int accountId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String img;
    private Date dob;
    private int status;
    private int roleId;

    public Accounts() {
    }

    public Accounts(int accountId, String fullName, String email, String password, String phone, String address, String img, Date dob, int status, int roleId) {
        this.accountId = accountId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.img = img;
        this.dob = dob;
        this.status = status;
        this.roleId = roleId;
    }

    public Accounts(int accountId,String fullName, String email, String phone, String address, String img, Date dob) {
        this.accountId = accountId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.img = img;
        this.dob = dob;
    }

    public Accounts(String fullname, String email, String password, String phone) {
        this.fullName = fullname;
        this.email = email;
        this.password = password;
        this.phone = phone;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Accounts{" +
                "accountId=" + accountId +
                ", fullName='" + fullName + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", img='" + img + '\'' +
                ", dob=" + dob +
                ", roleId=" + roleId +
                ", status=" + status +
                '}';
    }
}
