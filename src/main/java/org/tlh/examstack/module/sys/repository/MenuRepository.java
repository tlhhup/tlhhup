package org.tlh.examstack.module.sys.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.tlh.examstack.module.sys.entity.Menu;

import java.util.List;

public interface MenuRepository  extends JpaRepository<Menu,String>{

    /**
     * 查询父级菜单为空的菜单
     * @return
     */
    List<Menu> findMenuByParentNotNullOrderBySortAsc();

    /**
     * 查询孩子菜单
     * @param parentId
     * @return
     */
    List<Menu> findMenuByParentIdOrderBySortAsc(String parentId);

    /**
     * 查询该父级菜单下的排序的最大值
     * @param id
     * @return
     */
    @Query("select max(sort) from Menu where parent.id=?1")
    Integer findMaxSortById(String id);
}
