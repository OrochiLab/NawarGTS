/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Vehicule;
import java.util.List;

/**
 *
 * @author Yunho
 */
public interface VehiculeDAO {
    
    public List<Vehicule> getAll();
    public Vehicule getById(int id);
    public void saveOrUpdate(Vehicule vehicule);
    public void remove(int id);
}
