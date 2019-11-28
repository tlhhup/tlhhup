package org.tlh.examstack.module.sys.service;

import org.tlh.examstack.module.sys.entity.Role;

import java.util.List;

public interface RoleService extends BaseService<Role,String> {

    /**
     * 获取该角色拥有的权限
     * @param id
     * @return
     */
    List<String> findRoleMenus(String id);

    /**
     * 解除角色和用户的关系
     * @param userId
     * @param roleId
     */
    void removeUser(String userId, String roleId);

    /**
     * 添加用户和角色的关系
     * @param roleId
     * @param userIds
     */
    void assignRole(String roleId, String[] userIds);
}
