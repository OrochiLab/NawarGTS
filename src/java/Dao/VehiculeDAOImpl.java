/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Vehicule;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("vehiculeDao")
public class VehiculeDAOImpl implements VehiculeDAO{

    @Autowired
    private SessionFactory factory;
    
    @Override
    public List<Vehicule> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<Vehicule> liste = session.createQuery("from Vehicule").list();
        session.close();
        return liste;
    }

    @Override
    public Vehicule getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        Vehicule vehicule = (Vehicule)session.get(Vehicule.class, id);
        session.close();
        return vehicule;
    }

    @Override
    public void saveOrUpdate(Vehicule vehicule) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.saveOrUpdate(vehicule);
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
