import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Izdavac } from '../model/Izdavac';
import { Kategorija } from '../model/Kategorija';
import { Knjiga } from '../model/Knjiga';

@Injectable({
  providedIn: 'root'
})
export class KategorijaService {

  private BACKEND_BASE="http://localhost:8080/api/kategorije/"

  constructor(private httpClient: HttpClient) { }

  getKategorije(): Observable<Kategorija[]> {
    return this.httpClient.get<Kategorija[]>(this.BACKEND_BASE+"kategorijas-list")
  }

  getKnjigeZaKategoriju(idKategorija:number){
    return this.httpClient.get<Knjiga[]>(this.BACKEND_BASE+"knjige-za-kategoriju/"+idKategorija);
  }

  getIzdavaci():Observable<Izdavac[]>{
    return this.httpClient.get<Izdavac[]>(this.BACKEND_BASE+'izdavaci-list')
  }
}
