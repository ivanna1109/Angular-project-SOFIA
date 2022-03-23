package model;

import java.io.Serializable;
import javax.persistence.*;

import java.util.ArrayList;
import java.util.List;


/**
 * The persistent class for the izdavac database table.
 * 
 */
@Entity
@NamedQuery(name="Izdavac.findAll", query="SELECT i FROM Izdavac i")
public class Izdavac implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idIzdavac;

	private String adresa;

	private String naziv;

	private String telefon;

	//bi-directional many-to-one association to Knjiga
	@OneToMany(mappedBy="izdavac")
	private List<Knjiga> knjigas;

	public Izdavac() {
		this.knjigas = new ArrayList<Knjiga>();
	}

	public int getIdIzdavac() {
		return this.idIzdavac;
	}

	public void setIdIzdavac(int idIzdavac) {
		this.idIzdavac = idIzdavac;
	}

	public String getAdresa() {
		return this.adresa;
	}

	public void setAdresa(String adresa) {
		this.adresa = adresa;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getTelefon() {
		return this.telefon;
	}

	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}

	public List<Knjiga> getKnjigas() {
		return this.knjigas;
	}

	public void setKnjigas(List<Knjiga> knjigas) {
		this.knjigas = knjigas;
	}

	public Knjiga addKnjiga(Knjiga knjiga) {
		getKnjigas().add(knjiga);
		knjiga.setIzdavac(this);

		return knjiga;
	}

	public Knjiga removeKnjiga(Knjiga knjiga) {
		getKnjigas().remove(knjiga);
		knjiga.setIzdavac(null);

		return knjiga;
	}

	@Override
	public String toString() {
		return "Izdavac: " + naziv;
	}

}