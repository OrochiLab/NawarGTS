/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.CategoriePermission;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("categoriePermissionDao")
public class CategoriePermissionDAOImpl implements CategoriePermissionDAO {
    
    @Autowired
    private SessionFactory factory;

    @Override
    public List<CategoriePermission> getAll() {
        Session session = factory.openSession();
        session.beginTransaction();
        List<CategoriePermission> liste = session.createQuery("from CategoriePermission").list();
        session.close();
        return liste;
    }
    
}
