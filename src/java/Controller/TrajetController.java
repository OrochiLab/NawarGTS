/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.PositionDAO;
import Dao.VehiculeDAO;
import Metier.Position;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Yunho
 */
@Controller
public class TrajetController {
    
    
    @Autowired
    private PositionDAO positionDao;
    @Autowired
    private VehiculeDAO vehiculeDao;
    
    
    @RequestMapping("/trajets")
    public ModelAndView getTrajetsPage()
    {
        ModelAndView model = new ModelAndView("trajets");
        model.addObject("vehicules",vehiculeDao.getAll());
        return model;
    }
    
    
    @RequestMapping(value="json/trajet",method = RequestMethod.POST)
    @ResponseBody
    public List<Position> getTrajets(@RequestParam("id_vehicule") int id,
            @RequestParam("date_debut") @DateTimeFormat(pattern="dd/MM/yyyy") Date debut,
            @RequestParam("date_fin") @DateTimeFormat(pattern="dd/MM/yyyy") Date fin)
    {
        List<Position> liste = positionDao.getPositionByVehiculeBetweenDates(vehiculeDao.getById(id), debut, fin);
        for(Position p : liste)
        {
            p.getVehicule().getChauffeur().setVehicules(null);
            p.getVehicule().getGroupe().setVehicules(null);
        }
        
        return liste;
        
    }
}
