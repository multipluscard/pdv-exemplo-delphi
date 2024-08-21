object frmconfig: Tfrmconfig
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es'
  ClientHeight = 510
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object pntitulo: TPanel
    Left = 8
    Top = 16
    Width = 973
    Height = 57
    Caption = 'CONFIGURA'#199#213'ES'
    Color = clSilver
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnrodape: TPanel
    Left = 8
    Top = 439
    Width = 973
    Height = 63
    Color = clSilver
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      973
      63)
    object btsalvar: TSpeedButton
      Left = 602
      Top = 8
      Width = 153
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'Salvar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btsalvarClick
      ExplicitLeft = 502
    end
    object btcancelar: TSpeedButton
      Left = 761
      Top = 8
      Width = 202
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'ESC - Cancelar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btcancelarClick
      ExplicitLeft = 661
    end
  end
  object pgc: TPageControl
    Left = 24
    Top = 88
    Width = 961
    Height = 345
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Conex'#227'o com Multiplus'
      object Label307: TLabel
        Left = 209
        Top = 14
        Width = 53
        Height = 25
        Caption = 'CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label308: TLabel
        Left = 225
        Top = 49
        Width = 37
        Height = 25
        Caption = 'Loja'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label340: TLabel
        Left = 221
        Top = 92
        Width = 41
        Height = 25
        Caption = 'PDV'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label305: TLabel
        Left = 33
        Top = 127
        Width = 229
        Height = 25
        Caption = 'Comprovante do cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label306: TLabel
        Left = 62
        Top = 161
        Width = 200
        Height = 25
        Caption = 'Comprovante da loja'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtcnpjMultiPlus: TMaskEdit
        Left = 265
        Top = 12
        Width = 240
        Height = 31
        Color = clInactiveBorder
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 100
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = ''
      end
      object edtLojaMultiPlus: TMaskEdit
        Left = 265
        Top = 49
        Width = 104
        Height = 31
        Color = clInactiveBorder
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 100
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Text = ''
      end
      object edtPDVMultiPlus: TMaskEdit
        Left = 265
        Top = 86
        Width = 104
        Height = 31
        Color = clInactiveBorder
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 100
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Text = ''
      end
      object cbcomprovanteclientemultiplus: TComboBox
        Left = 265
        Top = 124
        Width = 405
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 3
        Text = 'Imprimir sempre'
        Items.Strings = (
          'Imprimir sempre'
          'Perguntar'
          'N'#227'o imprimir')
      end
      object cbcomprovantelojamultiplus: TComboBox
        Left = 265
        Top = 158
        Width = 405
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 4
        Text = 'Imprimir sempre'
        Items.Strings = (
          'Imprimir sempre'
          'Perguntar'
          'N'#227'o imprimir')
      end
      object cbcomprovantesimplificadomultiplus: TCheckBox
        Left = 265
        Top = 202
        Width = 234
        Height = 17
        Caption = 'Imprimir comprovante da loja simplificado'
        TabOrder = 5
      end
      object cbsalvarlogmultiplus: TCheckBox
        Left = 537
        Top = 202
        Width = 120
        Height = 17
        Caption = 'Salvar LOG do TEF'
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Pinpad'
      ImageIndex = 1
      object Label330: TLabel
        Left = 168
        Top = 28
        Width = 26
        Height = 13
        Caption = 'Porta'
      end
      object Label331: TLabel
        Left = 53
        Top = 55
        Width = 141
        Height = 13
        Caption = 'Baud Rate - Bits por Segundo'
      end
      object Label333: TLabel
        Left = 76
        Top = 82
        Width = 118
        Height = 13
        Caption = 'Data Bits - Bits de Dados'
      end
      object Label332: TLabel
        Left = 114
        Top = 109
        Width = 80
        Height = 13
        Caption = 'Parity - Paridade'
      end
      object Label335: TLabel
        Left = 83
        Top = 136
        Width = 111
        Height = 13
        Caption = 'Stop Bit - Bit de Parada'
      end
      object Label334: TLabel
        Left = 40
        Top = 163
        Width = 154
        Height = 13
        Caption = 'Handshaking - Controle de fluxo'
      end
      object btpinpad_testar: TSpeedButton
        Left = 664
        Top = 16
        Width = 260
        Height = 57
        Caption = 'Testar PinPad'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbpinpad_porta: TComboBox
        Left = 199
        Top = 25
        Width = 145
        Height = 21
        TabOrder = 0
      end
      object cbpinpad_Baud: TComboBox
        Left = 199
        Top = 52
        Width = 145
        Height = 21
        TabOrder = 1
        Text = '9600'
        Items.Strings = (
          '300'
          '600'
          '1200'
          '2400'
          '4800'
          '9600'
          '14400'
          '19200'
          '38400'
          '56000'
          '57600'
          '115200')
      end
      object cbpinpad_DataBits: TComboBox
        Left = 199
        Top = 79
        Width = 145
        Height = 21
        ItemIndex = 3
        TabOrder = 2
        Text = '8'
        Items.Strings = (
          '5'
          '6'
          '7'
          '8')
      end
      object cbpinpad_Parity: TComboBox
        Left = 199
        Top = 106
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 3
        Text = 'None'
        Items.Strings = (
          'None'
          'Odd'
          'Even'
          'Mark'
          'Space')
      end
      object cbpinpad_StopBit: TComboBox
        Left = 199
        Top = 133
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 4
        Text = '1'
        Items.Strings = (
          '1'
          '1,5'
          '2')
      end
      object cbpinpad_HandShacking: TComboBox
        Left = 199
        Top = 160
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 5
        Text = 'Nenhum'
        Items.Strings = (
          'Nenhum'
          'XON/XOFF'
          'RTS/CTS'
          'DTR/DSR')
      end
      object cbpinpad_HardFlow: TCheckBox
        Left = 200
        Top = 191
        Width = 97
        Height = 17
        Caption = 'HardFlow'
        TabOrder = 6
      end
      object cbpinpad_SoftFlow: TCheckBox
        Left = 200
        Top = 213
        Width = 97
        Height = 17
        Caption = 'SoftFlow'
        TabOrder = 7
      end
      object cbpinpad_ativar: TCheckBox
        Left = 200
        Top = 235
        Width = 369
        Height = 17
        Caption = 'Ativar o uso do PINPAD no sistema'
        TabOrder = 8
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Impressora'
      ImageIndex = 2
      object Label53: TLabel
        Left = 111
        Top = 36
        Width = 91
        Height = 20
        Caption = 'Impressora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object btbuscaportawindows: TSpeedButton
        Left = 766
        Top = 34
        Width = 26
        Height = 26
        Caption = '...'
        OnClick = btbuscaportawindowsClick
      end
      object Label51: TLabel
        Left = 45
        Top = 69
        Width = 156
        Height = 19
        Alignment = taRightJustify
        Caption = 'Modelo de impressora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label52: TLabel
        Left = 150
        Top = 101
        Width = 52
        Height = 19
        Alignment = taRightJustify
        Caption = 'Avan'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object edtporta_impressora_ESC_POS: TMaskEdit
        Left = 206
        Top = 34
        Width = 559
        Height = 26
        Color = clInactiveBorder
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 100
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        Text = ''
      end
      object cbimpressora_ESC_POS: TComboBox
        Left = 206
        Top = 66
        Width = 203
        Height = 27
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Text = 'Bematech'
        Items.Strings = (
          'Bematech'
          'Daruma'
          'Diebold'
          'Elgin Vox'
          'Epson'
          'Texto'
          'Epson P2'
          'Custom Pos'
          'PosStar'
          'ZJiang'
          'GPrinter')
      end
      object edtavanco: TMaskEdit
        Left = 206
        Top = 99
        Width = 75
        Height = 26
        Color = clInactiveBorder
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 100
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Text = ''
      end
      object cblistaimpressoras: TComboBox
        Left = 206
        Top = 3
        Width = 559
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnEnter = cblistaimpressorasEnter
        OnExit = cblistaimpressorasExit
        OnSelect = cblistaimpressorasSelect
      end
    end
  end
end
