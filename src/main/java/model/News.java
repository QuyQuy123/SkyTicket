package model;

import java.sql.Timestamp;

public class News {
    private int newId;
    private String title;
    private String img;
    private String content;
    private int airlineId;
    private int status;
    private Timestamp createAt;


    public News() {
    }

    public News(int newId, String title, String img, String content, int airlineId, int status) {
        this.newId = newId;
        this.title = title;
        this.img = img;
        this.content = content;
        this.airlineId = airlineId;
        this.status = status;
    }

    public News(String title, String img, String content, int airlineId, int status) {
        this.title = title;
        this.img = img;
        this.content = content;
        this.airlineId = airlineId;
        this.status = status;
    }

    public News(int newId, String img, String title, String content, int airlineId, int status, Timestamp createAt) {
        this.newId = newId;
        this.img = img;
        this.title = title;
        this.content = content;
        this.airlineId = airlineId;
        this.status = status;
        this.createAt = createAt;
    }

    public int getNewId() {
        return newId;
    }

    public void setNewId(int newId) {
        this.newId = newId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }
}
