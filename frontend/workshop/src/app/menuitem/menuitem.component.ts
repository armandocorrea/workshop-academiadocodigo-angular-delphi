import { Component, HostBinding, Input, OnDestroy, OnInit } from '@angular/core';

@Component({
  selector: '[app-menuitem]',
  templateUrl: './menuitem.component.html',
  styleUrls: ['./menuitem.component.scss']
})
export class MenuitemComponent implements OnInit, OnDestroy  {

  @Input() item: any;
  @Input() index!: number;
  @Input() @HostBinding('class.layout-root-menuitem') root!: boolean;
  @Input() parentKey!: string;

  key: string = "";

  constructor() {}

  ngOnInit(): void {}

  updateActiveStateFromRoute() {}

  itemClick(event: Event) {}

  get submenuAnimation() {return}

  @HostBinding('class.active-menuitem')
  get activeClass() {return}

  ngOnDestroy(): void {}

}
