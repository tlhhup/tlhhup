package org.tlh.examstack.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.tlh.examstack.App;
import org.tlh.examstack.module.sys.entity.Role;
import org.tlh.examstack.module.sys.service.RoleService;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = App.class)
public class RoleServiceTest {

    @Resource
    private RoleService roleService;

    @Test
    public void save(){
        Role role=new Role();
        role.setRoleName("超级用户");
        role.setRoleValue("-1");
        role.setRoleDesc("具有所有权限");

        this.roleService.saveOrUpdate(role);
    }

}
