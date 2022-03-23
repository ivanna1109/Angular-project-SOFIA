import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ChartNarComponent } from './chart/chart-nar/chart-nar.component';
import { AddKnjigaComponent } from './components/add-knjiga/add-knjiga.component';
import { KategorijaComponent } from './components/kategorija/kategorija.component';
import { KnjigaItemComponent } from './components/knjiga-item/knjiga-item.component';
import { KnjigaViewComponent } from './components/knjiga-view/knjiga-view.component';
import { KnjigeListComponent } from './components/knjige-list/knjige-list.component';
import { NarudzbenicaListComponent } from './components/narudzbenica-list/narudzbenica-list.component';
import { OmiljeneKnjigeComponent } from './components/omiljene-knjige/omiljene-knjige.component';
import { PostaviAkcijuComponent } from './components/postavi-akciju/postavi-akciju.component';
import { AuthGuard } from './guard/auth-guard';
import { AuthGuardRadnik } from './guard/auth-guard-radnik';
import { LoginComponent } from './user/login/login.component';
import { RegisterComponent } from './user/register/register.component';

const routes: Routes = [
  { path: '', redirectTo: 'sve-knjige', pathMatch: 'full' },
  { path:'login', component: LoginComponent},
  { path:'register', component:RegisterComponent},  
  { path: 'sve-knjige', component: KategorijaComponent },  
  { path: 'dodaj-knjigu', component: AddKnjigaComponent, canActivate:[AuthGuardRadnik]},
  {path: 'statistika', component:ChartNarComponent},
  {path: 'postavi-akciju', component:PostaviAkcijuComponent},  
  {path:'sve-kategorije', component: KategorijaComponent},
  {path:'kratko-knjiga/:naziv', component:KnjigaItemComponent},
  {path:'prikaz-knjige/:nazivKnjige', component: KnjigaViewComponent},
  {path: 'omiljene-knjige', component:OmiljeneKnjigeComponent, canActivate:[AuthGuard]},
  {path: 'lista-narudzbina', component:NarudzbenicaListComponent, canActivate:[AuthGuard]}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
