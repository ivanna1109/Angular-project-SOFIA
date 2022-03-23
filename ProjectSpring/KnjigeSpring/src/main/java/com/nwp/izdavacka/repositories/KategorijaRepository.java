package com.nwp.izdavacka.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import model.Kategorija;

@Repository
@Transactional
public interface KategorijaRepository extends JpaRepository<Kategorija, Integer>{

	public Kategorija findByNazivKategorije(String naziv);

}
