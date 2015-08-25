/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.PointInteretDAO;
import Metier.PointInteret;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Yunho
 */
@Controller
public class PointInteretController {
    
    @Autowired
    private PointInteretDAO pointsInteretDao;
    
    
    @RequestMapping("/pointsInteret")
    public ModelAndView getPage()
    {
        String[] iconnes = {"regroup.png","embassy.png","fooddelivery.png","hotel_0star.png","house.png","library.png","mall.png","newsagent.png","computers.png","restaurant.png","tools.png","villa.png","workoffice.png","apartment-3.png"};
        ModelAndView model = new ModelAndView("pointsInteret");
        model.addObject("iconnes",iconnes);
        return model;
    }
    
    
    @RequestMapping("/json/points")
    @ResponseBody
    public List<PointInteret> getPoints()
    {
        return pointsInteretDao.getAll();
    }
    
    
    @RequestMapping(value="/json/points/save",method=RequestMethod.PUT)
    @ResponseBody
    public PointInteret[] save(@RequestBody PointInteret[] points)
    {
        for(PointInteret point : points)
        {
            //System.out.println("Point : "+point);
            pointsInteretDao.saveOrUpdate(point);
        }
        return points;
    }
    
    @RequestMapping(value="/json/points/delete",method=RequestMethod.DELETE)
    @ResponseBody
    public PointInteret[] delete(@RequestBody PointInteret[] points)
    {
        for(PointInteret point : points)
        {
            //System.out.println("Point : "+point);
            pointsInteretDao.remove(point.getId());
        }
        return points;
    }
}
