unit UIBGEAPI.Core;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, IdSSLOpenSSL, System.JSON,
  UIBGEAPI.Intf, UIBGEAPI.Model;

type
  TIBGEAPI = class(TInterfacedObject, IIBGEAPI)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    constructor Create;
    destructor Destroy; override;
    function ConsultarCodigoIBGE(const Cidade, UF: string): string;
  end;

implementation

constructor TIBGEAPI.Create;
begin
  FIdHTTP := TIdHTTP.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(FIdHTTP);
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
end;

destructor TIBGEAPI.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

function TIBGEAPI.ConsultarCodigoIBGE(const Cidade, UF: string): string;
var
  Response: string;
  JSONArr: TJSONArray;
  JSONObject: TJSONObject;
  I: Integer;
begin
  Result := '';
  try
    FIdHTTP.Request.UserAgent := 'Mozilla/5.0';    //EVITAR O ERRO Project Project_Cliente.exe raised exception class EIdHTTPProtocolException with message 'HTTP/1.1 403 Forbidden'.

    Response := FIdHTTP.Get('https://brasilapi.com.br/api/ibge/municipios/v1/' + UF);
    JSONArr := TJSONObject.ParseJSONValue(Response) as TJSONArray;
    if Assigned(JSONArr) then
    begin
      for I := 0 to JSONArr.Count - 1 do
      begin
        JSONObject := JSONArr.Items[I] as TJSONObject;
        if SameText(JSONObject.GetValue('nome').Value, Cidade) then
        begin
          Result := JSONObject.GetValue('codigo_ibge').Value;
          Break;
        end;
      end;
      JSONArr.Free;
    end;
  except
    on E: Exception do
      Result := '';
  end;
end;

end.

