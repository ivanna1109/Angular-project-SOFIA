import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Izdavac } from 'src/app/model/Izdavac';
import { Knjiga } from 'src/app/model/Knjiga';
import { Pisac } from 'src/app/model/Pisac';
import { KnjigaService } from 'src/app/services/knjiga.service';
import { NarudzbinaService } from 'src/app/services/narudzbina.service';

@Component({
  selector: 'app-knjiga-view',
  templateUrl: './knjiga-view.component.html',
  styleUrls: ['./knjiga-view.component.css']
})
export class KnjigaViewComponent implements OnInit {

  @Input() public izabranaKnjiga: Knjiga
  public pisac: Pisac
  public izdavac: Izdavac
  public staraCena: number
  public uKorpi: number = 0


  public prosecnaOcena: number
  constructor(private knjigaService: KnjigaService, private narudzbinaService: NarudzbinaService, private router: Router, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.prosecnaOcena = 0
    const idIzdanje = this.route.snapshot.paramMap.get('nazivKnjige');
    this.knjigaService.nadjiKnjigu(idIzdanje!).subscribe((resp: any) => {
        this.izabranaKnjiga = resp,
        this.knjigaService.getPisac(this.izabranaKnjiga.idKnjiga).subscribe((resp: any) => {
          this.pisac = resp
        }),
        this.knjigaService.getIzdavac(this.izabranaKnjiga.idKnjiga).subscribe((resp: any) => {
          this.izdavac = resp
        }),
        this.knjigaService.prosecnaOcena(this.izabranaKnjiga.idKnjiga).subscribe((resp: any) => {
          console.log("ovo je ocena knjige: " + resp)
          this.prosecnaOcena = resp;
        }),
        this.knjigaService.vratiStaruCenu(this.izabranaKnjiga.idKnjiga).subscribe((resp:any) => {
          if (resp == this.izabranaKnjiga.cena)
              this.staraCena = 0;
          else {
            this.staraCena = resp;
          }
        })
    })
  }

  oceniKnjigu(ocenaForm: any) {
    if (localStorage.getItem('idKorisnika')) {
      this.knjigaService.oceniKnjigu(localStorage.getItem('idKorisnika'), this.izabranaKnjiga.idKnjiga.toString(), ocenaForm.value.ocena).subscribe((resp: any) => {
        if (resp == true) {
          alert("Uspešno ste ocenili knjigu!")
          window.location.href = "http://localhost:4200/prikaz-knjige/"+this.izabranaKnjiga.naziv
        } else {
          alert("Neuspešno ocenjivanje knjige!")
        }
      })
    } else {
      alert("Niste ulogovani, ne možete oceniti knjigu!");
    }
  }

  komentarisiKnjigu(komentarForm: any) {
    if (localStorage.getItem('idKorisnika')) {
      this.knjigaService.komentarisiKnjigu(localStorage.getItem('idKorisnika'), this.izabranaKnjiga.idKnjiga.toString(), komentarForm.value.komentar).subscribe((resp: any) => {
        if (resp == true) {
          alert("Uspešno ste komentarisali knjigu!")
          window.location.href = "http://localhost:4200/prikaz-knjige/"+this.izabranaKnjiga.naziv
        } else {
          alert("Neuspešno komentarisanje knjige!")
        }
      })
    } else
      alert("Niste ulogovani, ne možete komentarisati knjigu!")
  }

  dodajUOmiljene() {
    if (localStorage.getItem("idKorisnika")) {
      this.knjigaService.dodajKnjiguUOmiljene(localStorage.getItem('idKorisnika'), this.izabranaKnjiga.idKnjiga.toString()).subscribe((resp: any) => {
        if (resp == false) {
          alert("Ova knjiga je već u Vašim omiljenim knjigama!")
        } else
          alert("Uspešno ste dodali knjigu u Vaše omiljene knjige! Pogledajte listu svojih omiljenih knjiga!")
        this.router.navigate(['/omiljene-knjige'])
      })
    } else {
      alert("Niste ulogovani, ne možete dodati ovu knjigu u omiljene!")
    }
  }

  //narucivanje
  smanjiKolicinu() {
    this.uKorpi--;
  }

  povecajKolicinu() {
    this.uKorpi++;
  }

  narucivanje() {
    if (!localStorage.getItem('idKorisnika')) {
      alert("Niste ulogovani, ne možete naručivati knjige!")
    } else {
      const idKor = localStorage.getItem('idKorisnika');
      this.narudzbinaService.narucivanje(idKor, this.izabranaKnjiga.idKnjiga, this.uKorpi).subscribe((resp: any) => {
        if (resp == true) {
          alert("Narucili ste zeljenu knjigu! Pogledajte svoju listu narucenih knjiga!");
          this.router.navigate(["/lista-narudzbina"])
        } else {
          alert("Greska pri narucivanju!");
        }
      })
    }
  }

}
