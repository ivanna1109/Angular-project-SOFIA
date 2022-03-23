import { Knjiga } from './Knjiga'
import { Korisnik } from './Korisnik'

export class Narudzbenica {
    idNarudzbenica: number = 0
    datumNarucivanja: Date = new Date
    ukupanIznos: number = 0
    knjiga: Knjiga = new Knjiga()
    korisnik: Korisnik = new Korisnik()
}