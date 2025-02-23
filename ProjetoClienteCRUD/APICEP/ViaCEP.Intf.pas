unit ViaCEP.Intf;

interface

uses
  ViaCEP.Model;

type
  IViaCEP = interface
    ['{9D2F1E1A-4B8C-4F3D-9C7E-6F1A8D3B2C9A}']
    function Get(const ACep: string; TrazerCoordenadas: Boolean): TViaCEPClass;
    function Validate(const ACep: string): Boolean;
  end;

implementation

end.

