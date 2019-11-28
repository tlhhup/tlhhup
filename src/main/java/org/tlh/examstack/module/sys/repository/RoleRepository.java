package org.tlh.examstack.module.sys.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.tlh.examstack.module.sys.entity.Role;

public interface RoleRepository extends JpaRepository<Role,String> {
}
