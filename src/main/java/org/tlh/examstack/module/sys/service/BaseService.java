package org.tlh.examstack.module.sys.service;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.io.Serializable;
import java.util.List;

public interface BaseService<T,ID extends Serializable> {

    T saveOrUpdate(T t);

    void delete(ID id);

    T getOne(ID id);

    boolean exists(Example<T> example);

    Page<T> findWithPageInfo(Example<T> example,Pageable pageable);

    Page<T> findAll(Pageable pageable);

    List<T> findAll();
}
