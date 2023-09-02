import { CookieService } from 'ngx-cookie-service';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { LoginRequest } from '../models/loginRequest';
import { LoginResponse } from '../models/loginResponse';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  private API_URL = 'http://localhost:8020';

  constructor(
    private http: HttpClient,
    private cookie: CookieService
  ) { }

  authenticator(requestDatas: LoginRequest): Observable<LoginResponse> {
    return this.http.post<LoginResponse>(
      `${this.API_URL}/login`,  //Format(%s/login, [this.API_URL])
      requestDatas
    );
  }

  isLogged(): boolean {
    const JWT_TOKEN = this.cookie.get('LOGIN_INFO');
    console.log(JWT_TOKEN);
    return JWT_TOKEN ? true : false;
  }

}
