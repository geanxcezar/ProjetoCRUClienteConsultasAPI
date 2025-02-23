unit UCnpjAPI.Core;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, IdSSLOpenSSL, System.JSON,
  UCnpjAPI.Intf, UCnpjAPI.Model;

type
  TCnpjAPI = class(TInterfacedObject, ICnpjAPI)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    constructor Create;
    destructor Destroy; override;
    function ConsultarCNPJ(const CNPJ: string): TJSONObject;
  end;

implementation

constructor TCnpjAPI.Create;
begin
  FIdHTTP := TIdHTTP.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(FIdHTTP);
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
end;

destructor TCnpjAPI.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

function TCnpjAPI.ConsultarCNPJ(const CNPJ: string): TJSONObject;
var
  Response: string;
begin
  FIdHTTP.Request.UserAgent := 'Mozilla/5.0';    //EVITAR O ERRO Project Project_Cliente.exe raised exception class EIdHTTPProtocolException with message 'HTTP/1.1 403 Forbidden'.

  Response := FIdHTTP.Get('https://brasilapi.com.br/api/cnpj/v1/' + CNPJ);
  Result := TJSONObject.ParseJSONValue(Response) as TJSONObject;
end;


end.
