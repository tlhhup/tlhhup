package org.tlh.examstack.module.sys.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "sys_roles")
public class Role extends BaseEntity {

    @Id
    @GenericGenerator(strategy = "uuid",name = "uuid")
    @GeneratedValue(generator="uuid")
    private String roleId;

    @Column(unique = true)
    private String roleName;
    @Column(unique = true)
    private String enName;//英文名称
    private String roleDesc;
    private String roleValue;

    @ManyToMany(targetEntity = Menu.class,cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id")
    private Set<Menu> menus;//和菜单的多对多关系

    public Set<Menu> getMenus() {
        return menus;
    }

    public void setMenus(Set<Menu> menus) {
        this.menus = menus;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

    public String getRoleValue() {
        return roleValue;
    }

    public void setRoleValue(String roleValue) {
        this.roleValue = roleValue;
    }

    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }
}
