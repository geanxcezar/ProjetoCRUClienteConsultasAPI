unit UCnpjAPI.Model;

interface

uses
  System.SysUtils, System.Classes, System.JSON;

type
  TCnpjModel = class
  private
    FRazaoSocial: string;
    FLogradouro: string;
    FMunicipio: string;
    FUF: string;
    FCEP: string;
    FCodigoMunicipio: string;
  public
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Municipio: string read FMunicipio write FMunicipio;
    property UF: string read FUF write FUF;
    property CEP: string read FCEP write FCEP;
    property CodigoMunicipio: string read FCodigoMunicipio write FCodigoMunicipio;

    class function FromJSON(const AJSON: TJSONObject): TCnpjModel;
  end;

implementation

class function TCnpjModel.FromJSON(const AJSON: TJSONObject): TCnpjModel;
begin
  Result := TCnpjModel.Create;
  try
    Result.RazaoSocial := AJSON.GetValue<string>('razao_social');
    Result.Logradouro := AJSON.GetValue<string>('logradouro');
    Result.Municipio := AJSON.GetValue<string>('municipio');
    Result.UF := AJSON.GetValue<string>('uf');
    Result.CEP:= AJSON.GetValue<string>('cep');
    Result.CodigoMunicipio := AJSON.GetValue<string>('codigo_municipio');
  except
    Result.Free;
    raise;
  end;
end;

end.
