import { Component, OnInit } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { Kategorija } from 'src/app/model/Kategorija';
import { Knjiga } from 'src/app/model/Knjiga';
import { KnjigaService } from 'src/app/services/knjiga.service';

@Component({
  selector: 'app-knjige-list',
  templateUrl: './knjige-list.component.html',
  styleUrls: ['./knjige-list.component.css']
})
export class KnjigeListComponent implements OnInit {

  public knjige: Knjiga[] | undefined

  private reloadKnjigasList: Subject<any> = new Subject();

  constructor(private knjigaService:KnjigaService) { }

  ngOnInit(): void {
  //  this.knjigaService.getKnjige().subscribe((resp:any) => {
  //    this.knjige = resp,
  //    console.log("ovde smo na ng on init dobavili sve knjige.")
  //  });
  }

  onCreate(){
    this.reloadKnjigasList.next();
  }


}
