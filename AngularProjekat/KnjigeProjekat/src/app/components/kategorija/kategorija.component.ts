import { ElementSchemaRegistry } from '@angular/compiler';
import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';
import { Kategorija } from 'src/app/model/Kategorija';
import { Knjiga } from 'src/app/model/Knjiga';
import { KategorijaService } from 'src/app/services/kategorija.service';
import { KnjigaService } from 'src/app/services/knjiga.service';

@Component({
  selector: 'app-kategorija',
  templateUrl: './kategorija.component.html',
  styleUrls: ['./kategorija.component.css']
})
export class KategorijaComponent implements OnInit {

  public kategorije: Kategorija[] | undefined

  public knjige: Knjiga[] | undefined

  public selectedKat: Kategorija = new Kategorija()
  public trazenaKnjiga: Knjiga | undefined
  private reloadKategorijasList: Subject<any> = new Subject();

  constructor(private kategorijaService: KategorijaService, private knjigaService: KnjigaService, private router:Router) { }

  ngOnInit(): void {
    this.kategorijaService.getKategorije().subscribe((resp:any) => {
      this.kategorije = resp
    })
    this.knjigaService.getKnjige().subscribe((resp:any)=> {
      this.knjige = resp,
      this.trazenaKnjiga = undefined;
    })
  }

  onCreate(){
    this.reloadKategorijasList.next();
  }

  knjigeZaKategoriju(idKategorija:number){
    this.kategorijaService.getKnjigeZaKategoriju(idKategorija).subscribe((resp:any) => {
      this.knjige = resp,
      this.trazenaKnjiga = undefined;
    })
  }

  nadjiKnjigu(searchForm:any){
    this.knjigaService.nadjiKnjigu(searchForm.value.nazivKnjige).subscribe((resp:any) => {
      if (resp == null) {
        alert("Nema knjige sa prosledjenim nazivom!");
        window.location.href = "http://localhost:4200/sve-knjige"
      } else {
        const naziv = searchForm.value.nazivKnjige;
        this.router.navigate(["/prikaz-knjige/"+naziv])
      }
    })
  }

}
