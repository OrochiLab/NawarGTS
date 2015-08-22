/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Groupe;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("groupeDao")
public class GroupeDAOImpl implements GroupeDAO{
    
    @Autowired
    private SessionFactory factory;

    @Override
    public List<Groupe> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<Groupe> liste = session.createQuery("from Groupe").list();
        session.close();
        return liste;
    }

    @Override
    public Groupe getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        Groupe groupe = (Groupe)session.get(Groupe.class, id);
        session.close();
        return groupe;
    }

    @Override
    public void saveOrUpdate(Groupe groupe) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.saveOrUpdate(groupe);
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
