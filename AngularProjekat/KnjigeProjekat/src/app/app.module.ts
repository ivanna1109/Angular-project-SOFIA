import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';  
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { KnjigeListComponent } from './components/knjige-list/knjige-list.component';
import { AddKnjigaComponent } from './components/add-knjiga/add-knjiga.component';
import { KnjigaItemComponent } from './components/knjiga-item/knjiga-item.component';
import { KategorijaComponent } from './components/kategorija/kategorija.component';
import { LoginComponent } from './user/login/login.component';
import { RegisterComponent } from './user/register/register.component';
import { UserService } from './services/user.service';
import { KnjigaService } from './services/knjiga.service';
import { KategorijaService } from './services/kategorija.service';
import { TokenInterceptor } from './services/token-interceptor';
import { AuthGuard } from './guard/auth-guard';
import { AuthGuardRadnik } from './guard/auth-guard-radnik';
import { OmiljeneKnjigeComponent } from './components/omiljene-knjige/omiljene-knjige.component';
import { NarudzbenicaListComponent } from './components/narudzbenica-list/narudzbenica-list.component';
import { KnjigaViewComponent } from './components/knjiga-view/knjiga-view.component';
import { PostaviAkcijuComponent } from './components/postavi-akciju/postavi-akciju.component';
import { NarudzbenicaItemComponent } from './components/narudzbenica-item/narudzbenica-item.component';
import { ChartNarComponent } from './chart/chart-nar/chart-nar.component';



@NgModule({
  declarations: [
    AppComponent,
    KnjigeListComponent,
    AddKnjigaComponent,
    KnjigaItemComponent,
    KategorijaComponent,
    LoginComponent,
    RegisterComponent,
    OmiljeneKnjigeComponent,
    NarudzbenicaListComponent,
    KnjigaViewComponent,
    PostaviAkcijuComponent,
    NarudzbenicaItemComponent,
    ChartNarComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,  
    ReactiveFormsModule,  
    HttpClientModule,  
  ],
  providers: [UserService, KnjigaService, KategorijaService, AuthGuard, AuthGuardRadnik, {provide: HTTP_INTERCEPTORS, useClass:TokenInterceptor, multi: true}],
  bootstrap: [AppComponent]
})
export class AppModule {

 }
