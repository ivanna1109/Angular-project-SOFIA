import { Knjiga } from './Knjiga';
import { Korisnik } from './Korisnik';

export class Ocena {
    idOcena: number = 0;
    vrednost: number = 0;
    knjiga: Knjiga = new Knjiga()
    korisnik: Korisnik = new Korisnik()   
}