import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  //iskoristiti servis za registraciju
  constructor(private userService: UserService, private router: Router) { }

  public username: string = '';
  public password: string = '';
  ngOnInit(): void {
    localStorage.clear();
  }

  login() {
    this.userService.login(this.username, this.password).subscribe((resp:any) => {
      if (resp.idKorisnika == 0) {
        console.log(resp)
        alert("Logovanje je neuspešno! Probajte ponovo!"),
        this.router.navigate(['/login'])
      } else {
        console.log(resp)
        localStorage.setItem("token", resp.token),
        localStorage.setItem("idKorisnika", resp.idKorisnika),
        localStorage.setItem("idUloga", resp.idUloga),
        this.router.navigate(['/sve-knjige'])
      }
    })
  }


}
