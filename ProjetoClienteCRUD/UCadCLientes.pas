unit uCadClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, Buttons, DB, ComCtrls,
  DBCtrls, Mask, JSON, Printers,
  ViaCEP.Intf, ViaCEP.Core, ViaCEP.Model,
  UCnpjAPI.Intf, UCnpjAPI.Core, UCnpjAPI.Model,
  UIBGEAPI.Intf, UIBGEAPI.Core, UIBGEAPI.Model;

type
  TPCadClientes = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    GroupBoxPesquisa: TGroupBox;
    EditPesquisa: TEdit;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    SpeedButton4: TSpeedButton;
    SpeedButtonExcluir: TSpeedButton;
    SpeedButtonAlterar: TSpeedButton;
    SpeedButtonNovo: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Panel3: TPanel;
    SpeedButtonCancelar: TSpeedButton;
    SpeedButtonGravar: TSpeedButton;
    DBEditID: TDBEdit;
    DBEditNOME: TDBEdit;
    DBEditLOCALIDADE: TDBEdit;
    btnAtualizarIBGE: TBitBtn;
    chbTrazerCoordenadas: TCheckBox;
    Label5: TLabel;
    DBEditBAIRRO: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEditUF: TDBEdit;
    DBEditIBGE: TDBEdit;
    Label9: TLabel;
    DBEditLATITUDE: TDBEdit;
    DBEditLONGITUDE: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEditCOMPLEMENTO: TDBEdit;
    Label19: TLabel;
    DBEditLOGRADOURO: TDBEdit;
    mskCnpj: TMaskEdit;
    mskCpf: TMaskEdit;
    mskCep: TMaskEdit;
    SpbImprimirClick: TSpeedButton;
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButtonNovoClick(Sender: TObject);
    procedure GroupBoxPesquisaClick(Sender: TObject);
    procedure SpeedButtonAlterarClick(Sender: TObject);
    procedure SpeedButtonExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure EditPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SpeedButtonCancelarClick(Sender: TObject);
    procedure SpeedButtonGravarClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btnAtualizarIBGEClick(Sender: TObject);
    procedure mskCepExit(Sender: TObject);
    procedure mskCpfExit(Sender: TObject);
    procedure mskCnpjExit(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure SpbImprimirClickClick(Sender: TObject);
  private
    procedure ConsultarCNPJ;
    { Private declarations }
  public
    { Public declarations }
    itemmenu: Integer;
    modal: char;
  end;

var
  PCadClientes: TPCadClientes;
  c_cod: Integer;

implementation

uses UDM, UDMCadastros, UMenuPrincipal, Ufunc;

{$R *.dfm}

procedure TPCadClientes.SpbImprimirClickClick(Sender: TObject);
var
  i, j: Integer;
  LineHeight, CurrentY, StartX: Integer;
  PageNumber: Integer;
  Texto: string;
  ColWidths: array of Integer; // Array para armazenar as larguras das colunas
  ColTitles: array of string;  // Array para armazenar os títulos das colunas
begin
  // Define as larguras das colunas em pixels
  SetLength(ColWidths, 13); // 13 colunas
  ColWidths[0] := 50;  // ID
  ColWidths[1] := 150; // NOME
  ColWidths[2] := 100; // CPF
  ColWidths[3] := 120; // CNPJ
  ColWidths[4] := 80;  // CEP
  ColWidths[5] := 200; // LOGRADOURO
  ColWidths[6] := 150; // BAIRRO
  ColWidths[7] := 50;  // UF
  ColWidths[8] := 150; // LOCALIDADE
  ColWidths[9] := 100; // COMPLEMENTO
  ColWidths[10] := 80; // IBGE
  ColWidths[11] := 100; // LATITUDE
  ColWidths[12] := 100; // LONGITUDE

  // Define os títulos das colunas
  SetLength(ColTitles, 13);
  ColTitles[0] := 'ID';
  ColTitles[1] := 'NOME';
  ColTitles[2] := 'CPF';
  ColTitles[3] := 'CNPJ';
  ColTitles[4] := 'CEP';
  ColTitles[5] := 'LOGRADOURO';
  ColTitles[6] := 'BAIRRO';
  ColTitles[7] := 'UF';
  ColTitles[8] := 'LOCALIDADE';
  ColTitles[9] := 'COMPLEMENTO';
  ColTitles[10] := 'IBGE';
  ColTitles[11] := 'LATITUDE';
  ColTitles[12] := 'LONGITUDE';

  // Configura a impressora
  Printer.Orientation := poLandsCape; // Define a orientação da página como vertical
  Printer.BeginDoc;
  try
    // Define a fonte e o tamanho
    Printer.Canvas.Font.Name := 'Courier New';
    Printer.Canvas.Font.Size := 7; // Fonte menor

    // Calcula a altura da linha
    LineHeight := Printer.Canvas.TextHeight('A') + 15; // Espaçamento maior

    // Posição inicial no topo da página
    CurrentY := 200; // Margem superior maior

    // Imprime o cabeçalho do relatório
    Printer.Canvas.TextOut(100, CurrentY, 'Relatório de Clientes');
    CurrentY := CurrentY + LineHeight * 2;

    // Imprime os títulos das colunas
    StartX := 100; // Define a margem esquerda
    for j := 0 to High(ColTitles) do
    begin
      Printer.Canvas.TextOut(StartX, CurrentY, ColTitles[j]);
      StartX := StartX + ColWidths[j] + 400; // Adiciona a largura da coluna + espaçamento
    end;
    CurrentY := CurrentY + LineHeight;

    // Percorre os registros da grid
    DMCadastros.C_QCliente.First;
    while not DMCadastros.C_QCliente.Eof do
    begin
      // Verifica se precisa iniciar uma nova página
      if CurrentY > Printer.PageHeight - 200 then
      begin
        Printer.NewPage;
        CurrentY := 100;
        Inc(PageNumber);
        Printer.Canvas.TextOut(100, CurrentY, 'Página ' + IntToStr(PageNumber));
        CurrentY := CurrentY + LineHeight * 2;
      end;

      // Imprime os dados de cada linha
      StartX := 100; // Reinicia a posição horizontal para o início da linha
      for j := 0 to High(ColWidths) do
      begin
        case j of
          0: Texto := DMCadastros.C_QCliente.FieldByName('ID').AsString;
          1: Texto := DMCadastros.C_QCliente.FieldByName('NOME').AsString;
          2: Texto := DMCadastros.C_QCliente.FieldByName('CPF').AsString;
          3: Texto := DMCadastros.C_QCliente.FieldByName('CNPJ').AsString;
          4: Texto := DMCadastros.C_QCliente.FieldByName('CEP').AsString;
          5: Texto := DMCadastros.C_QCliente.FieldByName('LOGRADOURO').AsString;
          6: Texto := DMCadastros.C_QCliente.FieldByName('BAIRRO').AsString;
          7: Texto := DMCadastros.C_QCliente.FieldByName('UF').AsString;
          8: Texto := DMCadastros.C_QCliente.FieldByName('LOCALIDADE').AsString;
          9: Texto := DMCadastros.C_QCliente.FieldByName('COMPLEMENTO').AsString;
          10: Texto := DMCadastros.C_QCliente.FieldByName('IBGE').AsString;
          11: Texto := DMCadastros.C_QCliente.FieldByName('LATITUDE').AsString;
          12: Texto := DMCadastros.C_QCliente.FieldByName('LONGITUDE').AsString;
        end;

        // Imprime o texto na posição correta
        Printer.Canvas.TextOut(StartX, CurrentY, Texto);
        StartX := StartX + ColWidths[j] + 400; // Avança para a próxima coluna
      end;
      CurrentY := CurrentY + LineHeight; // Avança para a próxima linha

      // Vai para o próximo registro
      DMCadastros.C_QCliente.Next;
    end;

    // Finaliza a impressão
    Printer.EndDoc;
  except
    on E: Exception do
    begin
      Printer.Abort;
      ShowMessage('Erro ao imprimir: ' + E.Message);
    end;
  end;
end;

procedure TPCadClientes.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TPCadClientes.SpeedButtonNovoClick(Sender: TObject);
var
  i_cod: Integer;
begin
  if DMCadastros.QCliente.Active = false then
    DMCadastros.QCliente.Open;

  if DMBanco.TTBanco.InTransaction then
    DMBanco.TTBanco.Commit;

  DMBanco.query.Close;
  DMBanco.query.sql.clear;
  DMBanco.query.sql.text := ' select max(ID) from CLIENTE ';
  DMBanco.query.Open;
  if DMBanco.query.fields[0].value = null then
    i_cod := 0
  else
    i_cod := DMBanco.query.fields[0].asinteger;
  DMCadastros.QCliente.insert;
  DMCadastros.QClienteID.asinteger := i_cod + 1;

  c_cod := DMCadastros.QClienteID.asinteger;

  TabSheet1.TabVisible := false;
  TabSheet2.TabVisible := true;
  mskCnpj.Text:= '';
  mskCpf.Text:= '';
  mskCep.Text:= '';
  DBEditNOME.SetFocus;
end;

procedure TPCadClientes.TabSheet2Show(Sender: TObject);
begin
   if DMCadastros.QCliente.State in [dsedit] then
   begin
      DMCadastros.C_QCliente.Close;
      DMCadastros.C_QCliente.SQL.Clear;
      DMCadastros.C_QCliente.SQL.Text:= c_cliente+' where ID = :d1 ';
      DMCadastros.C_QCliente.ParamByName('d1').AsString:= DMCadastros.QClienteID.AsString;
      DMCadastros.C_QCliente.Open;
      mskCnpj.Text:= DMCadastros.C_QClienteCNPJ.AsString;
      mskCpf.Text:= DMCadastros.C_QClienteCPF.AsString;
      mskCep.Text:= DMCadastros.C_QClienteCEP.AsString;
   end;
end;

procedure TPCadClientes.GroupBoxPesquisaClick(Sender: TObject);
var
  select: String;
  ufValue: String;
begin
  select := '';
  if DMCadastros.C_TCliente.InTransaction then
    DMCadastros.C_TCliente.Commit;

  select := ' where 1 = 1';

  // Pesquisa dos Clientes
  DMCadastros.C_QCliente.Close;
  DMCadastros.C_QCliente.sql.clear;
  if Trim(EditPesquisa.text) <> '' then
  begin
    DMCadastros.C_QCliente.sql.text := c_cliente + select +
      ' AND NOME LIKE :d1 ' +
      ' OR CPF LIKE :d1 ' +
      ' OR CNPJ LIKE :d1 ' +
      ' OR CEP LIKE :d1 ' +
      ' OR LOGRADOURO LIKE :d1 ' +
      ' OR BAIRRO LIKE :d1 ' +
      ' OR LOCALIDADE LIKE :d1 ' +
      ' OR IBGE LIKE :d1 ';
    DMCadastros.C_QCliente.ParamByName('d1').AsString := Trim('%' + EditPesquisa.Text + '%');
  end
  else
    DMCadastros.C_QCliente.sql.text := c_cliente + select +
      ' order by NOME ';

  try
    DMCadastros.C_QCliente.Open;
  except
    on E: Exception do
      ShowMessage('Erro ao abrir consulta: ' + E.Message);
  end;

  DMCadastros.C_QCliente.Locate('ID;', VarArrayOf([c_cod]),
    [loCaseInsensitive]);
end;

procedure TPCadClientes.mskCepExit(Sender: TObject);
var
  ViaCEP: IViaCEP;
  CEP: TViaCEPClass;
begin
  if mskCep.Text <> '' then
  begin
    ViaCEP := TViaCEP.Create;
    if ViaCEP.Validate(mskCep.Text) then
    begin
      CEP := ViaCEP.Get(mskCep.Text, chbTrazerCoordenadas.Checked);
      if Assigned(CEP) then
      begin
        try
          DBEditLOGRADOURO.Text := CEP.Logradouro;
          DBEditCOMPLEMENTO.Text := CEP.Complemento;
          DBEditBAIRRO.Text := CEP.Bairro;
          DBEditLOCALIDADE.Text := CEP.Localidade;
          DBEditUF.Text := CEP.UF;
          btnAtualizarIBGE.Enabled:= true;
          if chbTrazerCoordenadas.Checked and Assigned(CEP.Location) and Assigned(CEP.Location.Coordinates) then
          begin
            DBEditLATITUDE.Text := FloatToStr(CEP.Location.Coordinates.Latitude);
            DBEditLONGITUDE.Text := FloatToStr(CEP.Location.Coordinates.Longitude);
          end;

          DMCadastros.QClienteCEP.AsString:=mskCep.Text;

        finally
          CEP.Free;
        end;
      end
      else
        MessageDlg('CEP NÃO ENCONTRADO.', mtWarning, [mbOK], 0);
    end
    else
      MessageDlg('CEP INVÁLIDO.', mtWarning, [mbOK], 0);
  end;
end;

procedure TPCadClientes.mskCnpjExit(Sender: TObject);
begin
  if TabSheet2.TabVisible = true then
  begin
    if Trim(mskCnpj.Text) <> '00000000000000' then
    begin

      if not VerificaCNPJ(mskCnpj.Text) then
      begin
        mskCnpj.Clear;
        ShowMessage('CNPJ inválido.');
      end
      else
      begin
        ConsultarCNPJ;
        DMCadastros.QClienteCNPJ.AsString:=mskCnpj.Text;
      end;

    end;
  end;
end;

procedure TPCadClientes.mskCpfExit(Sender: TObject);
begin
  if TabSheet2.TabVisible = true then
  begin
    if Trim(mskcpf.Text) <> '00000000000' then
    begin

      if not VerificaCpf( mskcpf.text ) then
        begin
          mskcpf.clear;
          messagedlg('CPF INVÁLIDO.', mtwarning, [mbok], 0);
        end
      else
        DMCadastros.QClienteCPF.AsString:=mskcpf.Text;

    end;
  end;
end;

procedure TPCadClientes.SpeedButtonAlterarClick(Sender: TObject);
begin
  if DMCadastros.TCliente.InTransaction then
    DMCadastros.TCliente.Commit;

  c_cod := DMCadastros.C_QClienteID.asinteger;

  DMCadastros.QCliente.Close;
  DMCadastros.QCliente.sql.clear;
  DMCadastros.QCliente.sql.text := c_cliente + ' where ID = :d1 ';
  DMCadastros.QCliente.ParamByName('d1').AsString := DMCadastros.C_QClienteID.AsString;
  DMCadastros.QCliente.Open;

  DMCadastros.QCliente.edit;
  TabSheet1.TabVisible := false;
  TabSheet2.TabVisible := true;
  DBEditNOME.SetFocus;

end;

procedure TPCadClientes.SpeedButtonExcluirClick(Sender: TObject);
begin
  DMCadastros.QCliente.Close;
  DMCadastros.QCliente.sql.clear;
  DMCadastros.QCliente.sql.text := c_cliente + ' where ID = :d1 ';
  DMCadastros.QCliente.ParamByName('d1').AsString := DMCadastros.C_QClienteID.AsString;
  DMCadastros.QCliente.Open;
  try
    if (DMCadastros.QCliente.recordcount <> 0) and
      (application.MessageBox('Confirma exclusão do registro?', '',
      mb_iconquestion + mb_yesno) = idyes) then
    begin
      DMCadastros.QCliente.delete;
      DMCadastros.QCliente.ApplyUpdates;
      DMCadastros.TCliente.Commit;
      GroupBoxPesquisaClick(Sender);
    end;
  except
    DMCadastros.TCliente.rollback;
    GroupBoxPesquisaClick(Sender);
    application.MessageBox('O registro não pode ser deletado!', '',
      mb_iconerror + mb_ok);
  end;
end;

procedure TPCadClientes.FormShow(Sender: TObject);
begin
  TabSheet1.TabVisible := true;
  TabSheet2.TabVisible := false;

  //Carrega a QUERY de consulta
  GroupBoxPesquisaClick(Sender);

  EditPesquisa.SetFocus;
end;

procedure TPCadClientes.DBGrid1DblClick(Sender: TObject);
begin
  if Tag = 1 then
    SpeedButtonAlterarClick(Sender)
  else
    Close;
end;

procedure TPCadClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = vk_escape) and (TabSheet2.TabVisible = false)) then
    SpeedButton4Click(Sender);
  if Key = vk_return then
    Perform(WM_NEXTDLGCTL, 0, 0);
  if (Key = vk_F2) then
    SpeedButtonAlterarClick(Sender);

end;

procedure TPCadClientes.FormDestroy(Sender: TObject);
begin
  PCadClientes := nil;
end;

procedure TPCadClientes.EditPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_return then
    GroupBoxPesquisaClick(Sender);

  if (Key = vk_up) or (Key = vk_down) then
    DBGrid1.SetFocus;
end;

procedure TPCadClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DMCadastros.QCliente.cancel;

  if PCadClientes <> nil then
    PCadClientes.Release;
end;

procedure TPCadClientes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if DMCadastros.cursor = DMCadastros.C_QCliente.Bookmark then
  begin
    DBGrid1.Canvas.Brush.Color := clBtnFace;
    DBGrid1.Canvas.Font.Color := clBlack;

    if State = [gdSelected, gdFocused] then
    begin
      DBGrid1.Canvas.Brush.Color := clGray;
      DBGrid1.Canvas.Font.Color := clWindow;
    end;
  end;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TPCadClientes.SpeedButtonCancelarClick(Sender: TObject);
begin
  DMCadastros.QCliente.cancel;
  TabSheet1.TabVisible := true;
  TabSheet2.TabVisible := false;
  GroupBoxPesquisaClick(Sender);
  DBGrid1.SetFocus;
end;

procedure TPCadClientes.SpeedButtonGravarClick(Sender: TObject);
begin
  try
    DMCadastros.QCliente.Post;
    DMCadastros.QCliente.ApplyUpdates;
    DMCadastros.TCliente.Commit;
    TabSheet1.TabVisible := true;
    TabSheet2.TabVisible := false;
  except
    on E: Exception do
    begin
      application.MessageBox(PChar('Erro: ' + E.Message), 'Atenção', MB_ICONINFORMATION + MB_OK);
    end;
  end;

  GroupBoxPesquisaClick(Sender);
end;

procedure TPCadClientes.DBGrid1TitleClick(Column: TColumn);
var
  Idx, Idx2: Integer;
begin
  // verifica se o campo existe no banco
  if campotabela(Column.FieldName) then
  begin
    // Alteração da query ordenando pelo campo "clicado"
    with DMCadastros.C_QCliente do
    begin;
      Idx := Pos('ORDER BY ', UpperCase(sql.text));
      Idx2 := Pos(' DESC ', UpperCase(sql.text));
      if Idx > 0 then
      begin
        sql.text := Copy(sql.text, 1, Idx - 1);
        if (Column.Index <> DBGrid1.Tag) or (Idx2 > 0) then
          sql.text := sql.text + ' ORDER BY ' + Column.FieldName
        else
          sql.text := sql.text + ' ORDER BY ' + Column.FieldName + ' desc ';
      end;
      Close;
      Open;
    end;

    // restaurando a cor do título
    DBGrid1.Columns[DBGrid1.Tag].Title.Color := clBtnFace;
    DBGrid1.Columns[DBGrid1.Tag].Title.Font.Color := clWindowText;

    // guarda a coluna selecionada
    DBGrid1.Tag := Column.Index;

    // alterando a cor do título do campo ordenado
    DBGrid1.Columns[DBGrid1.Tag].Title.Color := $00BE7C7C;
    DBGrid1.Columns[DBGrid1.Tag].Title.Font.Color := clWhite;
  end;
end;

procedure TPCadClientes.ConsultarCNPJ;
var
  CnpjAPI: ICnpjAPI;
  JSON: TJSONObject;
  CnpjModel: TCnpjModel;
begin
  CnpjAPI := TCnpjAPI.Create;
  JSON := CnpjAPI.ConsultarCNPJ(mskCnpj.Text);
  if Assigned(JSON) then
  begin
    CnpjModel := nil;
    try
      CnpjModel := TCnpjModel.FromJSON(JSON);
      DBEditNOME.Text := CnpjModel.RazaoSocial;
      DBEditLOGRADOURO.Text := CnpjModel.Logradouro;
      DBEditLOCALIDADE.Text := CnpjModel.Municipio;
      DBEditUF.Text := CnpjModel.UF;
      DBEditIBGE.Text := CnpjModel.CodigoMunicipio;
      mskCep.Text:= CnpjModel.CEP;
      btnAtualizarIBGE.Enabled:= true;
    finally
      JSON.Free;
      CnpjModel.Free;
    end;
  end
  else
    ShowMessage('CNPJ não encontrado.');
end;

procedure TPCadClientes.btnAtualizarIBGEClick(Sender: TObject);
var
  IBGEAPI: IIBGEAPI;
  CodigoIBGE: string;
begin
  IBGEAPI := TIBGEAPI.Create;
  CodigoIBGE := IBGEAPI.ConsultarCodigoIBGE(DBEditLOCALIDADE.Text, DBEditUF.Text);
  if CodigoIBGE <> '' then
    DBEditIBGE.Text := CodigoIBGE
  else
    ShowMessage('Código IBGE não encontrado para a cidade informada.');

end;

end.
