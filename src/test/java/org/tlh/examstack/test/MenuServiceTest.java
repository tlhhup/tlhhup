package org.tlh.examstack.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.tlh.examstack.App;
import org.tlh.examstack.module.sys.entity.Menu;
import org.tlh.examstack.module.sys.service.MenuService;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = App.class)
public class MenuServiceTest {

    @Resource
    private MenuService menuService;

    @Test
    public void save(){
        Menu menu=new Menu();
        menu.setTitle("角色管理");
        menu.setIsShow(true);

        Menu parent=new Menu();
        parent.setId("4028b8815f945568015f945581580000");

        menu.setParent(parent);

        this.menuService.saveOrUpdate(menu);
    }

    @Test
    public void getOne(){
        Menu menu = this.menuService.getOne("4028b8815f945568015f945581580000");
        System.out.println(menu.getParent().getId());
    }

    @Test
    public void findAll(){
        List<Menu> menus = this.menuService.findTreeTableMenus();
        for(Menu menu:menus){
            System.out.println(menu.getTitle()+menu.getIsShow());
        }
    }

    @Test
    public void findTree(){
        List<Map<String, Object>> treeSelectMenus = this.menuService.findTreeSelectMenus();
        System.out.println(treeSelectMenus.size());
    }

    @Test
    public void delete(){
         this.menuService.delete("4028b8815f945568015f945581580000");
    }

    @Test
    public void findMaxSort(){
        Integer maxSortById = this.menuService.findMaxSortById("292c8ae55f9c0e4f015f9c152a550001");
        System.out.println(maxSortById);
    }

}
