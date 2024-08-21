object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 330
  Width = 503
  object tblconf: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 32
    object tblconfCNPJ: TStringField
      FieldName = 'CNPJ'
    end
    object tblconfLoja: TStringField
      FieldName = 'Loja'
      Size = 6
    end
    object tblconfPDV: TStringField
      FieldName = 'PDV'
      Size = 6
    end
    object tblconfImpressaoComprovanteCliente: TIntegerField
      FieldName = 'ImpressaoComprovanteCliente'
    end
    object tblconfImpressaoComprovanteLoja: TIntegerField
      FieldName = 'ImpressaoComprovanteLoja'
    end
    object tblconfComprovanteLojaSimplificado: TBooleanField
      FieldName = 'ComprovanteLojaSimplificado'
    end
    object tblconfSalvarLOG: TBooleanField
      FieldName = 'SalvarLOG'
    end
    object tblconfPINPADPorta: TStringField
      FieldName = 'PINPADPorta'
      Size = 10
    end
    object tblconfPINPADBauRate: TIntegerField
      FieldName = 'PINPADBauRate'
    end
    object tblconfPINPADDataBits: TIntegerField
      FieldName = 'PINPADDataBits'
    end
    object tblconfPINPADParity: TIntegerField
      FieldName = 'PINPADParity'
    end
    object tblconfPINPADStopBits: TIntegerField
      FieldName = 'PINPADStopBits'
    end
    object tblconfPINPADHandshaking: TIntegerField
      FieldName = 'PINPADHandshaking'
    end
    object tblconfPINPADHardFlow: TBooleanField
      FieldName = 'PINPADHardFlow'
    end
    object tblconfPINPADSoftFlow: TBooleanField
      FieldName = 'PINPADSoftFlow'
    end
    object tblconfPINPADUsar: TBooleanField
      FieldName = 'PINPADUsar'
    end
    object tblconfIMPRESSORAPortaNome: TStringField
      FieldName = 'IMPRESSORAPortaNome'
      Size = 100
    end
    object tblconfIMPRESSORAModelo: TIntegerField
      FieldName = 'IMPRESSORAModelo'
    end
    object tblconfIMPRESSORAAvanco: TIntegerField
      FieldName = 'IMPRESSORAAvanco'
    end
  end
  object tbltef: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 104
    object tbltefValorPgto: TFloatField
      FieldName = 'ValorPgto'
    end
    object tbltefDocumento: TStringField
      FieldName = 'Documento'
      Size = 30
    end
    object tbltefNSU: TStringField
      FieldName = 'NSU'
      Size = 30
    end
    object tbltefTipoPgto: TIntegerField
      FieldName = 'TipoPgto'
    end
  end
  object dtstef: TDataSource
    AutoEdit = False
    DataSet = tbltef
    Left = 80
    Top = 106
  end
end
