package org.tlh.examstack.module.sys.controller;

import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tlh.examstack.module.sys.entity.Menu;
import org.tlh.examstack.module.sys.entity.Role;
import org.tlh.examstack.module.sys.service.MenuService;
import org.tlh.examstack.module.sys.service.RoleService;
import org.tlh.examstack.module.sys.service.UserService;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/sys/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(Model model, Pageable pageable){
        model.addAttribute("roles",this.roleService.findAll(pageable));
        return "sys/role/roleList";
    }

    @RequestMapping(value = "/checkName")
    public @ResponseBody Boolean checkName(Role role){
        Example<Role> roleExample=Example.of(role);
        return !this.roleService.exists(roleExample);
    }

    @RequestMapping(value = "/checkEnName")
    public @ResponseBody Boolean checkEnName(Role role){
        Example<Role> roleExample=Example.of(role);
        return !this.roleService.exists(roleExample);
    }

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/form",method = RequestMethod.GET)
    public String form(Model model,String id){
        Role role=null;
        if(StringUtils.isEmpty(id)){//新增
            role=new Role();
        }else{//修改
            role=this.roleService.getOne(id);
            model.addAttribute("menuIds",this.roleService.findRoleMenus(id));
        }
        model.addAttribute("menus",this.menuService.findAll());
        model.addAttribute("role",role);
        return "sys/role/roleForm";
    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(Role role,String[] menuIds){
        if(menuIds!=null&&menuIds.length>0){
            Set<Menu> menus=new HashSet<>();
            Menu menu;
            for(String id:menuIds){
                menu=new Menu();
                menu.setId(id);
                menus.add(menu);
            }

            role.setMenus(menus);
        }
        role=this.roleService.saveOrUpdate(role);
        return "redirect:form?id="+role.getRoleId();
    }

    @RequestMapping(value = "/delete/{id}",method = RequestMethod.GET)
    public String delete(@PathVariable String id){
        this.roleService.delete(id);
        return "redirect:../index";
    }

    @Autowired
    private UserService userService;

    //权限分配
    @RequestMapping("/assign")
    public String assign(Role role,Model model){
        role = this.roleService.getOne(role.getRoleId());
        model.addAttribute("role",role);
        model.addAttribute("users",this.userService.findUsersByRole(role));
        return "sys/role/roleAssign";
    }

    @RequestMapping(value = "/outrole")
    public String outrole(String userId,String roleId){
        this.roleService.removeUser(userId,roleId);
        return "redirect:assign?roleId="+roleId;
    }

    @RequestMapping(value = "/usertorole")
    public String usertorole(Role role, Model model){
        model.addAttribute("role",this.roleService.getOne(role.getRoleId()));
        model.addAttribute("inUsers",this.userService.findUsersByRole(role));
        model.addAttribute("users",this.userService.findAll());
        return "sys/role/selectUserToRole";
    }

    @RequestMapping(value = "/assignrole")
    public String assignRole(String roleId,String[] userIds){
        this.roleService.assignRole(roleId,userIds);
        return "redirect:assign?roleId="+roleId;
    }

}
