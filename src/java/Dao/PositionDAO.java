/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Position;
import Metier.Vehicule;
import java.util.Date;
import java.util.List;


/**
 *
 * @author Yunho
 */
public interface PositionDAO {
    
    public List<Position> getAll();
    public Position getById(int id);
    public void saveOrUpdate(Position position);
    public void remove(int id);
    public List<Position> getPositionsByVehicle(Vehicule vehicule);
    public Position getLastPositionByVehicle(Vehicule vehicule);
    public List<Position> getPositionByVehiculeBetweenDates(Vehicule vehicule,Date debut,Date fin);
}
