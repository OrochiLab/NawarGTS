/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Metier.Permission;

/**
 *
 * @author Yunho
 */
public interface PermissionDAO {
    
    public Permission getById(int id);
}
