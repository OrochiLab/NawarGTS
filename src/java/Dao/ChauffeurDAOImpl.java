/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Chauffeur;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("chauffeurDao")
public class ChauffeurDAOImpl implements ChauffeurDAO{

    @Autowired
    private SessionFactory factory;
    
    
    @Override
    public List<Chauffeur> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<Chauffeur> liste = session.createQuery("from Chauffeur").list();
        session.close();
        return liste;
    }

    @Override
    public Chauffeur getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        Chauffeur chauffeur = (Chauffeur)session.get(Chauffeur.class, id);
        session.close();
        return chauffeur;
    }

    @Override
    public void saveOrUpdate(Chauffeur chauffeur) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.saveOrUpdate(chauffeur);
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
