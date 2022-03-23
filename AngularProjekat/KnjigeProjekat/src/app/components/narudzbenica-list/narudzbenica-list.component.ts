import { Component, OnInit } from '@angular/core';
import { Narudzbenica } from 'src/app/model/Narudzbenica';
import { KnjigaService } from 'src/app/services/knjiga.service';
import { NarudzbinaService } from 'src/app/services/narudzbina.service';

@Component({
  selector: 'app-narudzbenica-list',
  templateUrl: './narudzbenica-list.component.html',
  styleUrls: ['./narudzbenica-list.component.css']
})
export class NarudzbenicaListComponent implements OnInit {

  public narudzbenice: Narudzbenica[]
  public ukupanIznos: number

  constructor(private narudzbinaService: NarudzbinaService) { }

  ngOnInit(): void {
    this.narudzbinaService.vratiNarudzbine(localStorage.getItem('idKorisnika')).subscribe((resp:any)=> {
      this.narudzbenice = resp;
      var tmp: number = 0
      if ( this.narudzbenice != undefined){
        for (let i=0; i < this.narudzbenice.length;i++){
          tmp += this.narudzbenice[i].ukupanIznos;
          console.log(this.narudzbenice[i])
        }
      }
      this.ukupanIznos = tmp;
    })
  }

}
