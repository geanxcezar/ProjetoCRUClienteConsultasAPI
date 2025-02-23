unit UMenuPrincipal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Imaging.jpeg,
    Vcl.ExtCtrls, frxSmartMemo, frxClass, frxDBSet, frCoreClasses;

type
    TFormMenu = class(TForm)
                MainMenu1: TMainMenu;
                Cadastro1: TMenuItem;
                Clientes1: TMenuItem;
                Sair1: TMenuItem;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
        private
                { Private declarations }
        public
                { Public declarations }
        end;

var
        FormMenu: TFormMenu;
        c_cliente : string;

implementation

{$R *.dfm}

uses UDM, UDMCadastros, UCadCLientes;

procedure TFormMenu.FormShow(Sender: TObject);
begin
  // carregas as Variaveis
  c_cliente   := DMCadastros.C_QCliente.SQL.Text;

end;

procedure TFormMenu.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMenu.Clientes1Click(Sender: TObject);
begin
  // pesquisa verificano se a tela ja esta criada
  if PCadClientes = nil then
  begin
    PCadClientes := TPCadClientes.create(self);
    PCadClientes.modal := 'S';
    PCadClientes.Tag:=1;
    PCadClientes.show;
  end;
end;

end.
