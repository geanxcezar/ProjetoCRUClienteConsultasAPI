unit ViaCEP.Core;

interface

uses
  IdHTTP, IdSSLOpenSSL, ViaCEP.Intf, ViaCEP.Model, System.SysUtils, System.Classes, System.JSON;

type
  TViaCEP = class(TInterfacedObject, IViaCEP)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    function Get(const ACep: string; TrazerCoordenadas: Boolean): TViaCEPClass;
    function Validate(const ACep: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TViaCEP }

uses
  REST.Json;

constructor TViaCEP.Create;
begin
  FIdHTTP := TIdHTTP.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

function TViaCEP.Get(const ACep: string; TrazerCoordenadas: Boolean): TViaCEPClass;
const
  URL = 'https://brasilapi.com.br/api/cep/v2/%s';
var
  LResponse: TStringStream;
  JSONObject: TJSONObject;
  Coordinates: TJSONObject;
  JSONString: string;
begin
  Result := nil;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Request.UserAgent := 'Mozilla/5.0'; // Evita erro 403 Forbidden

    FIdHTTP.Get(Format(URL, [ACep.Trim]), LResponse);
    if FIdHTTP.ResponseCode = 200 then
    begin
      JSONString := LResponse.DataString;
      JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
      try
        Result := TJson.JsonToObject<TViaCEPClass>(JSONString);
        if Assigned(Result) then
        begin
          if TrazerCoordenadas and Assigned(JSONObject.GetValue('location')) then
          begin
            Coordinates := JSONObject.GetValue<TJSONObject>('location').GetValue<TJSONObject>('coordinates');
            Result.Location := TLocation.Create;
            Result.Location.Coordinates := TCoordinates.Create;
            Result.Location.Coordinates.Latitude := Coordinates.GetValue<Double>('latitude');
            Result.Location.Coordinates.Longitude := Coordinates.GetValue<Double>('longitude');
          end;
        end
        else
          raise Exception.Create('Falha ao converter JSON para TViaCEPClass.');
      finally
        JSONObject.Free;
      end;
    end;
  finally
    LResponse.Free;
  end;
end;

function TViaCEP.Validate(const ACep: string): Boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if ACep.Trim.Length <> 8 then
    Exit(False);
  if StrToIntDef(ACep, INVALID_CHARACTER) = INVALID_CHARACTER then
    Exit(False);
end;

destructor TViaCEP.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

end.

