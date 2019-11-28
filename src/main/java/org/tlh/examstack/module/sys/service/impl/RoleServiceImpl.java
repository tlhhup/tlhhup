package org.tlh.examstack.module.sys.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SingleColumnRowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.tlh.examstack.module.sys.entity.Role;
import org.tlh.examstack.module.sys.repository.RoleRepository;
import org.tlh.examstack.module.sys.service.RoleService;

import javax.annotation.Resource;
import javax.persistence.Id;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@Transactional(readOnly = true)
@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<Role,String> implements RoleService{

    @Resource(name = "roleRepository")
    @Override
    public void setJpaRepository(JpaRepository<Role, String> jpaRepository) {
        super.setJpaRepository(jpaRepository);
    }

    @Transactional
    @Override
    public void delete(String s) {
        //1.清除角色和用户的关系
        String sql="DELETE from sys_users_roles where roles_role_id=?";
        //2.删除数据
        this.jdbcTemplate.update(sql,s);
        super.delete(s);
    }

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<String> findRoleMenus(String id) {
        String sql="SELECT menus_id from sys_roles_menus where role_role_id=?";
        return this.jdbcTemplate.query(sql,new Object[]{id},new SingleColumnRowMapper<String>());
    }

    @Transactional(readOnly = false)
    @Override
    public void removeUser(String userId, String roleId) {
        String sql="DELETE from sys_users_roles where user_user_id=? and roles_role_id=?";
        this.jdbcTemplate.update(sql,userId,roleId);
    }

    @Transactional(readOnly = false)
    @Override
    public void assignRole(String roleId, String[] userIds) {
        //1.先删除该角色下的所有用户
        String sql="DELETE from sys_users_roles where roles_role_id=?";
        this.jdbcTemplate.update(sql,roleId);
        //2.添加关系
        sql="INSERT INTO sys_users_roles(user_user_id,roles_role_id) VALUES (?,?)";
        this.jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
                preparedStatement.setString(1,userIds[i]);
                preparedStatement.setString(2,roleId);
            }

            @Override
            public int getBatchSize() {
                return userIds.length;
            }
        });
    }
}
