import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  
  private BACKEND_BASE="http://localhost:8080/api/user/"

  constructor(private httpClient: HttpClient) { }

  login(username:string, password:string){
    return this.httpClient.post(this.BACKEND_BASE+"login", {
      korisnickoIme:username,
      sifra:password
    })
  }

  register(userForm:any){
    let params = new HttpParams()
    .set('ime', userForm.value.ime)
    .set('prezime', userForm.value.prezime)
    .set('username', userForm.value.username)
    .set('password', userForm.value.password)
    .set('brojGodina', userForm.value.brojGodina)
    .set('adresa', userForm.value.adresa)

    console.log(params)
    return this.httpClient.post(this.BACKEND_BASE+"register", params, 
    {
      headers: new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded'})
    })
  }

}
