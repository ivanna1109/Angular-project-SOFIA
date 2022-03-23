package model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Date;


/**
 * The persistent class for the narudzbenica database table.
 * 
 */
@Entity
@NamedQuery(name="Narudzbenica.findAll", query="SELECT n FROM Narudzbenica n")
public class Narudzbenica implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idNarudzbenica;

	@Temporal(TemporalType.DATE)
	private Date datumNarucivanja;

	private int ukupanIznos;

	//bi-directional many-to-one association to Knjiga
	@ManyToOne
	@JsonIgnore
	private Knjiga knjiga;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JsonIgnore
	private Korisnik korisnik;

	public Narudzbenica() {
	}

	public int getIdNarudzbenica() {
		return this.idNarudzbenica;
	}

	public void setIdNarudzbenica(int idNarudzbenica) {
		this.idNarudzbenica = idNarudzbenica;
	}

	public Date getDatumNarucivanja() {
		return this.datumNarucivanja;
	}

	public void setDatumNarucivanja(Date datumNarucivanja) {
		this.datumNarucivanja = datumNarucivanja;
	}

	public int getUkupanIznos() {
		return this.ukupanIznos;
	}

	public void setUkupanIznos(int ukupanIznos) {
		this.ukupanIznos = ukupanIznos;
	}

	public Knjiga getKnjiga() {
		return this.knjiga;
	}

	public void setKnjiga(Knjiga knjiga) {
		this.knjiga = knjiga;
	}

	public Korisnik getKorisnik() {
		return this.korisnik;
	}

	public void setKorisnik(Korisnik korisnik) {
		this.korisnik = korisnik;
	}

}