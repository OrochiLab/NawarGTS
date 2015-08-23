/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.GroupeDAO;
import Metier.Groupe;
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
public class GroupeController {
    
    @Autowired
    private GroupeDAO groupeDao;
    
    @RequestMapping("/groupes")
    public ModelAndView getGroupes()
    {
        ModelAndView model = new ModelAndView("groupes");
        model.addObject("groupes",groupeDao.getAll());
        return model;
    }
    
    @RequestMapping("/editerGroupe")
    public ModelAndView chargerFormulaire(@RequestParam(value="id",required=false,defaultValue = "0") int id)
    {
        ModelAndView model = new ModelAndView("formulaireGroupe");
        if(id!=0)
            model.addObject("groupe",groupeDao.getById(id));
        
        return model;
    }
    
    @RequestMapping(value="/ajouterGroupe",method = RequestMethod.POST)
    public ModelAndView validerFormulaire(@Valid @ModelAttribute("groupe") Groupe groupe,BindingResult result)
    {
        if(result.hasErrors())
        {
            ModelAndView model = new ModelAndView("formulaireGroupe");
            model.addObject("groupe",groupe);
            model.addObject("erreur","Erreur detectée");
            return model;
        }
        
        groupeDao.saveOrUpdate(groupe);
         ModelAndView model = this.getGroupes();
         model.addObject("message","Opération effectuée avec succès !");
         return model;
    }
    
    @RequestMapping(value="/supprimerGroupe",method=RequestMethod.POST)
    public ModelAndView supprimerGroupe(@RequestParam(value="id",required=true) int id)
    {
        groupeDao.remove(id);
        ModelAndView model = this.getGroupes();
         model.addObject("message","Opération effectuée avec succès !");
         return model;
    }
    
    
}
