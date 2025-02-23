unit ViaCEP.Model;

interface

uses
  REST.Json.Types;

type
  TCoordinates = class
  private
    [JSONName('longitude')]
    FLongitude: Double;
    [JSONName('latitude')]
    FLatitude: Double;
    procedure SetLatitude(const Value: Double);
    procedure SetLongitude(const Value: Double);
  public
    property Latitude: Double read FLatitude write SetLatitude;
    property Longitude: Double read FLongitude write SetLongitude;
  end;

  TLocation = class
  private
    [JSONName('type')]
    FType: string;
    [JSONName('coordinates')]
    FCoordinates: TCoordinates;
    procedure SetCoordinates(const Value: TCoordinates);
    procedure SetType(const Value: string);
  public
    property &Type: string read FType write SetType;
    property Coordinates: TCoordinates read FCoordinates write SetCoordinates;
  end;

  TViaCEPClass = class
  private
    [JSONName('street')]
    FLogradouro: string;
    [JSONName('neighborhood')]
    FBairro: string;
    [JSONName('state')]
    FUF: string;
    [JSONName('cep')]
    FCEP: string;
    [JSONName('city')]
    FLocalidade: string;
    FComplemento: string;
    FIBGE: string;
    [JSONName('service')]
    FService: string;
    [JSONName('location')]
    FLocation: TLocation;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetIBGE(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetService(const Value: string);
    procedure SetLocation(const Value: TLocation);
  public
    property CEP: string read FCEP write SetCEP;
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Complemento: string read FComplemento write SetComplemento;
    property Bairro: string read FBairro write SetBairro;
    property Localidade: string read FLocalidade write SetLocalidade;
    property UF: string read FUF write SetUF;
    property IBGE: string read FIBGE write SetIBGE;
    property Service: string read FService write SetService;
    property Location: TLocation read FLocation write SetLocation;

    function ToJSONString: string;
    class function FromJSONString(const AJSONString: string): TViaCEPClass;
  end;

implementation

uses
  REST.Json;

{ TViaCEPClass }

class function TViaCEPClass.FromJSONString(const AJSONString: string): TViaCEPClass;
begin
  Result := TJson.JsonToObject<TViaCEPClass>(AJSONString);
end;

procedure TViaCEPClass.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TViaCEPClass.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TViaCEPClass.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TViaCEPClass.SetIBGE(const Value: string);
begin
  FIBGE := Value;
end;

procedure TViaCEPClass.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TViaCEPClass.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TViaCEPClass.SetUF(const Value: string);
begin
  FUF := Value;
end;

procedure TViaCEPClass.SetService(const Value: string);
begin
  FService := Value;
end;

procedure TViaCEPClass.SetLocation(const Value: TLocation);
begin
  FLocation := Value;
end;

{ TCoordinates }

procedure TCoordinates.SetLatitude(const Value: Double);
begin
  FLatitude := Value;
end;

procedure TCoordinates.SetLongitude(const Value: Double);
begin
  FLongitude := Value;
end;

{ TLocation }

procedure TLocation.SetCoordinates(const Value: TCoordinates);
begin
  FCoordinates := Value;
end;

procedure TLocation.SetType(const Value: string);
begin
  FType := Value;
end;

function TViaCEPClass.ToJSONString: string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.

