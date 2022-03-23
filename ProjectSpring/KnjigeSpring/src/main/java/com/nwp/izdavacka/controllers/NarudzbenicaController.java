package com.nwp.izdavacka.controllers;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nwp.izdavacka.repositories.KnjigaRepository;
import com.nwp.izdavacka.repositories.KorisnikRepository;
import com.nwp.izdavacka.repositories.NarudzbenicaRepository;

import model.Knjiga;
import model.Korisnik;
import model.Narudzbenica;

@RestController  
@CrossOrigin(origins="http://localhost:4200")  
@RequestMapping(value="/api/narucivanje/")  
public class NarudzbenicaController {

	@Autowired
	NarudzbenicaRepository narudzbenicaRep;
	
	@Autowired
	KorisnikRepository korisnikRep;
	
	@Autowired
	KnjigaRepository knjigaRep;
	
	@GetMapping(value="sve-narudzbenice/{idKorisnik}")
	public ResponseEntity<List<Narudzbenica>> getNarudzbenice(@PathVariable String idKorisnik) {
		Korisnik kor = korisnikRep.findById(Integer.parseInt(idKorisnik)).get();		
		List<Narudzbenica> narudzbenice = narudzbenicaRep.findByKorisnik(kor);
		return new ResponseEntity<List<Narudzbenica>>(narudzbenice, HttpStatus.OK); 
	}
	
	@GetMapping(value="knjiga-narudzbine/{idNarudzbina}")
	public ResponseEntity<Knjiga> knjigaZaNarudzbinu(@PathVariable String idNarudzbina){
		Narudzbenica trazena = narudzbenicaRep.findById(Integer.parseInt(idNarudzbina)).get();
		Knjiga trazenaKnjiga = trazena.getKnjiga();
		return new ResponseEntity<Knjiga>(trazenaKnjiga, HttpStatus.OK);
	}
	
	@PostMapping(value="naruci-knjigu")
	public ResponseEntity<Boolean> naruciKnjigu(@RequestParam(name="idKorisnik")String idKorisnik, @RequestParam(name="idKnjiga")String idKnjiga,
			@RequestParam(name="kolicina")String kolicina) {
		Korisnik korisnik = korisnikRep.findById( Integer.parseInt(idKorisnik)).get();
		
		Knjiga knjiga = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();
		
		
		int kolicinaInt = Integer.parseInt(kolicina);
		
		if (knjiga.getBrojKnjigaLager() > 0) {
			for (int i = 0; i < kolicinaInt; i++) {
				Narudzbenica naruci = new Narudzbenica();
				naruci.setKnjiga(knjiga);
				naruci.setKorisnik(korisnik);
				naruci.setDatumNarucivanja(new Date());
				naruci.setUkupanIznos(knjiga.getCena()+200);
				
				narudzbenicaRep.save(naruci);
				
				korisnik.getNarudzbenicas().add(naruci);
				korisnikRep.save(korisnik);
				knjiga.getNarudzbenicas().add(naruci);
				knjiga.setBrojKnjigaLager(knjiga.getBrojKnjigaLager()-1);
				knjigaRep.save(knjiga);
			}
			return new ResponseEntity<Boolean>(true, HttpStatus.OK);
		}
			
		return new ResponseEntity<Boolean>(false, HttpStatus.OK);
	}
}
