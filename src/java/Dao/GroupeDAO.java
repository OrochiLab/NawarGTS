/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Groupe;
import java.util.List;

/**
 *
 * @author Yunho
 */
public interface GroupeDAO {
    public List<Groupe> getAll();
    public Groupe getById(int id);
    public void saveOrUpdate(Groupe groupe);
    public void remove(int id);
}
