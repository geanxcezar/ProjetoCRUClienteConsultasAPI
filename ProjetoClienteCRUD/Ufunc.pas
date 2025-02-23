unit Ufunc;

interface

uses

  Windows, Messages, Dialogs, SysUtils, UDM, Forms, DateUtils,
  DB, Classes, Buttons, StdCtrls,
  Graphics, Printers, IBX.IBQuery, DBCtrls,
  Math, menus;

function PEQuery(tq: TIBQuery; sql: string; campos: variant;
  executar: boolean = false): boolean;
function campotabela(campo: string): boolean;
function VerificaCPF(CPF: string): Boolean;
function VerificaCNPJ(CNPJ: string): Boolean;

implementation

uses Variants, Controls, UMenuPrincipal, ComCtrls;

function PEQuery(tq: TIBQuery; sql: string; campos: variant;
  executar: boolean = false): boolean;
var
  x, y: integer;
  c: array of variant;
begin
  Result := False; // Inicializa o valor de retorno como False
  if VarIsArray(campos) then
  begin
    c := campos;
    y := Length(c);
  end
  else
    y := 0;

  tq.close;
  tq.sql.clear;
  tq.sql.Text := sql;

  if y >= 1 then
  begin
    for x := 0 to y - 1 do
    begin
      if VarIsFloat(campos[x]) then
        tq.ParamByName(inttostr(x + 1)).AsFloat := campos[x]
      else if VarIsStr(campos[x]) then
        tq.ParamByName(inttostr(x + 1)).AsString := VarToStr(campos[x])
      else if VarIsNumeric(campos[x]) then
        tq.ParamByName(inttostr(x + 1)).AsInteger := campos[x]
      else if VarIsType(campos[x], varDate) then
        tq.ParamByName(inttostr(x + 1)).AsDateTime := VarToDateTime(campos[x]);
    end;
  end
  else if campos <> null then
  begin
    if VarIsFloat(campos) then
      tq.ParamByName('1').AsFloat := campos
    else if VarIsStr(campos) then
      tq.ParamByName('1').AsString := VarToStr(campos)
    else if VarIsNumeric(campos) then
      tq.ParamByName('1').AsInteger := campos
    else if VarIsType(campos, varDate) then
      tq.ParamByName('1').AsDateTime := VarToDateTime(campos);
  end;
  try
    if not executar then
      tq.open
    else
      tq.execsql;
    Result := True; // Define o valor de retorno como True se a execução for bem-sucedida
  except
    on E: Exception do
    begin
      Result := False; // Define o valor de retorno como False se ocorrer uma exceção
      ShowMessage('Erro ao executar consulta: ' + E.Message);
    end;
  end;
end;

function campotabela(campo: string): boolean;
begin
  // verifica se existe um campo passado no parametro no banco de dados
  PEQuery(dmbanco.Query, ' select r.rdb$field_name ' +
    ' from rdb$relation_fields r ' +
    ' join rdb$fields f on f.rdb$field_name = r.rdb$field_source ' +
    ' join rdb$types t on f.rdb$field_type = t.rdb$type ' +
    ' where (r.rdb$field_name=' + QuotedStr(campo) + ') ' +
    ' and (t.rdb$field_name= ' + QuotedStr('RDB$FIELD_TYPE') + ')', null);

  if not dmbanco.Query.IsEmpty then
    campotabela := true
  else
    campotabela := false;
end;

function VerificaCPF(CPF: string): Boolean;
var
  CPFCalc : string;
  SomaCPF, CPFDigit: Integer;
  I: Byte;
begin
  try
    CPFCalc:= Copy(CPF, 1, 9);
    SomaCPF:= 0;
    for I:= 1 to 9 do
      SomaCPF:= SomaCPF + StrToInt(Copy(CPFCalc, I, 1)) * (11 - I);
    CPFDigit:= 11 - SomaCPF mod 11;
    if CPFDigit in [10, 11] then
      CPFCalc:= CPFCalc + '0'
    else
      CPFCalc:= CPFCalc + IntToStr(CPFDigit);
    SomaCPF:= 0;
    for I:= 1 to 10 do
      SomaCPF:= SomaCPF + StrToInt(Copy(CPFCalc, I, 1)) * (12 - I);
    CPFDigit:= 11 - SomaCPF mod 11;
    if CPFDigit in [10, 11] then
      CPFCalc:= CPFCalc + '0'
    else
      CPFCalc:= CPFCalc + IntToStr(CPFDigit);
    Result:= (CPF = CPFCalc);
  except
    Result:= false;
  end;
end;

function VerificaCNPJ(CNPJ: string): Boolean;
var
  CNPJCalc: string;
  SomaCNPJ, CNPJDigit: Integer;
  I: Byte;
  Peso1: array[1..12] of Byte;
  Peso2: array[1..13] of Byte;
begin
  // Verifica se o CNPJ tem 14 dígitos
  if Length(CNPJ) <> 14 then
  begin
    Result := False;
    Exit;
  end;

  try
    // Inicializa os pesos manualmente
    Peso1[1] := 5; Peso1[2] := 4; Peso1[3] := 3; Peso1[4] := 2;
    Peso1[5] := 9; Peso1[6] := 8; Peso1[7] := 7; Peso1[8] := 6;
    Peso1[9] := 5; Peso1[10] := 4; Peso1[11] := 3; Peso1[12] := 2;

    Peso2[1] := 6; Peso2[2] := 5; Peso2[3] := 4; Peso2[4] := 3;
    Peso2[5] := 2; Peso2[6] := 9; Peso2[7] := 8; Peso2[8] := 7;
    Peso2[9] := 6; Peso2[10] := 5; Peso2[11] := 4; Peso2[12] := 3; Peso2[13] := 2;

    CNPJCalc := Copy(CNPJ, 1, 12);
    SomaCNPJ := 0;
    for I := 1 to 12 do
      SomaCNPJ := SomaCNPJ + StrToInt(Copy(CNPJCalc, I, 1)) * Peso1[I];
    CNPJDigit := 11 - SomaCNPJ mod 11;
    if CNPJDigit >= 10 then
      CNPJCalc := CNPJCalc + '0'
    else
      CNPJCalc := CNPJCalc + IntToStr(CNPJDigit);

    SomaCNPJ := 0;
    for I := 1 to 13 do
      SomaCNPJ := SomaCNPJ + StrToInt(Copy(CNPJCalc, I, 1)) * Peso2[I];
    CNPJDigit := 11 - SomaCNPJ mod 11;
    if CNPJDigit >= 10 then
      CNPJCalc := CNPJCalc + '0'
    else
      CNPJCalc := CNPJCalc + IntToStr(CNPJDigit);

    Result := (CNPJ = CNPJCalc);
  except
    Result := False;
  end;
end;

end.
