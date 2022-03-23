import { Component, OnInit } from '@angular/core';
import { Knjiga } from 'src/app/model/Knjiga';
import { KnjigaService } from 'src/app/services/knjiga.service';


@Component({
  selector: 'app-chart-nar',
  templateUrl: './chart-nar.component.html',
  styleUrls: ['./chart-nar.component.css']
})
export class ChartNarComponent implements OnInit {

  public najpopularnije: Knjiga[]
  public ocenjene: Knjiga[]
  constructor(private knjigeService: KnjigaService) { }

  ngOnInit(): void {    
    this.knjigeService.najpopularnijeKnjige().subscribe((resp:any) =>{
      console.log(resp);
      this.najpopularnije = resp;
    })
    this.knjigeService.najboljeOcene().subscribe((resp:any) => {
      console.log(resp);
      this.ocenjene = resp;
    })

  }

}
