﻿unit Menues;

interface

Uses GraphABC, MineSweeper_game;

var
//Menues boolean
  main_menu, playing, statistics, settings, quit: boolean;

procedure MainMenu_Interface();
procedure MainMenu_MD(MouseX, MouseY, mouseButton: integer);
procedure MainMenu_KD(key: integer);

procedure Statistics_Interface();
procedure Statistics_MD(MouseX, MouseY, mouseButton: integer);
procedure Statistics_KD(key: integer);

procedure Settings_Interface();
procedure Settings_MD(MouseX, MouseY, mouseButton: integer);
procedure Settings_KD(key: integer);

implementation

type
  Button = class
    x1, y1, x2, y2: integer;
    text: string;
    constructor Create(x1, y1, x2, y2: integer; text: string);
    begin
      self.x1 := x1;
      self.y1 := y1;
      self.x2 := x2;
      self.y2 := y2;
      self.text := text;
    end;
    
    procedure Draw();
    begin
      Rectangle(x1, y1, x2, y2);
      DrawTextCentered(x1, y1, x2, y2, text);
    end;
  end;

var
  //Genreal
  background: picture;
  btn_color, btn_border_color, font_color: color;
  pen_width: integer;
  
  //MainMenu
  play_btn, stats_btn, settings_btn, quit_btn: button;


//-----------------------------  Main Menu  -----------------------------//
procedure MainMenu_Interface();
begin
  background := new Picture('data/Background.png');
  background.Draw(0, 0, Width, Height);
  SetFontColor(font_color);
  SetFontSize(Round(Height / 14.4));
  SetFontName('Tahoma');
  SetFontStyle(fsBold);
  DrawTextCentered(0, 0, Width, Round(Height / 6), 'MineSweeper');
  play_btn := new Button(Round(Width / 6), Round(Height / 6), Width - Round(Width / 6), Round(Height / 3.272), 'Играть'); 
  stats_btn := new Button(Round(Width / 6), Round(Height / 2.618), Width - Round(Width / 6), Round(Height / 1.92), 'Статистика'); 
  settings_btn := new Button(Round(Width / 6), Round(Height / 1.674), Width - Round(Width / 6), Round(Height / 1.358), 'Настройки'); 
  quit_btn := new Button(Round(Width / 6), Round(Height / 1.23), Width - Round(Width / 6), Round(Height / 1.051), 'Выход');
  SetPenColor(btn_border_color);
  SetBrushColor(btn_color);
  SetPenWidth(pen_width);
  SetFontSize(Round(Height / 19.459));
  play_btn.Draw();
  stats_btn.Draw();
  settings_btn.Draw();
  quit_btn.Draw();
  Redraw();
end;

procedure MainMenu_MD(MouseX, MouseY, mouseButton: integer);
begin
  if (mouseButton = 1) and (MouseX > play_btn.x1) and (MouseY > play_btn.y1) and (MouseX < play_btn.x2) and (MouseY < play_btn.y2) then 
  begin
    playing := true;
    MineSweeper_game.Init_party();
  end;
  if (mouseButton = 1) and (MouseX > stats_btn.x1) and (MouseY > stats_btn.y1) and (MouseX < stats_btn.x2) and (MouseY < stats_btn.y2) then statistics := true;
  if (mouseButton = 1) and (MouseX > settings_btn.x1) and (MouseY > settings_btn.y1) and (MouseX < settings_btn.x2) and (MouseY < settings_btn.y2) then settings := true;
  if (mouseButton = 1) and (MouseX > quit_btn.x1) and (MouseY > quit_btn.y1) and (MouseX < quit_btn.x2) and (MouseY < quit_btn.y2) then quit := true;
end;

procedure MainMenu_KD(key: integer);
begin
  if key = VK_Enter then 
  begin
    playing := true;
    MineSweeper_game.Init_party();
  end;
end;
//-----------------------------------------------------------------------//


//-----------------------------  Statistics  -----------------------------//
procedure Statistics_Interface();
begin
  background.Draw(0, 0, Width, Height);
  SetFontColor(font_color);
  SetFontSize(Round(Height / 10));
  SetFontName('Tahoma');
  SetFontStyle(fsBold);
  DrawTextCentered(0, 0, Width, Height, 'Раздел в разработке');
  SetFontSize(Round(Height / 36));
  DrawTextCentered(0, Height - Round(Height / 7.2), Width, Height, 'Нажмите "Esc" чтобы выйти');
  Redraw();
end;

procedure Statistics_MD(MouseX, MouseY, mouseButton: integer);
begin
  
end;

procedure Statistics_KD(key: integer);
begin
  if key = VK_Escape then statistics := false;
end;
//-----------------------------------------------------------------------//


//-----------------------------  Settings  -----------------------------//
procedure Settings_Interface();
begin
  background.Draw(0, 0, Width, Height);
  SetFontColor(font_color);
  SetFontSize(Round(Height / 10));
  SetFontName('Tahoma');
  SetFontStyle(fsBold);
  DrawTextCentered(0, 0, Width, Height, 'Раздел в разработке');
  SetFontSize(Round(Height / 36));
  DrawTextCentered(0, Height - Round(Height / 7.2), Width, Height, 'Нажмите "Esc" чтобы выйти');
  Redraw();
end;

procedure Settings_MD(MouseX, MouseY, mouseButton: integer);
begin
  
end;

procedure Settings_KD(key: integer);
begin
  if key = VK_Escape then settings := false;
end;
//-----------------------------------------------------------------------//


begin
  //General
  btn_color := rgb(185, 185, 185);
  btn_border_color := rgb(255, 255, 255);
  font_color := rgb(255, 255, 255);
  pen_width := Round(Height / 102.857);
end.
