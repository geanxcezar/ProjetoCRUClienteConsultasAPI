program ProjetoCRUDCliente;

uses
  Vcl.Forms,
  UMenuPrincipal in 'UMenuPrincipal.pas' {FormMenu},
  UCadCLientes in 'UCadCLientes.pas' {PCadClientes},
  UDM in 'UDM.pas' {DMBanco: TDataModule},
  Ufunc in 'Ufunc.pas',
  UDMCadastros in 'UDMCadastros.pas' {DMCadastros: TDataModule},
  UCnpjAPI.Core in 'APICNPJ\UCnpjAPI.Core.pas',
  UCnpjAPI.Intf in 'APICNPJ\UCnpjAPI.Intf.pas',
  UCnpjAPI.Model in 'APICNPJ\UCnpjAPI.Model.pas',
  UIBGEAPI.Core in 'APIIBGE\UIBGEAPI.Core.pas',
  UIBGEAPI.Intf in 'APIIBGE\UIBGEAPI.Intf.pas',
  UIBGEAPI.Model in 'APIIBGE\UIBGEAPI.Model.pas',
  ViaCEP.Core in 'APICEP\ViaCEP.Core.pas',
  ViaCEP.Intf in 'APICEP\ViaCEP.Intf.pas',
  ViaCEP.Model in 'APICEP\ViaCEP.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMBanco, DMBanco);
  Application.CreateForm(TDMCadastros, DMCadastros);
  Application.CreateForm(TFormMenu, FormMenu);
  Application.Run;

end.
