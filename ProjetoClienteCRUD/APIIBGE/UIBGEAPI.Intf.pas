unit UIBGEAPI.Intf;

interface

type
  IIBGEAPI = interface
    ['{9D2F1E1A-4B8C-4F3D-9C7E-6F1A8D3B2C9A}']
    function ConsultarCodigoIBGE(const Cidade, UF: string): string;
  end;

implementation

end.

