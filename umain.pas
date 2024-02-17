unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    buValidareCNP: TButton;
    edCNP: TEdit;
    laValidareLungime: TLabel;
    laAn: TLabel;
    laVarsta: TLabel;
    laLuna: TLabel;
    laZi: TLabel;
    laJudet: TLabel;
    laCNPvalid: TLabel;
    laCNPinvalid: TLabel;
    laCNP: TLabel;
    laValidareSex: TLabel;
    laValidareAn: TLabel;
    laValidareVarsta: TLabel;
    laValidareLuna: TLabel;
    laValidareZi: TLabel;
    laValidareJudet: TLabel;
    laLungime: TLabel;
    laCifra: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure buValidareCNPClick(Sender: TObject);
    procedure edCNPClick(Sender: TObject);
    procedure edCNPKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

function CheckCNP(sir: string): boolean;
var
  i: integer;
  s: integer;
const
  nr: array[1..12] of shortint = (2, 7, 9, 1, 4, 6, 3, 5, 8, 2, 7, 9);
begin
  s := 0;
  if Length(sir) = 13 then
  begin
    for i := 1 to High(nr) do
      s := s + (nr[i] * StrToInt(sir[i]));
    s := s mod 11;
    if ((s < 10) and (s = StrToInt(sir[13]))) or
      ((s = 10) and (StrToInt(sir[13]) = 1)) then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
end;

function StrToInt2(s: string): integer;
var
  c: integer;
begin
  Val(s, Result, c);
  if c <> 0 then
    Result := -1;
end;


procedure TfMain.edCNPClick(Sender: TObject);
const
  judet: array [1..52] of string =
    ('Alba', 'Arad', 'Arges', 'Bacau', 'Bihor', 'Bistrita-Nasaud',
    'Botosani', 'Brasov', 'Braila', 'Buzau', 'Caras-Severin',
    'Cluj', 'Constanta', 'Covasna', 'Dâmbovita', 'Dolj', 'Galati',
    'Gorj', 'Harghita', 'Hunedoara', 'Ialomita', 'Iasi', 'Ilfov',
    'Maramures', 'Mehedinti', 'Mures', 'Neamt', 'Olt', 'Prahova',
    'Satu Mare', 'Salaj', 'Sibiu', 'Suceava', 'Teleorman', 'Timis',
    'Tulcea', 'Vaslui', 'Vâlcea', 'Vrancea', 'Bucuresti',
    'Bucuresti Sectorul 1', 'Bucuresti Sectorul 2',
    'Bucuresti Sectorul 3',
    'Bucuresti Sectorul 4', 'Bucuresti Sectorul 5',
    'Bucuresti Sectorul 6',
    '', '', '', '', 'Calarasi', 'Giurgiu');
var
  s: string;
  b: boolean;
begin
  b := True;
  s := edCNP.Text;
  if Length(s) = 13 then
  begin
    laLungime.Caption := 'OK';
    if s[1] in ['1', '3', '5', '7'] then
      laCifra.Caption := 'masculin'
    else if s[1] in ['2', '4', '6', '8'] then
      laCifra.Caption := 'feminin'
    else
    begin
      laCifra.Caption := '-';
      b := False;
    end;
    if s[1] in ['1', '2'] then
    begin
      laAn.Caption := IntToStr(1900 + StrToInt(s[2] + s[3]));
      laVarsta.Caption := IntToStr(StrToInt(FormatDateTime('yyyy', Now())) -
        (1900 + StrToInt(s[2] + s[3])));
    end
    else if s[1] in ['3', '4'] then
    begin
      laAn.Caption := IntToStr(1800 + StrToInt(s[2] + s[3]));
      laVarsta.Caption := IntToStr(StrToInt(FormatDateTime('yyyy', Now())) -
        (1800 + StrToInt(s[2] + s[3])));
    end
    else if s[1] in ['5', '6'] then
    begin
      laAn.Caption := IntToStr(2000 + StrToInt(s[2] + s[3]));
      laVarsta.Caption := IntToStr(StrToInt(FormatDateTime('yyyy', Now())) -
        (2000 + StrToInt(s[2] + s[3])));
    end
    else if s[1] in ['7', '8'] then
    begin
      laAn.Caption := 'persoana straina rezidenta in Romania';
      if s[1] = '7' then
        laVarsta.Caption := 'masculin rezident'
      else if s[1] = '8' then
        laVarsta.Caption := 'feminin rezident';
    end
    else if s[1] = '9' then
    begin
      laAn.Caption := 'persoana straina';
      laVarsta.Caption := 'masculin/feminin strain';
    end
    else
    begin
      laAn.Caption := '-';
      laVarsta.Caption := '-';
      b := False;
    end;
    if s[4] + s[5] = '01' then
      laLuna.Caption := 'ianuarie'
    else if s[4] + s[5] = '02' then
      laLuna.Caption := 'februarie'
    else if s[4] + s[5] = '03' then
      laLuna.Caption := 'martie'
    else if s[4] + s[5] = '04' then
      laLuna.Caption := 'aprilie'
    else if s[4] + s[5] = '05' then
      laLuna.Caption := 'mai'
    else if s[4] + s[5] = '06' then
      laLuna.Caption := 'iunie'
    else if s[4] + s[5] = '07' then
      laLuna.Caption := 'iulie'
    else if s[4] + s[5] = '08' then
      laLuna.Caption := 'august'
    else if s[4] + s[5] = '09' then
      laLuna.Caption := 'septembrie'
    else if s[4] + s[5] = '10' then
      laLuna.Caption := 'octombrie'
    else if s[4] + s[5] = '11' then
      laLuna.Caption := 'noiembrie'
    else if s[4] + s[5] = '12' then
      laLuna.Caption := 'decembrie';
    if StrToInt(s[6] + s[7]) in [1..31] then
      laZi.Caption := s[6] + s[7]
    else
    begin
      laZi.Caption := '-';
      b := False;
    end;
    if StrToInt(s[8] + s[9]) in [1..46, 51, 52] then
      laJudet.Caption := judet[StrToInt(s[8] + s[9])]
    else
    begin
      laJudet.Caption := '-';
      b := False;
    end;
  end
  else
  begin
    laLungime.Caption := '-';
    b := False;
  end;
  laCNPvalid.Visible := checkcnp(edCNP.Text) and b;
  laCNPinvalid.Visible := not laCNPvalid.Visible;
  if Length(edCNP.Text) = 13 then
  begin
    laCNPinvalid.Caption := 'CNP invalid!';
    buValidareCNP.Enabled := True;
  end
  else
  begin
    laCNPinvalid.Caption := 'CNP incomplet!';
    buValidareCNP.Enabled := False;
  end;
  if laCNPinvalid.Visible then
  begin
    laLungime.Caption := '-';
    laCifra.Caption := '-';
    laAn.Caption := '-';
    laVarsta.Caption := '-';
    laLuna.Caption := '-';
    laZi.Caption := '-';
    laJudet.Caption := '-';
  end;
end;

procedure TfMain.buValidareCNPClick(Sender: TObject);
var
  s1, s2: string;
  i: integer;
begin
  s1 := edCNP.Text;
  s2 := s1;
  Delete(s2, Length(s2), 1);
  i := 0;
  repeat
    edCNP.Text := s2 + IntToStr(i);
    edCNPClick(Sender);
    Inc(i);
  until laCNPvalid.Visible or (i = 10);
end;

procedure TfMain.edCNPKeyPress(Sender: TObject; var Key: char);
begin
  // #8 is Backspace
  if not (Key in [#8, '0'..'9']) then
  begin
    //ShowMessage('Invalid key');
    // Discard the key
    Key := #0;
  end;
end;

end.
