import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Izdavac } from 'src/app/model/Izdavac';
import { Kategorija } from 'src/app/model/Kategorija';
import { KategorijaService } from 'src/app/services/kategorija.service';
import { KnjigaService } from 'src/app/services/knjiga.service';

@Component({
  selector: 'app-add-knjiga',
  templateUrl: './add-knjiga.component.html',
  styleUrls: ['./add-knjiga.component.css']
})
export class AddKnjigaComponent implements OnInit {

  public kategorije: Kategorija[]
  public izdavaci: Izdavac[]

  public selectedKategorija: String
  public selectedIzdavac: String
  constructor(private knjigaService: KnjigaService, private kategorijaService: KategorijaService, private router: Router) { }

  ngOnInit(): void {
    this.kategorijaService.getKategorije().subscribe((resp:any) => {
      this.kategorije = resp;
    })
    this.kategorijaService.getIzdavaci().subscribe((resp:any) => {
      this.izdavaci = resp
    })
  }

  dodajNovuKnjigu(knjigaForm:any){
    console.log("Selected kategorija"+knjigaForm.value.selectedKategorija)
    console.log("Selected izdavac:"+knjigaForm.value.selectedIzdavac)
    this.knjigaService.dodajNovuKnjigu(knjigaForm).subscribe((resp: any) => {
      if (resp == true){
        alert('Uspešno ste dodali novu knjigu!') 
        window.location.href = "http://localhost:4200/dodaj-knjigu"
      }   
      else {
        alert('Greška pri dodavanju nove knjige!')       
    }
  })
}

}
