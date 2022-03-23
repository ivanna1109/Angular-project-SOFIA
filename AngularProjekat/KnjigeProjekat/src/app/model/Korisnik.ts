
import { Uloga } from './Uloga'

export class Korisnik {
    idKorisnik: number =  0
    adresa:String = ''
    brojGodina: number = 0
    ime: String = ''
    prezime: String = ''
    korisnickoIme: String = ''
    sifra: String = ''
    uloga: Uloga = new Uloga()  
}