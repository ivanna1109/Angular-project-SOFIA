import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NarudzbenicaListComponent } from './narudzbenica-list.component';

describe('NarudzbenicaListComponent', () => {
  let component: NarudzbenicaListComponent;
  let fixture: ComponentFixture<NarudzbenicaListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NarudzbenicaListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NarudzbenicaListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
