import { MessageService } from 'primeng/api';
import { CookieService } from 'ngx-cookie-service';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { LoginService } from '../services/login.service';
import { LoginRequest } from '../models/loginRequest';
import { Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit, OnDestroy {
  private destroy$ = new Subject<void>;

  constructor(
    private formBuilder: FormBuilder,
    private loginService: LoginService,
    private cookieService: CookieService,
    private router: Router,
    private messageService: MessageService
  ) {}

  ngOnInit(): void {
    this.onLogout();
  }

  onLogout() {
    this.cookieService.delete('LOGIN_INFO');
  }

  //Formulários Data-Driven
  public loginForm = this.formBuilder.group({
    email: ['', Validators.required],
    senha: ['', Validators.required]
  });

  onSubmitLoginForm() {
    if (this.loginForm.value && this.loginForm.valid) {
      this.loginService.authenticator(this.loginForm.value as LoginRequest)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: (response) => {
            if (response) {
              this.cookieService.set('LOGIN_INFO', response.token);
              this.loginForm.reset();
              this.router.navigate(['/home']);
              this.messageService.add({
                severity: 'success',
                summary: 'Sucesso',
                detail: `Bem vindo de volta ${response.nome}`,
                life: 5000
              });
            }
          },
          error: (err) => {
            console.log(err);
            this.messageService.add({
              severity: 'error',
              summary: 'Erro',
              detail: `Erro ao fazer o login ${err.message}`,
              life: 5000
            });
          }
        });
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

}
