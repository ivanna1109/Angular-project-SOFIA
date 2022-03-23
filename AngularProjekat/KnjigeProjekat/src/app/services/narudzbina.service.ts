import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Knjiga } from '../model/Knjiga';
import { Narudzbenica } from '../model/Narudzbenica';

@Injectable({
  providedIn: 'root'
})
export class NarudzbinaService {

  private BACKEND_BASE="http://localhost:8080/api/narucivanje/"

  constructor(private httpClient: HttpClient) { }

  vratiNarudzbine(idKorisnik:any):Observable<Narudzbenica[]>{
    return this.httpClient.get<Narudzbenica[]>(this.BACKEND_BASE+"sve-narudzbenice/"+idKorisnik)
  }

  knjigaZaNarudzbinu(idNarudzbina: any):Observable<Knjiga>{
    return this.httpClient.get<Knjiga>(this.BACKEND_BASE+'knjiga-narudzbine/'+idNarudzbina)
  }

  narucivanje(idKorisnik:any, idKnjiga: any, kolicina: any){
    let params = new HttpParams()
    .set('idKorisnik', idKorisnik)
    .set('idKnjiga', idKnjiga)
    .set('kolicina', kolicina)

    return this.httpClient.post(this.BACKEND_BASE+'naruci-knjigu', params, {
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }
}
