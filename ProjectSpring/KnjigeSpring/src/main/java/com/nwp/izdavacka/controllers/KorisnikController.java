package com.nwp.izdavacka.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nwp.izdavacka.repositories.KorisnikRepository;

import model.Korisnik;

@RestController  
@CrossOrigin(origins="http://localhost:4200")  
@RequestMapping(value="/api/korisnik/")  
public class KorisnikController {

	@Autowired
	KorisnikRepository korisnikRep;
	
	//dobavi sve korisnike
	@GetMapping(value="knjigas-list")
	public ResponseEntity<List<Korisnik>> allKorisniks(){
		List<Korisnik> korisnici = korisnikRep.findAll();
		return new ResponseEntity<List<Korisnik>>(korisnici, HttpStatus.OK);
	}
}
