package com.nwp.izdavacka.controllers;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nwp.izdavacka.classes.Response;
import com.nwp.izdavacka.repositories.KategorijaRepository;
import com.nwp.izdavacka.repositories.KorisnikRepository;
import com.nwp.izdavacka.repositories.UlogaRepository;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import model.Korisnik;


@Controller
@RequestMapping(value="/api/user/")
public class LoginController {
	
	@Autowired
	KorisnikRepository korisnikRep;
	
	@Autowired
	UlogaRepository ulogaRep;
	
	@Autowired
	KategorijaRepository kategorijaRep;

	@PostMapping(value="login")
	public ResponseEntity<Response> login(@RequestBody Korisnik k, Principal principal) {
		Korisnik kor = korisnikRep.findByKorisnickoIme(k.getKorisnickoIme());
		Response resp = new Response();
		if ( kor == null) { //ukoliko nema korisnika u listi korisnika
			return new ResponseEntity<Response>(resp, HttpStatus.OK);
		}
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		if ( !passEncoder.matches(k.getSifra(), kor.getSifra())) //ukoliko se sifra ne poklapa sa sifrom koja odgovara tom usernameu
			return new ResponseEntity<Response>(resp, HttpStatus.OK);
		resp.setIdKorisnika(kor.getIdKorisnik());
		resp.setIdUloga(kor.getUloga().getIdUloga());
		resp.setToken(getJWTToken(k.getKorisnickoIme()));
		return new ResponseEntity<Response>(resp, HttpStatus.OK);
	}
	
	@PostMapping(value="register")
	public ResponseEntity<Boolean> registracija(@RequestParam(name="username") String username, @RequestParam(name="password") String password,
			@RequestParam(name="ime") String ime, @RequestParam(name="prezime") String prezime,
			@RequestParam(name="brojGodina") String brojGodina, @RequestParam(name="adresa") String adresa, HttpServletRequest request) {
		int brojGod = Integer.parseInt(brojGodina);
		Korisnik kor = korisnikRep.findByKorisnickoIme(username);
		if (kor != null) {
			return new ResponseEntity<Boolean>(false, HttpStatus.OK);
		}

		Korisnik k = new Korisnik();
		BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
		password = passEncoder.encode(password);
		
		k.setKorisnickoIme(username);
		k.setSifra(password);
		k.setIme(ime);
		k.setPrezime(prezime);
		k.setBrojGodina(brojGod);
		k.setAdresa(adresa);
		
		k.setUloga(ulogaRep.findById(1).get());
		
		korisnikRep.save(k);
		
		return new ResponseEntity<Boolean>(true, HttpStatus.OK);		
	}
	
	//dobavi JWT token koji salje u response
	private String getJWTToken(String username) {
		String secretKey = "mySecretKey";
		List<GrantedAuthority> grantedAuthorities = AuthorityUtils.commaSeparatedStringToAuthorityList(korisnikRep.findByKorisnickoIme(username).getUloga().getNaziv());
		
		String token = Jwts.builder()
				.setId("softtekJWT")
				.setSubject(username)
				.claim("authorities",
						grantedAuthorities.stream()
								.map(GrantedAuthority::getAuthority)
								.collect(Collectors.toList()))
				.setIssuedAt(new Date(System.currentTimeMillis()))
				.setExpiration(new Date(System.currentTimeMillis() + 600000))
				.signWith(SignatureAlgorithm.HS512,
						secretKey.getBytes()).compact();

		return "Bearer " + token;
	}
	
//    @RequestMapping(value="/logout", method = RequestMethod.GET)
//    public String logoutPage(HttpServletRequest request, HttpServletResponse response){
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        if (auth != null){    
//            SecurityContextHolder.getContext().setAuthentication(null);
//        }
//        return "login";
//    }
    
}

