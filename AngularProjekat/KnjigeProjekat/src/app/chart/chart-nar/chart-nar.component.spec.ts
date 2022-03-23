import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ChartNarComponent } from './chart-nar.component';

describe('ChartNarComponent', () => {
  let component: ChartNarComponent;
  let fixture: ComponentFixture<ChartNarComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ChartNarComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ChartNarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
