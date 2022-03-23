package com.nwp.izdavacka.controllers;
import org.springframework.web.bind.annotation.RestController;

import com.nwp.izdavacka.repositories.IzdavacRepository;
import com.nwp.izdavacka.repositories.KategorijaRepository;
import com.nwp.izdavacka.repositories.KnjigaRepository;

import model.Izdavac;
import model.Kategorija;
import model.Knjiga;

import org.springframework.web.bind.annotation.CrossOrigin; 
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController  
@CrossOrigin(origins="http://localhost:4200")  
@RequestMapping(value="/api/kategorije/")  
public class KategorijaController {

	@Autowired
	KategorijaRepository kategorijaRep;
	
	@Autowired
	KnjigaRepository knjigaRep;
	
	@Autowired
	IzdavacRepository izdavacRep;
	
	//sve kategorije izlistaj
	@GetMapping(value="kategorijas-list")
	public ResponseEntity<List<Kategorija>> allKategorijas(){
		List<Kategorija> sveKategorije = kategorijaRep.findAll();
		return new ResponseEntity<List<Kategorija>>(sveKategorije, HttpStatus.OK);
	}
	
	//nadji kategoriju po imenu
	@GetMapping(value="nadji-kategoriju/{nazivKategorije}")
	public ResponseEntity<Kategorija> pronadjiKategoriju(@PathVariable String nazivKategorije){
		Kategorija kat = kategorijaRep.findByNazivKategorije(nazivKategorije);
		return new ResponseEntity<Kategorija>(kat, HttpStatus.OK);
	}
	
	//dobavljanje knjiga odredjene kategorije
	@GetMapping(value="knjige-za-kategoriju/{idKategorija}")
	public ResponseEntity<List<Knjiga>> knjigeZaKategoriju(@PathVariable Integer idKategorija){
		List<Knjiga> knjige = knjigaRep.findByKategorija(idKategorija);
		return new ResponseEntity<List<Knjiga>>(knjige, HttpStatus.OK);
	}
	
	@GetMapping(value="izdavaci-list")
	public ResponseEntity<List<Izdavac>> allIzdavaci(){
		List<Izdavac> sviIzdavaci = izdavacRep.findAll();
		return new ResponseEntity<List<Izdavac>>(sviIzdavaci, HttpStatus.OK);
	}
	
}
