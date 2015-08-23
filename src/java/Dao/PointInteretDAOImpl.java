/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.PointInteret;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("pointsInteretDao")
public class PointInteretDAOImpl implements PointInteretDAO{

    @Autowired
    private SessionFactory factory;
    
    @Override
    public List<PointInteret> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<PointInteret> liste = session.createQuery("from PointInteret").list();
        session.close();
        return liste;
    }

    @Override
    public PointInteret getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        PointInteret point = (PointInteret)session.get(PointInteret.class, id);
        session.close();
        return point;
    }

    @Override
    public void saveOrUpdate(PointInteret point) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.saveOrUpdate(point);
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
    
}
