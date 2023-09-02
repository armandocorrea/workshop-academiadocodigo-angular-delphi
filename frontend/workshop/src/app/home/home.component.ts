import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  model: any[] = []; //Variant

  ngOnInit(): void {
    this.model = [
      {
        label: 'Home',
        items: [
          {
            label: 'Dashboard',
            icon: 'pi pi-fw pi-home',
            routerLink: ['/home']
          }
        ]
      },
      {
        label: 'Cadastros',
        items: [
          {
            label: 'Cad 1', icon: 'pi pi-fw pi-building', routerLink: ['/cadastros/cad1']
          },
          {
            label: 'Cad 1', icon: 'pi pi-fw pi-thumbs-up', routerLink: ['/cadastros/cad2']
          }
        ]
      }
    ]
  }

}
