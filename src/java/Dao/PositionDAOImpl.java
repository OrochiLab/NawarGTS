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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("positionDao")
public class PositionDAOImpl implements PositionDAO{

    @Autowired
    private SessionFactory factory;
    
    @Override
    public List<Position> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<Position> liste = session.createQuery("from Position").list();
        session.close();
        return liste;
    }

    @Override
    public Position getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        Position position = (Position)session.get(Position.class, id);
        session.close();
        return position;
    }

    @Override
    public void saveOrUpdate(Position position) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.saveOrUpdate(position);
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public void remove(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.delete(this.getById(id));
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public List<Position> getPositionsByVehicle(Vehicule vehicule) {
        Session session = factory.openSession();
        session.beginTransaction();
        
        List<Position> liste = session.createQuery("from Position where vehicule.id=:id order by timestamp desc")
                .setParameter("id",vehicule.getId())
                .list();
        session.close();
        return liste;
    }

    @Override
    public Position getLastPositionByVehicle(Vehicule vehicule) {
        Session session = factory.openSession();
        session.beginTransaction();
        
        Position position = (Position)session.createQuery("from Position where vehicule.id=:id order by timestamp desc")
                .setParameter("id",vehicule.getId())
                .setMaxResults(1)
                .uniqueResult();
                
        session.close();
        return position;
    }

    @Override
    public List<Position> getPositionByVehiculeBetweenDates(Vehicule vehicule, Date debut, Date fin) {
        Session session = factory.openSession();
        session.beginTransaction();
        
        List<Position> liste = session.createQuery("from Position where vehicule.id=:id and (timestamp between :debut and :fin) order by timestamp asc")
                .setParameter("id",vehicule.getId())
                .setParameter("debut",debut)
                .setParameter("fin",fin)
                .list();
        session.close();
        return liste;
    }
    
}
