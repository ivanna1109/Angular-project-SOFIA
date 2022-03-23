import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http'
import { Observable } from 'rxjs'

export class TokenInterceptor implements HttpInterceptor{

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>>{
        const userJson = localStorage.getItem('token')!
        if(localStorage.getItem("token")){
        const authHeader=req.clone({
        headers: req.headers.set("X-AUTH-HEADER", userJson)
        })
        req = authHeader;
        }
        return next.handle(req)
    }
}