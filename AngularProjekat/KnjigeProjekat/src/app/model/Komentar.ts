import { Knjiga } from './Knjiga'
import { Korisnik } from './Korisnik'

export class Komentar {
    idKomentar: number = 0
    tekst: String = ''
    knjiga: Knjiga = new Knjiga()
}