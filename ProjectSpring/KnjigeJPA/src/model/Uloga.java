package model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.ArrayList;
import java.util.List;


/**
 * The persistent class for the uloga database table.
 * 
 */
@Entity
@NamedQuery(name="Uloga.findAll", query="SELECT u FROM Uloga u")
public class Uloga implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idUloga;

	private String naziv;

	private int plata;

	//bi-directional many-to-one association to Korisnik
	@OneToMany(mappedBy="uloga")
	@JsonIgnore
	private List<Korisnik> korisniks;

	public Uloga() {
		this.korisniks = new ArrayList<Korisnik>();
	}

	public int getIdUloga() {
		return this.idUloga;
	}

	public void setIdUloga(int idUloga) {
		this.idUloga = idUloga;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public int getPlata() {
		return this.plata;
	}

	public void setPlata(int plata) {
		this.plata = plata;
	}

	public List<Korisnik> getKorisniks() {
		return this.korisniks;
	}

	public void setKorisniks(List<Korisnik> korisniks) {
		this.korisniks = korisniks;
	}

	public Korisnik addKorisnik(Korisnik korisnik) {
		getKorisniks().add(korisnik);
		korisnik.setUloga(this);

		return korisnik;
	}

	public Korisnik removeKorisnik(Korisnik korisnik) {
		getKorisniks().remove(korisnik);
		korisnik.setUloga(null);

		return korisnik;
	}

}