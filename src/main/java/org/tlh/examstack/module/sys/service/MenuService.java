package org.tlh.examstack.module.sys.service;

import org.tlh.examstack.module.sys.entity.Menu;
import org.tlh.examstack.module.sys.view.TreeMenu;

import java.util.List;
import java.util.Map;

public interface MenuService extends BaseService<Menu,String>{

    /**
     * 获取树型的菜单
     * @return
     */
    List<Map<String,Object>> findTreeSelectMenus();

    /**
     * 获取tableTree型的菜单数据
     * @return
     */
    List<Menu> findTreeTableMenus();

    /**
     * 通过父级菜单的id获取孩子节点
     * @return
     */
    List<Menu> findMenusByParentId(String parentId);

    /**
     * 获取左侧菜单导航的数据
     * @param parentId
     * @return
     */
    List<TreeMenu> findLeftMenus(String parentId);

    /**
     * 查询最大的排序值
     * @param parentId
     * @return
     */
    Integer findMaxSortById(String parentId);
}
