/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

import Dao.PositionDAO;
import Dao.VehiculeDAO;
import Metier.Position;
import Metier.Vehicule;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 *
 * @author Yunho
 */
public class Test {
    
    public static void main(String[] args)
    {
        AbstractApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        context.registerShutdownHook();
        PositionDAO dao = (PositionDAO)context.getBean("positionDao");
        VehiculeDAO vdao = (VehiculeDAO)context.getBean("vehiculeDao");
        Vehicule v = vdao.getById(1);
        List<Position> liste = dao.getPositionsByVehicle(v);
        for(Position p : liste)
        {
            System.out.println(p);
        }
        Position pos = dao.getLastPositionByVehicle(v);
        System.out.println("Derniere position de : "+v.getIntitule()+" "+pos);
        context.close();
    }
}
