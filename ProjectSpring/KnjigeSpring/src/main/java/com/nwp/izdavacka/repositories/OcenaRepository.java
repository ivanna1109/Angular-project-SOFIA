package com.nwp.izdavacka.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Ocena;

public interface OcenaRepository extends JpaRepository<Ocena, Integer>{

	@Query("select o from Ocena o where o.knjiga.idKnjiga like id")
	public List<Ocena> findByKnjiga(@Param("id") Integer idKnjiga);
}
