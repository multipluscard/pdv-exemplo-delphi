unit uconfig;

interface

uses
  ACBrAbecsPinPad,
  AcbrPosPrinter,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ComCtrls;

type
  Tfrmconfig = class(TForm)
    pntitulo: TPanel;
    pnrodape: TPanel;
    btsalvar: TSpeedButton;
    btcancelar: TSpeedButton;
    pgc: TPageControl;
    TabSheet1: TTabSheet;
    Label307: TLabel;
    edtcnpjMultiPlus: TMaskEdit;
    Label308: TLabel;
    edtLojaMultiPlus: TMaskEdit;
    Label340: TLabel;
    edtPDVMultiPlus: TMaskEdit;
    Label305: TLabel;
    cbcomprovanteclientemultiplus: TComboBox;
    Label306: TLabel;
    cbcomprovantelojamultiplus: TComboBox;
    cbcomprovantesimplificadomultiplus: TCheckBox;
    cbsalvarlogmultiplus: TCheckBox;
    TabSheet2: TTabSheet;
    Label330: TLabel;
    cbpinpad_porta: TComboBox;
    Label331: TLabel;
    cbpinpad_Baud: TComboBox;
    Label333: TLabel;
    cbpinpad_DataBits: TComboBox;
    Label332: TLabel;
    cbpinpad_Parity: TComboBox;
    Label335: TLabel;
    cbpinpad_StopBit: TComboBox;
    Label334: TLabel;
    cbpinpad_HandShacking: TComboBox;
    cbpinpad_HardFlow: TCheckBox;
    cbpinpad_SoftFlow: TCheckBox;
    cbpinpad_ativar: TCheckBox;
    btpinpad_testar: TSpeedButton;
    TabSheet3: TTabSheet;
    edtporta_impressora_ESC_POS: TMaskEdit;
    Label53: TLabel;
    btbuscaportawindows: TSpeedButton;
    Label51: TLabel;
    cbimpressora_ESC_POS: TComboBox;
    Label52: TLabel;
    edtavanco: TMaskEdit;
    cblistaimpressoras: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure btcancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btbuscaportawindowsClick(Sender: TObject);
    procedure cblistaimpressorasEnter(Sender: TObject);
    procedure cblistaimpressorasSelect(Sender: TObject);
    procedure cblistaimpressorasExit(Sender: TObject);
    procedure btsalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmconfig: Tfrmconfig;

implementation

{$R *.dfm}

uses udm;

procedure Tfrmconfig.btbuscaportawindowsClick(Sender: TObject);
var
   impressora : TACBrPosPrinter;
   lista      : TStringList;
begin
   impressora := TACBrPosPrinter.Create(nil);
   lista := TStringList.Create;
   impressora.Device.AcharPortasSeriais( lista );
   impressora.Device.AcharPortasUSB( lista );
   impressora.Device.AcharPortasRAW( lista );
   impressora.Device.AcharPortasBlueTooth( lista );
   cblistaimpressoras.Items := lista;
   lista.Free;
   impressora.Free;
   //---------------------------------------------------------------------------
   cblistaimpressoras.Visible := true;
   cblistaimpressoras.Left    := edtporta_impressora_ESC_POS.Left;
   cblistaimpressoras.Top     := edtporta_impressora_ESC_POS.Top;
   cblistaimpressoras.Width   := edtporta_impressora_ESC_POS.Width;
   cblistaimpressoras.SetFocus;
   //---------------------------------------------------------------------------
end;

procedure Tfrmconfig.btcancelarClick(Sender: TObject);
begin
   frmconfig.Close;
end;

procedure Tfrmconfig.btsalvarClick(Sender: TObject);
begin
   dm.tblconf.EmptyDataSet;
   dm.tblconf.append;
   dm.tblconf.FieldByName('CNPJ').AsString                         := edtcnpjMultiPlus.Text;
   dm.tblconf.FieldByName('Loja').AsString                         := edtLojaMultiPlus.Text;
   dm.tblconf.FieldByName('PDV').AsString                          := edtPDVMultiPlus.Text;
   dm.tblconf.FieldByName('ImpressaoComprovanteCliente').AsInteger := cbcomprovanteclientemultiplus.ItemIndex;      // Via do cliente - 1 = Perguntar
   dm.tblconf.FieldByName('ImpressaoComprovanteLoja').AsInteger    := cbcomprovantelojamultiplus.ItemIndex;      // Via da Loja -    1 = Perguntar
   dm.tblconf.FieldByName('ComprovanteLojaSimplificado').AsBoolean := cbcomprovantesimplificadomultiplus.Checked;   // Imprimir a via da loja simplificada
   dm.tblconf.FieldByName('SalvarLOG').AsBoolean                   := cbsalvarlogmultiplus.Checked;   // Salvar LOG automaticamente
   dm.tblconf.FieldByName('PINPADPorta').AsString                  := cbpinpad_porta.Text; // Porta do PINPAD - (AUTO_USB para multiplus)
   dm.tblconf.FieldByName('PINPADBauRate').AsInteger               := cbpinpad_Baud.ItemIndex;      // Padrão 9600
   dm.tblconf.FieldByName('PINPADDataBits').AsInteger              := cbpinpad_DataBits.ItemIndex;      // Padsrão 8
   dm.tblconf.FieldByName('PINPADParity').AsInteger                := cbpinpad_Parity.ItemIndex;      // Padrão NONE
   dm.tblconf.FieldByName('PINPADStopBits').AsInteger              := cbpinpad_StopBit.ItemIndex;      // Padrão 1
   dm.tblconf.FieldByName('PINPADHandshaking').AsInteger           := cbpinpad_HandShacking.ItemIndex;      // Padrão Nenhum
   dm.tblconf.FieldByName('PINPADHardFlow').AsBoolean              := cbpinpad_HardFlow.Checked;
   dm.tblconf.FieldByName('PINPADSoftFlow').AsBoolean              := cbpinpad_SoftFlow.Checked;
   dm.tblconf.FieldByName('PINPADUsar').AsBoolean                  := cbpinpad_ativar.Checked;
   dm.tblconf.FieldByName('IMPRESSORAPortaNome').AsString          := edtporta_impressora_ESC_POS.Text;
   dm.tblconf.FieldByName('IMPRESSORAModelo').AsInteger            := cbimpressora_ESC_POS.ItemIndex;  // Padrão EPSON
   dm.tblconf.FieldByName('IMPRESSORAAvanco').AsInteger            := strtointdef(edtavanco.Text,5);  //  Padrão 5 linhas
   dm.tblconf.Post;
   dm.tblconf.SaveToFile('config.xml');
   //---------------------------------------------------------------------
   btcancelar.Click;
end;

procedure Tfrmconfig.cblistaimpressorasEnter(Sender: TObject);
begin
   cblistaimpressoras.DroppedDown := true;
end;

procedure Tfrmconfig.cblistaimpressorasExit(Sender: TObject);
begin
   cblistaimpressoras.Visible := false;
end;

procedure Tfrmconfig.cblistaimpressorasSelect(Sender: TObject);
begin
   if cblistaimpressoras.ItemIndex>=0 then
      edtporta_impressora_ESC_POS.Text := cblistaimpressoras.Items[cblistaimpressoras.ItemIndex];
   edtporta_impressora_ESC_POS.SetFocus;
end;

procedure Tfrmconfig.FormActivate(Sender: TObject);
var
   lista  : TStringList;
   d      : integer;
   porta  : string;
   pinpad : TACBrAbecsPinPad;
begin
   //---------------------------------------------------------------------------
   pntitulo.Align := alTop;
   pnrodape.Align := alBottom;
   //---------------------------------------------------------------------------
   pgc.Align := alClient;
   //---------------------------------------------------------------------------
   pinpad := TACBrAbecsPinPad.Create(nil);
   lista := TStringList.Create;
   pinpad.Device.AcharPortasSeriais( lista );  // Capturar as portas seriais do PC
   cbpinpad_porta.Items.Clear;
   cbpinpad_porta.Items.Text := lista.Text;
   lista.Free;
   pinpad.Free;
   //---------------------------------------------------------------------------
   //  Carregar as configurações do DataSet para os componentes visuais e interativos
   //---------------------------------------------------------------------------
   // Dados do TEF
   edtcnpjMultiPlus.Text                      := dm.tblconfCNPJ.Text;
   edtLojaMultiPlus.Text                      := dm.tblconfLoja.Text;
   edtPDVMultiPlus.Text                       := dm.tblconfPDV.Text;
   cbcomprovanteclientemultiplus.ItemIndex    := strtointdef(dm.tblconfImpressaoComprovanteCliente.Text,1);
   cbcomprovantelojamultiplus.ItemIndex       := strtointdef(dm.tblconfImpressaoComprovanteLoja.Text,1);
   cbcomprovantesimplificadomultiplus.Checked := dm.tblconf.FieldByName('ComprovanteLojaSimplificado').AsBoolean;
   cbsalvarlogmultiplus.Checked               := dm.tblconf.FieldByName('SalvarLOG').AsBoolean;
   //---------------------------------------------------------------------------
   // Configurações do PINPAD
   porta := dm.tblconfPINPADPorta.Text;
   for d := 1 to cbpinpad_porta.Items.Count do
      begin
         if dm.tblconfPINPADPorta.Text=cbpinpad_porta.Items[d-1] then
            cbpinpad_porta.ItemIndex := d-1;
      end;
   cbpinpad_Baud.ItemIndex         := strtointdef(dm.tblconfPINPADBauRate.Text,5);  // 9600 por padrão
   cbpinpad_DataBits.ItemIndex     := strtointdef(dm.tblconfPINPADDataBits.Text,3);
   cbpinpad_Parity.ItemIndex       := strtointdef(dm.tblconfPINPADParity.Text,0);
   cbpinpad_StopBit.ItemIndex      := strtointdef(dm.tblconfPINPADStopBits.Text,5);
   cbpinpad_HandShacking.ItemIndex := strtointdef(dm.tblconfPINPADHandshaking.Text,5);
   cbpinpad_HardFlow.Checked       := dm.tblconf.FieldByName('PINPADHardFlow').AsBoolean;
   cbpinpad_SoftFlow.Checked       := dm.tblconf.FieldByName('PINPADSoftFlow').AsBoolean;
   cbpinpad_ativar.Checked         := dm.tblconf.FieldByName('PINPADUsar').AsBoolean;
   //---------------------------------------------------------------------------
   //  Configurações da impressora
   edtporta_impressora_ESC_POS.Text := dm.tblconfIMPRESSORAPortaNome.Text;
   cbimpressora_ESC_POS.ItemIndex   := strtointdef(dm.tblconfIMPRESSORAModelo.Text,4);
   edtavanco.Text                   := dm.tblconfIMPRESSORAAvanco.Text;
   //---------------------------------------------------------------------------
end;

procedure Tfrmconfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmconfig.Release;
end;

procedure Tfrmconfig.FormCreate(Sender: TObject);
begin
   pgc.ActivePageIndex := 0;
end;

end.
