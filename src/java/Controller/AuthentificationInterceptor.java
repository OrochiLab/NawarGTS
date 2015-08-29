/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


/**
 *
 * @author Yunho
 */
public class AuthentificationInterceptor extends HandlerInterceptorAdapter{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String path = request.getRequestURI().substring(request.getContextPath().length());
        System.out.println("===========>"+path);
        if(request.getSession().getAttribute("user")!=null || request.getParameter("authentificate")!=null )
            return true;
        else
        {
            response.sendRedirect(request.getContextPath());
            return false;
        }
    }

    
    
    
}
