import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'IzdavackaKucaSOFIA';

   public idUloga: number

   constructor(private router:Router){}

   ngOnInit(){
   }

   proveriUlogovanost():boolean {
    const tmp =localStorage.getItem('idUloga')
    if (tmp != undefined) {
        return true;
    }
    return false;
  }

  proveriUlogovanostRadnika():boolean {
    const tmp =localStorage.getItem('idUloga')
    if (tmp != undefined && tmp == '2') {
        return true;
    }
    return false;
  }

  proveriUlogovanostKorisnika():boolean {
    const tmp =localStorage.getItem('idUloga')
    if (tmp != undefined && tmp == '1') {
        return true;
    }
    return false;
  }

  logOut(){
    localStorage.clear();
  }
 }
