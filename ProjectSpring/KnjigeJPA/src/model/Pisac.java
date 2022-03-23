package model;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.ArrayList;
import java.util.List;


/**
 * The persistent class for the pisac database table.
 * 
 */
@Entity
@NamedQuery(name="Pisac.findAll", query="SELECT p FROM Pisac p")
public class Pisac implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idPisac;

	private String ime;

	private String prezime;

	//bi-directional many-to-one association to Knjiga
	@OneToMany(mappedBy="pisac")
	@JsonIgnore
	private List<Knjiga> knjigas;

	public Pisac() {
		this.knjigas = new ArrayList<Knjiga>();
	}

	public int getIdPisac() {
		return this.idPisac;
	}

	public void setIdPisac(int idPisac) {
		this.idPisac = idPisac;
	}

	public String getIme() {
		return this.ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getPrezime() {
		return this.prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public List<Knjiga> getKnjigas() {
		return this.knjigas;
	}

	public void setKnjigas(List<Knjiga> knjigas) {
		this.knjigas = knjigas;
	}

	public Knjiga addKnjiga(Knjiga knjiga) {
		getKnjigas().add(knjiga);
		knjiga.setPisac(this);

		return knjiga;
	}

	public Knjiga removeKnjiga(Knjiga knjiga) {
		getKnjigas().remove(knjiga);
		knjiga.setPisac(null);

		return knjiga;
	}

	@Override
	public String toString() {
		return "Pisac:" + ime + " " + prezime;
	}

}