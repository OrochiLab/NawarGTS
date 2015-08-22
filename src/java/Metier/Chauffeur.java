/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Metier;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author Yunho
 */
@Entity
@Table(name="chauffeurs")
public class Chauffeur extends Personne{

    @OneToMany(mappedBy = "chauffeur")
    private List<Vehicule> vehicules;

    public List<Vehicule> getVehicules() {
        return vehicules;
    }

    public void setVehicules(List<Vehicule> vehicules) {
        this.vehicules = vehicules;
    }
    
    
    
}
