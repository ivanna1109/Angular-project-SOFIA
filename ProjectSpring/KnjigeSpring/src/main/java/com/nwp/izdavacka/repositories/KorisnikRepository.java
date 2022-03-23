package com.nwp.izdavacka.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Korisnik;

public interface KorisnikRepository extends JpaRepository<Korisnik, Integer>{

	public Korisnik findByKorisnickoIme(String korisnicko);
}
