/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Metier;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Yunho
 */
@Entity
@Table(name="positions")
public class Position {
    
    @Id
    @GeneratedValue
    private int id;
    @Column(name="latitude",nullable = false)
    private double latitude;
    @Column(name="longitude",nullable = false)
    private double longitude;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="timestamp")
    private Date timestamp;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="vehicule_id")
    private Vehicule vehicule;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public Vehicule getVehicule() {
        return vehicule;
    }

    public void setVehicule(Vehicule vehicule) {
        this.vehicule = vehicule;
    }

    @Override
    public String toString() {
        return "Position{" + "id=" + id + ", latitude=" + latitude + ", longitude=" + longitude + ", timestamp=" + timestamp + ", vehicule=" + vehicule + '}';
    }
    
    
    
}
