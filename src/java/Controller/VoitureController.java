/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.ChauffeurDAO;
import Dao.GroupeDAO;
import Dao.VehiculeDAO;
import Metier.Vehicule;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
public class VoitureController {
    
    @Autowired
    private VehiculeDAO vehiculeDao;
    @Autowired
    private ChauffeurDAO chauffeurDao;
    @Autowired
    private GroupeDAO groupeDao;
    
    @RequestMapping("/vehicules")
    public ModelAndView getPageVehicules(){
        ModelAndView model = new ModelAndView("vehicules");
        model.addObject("vehicules",vehiculeDao.getAll());
        return model;
    }
    
    @RequestMapping("/editerVehicule")
    public ModelAndView chargerFormulaire(@RequestParam(value="id",required=false,defaultValue = "0") int id)
    {
        ModelAndView model = new ModelAndView("formulaireVoiture");
        if(id!=0)
            model.addObject("vehicule",vehiculeDao.getById(id));
        
        model.addObject("chauffeurs",chauffeurDao.getAll());
        model.addObject("groupes",groupeDao.getAll());
        return model;
    }
    
    @RequestMapping(value="/ajouterVehicule",method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView validerFormulaire(@RequestParam("groupe_id") int groupe_id,
            @RequestParam("chauffeur_id") int chauffeur_id,
            @Valid @ModelAttribute("vehicule") Vehicule vehicule,BindingResult result
            )
    {
        if(result.hasErrors())
        {
            ModelAndView model = new ModelAndView("formulaireVoiture");
            model.addObject("chauffeurs",chauffeurDao.getAll());
            model.addObject("groupes",groupeDao.getAll());
            model.addObject("vehicule",vehicule);
            model.addObject("erreur","Erreur detectée");
            return model;
        }
        vehicule.setGroupe(groupeDao.getById(groupe_id));
        vehicule.setChauffeur(chauffeurDao.getById(chauffeur_id));
        vehiculeDao.saveOrUpdate(vehicule);
         ModelAndView model = this.getPageVehicules();
         model.addObject("message","Opération effectuée avec succès !");
         return model;
    }
    
    @RequestMapping(value="/supprimerVehicule",method=RequestMethod.POST)
    public ModelAndView supprimerVehicule(@RequestParam(value="id",required=true) int id)
    {
        vehiculeDao.remove(id);
        ModelAndView model = this.getPageVehicules();
         model.addObject("message","Opération effectuée avec succès !");
         return model;
    }
 
}
