/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Utilisateur;
import java.util.List;

/**
 *
 * @author Yunho
 */
public interface UtilisateurDAO {
    
    public List<Utilisateur> getAll();
    public Utilisateur getById(int id);
    public void saveOrUpdate(Utilisateur utilisateur);
    public void remove(int id);
    public Utilisateur getUserByLogin(String compte,String password);
    public void persist(Utilisateur user);
}
