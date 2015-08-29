/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Metier;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Yunho
 */
@Entity
@Table(name="permissions")
public class Permission {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(name="intitule",length = 50,nullable=false)
    private String intitule;
    @Column(name="description",length =255,nullable=true)
    private String description;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="categorie_id")
    private CategoriePermission categorie;
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIntitule() {
        return intitule;
    }

    public void setIntitule(String intitule) {
        this.intitule = intitule;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Permission{" + "id=" + id + ", intitule=" + intitule + ", description=" + description + '}';
    }
    
    
    
}
