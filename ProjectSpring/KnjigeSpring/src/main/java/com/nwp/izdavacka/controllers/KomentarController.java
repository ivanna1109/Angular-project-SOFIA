package com.nwp.izdavacka.controllers;

import org.springframework.web.bind.annotation.RestController;

import com.nwp.izdavacka.repositories.KnjigaRepository;
import com.nwp.izdavacka.repositories.KomentarRepository;
import com.nwp.izdavacka.repositories.KorisnikRepository;

import model.Knjiga;
import model.Komentar;
import model.Korisnik;

import org.springframework.web.bind.annotation.CrossOrigin; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;

@RestController  
@CrossOrigin(origins="http://localhost:4200")  
@RequestMapping(value="/api/komentari/")  
public class KomentarController {
	
	@Autowired
	KomentarRepository komentarRep;
	
	@Autowired
	KorisnikRepository korisnikRep;
	
	@Autowired
	KnjigaRepository knjigaRep;
	
	//komentarisanje
	@PostMapping(value="komentarisi")
	public boolean komentarisiKnjigu(@RequestParam(name="idKnjiga") Integer idKnjiga, @RequestParam(name="idKorisnik") Integer idKorisnik, @RequestParam(name="komentar") String komentar) {
		Korisnik kor = korisnikRep.findById(idKorisnik).get();
		
		Knjiga knjiga = knjigaRep.findById(idKnjiga).get();
		Komentar kom = new Komentar();
		
		kom.setTekst(komentar);
		kom.setKorisnik(kor);
		kom.setKnjiga(knjiga);
		
		komentarRep.save(kom);
		
		knjiga.getKomentars().add(kom); 
		knjigaRep.save(knjiga);
		
		kor.getKomentars().add(kom); 
		korisnikRep.save(kor);
		
		return true;
	}

}
