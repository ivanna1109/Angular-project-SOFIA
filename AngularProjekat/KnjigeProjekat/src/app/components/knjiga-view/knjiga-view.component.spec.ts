import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KnjigaViewComponent } from './knjiga-view.component';

describe('KnjigaViewComponent', () => {
  let component: KnjigaViewComponent;
  let fixture: ComponentFixture<KnjigaViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ KnjigaViewComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(KnjigaViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
