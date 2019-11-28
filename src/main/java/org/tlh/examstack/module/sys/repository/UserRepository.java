package org.tlh.examstack.module.sys.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import org.tlh.examstack.module.sys.entity.Role;
import org.tlh.examstack.module.sys.entity.User;

import java.util.List;

public interface UserRepository extends JpaRepository<User,String>{

    User findByUserName(String userName);

    List<User> findUserByRoles(Role role);

    @Query("update User u set u.realName=:#{#user.realName},u.email=:#{#user.email},u.phoneNum=:#{#user.phoneNum} ,u.enabled=:#{#user.enabled} where u.userId=:#{#user.userId}")
    @Modifying
    @Transactional
    int updateUserInfo(@Param("user") User user);

    @Query("update User u set u.password=?1 where u.userId=?2")
    @Modifying
    @Transactional
    int modifyPwd(String passwod,String id);

    /**
     * 更新用户最后登录的时间
     * @param user
     */
    @Query("update User u set u.lastLoginTime=:#{#user.lastLoginTime} where u.userId=:#{#user.userId}")
    @Modifying
    @Transactional
    void updateLastLogin(@Param("user") User user);
}
