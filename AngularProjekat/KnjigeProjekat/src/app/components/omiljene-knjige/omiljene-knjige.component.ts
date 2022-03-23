import { ThisReceiver } from '@angular/compiler';
import { Component, Input, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';
import { Izdavac } from 'src/app/model/Izdavac';
import { Knjiga } from 'src/app/model/Knjiga';
import { Pisac } from 'src/app/model/Pisac';
import { KnjigaService } from 'src/app/services/knjiga.service';

@Component({
  selector: 'app-omiljene-knjige',
  templateUrl: './omiljene-knjige.component.html',
  styleUrls: ['./omiljene-knjige.component.css']
})
export class OmiljeneKnjigeComponent implements OnInit {

  public omiljeneKnjige: Knjiga[]
  @Input()public omiljena: Knjiga
  @Output()public pisac: Pisac
  @Output()public izdavac: Izdavac


  constructor(private knjigeService: KnjigaService, private router:Router) { }

  ngOnInit(): void {
    const idKor = localStorage.getItem('idKorisnika');
    if ( idKor != undefined){
        var id:number = +idKor;
        this.knjigeService.vratiOmiljeneKnjige(id).subscribe((resp:any) => {
          this.omiljeneKnjige = resp;
          this.knjigeService.getPisac(this.omiljena.idKnjiga).subscribe((resp:any) => {
            this.pisac = resp;
          }),
          this.knjigeService.getIzdavac(this.omiljena.idKnjiga).subscribe((resp:any) => {
            this.izdavac = resp;
            console.log(this.izdavac.naziv)
          });
        })
    }
    console.log("Velicina liste:"+this.omiljeneKnjige.length)
  }

  vratiPisca(idKnjiga:number){
    console.log("u pisac metodi");
    this.knjigeService.getPisac(idKnjiga).subscribe((resp:any) => {
      this.pisac = resp;
    });
  }

  vratiIzdavaca(idKnjiga:number){
    console.log("u izdavac metodi");
    this.knjigeService.getIzdavac(idKnjiga).subscribe((resp:any) => {
      this.izdavac = resp;
      console.log(this.izdavac.naziv)
    });
  }

  izbrisiIzOmiljenih(idKnjiga:number){
    console.log(localStorage.getItem("idKorisnika"))
    if (localStorage.getItem('idKorisnika')){
      this.knjigeService.izbrisiOmiljenuKnjigu(localStorage.getItem('idKorisnika'), idKnjiga.toString()).subscribe((resp:any) => {
        if (resp == true){
          alert('Uspešno ste uklonili knjigu iz liste omiljenih knjiga!')
          window.location.href = "http://localhost:4200/omiljene-knjige"
        } else 
            alert("Greškra pri uklanjanju knjige sa liste!")         
           //da ti se reloaduje stranica
      })
    }
  }

}
