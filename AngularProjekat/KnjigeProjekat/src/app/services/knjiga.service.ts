import { HttpClient,HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Izdavac } from '../model/Izdavac';
import { Knjiga } from '../model/Knjiga';
import { Pisac } from '../model/Pisac';
import { map } from 'rxjs/operators'

@Injectable({
  providedIn: 'root'
})
export class KnjigaService {

  private BACKEND_BASE="http://localhost:8080/api/knjige/"

  constructor(private httpClient:HttpClient) { }

  getKnjige(): Observable<Knjiga[]>{
    return this.httpClient.get<Knjiga[]>(this.BACKEND_BASE+"knjigas-list").pipe(map(results => results.sort((knjiga1, knjiga2) => knjiga1.naziv.localeCompare(knjiga2.naziv))))
  }

  getPisac(idKnjiga: number):Observable<Pisac>{
    return this.httpClient.get<Pisac>(this.BACKEND_BASE+'pisac-za-knjigu/'+idKnjiga)
  }

  getIzdavac(idKnjiga: number):Observable<Izdavac>{
    return this.httpClient.get<Izdavac>(this.BACKEND_BASE+'izdavac-za-knjigu/'+idKnjiga)
  }

  nadjiKnjigu(nazivKnjige: String): Observable<Knjiga> {
    return this.httpClient.get<Knjiga>(this.BACKEND_BASE+'knjiga-po-imenu/'+nazivKnjige);
  }

  //tabela omiljenih knjiga --> na komponenti omiljene knjige
  vratiOmiljeneKnjige(idKorisnika: number):Observable<Knjiga[]> {
    return this.httpClient.get<Knjiga[]>(this.BACKEND_BASE+'omiljene-knjige/'+idKorisnika)
  }

  //izbrisati knigu iz omiljeni ---> to je na komponenti omiljene knjige
  izbrisiOmiljenuKnjigu(idKorisnika: any, idKnjiga: string):Observable<boolean>{
    let params = new HttpParams()
    .set('idKorisnik', idKorisnika)
    .set('idKnjiga', idKnjiga)
    return this.httpClient.post<boolean>(this.BACKEND_BASE+"izbrisi-omiljenu", params, 
    {
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }

  //dodavanje knjige u omiljene --> u komponenti knjige item 
  dodajKnjiguUOmiljene(idKorisnika: any, idKnjiga: string){
    let params = new HttpParams()
    .set('idKorisnik', idKorisnika)
    .set('idKnjiga', idKnjiga)
    return this.httpClient.post(this.BACKEND_BASE+"dodaj-omiljenu", params, 
    {
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }

  prosecnaOcena(idKnjiga: number):Observable<Number>{
    return this.httpClient.get<Number>(this.BACKEND_BASE+"prosecna-ocena/"+idKnjiga)
  }

  oceniKnjigu(idKorisnik: any,idKnjiga:string, ocena:string){
    let params = new HttpParams()
    .set('idKorisnik', idKorisnik)
    .set('idKnjiga', idKnjiga)
    .set('vrednost', ocena)

    return this.httpClient.post(this.BACKEND_BASE+'oceni-knjigu', params,{
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }

  komentarisiKnjigu(idKorisnik: any,idKnjiga:string, kom:string){
    let params = new HttpParams()
    .set('idKorisnik', idKorisnik)
    .set('idKnjiga', idKnjiga)
    .set('komentar', kom)

    return this.httpClient.post(this.BACKEND_BASE+'komentarisi-knjigu', params,{
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }

  //dodavanje knjige --> opcija radnik
  dodajNovuKnjigu(knjigaForm: any){
    let params= new HttpParams()
    .set('naziv', knjigaForm.value.naziv)
    .set('imePisca', knjigaForm.value.imePisca)
    .set('prezimePisca', knjigaForm.value.prezimePisca)
    .set('izdavac', knjigaForm.value.selectedIzdavac)
    .set('idKategorija', knjigaForm.value.selectedKategorija)
    .set('godinaIzdanja', knjigaForm.value.godinaIzdanja)
    .set('brojKnjigaLager', knjigaForm.value.brojKnjigaLager)
    .set('kratakOpis', knjigaForm.value.kratakOpis)
    .set('cena', knjigaForm.value.cena)
    .set('slika', knjigaForm.value.slika)

    return this.httpClient.post(this.BACKEND_BASE+"dodaj-knjigu", params, {
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })

  }

  postaviAkciju(idKnjiga: any, akcija:any){
    let params = new HttpParams()
    .set('idKnjiga', idKnjiga)
    .set('akcija', akcija)

    return this.httpClient.post(this.BACKEND_BASE+'postavi-akciju', params,{
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }

  vratiStaruCenu(idKnjiga:any):Observable<Number>{
    return this.httpClient.get<Number>(this.BACKEND_BASE+'stara-cena/'+idKnjiga)
  }

  //radnik
  najpopularnijeKnjige():Observable<Knjiga[]>{
    return this.httpClient.get<Knjiga[]>(this.BACKEND_BASE+'knjiga-statistika')
  }

  najboljeOcene():Observable<Knjiga[]>{
    return this.httpClient.get<Knjiga[]>(this.BACKEND_BASE+'ocene-statistika')
  }

}
