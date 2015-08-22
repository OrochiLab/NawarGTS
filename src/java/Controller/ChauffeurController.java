/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.ChauffeurDAO;
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
 * @author PC
 */
@Controller
public class ChauffeurController {
    
    @Autowired
    private ChauffeurDAO chauffeurDao;
    
    @RequestMapping("/chauffeurs")
    public ModelAndView getPageChauffeurs(){
        ModelAndView model = new ModelAndView("chauffeurs");
        model.addObject("chauffeurs",chauffeurDao.getAll());
        return model;
    }
    
    @RequestMapping("/editerChauffeur")
    public ModelAndView chargerFormulaire(@RequestParam(value="id",required=false,defaultValue = "0") int id)
    {
        ModelAndView model = new ModelAndView("formulaireChauffeur");
        if(id!=0)
            model.addObject("chauffeur",chauffeurDao.getById(id));
        
        model.addObject("chauffeurs",chauffeurDao.getAll());
        return model;
    }
    
    @RequestMapping(value="/ajouterChauffeur",method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView validerFormulaire(
            @Valid @ModelAttribute("chauffeur") Metier.Chauffeur chauffeur,BindingResult result
            )
    {
        if(result.hasErrors())
        {
            ModelAndView model = new ModelAndView("formulaireChauffeur");
            model.addObject("erreur","Erreur detectée");
            return model;
        }
        chauffeurDao.saveOrUpdate(chauffeur);
         ModelAndView model = this.getPageChauffeurs();
         model.addObject("message","Opération effectuée avec succès !");
         return model;
    }
    
    @RequestMapping(value="/supprimerChauffeur",method=RequestMethod.POST)
    public ModelAndView supprimerChauffeur(@RequestParam(value="id",required=true) int id)
    {
        chauffeurDao.remove(id);
        ModelAndView model = this.getPageChauffeurs();
        model.addObject("message","Opération effectuée avec succès !");
        return model;
    }
    
}
