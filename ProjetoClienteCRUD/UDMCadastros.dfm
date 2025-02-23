object DMCadastros: TDMCadastros
  Height = 544
  Width = 390
  object UCliente: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ID,'
      '  NOME,'
      '  CPF,'
      '  CNPJ,'
      '  CEP,'
      '  LOGRADOURO,'
      '  COMPLEMENTO,'
      '  BAIRRO,'
      '  LOCALIDADE,'
      '  UF,'
      '  IBGE,'
      '  LATITUDE,'
      '  LONGITUDE'
      'from CLIENTE '
      'where'
      '  ID = :ID')
    ModifySQL.Strings = (
      'update CLIENTE'
      'set'
      '  ID = :ID,'
      '  NOME = :NOME,'
      '  CPF = :CPF,'
      '  CNPJ = :CNPJ,'
      '  CEP = :CEP,'
      '  LOGRADOURO = :LOGRADOURO,'
      '  COMPLEMENTO = :COMPLEMENTO,'
      '  BAIRRO = :BAIRRO,'
      '  LOCALIDADE = :LOCALIDADE,'
      '  UF = :UF,'
      '  IBGE = :IBGE,'
      '  LATITUDE = :LATITUDE,'
      '  LONGITUDE = :LONGITUDE'
      'where'
      '  ID = :OLD_ID')
    InsertSQL.Strings = (
      'insert into CLIENTE'
      
        '  (ID, NOME, CPF, CNPJ, CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LO' +
        'CALIDADE, '
      '   UF, IBGE, LATITUDE, LONGITUDE)'
      'values'
      
        '  (:ID, :NOME, :CPF, :CNPJ, :CEP, :LOGRADOURO, :COMPLEMENTO, :BA' +
        'IRRO, :LOCALIDADE, '
      '   :UF, :IBGE, :LATITUDE, :LONGITUDE)')
    DeleteSQL.Strings = (
      'delete from CLIENTE'
      'where'
      '  ID = :OLD_ID')
    Left = 29
    Top = 77
  end
  object DCliente: TDataSource
    AutoEdit = False
    DataSet = QCliente
    Left = 27
    Top = 213
  end
  object TCliente: TIBTransaction
    Active = True
    DefaultDatabase = DMBanco.ConectaBanco
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 30
    Top = 8
  end
  object QCliente: TIBQuery
    Database = DMBanco.ConectaBanco
    Transaction = TCliente
    BufferChunks = 1000
    CachedUpdates = True
    ParamCheck = True
    SQL.Strings = (
      'select *  from CLIENTE')
    UpdateObject = UCliente
    PrecommittedReads = False
    Left = 28
    Top = 145
    object QClienteID: TIntegerField
      FieldName = 'ID'
      Origin = 'CLIENTE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QClienteNOME: TIBStringField
      FieldName = 'NOME'
      Origin = 'CLIENTE.NOME'
      Required = True
      Size = 150
    end
    object QClienteCPF: TIBStringField
      FieldName = 'CPF'
      Origin = 'CLIENTE.CPF'
      Size = 11
    end
    object QClienteCNPJ: TIBStringField
      FieldName = 'CNPJ'
      Origin = 'CLIENTE.CNPJ'
      Size = 14
    end
    object QClienteCEP: TIBStringField
      FieldName = 'CEP'
      Origin = 'CLIENTE.CEP'
      Size = 8
    end
    object QClienteLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Origin = 'CLIENTE.LOGRADOURO'
      Size = 200
    end
    object QClienteCOMPLEMENTO: TIBStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'CLIENTE.COMPLEMENTO'
      Size = 150
    end
    object QClienteBAIRRO: TIBStringField
      FieldName = 'BAIRRO'
      Origin = 'CLIENTE.BAIRRO'
      Size = 150
    end
    object QClienteLOCALIDADE: TIBStringField
      FieldName = 'LOCALIDADE'
      Origin = 'CLIENTE.LOCALIDADE'
      Size = 150
    end
    object QClienteUF: TIBStringField
      FieldName = 'UF'
      Origin = 'CLIENTE.UF'
      Size = 2
    end
    object QClienteIBGE: TIBStringField
      FieldName = 'IBGE'
      Origin = 'CLIENTE.IBGE'
      Size = 7
    end
    object QClienteLATITUDE: TFMTBCDField
      FieldName = 'LATITUDE'
      Origin = 'CLIENTE.LATITUDE'
      Precision = 10
    end
    object QClienteLONGITUDE: TFMTBCDField
      FieldName = 'LONGITUDE'
      Origin = 'CLIENTE.LONGITUDE'
      Precision = 11
    end
  end
  object C_DCliente: TDataSource
    AutoEdit = False
    DataSet = C_QCliente
    Left = 25
    Top = 416
  end
  object C_TCliente: TIBTransaction
    Active = True
    DefaultDatabase = DMBanco.Banco
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 26
    Top = 280
  end
  object C_QCliente: TIBQuery
    Database = DMBanco.Banco
    Transaction = C_TCliente
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select *  from CLIENTE'
      '')
    PrecommittedReads = False
    Left = 24
    Top = 349
    object C_QClienteID: TIntegerField
      FieldName = 'ID'
      Origin = 'CLIENTE.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object C_QClienteNOME: TIBStringField
      FieldName = 'NOME'
      Origin = 'CLIENTE.NOME'
      Required = True
      Size = 150
    end
    object C_QClienteCPF: TIBStringField
      FieldName = 'CPF'
      Origin = 'CLIENTE.CPF'
      Size = 11
    end
    object C_QClienteCEP: TIBStringField
      FieldName = 'CEP'
      Origin = 'CLIENTE.CEP'
      Size = 8
    end
    object C_QClienteLOGRADOURO: TIBStringField
      FieldName = 'LOGRADOURO'
      Origin = 'CLIENTE.LOGRADOURO'
      Size = 200
    end
    object C_QClienteCOMPLEMENTO: TIBStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'CLIENTE.COMPLEMENTO'
      Size = 150
    end
    object C_QClienteBAIRRO: TIBStringField
      FieldName = 'BAIRRO'
      Origin = 'CLIENTE.BAIRRO'
      Size = 150
    end
    object C_QClienteLOCALIDADE: TIBStringField
      FieldName = 'LOCALIDADE'
      Origin = 'CLIENTE.LOCALIDADE'
      Size = 150
    end
    object C_QClienteUF: TIBStringField
      FieldName = 'UF'
      Origin = 'CLIENTE.UF'
      Size = 2
    end
    object C_QClienteIBGE: TIBStringField
      FieldName = 'IBGE'
      Origin = 'CLIENTE.IBGE'
      Size = 7
    end
    object C_QClienteLATITUDE: TFMTBCDField
      FieldName = 'LATITUDE'
      Origin = 'CLIENTE.LATITUDE'
      Precision = 10
    end
    object C_QClienteLONGITUDE: TFMTBCDField
      FieldName = 'LONGITUDE'
      Origin = 'CLIENTE.LONGITUDE'
      Precision = 11
    end
    object C_QClienteCNPJ: TIBStringField
      FieldName = 'CNPJ'
      Origin = 'CLIENTE.CNPJ'
      Size = 14
    end
  end
end
