object frmprinc: Tfrmprinc
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'PDV Demosntrativo Multiplus'
  ClientHeight = 524
  ClientWidth = 1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnActivate = FormActivate
  DesignSize = (
    1091
    524)
  TextHeight = 13
  object Label2: TLabel
    Left = 280
    Top = 365
    Width = 76
    Height = 29
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Digitar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 716
    Top = 365
    Width = 61
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Qtde.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 892
    Top = 365
    Width = 103
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Pre'#231'o R$'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 365
    Top = 372
    Width = 337
    Height = 19
    Anchors = [akLeft, akRight, akBottom]
    Caption = '" = " - Definir pre'#231'o / " * " - Definir Quantidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pntitulo: TPanel
    Left = 10
    Top = 8
    Width = 1070
    Height = 105
    Anchors = [akLeft, akTop, akRight]
    Caption = 'PDV Demonstrativo Multiplus'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -64
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 1064
  end
  object pnrodape: TPanel
    Left = 10
    Top = 449
    Width = 1070
    Height = 65
    Anchors = [akLeft, akRight, akBottom]
    Color = clSilver
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 440
    ExplicitWidth = 1064
    DesignSize = (
      1070
      65)
    object btreiniciarvenda: TSpeedButton
      Left = 891
      Top = 8
      Width = 172
      Height = 50
      Anchors = [akTop, akRight]
      Caption = 'F9 - Limpar tela'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btreiniciarvendaClick
    end
    object btpagar: TSpeedButton
      Left = 720
      Top = 8
      Width = 165
      Height = 50
      Anchors = [akTop, akRight]
      Caption = 'F5 - Finalizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btpagarClick
    end
    object Label1: TLabel
      Left = 432
      Top = 19
      Width = 89
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Total R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btconfig: TSpeedButton
      Left = 9
      Top = 8
      Width = 188
      Height = 50
      Caption = 'F2 - Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btconfigClick
    end
    object btrelatorio: TSpeedButton
      Left = 204
      Top = 8
      Width = 164
      Height = 50
      Caption = 'F7 - Relat'#243'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btrelatorioClick
    end
    object edttotal: TMaskEdit
      Left = 525
      Top = 16
      Width = 189
      Height = 35
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      ExplicitLeft = 519
    end
  end
  object DBGridprod: TDBGrid
    Left = 280
    Top = 119
    Width = 800
    Height = 234
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dtsvenda
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'qtde'
        Title.Alignment = taCenter
        Title.Caption = 'Quantidade'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o do Produto'
        Width = 472
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'preco'
        Title.Alignment = taCenter
        Title.Caption = 'Pre'#231'o R$'
        Width = 129
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'total'
        Title.Alignment = taCenter
        Title.Caption = 'Total R$'
        Width = 150
        Visible = True
      end>
  end
  object edtdigitar: TMaskEdit
    Left = 280
    Top = 396
    Width = 430
    Height = 47
    Anchors = [akLeft, akRight, akBottom]
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    Text = ''
    OnKeyDown = edtdigitarKeyDown
    OnKeyPress = edtdigitarKeyPress
    ExplicitTop = 387
    ExplicitWidth = 424
  end
  object edtqtde: TMaskEdit
    Left = 716
    Top = 396
    Width = 170
    Height = 47
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Ctl3D = False
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    Text = '1,000'
    ExplicitLeft = 710
    ExplicitTop = 387
  end
  object edtpreco: TMaskEdit
    Left = 892
    Top = 396
    Width = 188
    Height = 47
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Ctl3D = False
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
    Text = '0,00'
    ExplicitLeft = 886
    ExplicitTop = 387
  end
  object rbformas: TRadioGroup
    Left = 10
    Top = 119
    Width = 255
    Height = 324
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Formas de Pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'tpMPlCreditoVista'
      'tpMPlCredito'
      'tpMPlCreditoaParceladoLoja'
      'tpMPlCreditoParceladoADM'
      'tpMPlDebito'
      'tpMPlFrota'
      'tpMPlDebitoVista'
      'tpMPlVoucher'
      'tpMPlPIX'
      'tpMPlPIXMercadoPago'
      'tpMPlPIXPicPay')
    ParentFont = False
    TabOrder = 6
    ExplicitHeight = 315
  end
  object tblvenda: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 41
    Top = 40
    object tblvendadescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object tblvendaqtde: TFloatField
      FieldName = 'qtde'
    end
    object tblvendapreco: TFloatField
      FieldName = 'preco'
    end
    object tblvendatotal: TFloatField
      FieldName = 'total'
    end
  end
  object dtsvenda: TDataSource
    DataSet = tblvenda
    Left = 89
    Top = 40
  end
end
