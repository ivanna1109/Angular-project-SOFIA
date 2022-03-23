import { Component, Input, OnInit } from '@angular/core';
import { Knjiga } from 'src/app/model/Knjiga';
import { Narudzbenica } from 'src/app/model/Narudzbenica';
import { KnjigaService } from 'src/app/services/knjiga.service';
import { NarudzbinaService } from 'src/app/services/narudzbina.service';

@Component({
  selector: 'app-narudzbenica-item',
  templateUrl: './narudzbenica-item.component.html',
  styleUrls: ['./narudzbenica-item.component.css']
})
export class NarudzbenicaItemComponent implements OnInit {

  @Input() public narudzbina: Narudzbenica
  public knjiga: Knjiga

  constructor(private narudzbinaService: NarudzbinaService, private knjigaService: KnjigaService) { }

  ngOnInit(): void {
    this.narudzbinaService.knjigaZaNarudzbinu(this.narudzbina.idNarudzbenica).subscribe((resp:any)=> {
      this.knjiga = resp;
      })
  }

}
