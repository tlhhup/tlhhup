package org.tlh.examstack.module.sys.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.tlh.examstack.module.sys.entity.Menu;
import org.tlh.examstack.module.sys.service.MenuService;

import javax.servlet.http.HttpServletRequest;


@Controller
public class LoginController {

    @RequestMapping(value = {"/login","/"},method = RequestMethod.GET)
    public String login(){
        Subject subject = SecurityUtils.getSubject();
        //如果是登录界面则清除之前的请求的保持点 shiro
        Session session = subject.getSession();
        if(session!=null){
            session.removeAttribute(WebUtils.SAVED_REQUEST_KEY);
        }
        if(subject.isAuthenticated()){
            return "redirect:sys/main";
        }
        return "login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(HttpServletRequest request, Model model){
        String msg = (String)request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
        if(StringUtils.isEmpty(msg)) {
            return "redirect:sys/main";
        }else{
            if(DisabledAccountException.class.getName().equals(msg)){
                model.addAttribute("msg","账号禁用");
            }else if(AccountException.class.getName().equals(msg)){
                model.addAttribute("msg","用户名错误");
            }else {
                model.addAttribute("msg","密码错误");
            }
            return "login";
        }
    }

    @RequestMapping(value = "/logout",method =RequestMethod.GET)
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        if(subject!=null){
            subject.logout();
        }
        return "login";
    }

    @Autowired
    private MenuService menuService;

    @RequestMapping("/sys/main")
    public String main(Model model){
        model.addAttribute("topMenus",this.menuService.findMenusByParentId(Menu.getRootMenu()));
        return "layout/main";
    }

}
