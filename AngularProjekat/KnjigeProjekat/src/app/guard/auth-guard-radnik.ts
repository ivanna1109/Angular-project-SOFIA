import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot } from '@angular/router';

@Injectable()
export class AuthGuardRadnik implements CanActivate {

    public idUloga: number
    constructor(private router:Router){}

    canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
        console.log(localStorage.getItem("idUloga"))
        var x = localStorage.getItem("idUloga");
        if (x != null){
            this.idUloga = +x; //konvertuje string u broj, posto se iz localStoragea sve cita kao string, a nama treba idUloge
            if (localStorage.getItem("token") && this.idUloga == 2){
                console.log("proverili smo token i idUloge, poklapa se sa radnikom")
                return true;
            }
        }   
        console.log("prosli smo proveru za radnika, nije ulogovan radnik vec korisnik"); 
        alert("Niste ulogovani kao radnik!")
        this.router.navigate(["/sve-kategorije"])
        return false;
    }
}