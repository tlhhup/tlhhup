package org.tlh.examstack.module.sys.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "sys_menus")
public class Menu extends BaseEntity {

    @Id
    @GenericGenerator(strategy = "uuid",name = "uuid")
    @GeneratedValue(generator="uuid")
    private String id;
    private String title;//名称

    @Column(unique = true)
    private String url;//地址
    private Integer sort;//排序
    private String icon;//图标
    private String permission;//shiro权限
    private String remarks;//说明
    private Date createDate;//创建时间
    private Boolean isShow;//是否可见
    private String createBy;//创建人
    private String target;//目标

    @ManyToOne(targetEntity = Menu.class)
    @JoinColumn(name = "parentId")
    private Menu parent;//父级菜单

    public Menu getParent() {
        return parent;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Boolean getIsShow() {
        return isShow;
    }

    public void setIsShow(Boolean show) {
        isShow = show;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public static String getRootMenu(){
        return "0";
    }
}
