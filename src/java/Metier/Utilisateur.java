/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Metier;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 *
 * @author Yunho
 */
@Entity
@Table(name="utilisateurs")
public class Utilisateur extends Personne{
    
   
    @Column(name = "compte",nullable =false,length =30)
    private String compte;
    @Column(name = "password",nullable =false,length =30)
    private String password;

    @ManyToMany(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
    @JoinTable(name = "permissions_utilisateur")
    private List<Permission> permissions;
    

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<Permission> permissions) {
        this.permissions = permissions;
    }

    @Override
    public String toString() {
        return super.toString()+"\nUtilisateur{" + "compte=" + compte + ", password=" + password + '}'+
                "\nPermissions : "+this.getPermissions();
    }
    
    
    
    
    
}
