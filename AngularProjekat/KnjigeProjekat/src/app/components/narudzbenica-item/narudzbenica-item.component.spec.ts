import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NarudzbenicaItemComponent } from './narudzbenica-item.component';

describe('NarudzbenicaItemComponent', () => {
  let component: NarudzbenicaItemComponent;
  let fixture: ComponentFixture<NarudzbenicaItemComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NarudzbenicaItemComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NarudzbenicaItemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
