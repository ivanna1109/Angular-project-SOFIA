package com.nwp.izdavacka.controllers;

import org.springframework.web.bind.annotation.RestController;

import com.nwp.izdavacka.repositories.IzdavacRepository;
import com.nwp.izdavacka.repositories.KategorijaRepository;
import com.nwp.izdavacka.repositories.KnjigaRepository;
import com.nwp.izdavacka.repositories.KomentarRepository;
import com.nwp.izdavacka.repositories.KorisnikRepository;
import com.nwp.izdavacka.repositories.NarudzbenicaRepository;
import com.nwp.izdavacka.repositories.OcenaRepository;
import com.nwp.izdavacka.repositories.PisacRepository;

import model.Izdavac;
import model.Kategorija;
import model.Knjiga;
import model.Komentar;
import model.Korisnik;
import model.Narudzbenica;
import model.Ocena;
import model.Pisac;

import org.springframework.web.bind.annotation.CrossOrigin; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@RestController  
@CrossOrigin(origins="http://localhost:4200")  
@RequestMapping(value="/api/knjige/")  
public class KnjigaController {

	@Autowired
	KnjigaRepository knjigaRep;	
	
	@Autowired
	KorisnikRepository korisnikRep;
	
	@Autowired
	IzdavacRepository izdavacRep;
	
	@Autowired
	KategorijaRepository kategorijaRep;
	
	@Autowired
	PisacRepository pisacRep;
	
	@Autowired
	OcenaRepository ocenaRep;
	
	@Autowired
	KomentarRepository komentarRep;
	
	@Autowired
	NarudzbenicaRepository narudzbenicaRep;
	
	//dobavljanje svih knjiga
	@GetMapping(value="knjigas-list")
	public ResponseEntity<List<Knjiga>> allKnjigas(){
		List<Knjiga> sveKnjige = knjigaRep.findAll();
		return new ResponseEntity<List<Knjiga>>(sveKnjige, HttpStatus.OK);
	}
	
	//dobavljanje knjiga odredjene kategorije
	@GetMapping(value="knjige-za-kategoriju/{idKategorija}")
	public ResponseEntity<List<Knjiga>> knjigeZaKategoriju(@PathVariable Integer kat){
		List<Knjiga> knjige = knjigaRep.findByKategorija(kat);
		return new ResponseEntity<List<Knjiga>>(knjige, HttpStatus.OK);
	}
	
	//pronadji po imenu knjigu
	@GetMapping(value="knjiga-po-imenu/{naziv}")
	public ResponseEntity<Knjiga> nadjiPoImenu(@PathVariable String naziv){
		Knjiga trazena = knjigaRep.findByNaziv(naziv);
		if (trazena == null) {
			return new ResponseEntity<Knjiga>(trazena, HttpStatus.OK);
		}
		return new ResponseEntity<Knjiga>(trazena, HttpStatus.OK);
	}
	
	//nadjiPiscaZaKnjigu
	@GetMapping(value="pisac-za-knjigu/{idKnjiga}")
	public ResponseEntity<Pisac> vratiPisca(@PathVariable Integer idKnjiga){
		Knjiga knjiga = knjigaRep.findById(idKnjiga).get();
		Pisac pisacKnjige = knjiga.getPisac();
		return new ResponseEntity<Pisac>(pisacKnjige, HttpStatus.OK);
	}
	
	@GetMapping(value="izdavac-za-knjigu/{idKnjiga}")
	public ResponseEntity<Izdavac> vratiIzdavaca(@PathVariable Integer idKnjiga){
		Knjiga knjiga = knjigaRep.findById(idKnjiga).get();
		Izdavac izdavacKnjige = knjiga.getIzdavac();
		return new ResponseEntity<Izdavac>(izdavacKnjige, HttpStatus.OK);
	}
	
	@GetMapping(value="prosecna-ocena/{idKnjiga}")
	public ResponseEntity<Double> prosecnaOcena(@PathVariable Integer idKnjiga){
		List<Ocena> listaOcena = ocenaRep.findByKnjiga(idKnjiga);
		double tmp = 0.0;
		if ( listaOcena.size() == 0) {
			return new ResponseEntity<Double>(tmp, HttpStatus.OK);
		}
		else {
			for (int i = 0; i < listaOcena.size(); i++) {
				tmp+= listaOcena.get(i).getVrednost();
			}
			tmp /= listaOcena.size();
			return new ResponseEntity<Double>(tmp, HttpStatus.OK);
		}
	}
	
	//omiljene knjige
	@GetMapping(value="omiljene-knjige/{idKorisnik}")
	public ResponseEntity<List<Knjiga>> getOmiljeneKnjigeZaKorisnika(@PathVariable Integer idKorisnik) {
		Korisnik kor = korisnikRep.findById(idKorisnik).get();
		List<Knjiga> omiljene = knjigaRep.findByKorisnik(kor.getIdKorisnik());
		
		//vidi kako da proveris da li je ovo null
		return new ResponseEntity<List<Knjiga>>(omiljene, HttpStatus.OK);
	}
	
	@GetMapping(value="omiljena-knjiga")
	public ResponseEntity<Boolean> omiljenaKnjiga(@RequestParam(name="idKorisnik") String idKorisnik, @RequestParam(name="idKnjiga") String idKnjiga){
		List<Knjiga> omiljeneKnjige = knjigaRep.findByKorisnik(Integer.parseInt(idKorisnik));
		if (omiljeneKnjige.size() != 0) {
			for (int i = 0; i < omiljeneKnjige.size(); i++) {
				if (omiljeneKnjige.get(i).getIdKnjiga() == knjigaRep.findById(Integer.parseInt(idKnjiga)).get().getIdKnjiga()) {
					return new ResponseEntity<Boolean>(true, HttpStatus.OK);
				}
			}
		}
		return new ResponseEntity<Boolean>(false, HttpStatus.OK);
	}
	
	//dodaj knjigu u omiljenu
	@PostMapping(value="dodaj-omiljenu")
	public ResponseEntity<Boolean> dodaj(@RequestParam(name="idKorisnik") String idKorisnik, @RequestParam(name="idKnjiga") String idKnjiga) {
		Korisnik korisnik = korisnikRep.findById(Integer.parseInt(idKorisnik)).get();
		
		Knjiga knjiga = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();
		List<Knjiga> omiljene = korisnik.getKnjigas();
		
		List<Integer> tmp = omiljene.stream().map(x -> x.getIdKnjiga()).collect(Collectors.toList());
		
		if (tmp.contains(knjiga.getIdKnjiga())) {
			return new ResponseEntity<Boolean>(false, HttpStatus.OK);	
		} else {
			korisnik.getKnjigas().add(knjiga);
			korisnikRep.save(korisnik);
			knjiga.getKorisniks().add(korisnik);
			knjigaRep.save(knjiga);
			return new ResponseEntity<Boolean>(true, HttpStatus.OK);
		}
	}
	
	//izbrisi iz omiljenih
//	@RequestMapping(value="/izbrisiOmiljenu", method=RequestMethod.POST) //nisam sigurna da li je post u pitanju???
	@PostMapping(value="izbrisi-omiljenu")
	public ResponseEntity<Boolean> izbrisiOmiljenuKnjigu(@RequestParam(name="idKorisnik") String idKorisnik, @RequestParam(name="idKnjiga") String idKnjiga) {
		Korisnik kor = korisnikRep.findById(Integer.parseInt(idKorisnik)).get();
		Knjiga knjiga = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();	

		knjiga.getKorisniks().remove(kor);
		knjigaRep.save(knjiga);
		kor.getKnjigas().remove(knjiga);
		korisnikRep.save(kor);
		
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}
	
	//ocenjivanje knjige
	@PostMapping(value="oceni-knjigu")
	public ResponseEntity<Boolean> oceniKnjigu(@RequestParam(name="idKnjiga") String idKnjiga, @RequestParam(name="idKorisnik") String idKorisnik, @RequestParam(name="vrednost") String vrednost) {
		Korisnik kor = korisnikRep.findById(Integer.parseInt(idKorisnik)).get(); 
		Knjiga knjiga = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();
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
			oc.setVrednost(Integer.parseInt(vrednost));
			oc.setKorisnik(kor);
			oc.setKnjiga(knjiga);
			
			ocenaRep.save(oc);
			
			knjiga.getOcenas().add(oc); //kako da update tabelu
			knjigaRep.save(knjiga);
			kor.getOcenas().add(oc); //kako da update tabelu	
			korisnikRep.save(kor);
			return new ResponseEntity<Boolean>(true, HttpStatus.OK);
		} else 
			return new ResponseEntity<Boolean>(false, HttpStatus.OK);
	}
	
	@PostMapping(value="komentarisi-knjigu")
	public boolean komentarisiKnjigu(@RequestParam(name="idKnjiga") String idKnjiga, @RequestParam(name="idKorisnik") String idKorisnik, @RequestParam(name="komentar") String komentar) {
		Korisnik kor = korisnikRep.findById(Integer.parseInt(idKorisnik)).get();
		
		Knjiga knjiga = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();
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
	
	@GetMapping(value="stara-cena/{idKnjiga}")
	public ResponseEntity<Integer> staraCena(@PathVariable String idKnjiga){
		Knjiga found = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();
		
		int staraCena = (100* found.getCena()) / (100 - found.getAkcija());
		
		return new ResponseEntity<Integer>(staraCena, HttpStatus.OK);
	}
	
	//--------------------------------------radnik opcije-------------------------------------------------

	
	//tri knjige koje su se najvise narucivale
	@GetMapping(value="knjiga-statistika")
	public ResponseEntity<List<Knjiga>> najpopularnijeKnjige(){
		List<Narudzbenica> narucene = narudzbenicaRep.findAll();
		List<Knjiga> konacnaLista = new ArrayList<Knjiga>();
		HashMap<Knjiga, Integer> mapa = new HashMap<Knjiga, Integer>();
		if ( narucene.size() != 0) {
		for (int i = 0; i < narucene.size(); i++) {
			Knjiga knjiga = narucene.get(i).getKnjiga();
			if (mapa.containsKey(knjiga)) {
				int vrednost = mapa.get(knjiga);
				vrednost++;
				mapa.put(knjiga, vrednost);
			} else {
				mapa.put(knjiga, 1);
			}
		}
		//sortirana mapa po vrednostima
			mapa.entrySet()
			.stream()
			.sorted(Map.Entry.comparingByValue());

			List<Knjiga> knjige = new ArrayList<Knjiga>(mapa.keySet());
		
			for (int j = 0; j < 3; j++) {
				konacnaLista.add(knjige.get(j));
			}		
			return new ResponseEntity<List<Knjiga>>(konacnaLista, HttpStatus.OK);
		} else {
			return new ResponseEntity<List<Knjiga>>(konacnaLista, HttpStatus.OK);
		}
	}
	
	//tri knjige sa najvisom ocenom
	@GetMapping(value="ocene-statistika")
	public ResponseEntity<List<Knjiga>> oceneKnjige(){
		List<Knjiga> knjige = knjigaRep.findAll();
		List<Knjiga> konacnaLista = new ArrayList<Knjiga>();
		HashMap<Knjiga, Integer> mapa = new HashMap<Knjiga, Integer>();
		if ( knjige.size() != 0) {
		for (int i = 0; i < knjige.size(); i++) {
			List<Ocena> ocenaKnjige = knjige.get(i).getOcenas();
			int ukupnaOcena = 0;
			for (Ocena o: ocenaKnjige) {
				ukupnaOcena += o.getVrednost();
			}
			if ( ocenaKnjige.size() > 0) {
				ukupnaOcena /= ocenaKnjige.size();
			}
			mapa.put(knjige.get(i),ukupnaOcena);
			}
		}
		//sortirana mapa po vrednostima
			mapa.entrySet()
			.stream()
			.sorted(Map.Entry.comparingByValue());

			List<Knjiga> knjigePom = new ArrayList<Knjiga>(mapa.keySet());
		
			for (int j = 0; j < 3; j++) {
				konacnaLista.add(knjigePom.get(j));
			}		
			return new ResponseEntity<List<Knjiga>>(konacnaLista, HttpStatus.OK);
	}
	
	@PostMapping(value="dodaj-knjigu")
	public ResponseEntity<Boolean> sacuvajKnjigu(@RequestParam(name="idKategorija")String idKategorija, @RequestParam(name="naziv")String naziv, 
			@RequestParam(name="izdavac") String izdavacNaz,
			@RequestParam(name="imePisca") String imePisca,
			@RequestParam(name="prezimePisca") String prezimePisca,
			@RequestParam(name="godinaIzdanja") String godinaIzdanja,
			@RequestParam(name="cena") String cena, @RequestParam(name="brojKnjigaLager") String brojKnjigaNaLageru, 
			@RequestParam(name="kratakOpis") String opis,
			@RequestParam(name="slika") String slikaUrl){		
		
		Kategorija kat1 = kategorijaRep.findById(Integer.parseInt(idKategorija)).get();
		Pisac pom = pisacRep.findByImeIPrezime(imePisca, prezimePisca);	
		Izdavac izdavac = izdavacRep.findByNaziv(izdavacNaz);
		
		
		Knjiga novaKnjiga = new Knjiga();
		//fali jos kategorija i mesto za sliku i pisca
		novaKnjiga.setNaziv(naziv);
		novaKnjiga.setIzdavac(izdavac);
		novaKnjiga.setGodinaIzdanja(Integer.parseInt(godinaIzdanja));
		novaKnjiga.setAkcija(0);
		novaKnjiga.setCena(Integer.parseInt(cena));
		novaKnjiga.setBrojKnjigaLager(Integer.parseInt(brojKnjigaNaLageru));
		novaKnjiga.setKratakOpis(opis);
		novaKnjiga.getKategorijas().add(kat1); //videcemo sta cemo sa ostalim kategorijama
		
		novaKnjiga.setSlika(slikaUrl);
		
		if (pom != null) {
			novaKnjiga.setPisac(pom);
			knjigaRep.save(novaKnjiga);
			pom.getKnjigas().add(novaKnjiga);
			pisacRep.save(pom);			
		} else {
			Pisac noviPisac = new Pisac();
			noviPisac.setIme(imePisca);
			noviPisac.setPrezime(prezimePisca);
			pisacRep.save(noviPisac);
			novaKnjiga.setPisac(noviPisac);
			knjigaRep.save(novaKnjiga);
			noviPisac.getKnjigas().add(novaKnjiga);
			pisacRep.save(noviPisac);					
		}

		kat1.getKnjigas().add(novaKnjiga);
		kategorijaRep.save(kat1);
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
		
	}
	
	@PostMapping(value="postavi-akciju")
	public ResponseEntity<Boolean> postaviAkciju(@RequestParam(name="idKnjiga") String idKnjiga, @RequestParam(name="akcija") String akcija){
		Knjiga trazena = knjigaRep.findById(Integer.parseInt(idKnjiga)).get();
		int trenutnaAkcija = trazena.getAkcija();
		int prosledjenaAkcija = Integer.parseInt(akcija);
		
		int novaCena = 0;
		if (prosledjenaAkcija == 0) { //nema vise akcije
			novaCena = (100*trazena.getCena()) / (100-trenutnaAkcija);
		} else {
			novaCena = ((100-prosledjenaAkcija)*trazena.getCena() ) / 100;
		}
		trazena.setAkcija(prosledjenaAkcija);	
		trazena.setCena(novaCena);
		knjigaRep.save(trazena);
		
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}
	
}
