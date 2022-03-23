import { InvokeFunctionExpr } from '@angular/compiler';
import { Component, Input, OnInit } from '@angular/core';
import { Izdavac } from 'src/app/model/Izdavac';
import { Knjiga } from 'src/app/model/Knjiga';
import { Pisac } from 'src/app/model/Pisac';
import { KnjigaService } from 'src/app/services/knjiga.service';

@Component({
  selector: 'app-knjiga-item',
  templateUrl: './knjiga-item.component.html',
  styleUrls: ['./knjiga-item.component.css']
})
export class KnjigaItemComponent implements OnInit {

  @Input()book: Knjiga = new Knjiga()
  izdavac: Izdavac = new Izdavac()
  pisac: Pisac = new Pisac();
  @Input() izabranaKnjiga: Knjiga

  constructor(private knjigaService: KnjigaService) { }

  ngOnInit(): void {
    this.knjigaService.getPisac(this.book.idKnjiga).subscribe((resp:any) => {
      this.pisac = resp
    })
    this.knjigaService.getIzdavac(this.book.idKnjiga).subscribe((resp:any)=>{
      this.izdavac = resp
    })
  }

  prikazKnjige(naziv:String){
    if (!localStorage.getItem('idKorisnika')){
      alert('Niste prijavljeni, ne možete pristupiti ovome!')
    }
    else {
      this.knjigaService.nadjiKnjigu(naziv).subscribe((resp:any) => {
        this.izabranaKnjiga = resp;
      })
      this.knjigaService.getPisac(this.izabranaKnjiga.idKnjiga).subscribe((resp: any) =>
      {
        this.pisac = resp;
      })
      this.knjigaService.getIzdavac(this.izabranaKnjiga.idKnjiga).subscribe((resp:any) => {
        this.izdavac = resp;
      })
      window.location.href = "http://localhost:4200/sve-knjige" //reload stranice
    }

  }

}
