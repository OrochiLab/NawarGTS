/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Chauffeur;
import java.util.List;

/**
 *
 * @author Yunho
 */
public interface ChauffeurDAO {
    
    public List<Chauffeur> getAll();
    public Chauffeur getById(int id);
    public void saveOrUpdate(Chauffeur chauffeur);
    public void remove(int id);
}
