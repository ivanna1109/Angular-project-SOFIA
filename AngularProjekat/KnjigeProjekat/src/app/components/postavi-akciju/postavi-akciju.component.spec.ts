import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PostaviAkcijuComponent } from './postavi-akciju.component';

describe('PostaviAkcijuComponent', () => {
  let component: PostaviAkcijuComponent;
  let fixture: ComponentFixture<PostaviAkcijuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PostaviAkcijuComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PostaviAkcijuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
