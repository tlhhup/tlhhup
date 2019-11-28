package org.tlh.examstack.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.tlh.examstack.App;
import org.tlh.examstack.module.sys.entity.User;
import org.tlh.examstack.module.sys.service.UserService;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = App.class)
public class UserServiceTest {

    @Resource
    private UserService mUserService;

    @Test
    public void save(){
        User user=new User();
        user.setEnabled(true);
        user.setUserName("admin");
        user.setRealName("管理员");
        user.setPassword("admin");

        this.mUserService.saveOrUpdate(user);
    }

    @Test
    public void findByUserName(){
        User user = this.mUserService.findUserByUserName("admin");
        System.out.println(user.getRealName());
    }

    @Test
    public void findRoles(){
        List<String> roles = this.mUserService.findMenusByUserName("zhangsan");
        for(String role:roles){
            System.out.println(role);
        }
    }

}
