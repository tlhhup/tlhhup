package org.tlh.examstack.module.sys.controller;

import jdk.nashorn.internal.ir.ReturnNode;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tlh.examstack.module.sys.entity.User;
import org.tlh.examstack.module.sys.service.UserService;

@Controller
@RequestMapping("/sys/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/info",method = RequestMethod.GET)
    public String info(Model model){
        model.addAttribute("user",SecurityUtils.getSubject().getPrincipals().oneByType(User.class));
        return "sys/user/info";
    }

    @RequestMapping(value = "/info",method = RequestMethod.POST)
    public String info(User user,Model model){
        if(this.userService.updateUserInfo(user)){
            model.addAttribute("user",this.userService.getOne(user.getUserId()));
            model.addAttribute("message","修改成功");
        }else {
            model.addAttribute("message","修改失败");
            model.addAttribute("user",user);
        }
        return "sys/user/info";
    }

    @RequestMapping(value = "/modifyPwd",method = RequestMethod.GET)
    public String modifyPwd(Model model){
        model.addAttribute("userId",SecurityUtils.getSubject().getPrincipals().oneByType(User.class).getUserId());
        return "sys/user/modifyPwd";
    }

    @RequestMapping(value = "/modifyPwd",method = RequestMethod.POST)
    public String modifyPwd(String oldPassword,String newPassword,String userId,Model model){
        if(this.userService.checkOldPwd(oldPassword,userId)){
            User user = SecurityUtils.getSubject().getPrincipals().oneByType(User.class);
            user.setPassword(newPassword);
            this.userService.modifyPwd(user);
        }else{
            model.addAttribute("message","修改密码失败，旧密码错误");
        }
        model.addAttribute("userId",userId);
        return "sys/user/modifyPwd";
    }

    @RequestMapping(value = "/index",method = {RequestMethod.GET,RequestMethod.POST})
    public String index(User user, @PageableDefault(value = 10) Pageable pageable, Model model){
        if(StringUtils.isEmpty(user.getUserName())){// todo 处理 空字符串的问题
            user.setUserName(null);
        }
        if(StringUtils.isEmpty(user.getRealName())){
            user.setRealName(null);
        }
        ExampleMatcher exampleMatcher = ExampleMatcher.matching().withMatcher("userName", matcher -> matcher.startsWith()).withMatcher("realName", matcher -> matcher.startsWith());
        Example<User> example=Example.of(user,exampleMatcher);
        model.addAttribute("users",this.userService.findWithPageInfo(example,pageable));
        return "sys/user/userList";
    }

    @RequestMapping(value = "/form",method = RequestMethod.GET)
    public String form(String id,Model model){
        User user=null;
        if(StringUtils.isEmpty(id)){
            user=new User();
        }else {
            user=this.userService.getOne(id);
        }
        model.addAttribute("user",user);
        return "sys/user/userFrom";
    }

    @RequestMapping(value = "/checkLoginName",method = RequestMethod.GET)
    public @ResponseBody boolean checkLoginName(String userName){
        return this.userService.findUserByUserName(userName)==null;
    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(User user){
        if(StringUtils.isEmpty(user.getPassword())){//更新用户信息
            this.userService.updateUserInfo(user);
        }else{
            user=this.userService.saveOrUpdate(user);
        }
        return "redirect:form?id="+user.getUserId();
    }

    @RequestMapping(value = "/delete",method = RequestMethod.GET)
    public String delete(String id){
        this.userService.delete(id);
        return "redirect:index";
    }

}
