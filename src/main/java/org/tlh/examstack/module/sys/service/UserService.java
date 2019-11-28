package org.tlh.examstack.module.sys.service;

import org.tlh.examstack.module.sys.entity.Role;
import org.tlh.examstack.module.sys.entity.User;

import java.util.List;

public interface UserService extends BaseService<User,String>{

    /**
     * 通过用户名获取用户信息
     * @param userName
     * @return
     */
    User findUserByUserName(String userName);

    /**
     * 更新用户信息
     * @param user
     * @return
     */
    boolean updateUserInfo(User user);

    /**
     * 修改用户密码
     * @param user
     * @return
     */
    boolean modifyPwd(User user);

    /**
     * 检测用户输入的原始密码是否正确
     * @param oldPassword
     * @param userId
     * @return
     */
    boolean checkOldPwd(String oldPassword, String userId);

    /**
     * 查询用户的角色
     * @param userName
     * @return
     */
    List<String> findRolesByUserName(String userName);

    /**
     * 查询用户的权限
     * @param userName
     * @return
     */
    List<String> findMenusByUserName(String userName);

    /**
     * 通过角色id获取用户信息
     * @param role 必须对角色id进行赋值
     * @return
     */
    List<User> findUsersByRole(Role role);

    /**
     * 更新用户最后登录的时间
     * @param user
     */
    void updateLastLogin(User user);

}
