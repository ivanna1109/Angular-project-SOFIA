import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KnjigeListComponent } from './knjige-list.component';

describe('KnjigeListComponent', () => {
  let component: KnjigeListComponent;
  let fixture: ComponentFixture<KnjigeListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ KnjigeListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(KnjigeListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
