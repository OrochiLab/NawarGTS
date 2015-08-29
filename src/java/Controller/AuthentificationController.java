/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.UtilisateurDAO;
import Metier.Utilisateur;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Yunho
 */
@Controller
public class AuthentificationController {
    
    @Autowired
    private UtilisateurDAO utilisateurDao;
    
    
    @RequestMapping(value="/authentification",method = RequestMethod.POST)
    public ModelAndView authentificate(@RequestParam("compte") String compte,@RequestParam("password") String password,HttpSession session)
    {
        
        Utilisateur user = utilisateurDao.getUserByLogin(compte, password);
        System.out.println(user);
        if(user!=null)
        {
            session.setAttribute("user", user);
            return new ModelAndView("accueil");
        }
        else
        {
            return new ModelAndView("redirect:/");
        }
    }
    
    @RequestMapping(value="/deconnexion")
    public ModelAndView deconnexion(HttpSession session)
    {
        session.removeAttribute("user");
        session.invalidate();
        return new ModelAndView("redirect:/");
    }
}
