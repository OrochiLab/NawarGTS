/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.PointInteret;
import java.util.List;

/**
 *
 * @author Yunho
 */
public interface PointInteretDAO {
    public List<PointInteret> getAll();
    public PointInteret getById(int id);
    public void saveOrUpdate(PointInteret point);
    public void remove(int id);
}
