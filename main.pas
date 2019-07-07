Uses GraphABC, MineSweeper_Engine;

var grid: array [0..CellsInCol - 1, 0..CellsInRow - 1] of Cell; 
    app_is_running: boolean;
    bombs_in_grid: integer;
    
procedure Init_Party();
begin
  //Firstly setting all cells empty
  //Setting x and y positions for each cell
  var pos_x := 0;
  var pos_y := 0;
  for var y := 0 to CellsInCol - 1 do
    for var x := 0 to CellsInRow - 1 do
    begin
      grid[y, x] := new Cell(pos_x, pos_y, false);
      if pos_x + CellSize >= WindowWidth then
      begin
        pos_x := 0;
        pos_y += CellSize;
      end
      else pos_x += CellSize;  
    end;
  
  //Setting Up Bombs
  while bombs_in_grid > 0 do
  begin
    var x := Random(0, CellsInRow - 1);
    var y := Random(0, CellsInCol - 1);
    if not grid[y, x].contains_mine then grid[y, x].contains_mine := true
      else continue;
    bombs_in_grid -= 1;    
  end;
  
  //Setting Up Numbers
  for var y := 0 to CellsInCol - 1 do
    for var x := 0 to CellsInRow - 1 do
    begin
      var number := 0;
      if x > 0 then if grid[y, x - 1].contains_mine then number += 1;
      if y > 0 then if grid[y - 1, x].contains_mine then number += 1;
      if y < CellsInCol - 2 then if grid[y + 1, x].contains_mine then number += 1;
      if x < CellsInRow - 2 then if grid[y, x + 1].contains_mine then number += 1;
      if (x > 0) and (y > 0) then if grid[y - 1, x - 1].contains_mine then number += 1;
      if (y > 0) and (x < CellsInRow - 2) then if grid[y - 1, x + 1].contains_mine then number += 1;
      if (y < CellsInCol - 2) and (x > 0) then if grid[y + 1, x - 1].contains_mine then number += 1;
      if (y < CellsInCol - 2) and (x < CellsInRow - 2) then if grid[y + 1, x + 1].contains_mine then number += 1;
      grid[y, x].number := number;
    end;
end;

procedure CheckWon();
begin
  var count_unrevealed := 0;
  for var y := 0 to CellsInCol - 1 do
    for var x := 0 to CellsInRow - 1 do
     if not grid[y, x].revealed then count_unrevealed += 1;
  if count_unrevealed = bombs_in_grid then victory := true;
end;

procedure MouseUp(MouseX, MouseY, mouseButton: integer);
begin
  if not mine_is_pressed then
  begin
    var y := Trunc(MouseY / (WindowHeight / CellsInCol));
    var x := Trunc(MouseX / (WindowWidth / CellsInRow));
    grid[y, x].Click(mouseButton);
    if first_click then 
    begin
      if mine_is_pressed then
      begin
        mine_is_pressed := false;
        while grid[y, x].contains_mine do
          Init_Party();
        grid[y, x].Click(mouseButton);
      end;
      first_click := false;
    end;
  end;
end;

procedure Draw_Grid();
begin
  for var y := 0 to CellsInCol - 1 do
    for var x := 0 to CellsInRow - 1 do
      grid[y, x].Draw();
  UpdateWindow();
end;

procedure PartyIsLose();
begin
  ClearWindow(clBlack);
  UpdateWindow();
end;

procedure PartyIsWon();
begin
  ClearWindow(clOrange);
  UpdateWindow();
end;

procedure Main_SetUp();
begin
  SetWindowSize(CellsInRow * CellSize, CellsInCol * CellSize);
  Window.CenterOnScreen;
  Window.IsFixedSize := true;
  Window.Title := 'MineSweeper';
  bombs_in_grid := 40;
  Init_Party();
  LockDrawing();
  OnMouseUp := MouseUp;
  app_is_running := true;
  first_click := true;
  victory := false;
end;

procedure ExitGame();
begin
  app_is_running := false;
end;

begin
  Main_SetUp();
  while app_is_running do
  begin
    OnClose := ExitGame;
    if mine_is_pressed then
      PartyIsLose()
    else if victory then
      PartyIsWon()
    else
      Draw_Grid();
    CheckWon();
    end;
end.
