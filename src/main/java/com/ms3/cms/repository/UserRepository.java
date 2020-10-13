package com.ms3.cms.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ms3.cms.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

}
