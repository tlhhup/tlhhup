package org.tlh.examstack.module.sys.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tlh.examstack.module.sys.entity.Menu;
import org.tlh.examstack.module.sys.entity.User;
import org.tlh.examstack.module.sys.service.MenuService;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sys/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequiresPermissions("sys:menu:index")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(Model model){
        List<Menu> menus = this.menuService.findTreeTableMenus();
        model.addAttribute("menus",menus);
        return "sys/menu/menuList";
    }

    @RequestMapping(value = "/form",method = RequestMethod.GET)
    public String form(Model model,Menu menu){
        if(StringUtils.isEmpty(menu.getId())){//非修改，新增或添加孩子菜单
            if(menu.getParent()==null) {//新增
                menu.setParent(this.menuService.getOne(Menu.getRootMenu()));
            }else{
                menu.setParent(this.menuService.getOne(menu.getParent().getId()));
            }
            //初始化该菜单的排序值为当前父级菜单的最大值
            menu.setSort(menuService.findMaxSortById(menu.getParent().getId())+1);
        }else{
            menu=this.menuService.getOne(menu.getId());
        }
        model.addAttribute("menu",menu);
        return "sys/menu/menuForm";
    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(Menu menu,Model model){
        User user=(User)SecurityUtils.getSubject().getPrincipal();
        menu.setCreateBy(user.getUserId());
        menu=this.menuService.saveOrUpdate(menu);
        model.addAttribute("menu",menu);
        return  "sys/menu/menuForm";
    }

    @RequestMapping(value = "/delete",method = RequestMethod.GET)
    public String delete(String id){
        this.menuService.delete(id);
        return "redirect:index";
    }

    @RequestMapping("/treeData")
    public @ResponseBody List<Map<String,Object>> treeData(){
        return this.menuService.findTreeSelectMenus();
    }

    @RequestMapping(value = "/tree")
    public String tree(String parentId,Model model){
        model.addAttribute("parentId",parentId);
        model.addAttribute("leftMenus",this.menuService.findLeftMenus(parentId));
        return "sys/menu/menuTree";
    }

}