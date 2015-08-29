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
import org.springframework.web.bind.annotation.RequestBody;
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
 
    @RequestMapping(value="/json/authentification",method = RequestMethod.POST)
    @ResponseBody
    public VehiculeAndroid authentificate(@RequestBody Compte compte)
    {
        System.out.println(compte);
        Vehicule vehi = vehiculeDao.getVehiculeByPass(compte.getMatricule(), compte.getPassword());
        if(vehi!=null)
        {
            /*vehi.setPassword(null);
            vehi.getGroupe().setVehicules(null);
            vehi.getChauffeur().setVehicules(null);
            System.out.println(vehi);*/
            VehiculeAndroid andro = new VehiculeAndroid();
            andro.setId_vehicule(vehi.getId());
            andro.setIntitule(vehi.getIntitule());
            andro.setMatricule(vehi.getMatricule());
            andro.setType(vehi.getType());
            andro.setModele(vehi.getModele());
            andro.setGroupe(vehi.getGroupe().getNom());
            andro.setChauffeur(vehi.getChauffeur().getNom()+" "+vehi.getChauffeur().getPrenom());
            System.out.println(andro);
            return andro;
        }
        return null;
        
    }
    
    private static class VehiculeAndroid{
        
        private int id_vehicule;
        private String intitule;
        private String matricule;
        private String type;
        private String modele;
        private String groupe;
        private String chauffeur;

        public int getId_vehicule() {
            return id_vehicule;
        }

        public void setId_vehicule(int id_vehicule) {
            this.id_vehicule = id_vehicule;
        }

        public String getIntitule() {
            return intitule;
        }

        public void setIntitule(String intitule) {
            this.intitule = intitule;
        }

        public String getMatricule() {
            return matricule;
        }

        public void setMatricule(String matricule) {
            this.matricule = matricule;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getModele() {
            return modele;
        }

        public void setModele(String modele) {
            this.modele = modele;
        }

        public String getGroupe() {
            return groupe;
        }

        public void setGroupe(String groupe) {
            this.groupe = groupe;
        }

        public String getChauffeur() {
            return chauffeur;
        }

        public void setChauffeur(String chauffeur) {
            this.chauffeur = chauffeur;
        }

        @Override
        public String toString() {
            return "VehiculeAndroid{" + "id_vehicule=" + id_vehicule + ", intitule=" + intitule + ", matricule=" + matricule + ", type=" + type + ", modele=" + modele + ", groupe=" + groupe + ", chauffeur=" + chauffeur + '}';
        }
        
        
        
        
    }
    
    private static class Compte{
        private String matricule;
        private String password;

        public String getMatricule() {
            return matricule;
        }

        public void setMatricule(String matricule) {
            this.matricule = matricule;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        @Override
        public String toString() {
            return "Compte{" + "matricule=" + matricule + ", password=" + password + '}';
        }
        
        
    }
}
