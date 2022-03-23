import { Component, Input, OnInit, Output } from '@angular/core';
import { Knjiga } from 'src/app/model/Knjiga';
import { KnjigaService } from 'src/app/services/knjiga.service';

@Component({
  selector: 'app-postavi-akciju',
  templateUrl: './postavi-akciju.component.html',
  styleUrls: ['./postavi-akciju.component.css']
})
export class PostaviAkcijuComponent implements OnInit {

  @Input() public trazenaKnjiga: Knjiga
  @Output() public novaCena: number | undefined

  constructor(private knjigaService: KnjigaService) { }

  ngOnInit(): void {
  }

  nadjiKnjigu(searchForm:any){
    this.knjigaService.nadjiKnjigu(searchForm.value.nazivKnjige).subscribe((resp:any) => {
      if (resp == null) {
        alert("Nema knjige sa prosledjenim nazivom!");
        window.location.href = "http://localhost:4200/postavi-akciju"
      } else {
        this.trazenaKnjiga = resp
        this.novaCena = undefined
      }
    })
  }

  postaviAkciju(akcijaForm:any){
    const akcija = akcijaForm.value.procenatAkcije;
    const trenutnaAkcija = this.trazenaKnjiga.akcija;
    this.knjigaService.postaviAkciju(this.trazenaKnjiga.idKnjiga, akcija).subscribe((resp:any) => {
      if (resp == true){
        alert("Uspešno ste postavili akciju na knjigu!")
        if ( akcija == 0){
          this.novaCena = (100*this.trazenaKnjiga.cena) / (100 - trenutnaAkcija)
        } else {
          this.novaCena = (this.trazenaKnjiga.cena * (100 - akcija)) / 100
        }
      } else {
        alert("Došlo je do greške prilikom postavljanja akcije!")
      }
    })
  }
}
