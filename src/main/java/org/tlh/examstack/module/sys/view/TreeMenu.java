package org.tlh.examstack.module.sys.view;

import org.tlh.examstack.module.sys.entity.Menu;

import java.util.List;

/**
 * 左侧菜单模型
 */
public class TreeMenu extends Menu {

    private List<Menu> children;//孩子节点

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }
}
