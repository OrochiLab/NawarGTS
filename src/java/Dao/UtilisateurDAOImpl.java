/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Permission;
import Metier.Utilisateur;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("utilisateurDao")
public class UtilisateurDAOImpl implements UtilisateurDAO{

    @Autowired
    private SessionFactory factory;
    @Autowired
    private PermissionDAO permissionDao;
    
    @Override
    public List<Utilisateur> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<Utilisateur> liste = session.createQuery("from Utilisateur").list();
        session.close();
        return liste;
    }

    @Override
    public Utilisateur getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        Utilisateur utilisateur = (Utilisateur)session.get(Utilisateur.class, id);
        session.close();
        return utilisateur;
    }

    @Override
    public void saveOrUpdate(Utilisateur utilisateur) {
        Session session = factory.openSession();
        session.beginTransaction();
        session.saveOrUpdate(utilisateur);
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
    public Utilisateur getUserByLogin(String compte, String password) {
        Session session = factory.openSession();
        session.beginTransaction();
        Utilisateur utilisateur = (Utilisateur) session.createQuery("from Utilisateur where compte=:compte and password=:password")
                .setParameter("compte", compte)
                .setParameter("password", password)
                .uniqueResult();
        session.close();
        return utilisateur;
    }

    @Override
    public void persist(Utilisateur user) {
        Session session = factory.openSession();
        session.beginTransaction();
        for(int i=0;i<user.getPermissions().size();i++)
        {
            user.getPermissions().set(i, permissionDao.getById(user.getPermissions().get(i).getId()));
        }
        session.persist(user);
        session.getTransaction().commit();
        session.close();
    }
    
}
