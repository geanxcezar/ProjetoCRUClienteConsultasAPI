unit UDM;

interface

uses
  System.SysUtils, System.Classes, IBX.IBDatabase, Data.DB, Data.FMTBcd,
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TDMBanco = class(TDataModule)
    ConectaBanco: TIBDatabase;
    TrsConectaBanco: TIBTransaction;
    sqlGen: TSQLQuery;
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QueryCidade: TFDQuery;
    FDPhysFBDriverLink2: TFDPhysFBDriverLink;
    Base: TFDConnection;
    Banco: TIBDatabase;
    TTBanco: TIBTransaction;
    Query: TIBQuery;
    Query2: TIBQuery;
    dquery1: TDataSource;
    DataSourceRelatorio: TDataSource;
    IBQueryRelatorio: TIBQuery;

    procedure DataModuleCreate(Sender: TObject);
    procedure BancoBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMBanco: TDMBanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDataModule2 }

procedure TDMBanco.BancoBeforeConnect(Sender: TObject);
begin
    banco.DatabaseName:='C:\ProjetoClienteCRUD\Banco\BANCOCLIENTECRUD.FDB';
    banco.Params.Clear;
    banco.Params.Add('user_name=SYSDBA');
    banco.Params.Add('password=masterkey');
end;

procedure TDMBanco.DataModuleCreate(Sender: TObject);
var
  vName: String;

begin

  Base.Connected := False;

  // Caminho do Banco de Dados
  vName := 'C:\ProjetoClienteCRUD\Banco\BANCOCLIENTECRUD.FDB';
  Base.Params.Database := vName;
  Base.Params.UserName := 'SYSDBA';
  Base.Params.Password := 'masterkey';

end;

end.
