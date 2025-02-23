unit UCnpjAPI.Intf;

interface

uses
  System.JSON;

type
  ICnpjAPI = interface
    ['{3F2504E0-4F89-11D3-9A0C-0305E82C3301}']
    function ConsultarCNPJ(const CNPJ: string): TJSONObject;
  end;

implementation

end.
