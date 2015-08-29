/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Permission;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Yunho
 */
@Repository("permissionDao")
public class PermissionDAOImpl implements PermissionDAO{
    
    @Autowired
    private SessionFactory factory;

    @Override
    public Permission getById(int id) {
        Session session = factory.openSession();
        session.beginTransaction();
        Permission perm= (Permission)session.get(Permission.class, id);
        session.close();
        return perm;
    }
    
}
