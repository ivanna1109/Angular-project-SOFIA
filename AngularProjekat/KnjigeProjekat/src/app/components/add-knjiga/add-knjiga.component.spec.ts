import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddKnjigaComponent } from './add-knjiga.component';

describe('AddKnjigaComponent', () => {
  let component: AddKnjigaComponent;
  let fixture: ComponentFixture<AddKnjigaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddKnjigaComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddKnjigaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
