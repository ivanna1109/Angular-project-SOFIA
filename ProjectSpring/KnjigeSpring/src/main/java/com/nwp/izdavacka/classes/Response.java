package com.nwp.izdavacka.classes;

public class Response {

	private int idKorisnika;
	private int idUloga;
	private String token;
	
	public Response() {
		this.idKorisnika = 0;
		this.idUloga = 0;
		this.token = "";
	}

	public int getIdKorisnika() {
		return idKorisnika;
	}

	public void setIdKorisnika(int idKorisnika) {
		this.idKorisnika = idKorisnika;
	}

	public int getIdUloga() {
		return idUloga;
	}

	public void setIdUloga(int idUloga) {
		this.idUloga = idUloga;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	@Override
	public String toString() {
		return "Response [idKorisnika=" + idKorisnika + ", token=" + token + "]";
	}
}
