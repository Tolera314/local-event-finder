package Servlet;

import java.sql.Blob;
import java.util.Date;

public class Event {
    private final int id;
    private final String name;
    private final Blob image;
    private final double regularPrice;
    private final double vipPrice;
    private final String location;
    private final Date eventDate;

    public Event(int id, String name, Blob image, double regularPrice, double vipPrice, String location, Date eventDate) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.regularPrice = regularPrice;
        this.vipPrice = vipPrice;
        this.location = location;
        this.eventDate = eventDate;
    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public Blob getImage() { return image; }
    public double getRegularPrice() { return regularPrice; }
    public double getVipPrice() { return vipPrice; }
    public String getLocation() { return location; }
    public Date getEventDate() { return eventDate; }
}