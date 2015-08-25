/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.GroupeDAO;
import Dao.PositionDAO;
import Metier.Groupe;
import Metier.Position;
import Metier.Vehicule;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Yunho
 */
@Controller
public class PositionsController {
    
    @Autowired
    private GroupeDAO groupeDao;
    @Autowired
    private PositionDAO positionDao;
    
    
    
    @RequestMapping("/emplacements")
    public ModelAndView getPage()
    {
        String[] iconnes = {"regroup.png","embassy.png","fooddelivery.png","hotel_0star.png","house.png","library.png","mall.png","newsagent.png","computers.png","restaurant.png","tools.png","villa.png","workoffice.png","apartment-3.png"};
        ModelAndView model = new ModelAndView("emplacements");
        model.addObject("groupes",this.getLastPositions());
        model.addObject("iconnes",iconnes);
        return model;
    }
    
    
    
    @RequestMapping(value="/json/positions",method = RequestMethod.GET)
    @ResponseBody
    public List<Groupe> getLastPositions()
    {
        List<Groupe> liste = groupeDao.getAll();
        
        
        for(Groupe groupe:  liste)
        {
            
            
            for(Vehicule vehicule : groupe.getVehicules())
            {
                vehicule.setGroupe(null);
                vehicule.getChauffeur().setVehicules(null);
                Position pos = positionDao.getLastPositionByVehicle(vehicule);
                if(pos!=null)
                    pos.setVehicule(null);
                
                vehicule.addPosition_actuelle(pos);
                
            }
        }
        
        return liste;
    }
}
