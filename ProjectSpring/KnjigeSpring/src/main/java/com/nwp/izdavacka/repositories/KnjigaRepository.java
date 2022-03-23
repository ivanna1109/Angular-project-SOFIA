package com.nwp.izdavacka.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;

import model.Knjiga;

@Repository
@Transactional
public interface KnjigaRepository extends JpaRepository<Knjiga, Integer>{

	@Query("select k from Knjiga k inner join k.kategorijas kat where kat.idKategorija = :id")
	public List<Knjiga> findByKategorija(@Param("id")Integer kat);
	
	@Query("select k from Knjiga k inner join k.korisniks kor where kor.idKorisnik like :id")
	public List<Knjiga> findByKorisnik(@Param("id")Integer kor);
	
	@Query("select k from Knjiga k where k.naziv like :naziv")
	public Knjiga findByNaziv(@Param("naziv")String naziv);
}
