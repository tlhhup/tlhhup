package org.tlh.examstack.module.sys.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.ColumnMapRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.tlh.examstack.module.sys.entity.Menu;
import org.tlh.examstack.module.sys.repository.MenuRepository;
import org.tlh.examstack.module.sys.service.MenuService;
import org.tlh.examstack.module.sys.view.TreeMenu;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service("menuService")
public class MenuServiceImpl extends BaseServiceImpl<Menu,String> implements MenuService{

    @Autowired
    private MenuRepository menuRepository;

    @Resource(name = "menuRepository")
    @Override
    public void setJpaRepository(JpaRepository<Menu, String> jpaRepository) {
        super.setJpaRepository(jpaRepository);
    }

    @Transactional(readOnly = false)
    @Override
    public void delete(String s) {
        //0.清除菜单和角色的关系
        this.deleteRoleByMenuId(s);
        //1.先删除孩子节点
        deletChildren(s);
        //2.删除自己
        if(this.menuRepository.exists(s)){
            this.menuRepository.delete(s);
        }
    }

    //删除还是菜单
    private void deletChildren(String parentId){
        List<Menu> menus = this.menuRepository.findMenuByParentIdOrderBySortAsc(parentId);
        if(menus!=null&&menus.size()>0){//判断是否是叶子菜单
            for(Menu menu:menus){
                delete(menu.getId());//递归删除孩子
                if(this.menuRepository.exists(menu.getId())) {
                    this.deleteRoleByMenuId(parentId);
                    super.delete(menu.getId());//删除自己
                }
            }
        }else{
            this.deleteRoleByMenuId(parentId);
            super.delete(parentId);
        }
    }

    //处理孩子菜单也有角色的问题
    private void deleteRoleByMenuId(String menuId){
        String sql="delete from sys_roles_menus where menus_id=?";
        this.jdbcTemplate.update(sql,menuId);
    }

    @Override
    public List<Menu> findMenusByParentId(String parentId) {
        return this.menuRepository.findMenuByParentIdOrderBySortAsc(parentId);
    }

    @Override
    public List<TreeMenu> findLeftMenus(String parentId) {
        //1.先获取二级菜单
        List<Menu> menus = this.menuRepository.findMenuByParentIdOrderBySortAsc(parentId);
        List<TreeMenu> result=new ArrayList<>();
        TreeMenu treeMenu=null;
        for(Menu menu:menus){
            treeMenu=new TreeMenu();
            //2.复制数据
            BeanUtils.copyProperties(menu,treeMenu);
            //3.设置孩子节点
            treeMenu.setChildren(this.menuRepository.findMenuByParentIdOrderBySortAsc(menu.getId()));

            result.add(treeMenu);
            treeMenu=null;
        }
        return result;
    }

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Map<String, Object>> findTreeSelectMenus() {
        String sql="SELECT sm.id,sm.title as 'name',sm.parent_id as 'pId' from sys_menus sm where sm.is_show=true order by sort";
        return this.jdbcTemplate.query(sql,new ColumnMapRowMapper());
    }

    @Override
    public Integer findMaxSortById(String id) {
        return this.menuRepository.findMaxSortById(id);
    }

    @Override
    public List<Menu> findTreeTableMenus() {
        List<Menu> result=new ArrayList<>();
        List<Menu> source = this.menuRepository.findMenuByParentNotNullOrderBySortAsc();
        sortList(result,source,Menu.getRootMenu(),true);
        return result;
    }

    /**
     * 将属于一组的菜单排序到一起
     * @param result
     * @param source
     * @param parentId
     * @param cascade
     */
    public void sortList(List<Menu> result, List<Menu> source, String parentId, boolean cascade) {
        for(int i=0;i<source.size();i++){
            Menu e = source.get(i);
            //查找所有的定级菜单
            if(e.getParent().getId().equals(parentId)){
                result.add(e);
                if(cascade){
                    // 判断是否还有子节点, 有则继续获取子节点
                    for (int j=0; j<source.size(); j++){
                        Menu child = source.get(j);
                        if (child.getParent().getId().equals(e.getId())){
                            sortList(result, source, e.getId(), true);
                            break;
                        }
                    }
                }
            }
        }
    }
}
