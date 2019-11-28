package org.tlh.examstack.module.sys.service.impl;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SingleColumnRowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.tlh.examstack.module.sys.entity.Role;
import org.tlh.examstack.module.sys.entity.User;
import org.tlh.examstack.module.sys.repository.UserRepository;
import org.tlh.examstack.module.sys.service.UserService;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("userService")
@Transactional(readOnly = true)
public class UserServiceImpl extends BaseServiceImpl<User,String> implements UserService{

    @Resource(name = "userRepository")
    @Override
    public void setJpaRepository(JpaRepository<User, String> jpaRepository) {
        super.setJpaRepository(jpaRepository);
    }

    @Resource
    private UserRepository mUserRepository;

    @Override
    public User findUserByUserName(String userName) {
        return this.mUserRepository.findByUserName(userName);
    }

    @Override
    public User saveOrUpdate(User user) {
        if(StringUtils.isEmpty(user.getUserId())){//新增用户
            user.setLastLoginTime(new Date());
            user.setCreateTime(new Date());
            user.setLoginTime(new Date());
            prepareUser(user);
        }
        return super.saveOrUpdate(user);
    }

    @Override
    public boolean updateUserInfo(User user) {
        return this.mUserRepository.updateUserInfo(user)>0;
    }

    @Override
    public boolean checkOldPwd(String oldPassword, String userId) {
        User user = this.getOne(userId);
        //构建比对用户
        User oldUser=new User();
        oldUser.setSalt(user.getSalt());
        oldUser.setPassword(oldPassword);
        prepareUser(oldUser);
        //比对密码
        return oldUser.getPassword().equals(user.getPassword());
    }

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<String> findRolesByUserName(String userName) {
        String sql="SELECT\n" +
                "\tsr.en_name\n" +
                "FROM\n" +
                "\tsys_users su\n" +
                "INNER JOIN sys_users_roles sur ON su.user_id = sur.user_user_id\n" +
                "INNER JOIN sys_roles sr ON sur.roles_role_id = sr.role_id\n" +
                "WHERE\n" +
                "\tsu.user_name = ?";
        return this.jdbcTemplate.query(sql,new Object[]{userName}, new SingleColumnRowMapper<String>());
    }

    @Override
    public List<String> findMenusByUserName(String userName) {
        String sql="SELECT\n" +
                "\tsm.permission\n" +
                "FROM\n" +
                "\tsys_users su\n" +
                "INNER JOIN sys_users_roles sur ON su.user_id = sur.user_user_id\n" +
                "INNER JOIN sys_roles sr ON sur.roles_role_id = sr.role_id\n" +
                "INNER JOIN sys_roles_menus srm on sr.role_id=srm.role_role_id\n" +
                "INNER JOIN sys_menus sm on srm.menus_id=sm.id\n" +
                "WHERE\n" +
                "\tsu.user_name = ?";
        return this.jdbcTemplate.query(sql,new Object[]{userName}, new SingleColumnRowMapper<String>());
    }

    @Override
    public boolean modifyPwd(User user) {
        prepareUser(user);
        return this.mUserRepository.modifyPwd(user.getPassword(),user.getUserId())>0;
    }

    @Override
    public List<User> findUsersByRole(Role role) {
        return this.mUserRepository.findUserByRoles(role);
    }

    @Transactional(readOnly = false)
    @Override
    public void updateLastLogin(User user) {
        this.mUserRepository.updateLastLogin(user);
    }

    private void prepareUser(User user){
        if(StringUtils.isEmpty(user.getSalt())) {
            //生成凭证的盐,加强密码
            String salt = new SecureRandomNumberGenerator().nextBytes().toHex();
            salt = user.getUserName() + salt;
            user.setSalt(salt);
        }
        //加密
        SimpleHash hash=new SimpleHash(Md5Hash.ALGORITHM_NAME,user.getPassword(),user.getSalt(),5);
        user.setPassword(hash.toHex());
    }

}
