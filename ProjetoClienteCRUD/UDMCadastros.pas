unit UDMCadastros;

interface

uses
  SysUtils, Classes, DB, UDM, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase,
  IBX.IBUpdateSQL;

type
  TDMCadastros = class(TDataModule)
    UCliente: TIBUpdateSQL;
    DCliente: TDataSource;
    TCliente: TIBTransaction;
    QCliente: TIBQuery;
    C_DCliente: TDataSource;
    C_TCliente: TIBTransaction;
    C_QCliente: TIBQuery;
    C_QClienteID: TIntegerField;
    C_QClienteNOME: TIBStringField;
    C_QClienteCPF: TIBStringField;
    C_QClienteCEP: TIBStringField;
    C_QClienteLOGRADOURO: TIBStringField;
    C_QClienteCOMPLEMENTO: TIBStringField;
    C_QClienteBAIRRO: TIBStringField;
    C_QClienteLOCALIDADE: TIBStringField;
    C_QClienteUF: TIBStringField;
    C_QClienteIBGE: TIBStringField;
    C_QClienteLATITUDE: TFMTBCDField;
    C_QClienteLONGITUDE: TFMTBCDField;
    QClienteID: TIntegerField;
    QClienteNOME: TIBStringField;
    QClienteCPF: TIBStringField;
    QClienteCNPJ: TIBStringField;
    QClienteCEP: TIBStringField;
    QClienteLOGRADOURO: TIBStringField;
    QClienteCOMPLEMENTO: TIBStringField;
    QClienteBAIRRO: TIBStringField;
    QClienteLOCALIDADE: TIBStringField;
    QClienteUF: TIBStringField;
    QClienteIBGE: TIBStringField;
    QClienteLATITUDE: TFMTBCDField;
    QClienteLONGITUDE: TFMTBCDField;
    C_QClienteCNPJ: TIBStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    cursor : TArray<Byte>;
  end;

var
  DMCadastros: TDMCadastros;

implementation

{$R *.dfm}


end.
