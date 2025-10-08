/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Hung
 */
public class Location {

    private int locationId;
    private String province;
    private String ward;
    private String detail;

    // Default constructor
    public Location() {
    }

    // Parameterized constructor
    public Location(int locationId, String province, String ward, String detail) {
        this.locationId = locationId;
        this.province = province;
        this.ward = ward;
        this.detail = detail;
    }

    // Getters and Setters
    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return "Location{"
                + "locationId=" + locationId
                + ", province='" + province + '\''
                + ", ward='" + ward + '\''
                + '}';
    }
}
