object DMBanco: TDMBanco
  OnCreate = DataModuleCreate
  Height = 486
  Width = 871
  PixelsPerInch = 120
  object ConectaBanco: TIBDatabase
    Connected = True
    DatabaseName = 'C:\ProjetoClienteCRUD\Banco\BANCOCLIENTECRUD.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 64
    Top = 40
  end
  object TrsConectaBanco: TIBTransaction
    DefaultDatabase = ConectaBanco
    Left = 184
    Top = 40
  end
  object sqlGen: TSQLQuery
    Params = <>
    Left = 275
    Top = 40
  end
  object FDQuery1: TFDQuery
    Left = 64
    Top = 120
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\ProjetoClienteCRUD\Banco\BANCOCLIENTECRUD.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'CharacterSet=ISO8859_2'
      'DriverID=FB')
    LoginPrompt = False
    Left = 160
    Top = 121
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 288
    Top = 121
  end
  object QueryCidade: TFDQuery
    Connection = Base
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_CIDADE_ID'
    UpdateOptions.UpdateTableName = 'CIDADE'
    UpdateOptions.KeyFields = 'CODIGO'
    UpdateOptions.AutoIncFields = 'CODIGO'
    SQL.Strings = (
      'select * from cidade')
    Left = 120
    Top = 216
  end
  object FDPhysFBDriverLink2: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll'
    Left = 249
    Top = 216
  end
  object Base: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\Banco\TESTE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 48
    Top = 216
  end
  object Banco: TIBDatabase
    Connected = True
    DatabaseName = 'C:\ProjetoClienteCRUD\Banco\BANCOCLIENTECRUD.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    BeforeConnect = BancoBeforeConnect
    Left = 604
    Top = 58
  end
  object TTBanco: TIBTransaction
    DefaultDatabase = Banco
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 664
    Top = 58
  end
  object Query: TIBQuery
    Database = Banco
    Transaction = TTBanco
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 644
    Top = 143
  end
  object Query2: TIBQuery
    Database = Banco
    Transaction = TTBanco
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 708
    Top = 143
  end
  object dquery1: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 588
    Top = 143
  end
  object DataSourceRelatorio: TDataSource
    AutoEdit = False
    DataSet = IBQueryRelatorio
    Left = 588
    Top = 215
  end
  object IBQueryRelatorio: TIBQuery
    Database = Banco
    Transaction = TTBanco
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 724
    Top = 215
  end
end
