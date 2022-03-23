package com.nwp.izdavacka.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Izdavac;

public interface IzdavacRepository extends JpaRepository<Izdavac, Integer>{

	public Izdavac findByNaziv(String naziv);
}
