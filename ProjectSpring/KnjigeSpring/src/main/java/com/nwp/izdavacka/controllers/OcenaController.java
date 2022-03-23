package com.nwp.izdavacka.controllers;

import org.springframework.web.bind.annotation.RestController;

import com.nwp.izdavacka.repositories.KnjigaRepository;
import com.nwp.izdavacka.repositories.KorisnikRepository;
import com.nwp.izdavacka.repositories.OcenaRepository;

import model.Knjiga;
import model.Korisnik;
import model.Ocena;

import org.springframework.web.bind.annotation.CrossOrigin; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;

@RestController  
@CrossOrigin(origins="http://localhost:4200")  
@RequestMapping(value="/api/ocene/")  
public class OcenaController {

	@Autowired
	OcenaRepository ocenaRep;
	
	@Autowired
	KnjigaRepository knjigaRep;
	
	@Autowired
	KorisnikRepository korisnikRep;
	
	@PostMapping(value="oceni")
	public boolean oceniKnjigu(@RequestParam(name="idKnjiga") Integer idKnjiga, @RequestParam(name="idKorisnik") Integer idKorisnik, @RequestParam(name="vrednost") int vrednost) {
		Korisnik kor = korisnikRep.findById(idKorisnik).get(); 
		Knjiga knjiga = knjigaRep.findById(idKnjiga).get();
		Ocena oc = new Ocena();
		
		List<Ocena> korisnikoveOcene = kor.getOcenas();
		boolean nasao = false;
		for(Ocena o: korisnikoveOcene) {
			if ( o.getKnjiga().getIdKnjiga() == knjiga.getIdKnjiga()) {	
				nasao = true;
				break;
			}
		}
		if ( !nasao) {
			oc.setVrednost(vrednost);
			oc.setKorisnik(kor);
			oc.setKnjiga(knjiga);
			
			ocenaRep.save(oc);
			
			knjiga.getOcenas().add(oc); //kako da update tabelu
			knjigaRep.save(knjiga);
			kor.getOcenas().add(oc); //kako da update tabelu	
			korisnikRep.save(kor);
			return true;
		} else 
			return false;
	}
	

}
