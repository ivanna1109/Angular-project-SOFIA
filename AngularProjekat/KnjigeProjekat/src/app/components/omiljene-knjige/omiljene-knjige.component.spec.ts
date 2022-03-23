import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OmiljeneKnjigeComponent } from './omiljene-knjige.component';

describe('OmiljeneKnjigeComponent', () => {
  let component: OmiljeneKnjigeComponent;
  let fixture: ComponentFixture<OmiljeneKnjigeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OmiljeneKnjigeComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OmiljeneKnjigeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
