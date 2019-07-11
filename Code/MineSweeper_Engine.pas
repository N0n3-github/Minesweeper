unit MineSweeper_Engine;

interface 
Uses GraphABC;

type Cell = class
  x1, y1, x2, y2: integer;
  number: integer;
  contains_mine: boolean;
  revealed: boolean;
  flag_is_put: boolean;
  constructor Create(x1,y1, x2, y2: integer; mine: boolean);
  procedure Click(mouseButton: integer);
  procedure Draw();
end;

var mine_is_pressed, first_click: boolean;
    
implementation

constructor Cell.Create(x1, y1, x2, y2: integer; mine: boolean);
begin
  self.contains_mine := mine;
  self.x1 := x1;
  self.y1 := y1;
  self.x2 := x2;
  self.y2 := y2;
  self.revealed := false;
  self.flag_is_put := false;
end;

procedure Cell.Draw();
begin
  //Cell color
  if self.revealed then SetBrushColor(rgb(153, 153, 153))
    else SetBrushColor(rgb(204, 204, 204));
  
  //Flag Color
  if self.flag_is_put then SetBrushColor(clRed);
  
  // Mine Color 
  if (self.contains_mine) and (mine_is_pressed) then SetBrushColor(rgb(0, 0, 0));
  
  Rectangle(self.x1, self.y1, self.x2, self.y2);
  
  //Number
  SetFontSize(20);
  SetFontName('Times New Roman');
  SetFontStyle(fsBold);
  
  //Setting Color of Font Depending on Number 
  if self.number = 1 then SetFontColor(rgb(0, 0, 255));
  if self.number = 2 then SetFontColor(rgb(0, 153, 0));
  if self.number = 3 then SetFontColor(rgb(255, 0, 0));
  if self.number = 4 then SetFontColor(rgb(0, 0, 153));
  if self.number = 5 then SetFontColor(rgb(102, 0, 0));
  if self.number = 6 then SetFontColor(rgb(163, 73, 164));
  if self.number = 7 then SetFontColor(rgb(255, 128, 0));
  if self.number = 8 then SetFontColor(rgb(0, 0, 0));
  
  if (self.number > 0) and (self.revealed) and not (self.contains_mine) then DrawTextCentered(x1, y1, x2, y2, number);
end;

procedure Cell.Click(mouseButton: integer);
begin
  if (mouseButton = 1) and not (self.flag_is_put) then self.revealed := true;
  if (mouseButton = 2) and not (self.revealed) and not (first_click) then self.flag_is_put := not self.flag_is_put;
  if (self.revealed) and (self.contains_mine) then mine_is_pressed := true;
end;
end.