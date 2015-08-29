/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.CategoriePermissionDAO;
import Dao.PermissionDAO;
import Dao.UtilisateurDAO;
import Metier.Permission;
import Metier.Utilisateur;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Yunho
 */
@Controller
public class UtilisateurController {
    
    @Autowired
    private UtilisateurDAO utilisateurDao;
    @Autowired
    private CategoriePermissionDAO categoriePermissionDao;
    @Autowired
    private PermissionDAO permissionDao;
    
    @RequestMapping("/utilisateurs")
    public ModelAndView getPageUtilisateurs()
    {
        ModelAndView model =  new ModelAndView("utilisateurs");
        model.addObject("utilisateurs",utilisateurDao.getAll());
        return model;
    }
    
    @RequestMapping("/editerUtilisateur")
    public ModelAndView chargerFormulaire(@RequestParam(value="id",required=false,defaultValue = "0") int id)
    {
        ModelAndView model = new ModelAndView("formulaireUtilisateur");
        if(id!=0)
        {
            Utilisateur user = utilisateurDao.getById(id);
            model.addObject("utilisateur",user);
            Map<String,Permission> map = new HashMap();
            for(Permission p : user.getPermissions())
            {
                map.put(p.getIntitule(), p);
            }
            model.addObject("map",map);
        }
        
        model.addObject("categories",categoriePermissionDao.getAll());
        return model;
    }
    
    @RequestMapping(value="/ajouterUtilisateur",method = RequestMethod.POST)
    public ModelAndView validerFormulaire(
            @RequestParam(value="perm[]",required = false) int[] permissions_id,
            @Valid @ModelAttribute("utilisateur") Utilisateur utilisateur,BindingResult result
            )
    {
        if(result.hasErrors())
        {
            ModelAndView model = new ModelAndView("formulaireUtilisateur");
            model.addObject("utilisateur",utilisateur);
            model.addObject("erreur","Erreur detectée");
            return model;
        }
        
        utilisateur.setPermissions(new ArrayList<Permission>());
        for(int i=0;i<permissions_id.length;i++)
            utilisateur.getPermissions().add(permissionDao.getById(permissions_id[i]));
        
        System.out.println(utilisateur);
        utilisateurDao.saveOrUpdate(utilisateur);
         ModelAndView model = this.getPageUtilisateurs();
         model.addObject("message","Opération effectuée avec succès !");
         return model;
    }
}
