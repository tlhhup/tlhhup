package org.tlh.examstack.module.sys.service.impl;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;
import org.tlh.examstack.module.sys.service.BaseService;

import java.io.Serializable;
import java.util.List;

@Transactional(readOnly = true)
public abstract class BaseServiceImpl<T,ID extends Serializable> implements BaseService<T,ID> {

    private JpaRepository<T,ID> mJpaRepository;

    public void setJpaRepository(JpaRepository<T, ID> jpaRepository) {
        this.mJpaRepository = jpaRepository;
    }

    @Transactional(readOnly = false)
    @Override
    public T saveOrUpdate(T t) {
       return this.mJpaRepository.save(t);
    }

    @Transactional(readOnly = false)
    @Override
    public void delete(ID id) {
        this.mJpaRepository.delete(id);
    }

    @Override
    public T getOne(ID id) {
        return this.mJpaRepository.findOne(id);
    }

    @Override
    public boolean exists(Example<T> example) {
        return this.mJpaRepository.exists(example);
    }

    @Override
    public Page<T> findWithPageInfo(Example<T> example, Pageable pageable) {
        return this.mJpaRepository.findAll(example,pageable);
    }

    @Override
    public Page<T> findAll(Pageable pageable) {
        return this.mJpaRepository.findAll(pageable);
    }

    @Override
    public List<T> findAll() {
        return this.mJpaRepository.findAll();
    }
}
