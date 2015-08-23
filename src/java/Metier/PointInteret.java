/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Metier;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author Yunho
 */
@Entity
@Table(name="points_interet")
public class PointInteret {
    
    @Id
    @GeneratedValue
    private int id;
    @Column(name="nom",nullable=false,length=100)
    private String nom;
    @Column(name="adresse",nullable=false,length=255)
    private String adresse;
    @Column(name="iconne",nullable=true,length=255)
    private String icone;
    @Column(name="description",nullable=false,length=255)
    private String description;
    @Column(name="latitude",nullable=false)
    private double latitude;
    @Column(name="longitude",nullable=false)
    private double longitude;

    
    
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

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getIcone() {
        return icone;
    }

    public void setIcone(String icone) {
        this.icone = icone;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "PointInteret{" + "id=" + id + ", nom=" + nom + ", adresse=" + adresse + ", icone=" + icone + ", description=" + description + ", latitude=" + latitude + ", longitude=" + longitude + '}';
    }
    
    
}
