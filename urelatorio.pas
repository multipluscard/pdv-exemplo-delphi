unit urelatorio;

interface

uses
  acbrposprinter,
  uMultiplusTypes,
  Winapi.shellAPI,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids;

type
  Tfrmrelatorio = class(TForm)
    DBGridtef: TDBGrid;
    pntitulo: TPanel;
    pnrodape: TPanel;
    btcancelartef: TSpeedButton;
    btcancelar: TSpeedButton;
    btcomprovante: TSpeedButton;
    procedure btcancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btcomprovanteClick(Sender: TObject);
    procedure btcancelartefClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmrelatorio: Tfrmrelatorio;

implementation

{$R *.dfm}

uses udm, uprinc;

procedure Tfrmrelatorio.btcancelarClick(Sender: TObject);
begin
   frmrelatorio.Close;
end;

procedure Tfrmrelatorio.btcancelartefClick(Sender: TObject);
var
   //---------------------------------------------------------------------------
   ConfigTEFMPL : TConfigMultiplus;   // Configuração gerais do TEF
   RetornoTEF   : TMultiplusRetornoTransacao; // Contém o retorno da operação TEF
   //---------------------------------------------------------------------------
begin
   if dm.tbltef.RecordCount>0 then   // Verificando se o dataset possui algum registro para processar
      begin
         //---------------------------------------------------------------------
         // Processando o cancelamento
         //---------------------------------------------------------------------


         //---------------------------------------------------------------------------
         //   Configurações básicas do TEF - Pode usar uma variável pública global
         //---------------------------------------------------------------------------
         ConfigTEFMPL.IComprovanteCliente         := TtpMPlImpressao(dm.tblconf.FieldByName('ImpressaoComprovanteCliente').AsInteger);  // Podemos configurar a impressão do comprovante do cliente sempre, perguntar ou não imprimir
         ConfigTEFMPL.IComprovanteLoja            := TtpMPlImpressao(dm.tblconf.FieldByName('ImpressaoComprovanteLoja').AsInteger);  // Podemos configurar a impressão do comprovante do cliente sempre, perguntar ou não imprimir
         ConfigTEFMPL.ComprovanteLojaSimplificado := dm.tblconf.FieldByName('ComprovanteLojaSimplificado').AsBoolean;             // Esta configuração permite a impresão do comprovante da loja ser reduzido, apenas para conferência de caixa
         ConfigTEFMPL.CNPJ                        := dm.tblconfCNPJ.Text; // Atribua o CNPJ da empresa cadastrada no portal da MULTIPLUS
         ConfigTEFMPL.CodigoLoja                  := dm.tblconfLoja.Text; // Atribuir a este parâmetro o código da loja informado pela MULTPLUS
         ConfigTEFMPL.Pdv                         := dm.tblconfPDV.Text; // Atribua a esta variável o código do PDV fornecido pela MULTIPLUS
         ConfigTEFMPL.SalvarLog                   := dm.tblconf.FieldByName('SalvarLOG').AsBoolean;  // Este parâmetro habilita que o LOG da automação seja guardado na pasta GetCurrentDir+'\TEFMPL_log' criada automaticamente
         ConfigTEFMPL.TituloJanela                := 'TEF Multiplus Card'; // Título da janela a ser apresentado
         //---------------------------------------------------------------------------
         ConfigTEFMPL.Impressora.PortaImpressora      := dm.tblconfIMPRESSORAPortaNome.Text;  // Nome da impressora a ser utilizada pora imprimir os comprovantes - Usar o padrão ACBRPosPrinte
         ConfigTEFMPL.Impressora.AvancoImpressora     := dm.tblconf.FieldByName('IMPRESSORAAvanco').AsInteger; // Deina quantas linhas é o avanço da impressora
         ConfigTEFMPL.Impressora.ModeloImpressoraACBR := TACBrPosPrinterModelo(dm.tblconf.FieldByName('IMPRESSORAModelo').AsInteger);  // Utilize este parâmetro para definir o modelo de impressora, a grande maioria é EPSON, use o padrão ACBRPosPrinter
         //---------------------------------------------------------------------------
         //   Configurações do PINPAD
         //---------------------------------------------------------------------------
         ConfigTEFMPL.PINPAD.PINPAD_usar         := dm.tblconf.FieldByName('PINPADUsar').AsBoolean;    // Habilitar o uso do PINPAD para apresentar o logo definido na imagem
         ConfigTEFMPL.PINPAD.PINPAD_Porta        := dm.tblconfPINPADPorta.Text;  // Porta em que o PINPAD está conectado
         ConfigTEFMPL.PINPAD.PINPAD_Baud         := TBaudPINPAD(dm.tblconf.FieldByName('PINPADBauRate').AsInteger);   // Velocidade da porta - Pode ser 19200
         ConfigTEFMPL.PINPAD.PINPAD_DataBits     := dm.tblconf.FieldByName('PINPADDataBits').AsInteger;
         ConfigTEFMPL.PINPAD.PINPAD_StopBit      := TStopBit(dm.tblconf.FieldByName('PINPADStopBits').AsInteger);
         ConfigTEFMPL.PINPAD.PINPAD_Parity       := TParity(dm.tblconf.FieldByName('PINPADParity').AsInteger);
         ConfigTEFMPL.PINPAD.PINPAD_HandShaking  := THandShaking(dm.tblconf.FieldByName('PINPADHandshaking').AsInteger);
         ConfigTEFMPL.PINPAD.PINPAD_SoftFlow     := dm.tblconf.FieldByName('PINPADSoftFlow').AsBoolean;
         ConfigTEFMPL.PINPAD.PINPAD_HardFlow     := dm.tblconf.FieldByName('PINPADHardFlow').AsBoolean;
         ConfigTEFMPL.PINPAD.PINPAD_Imagem       := GetCurrentDir+'\icones\logo_cabecalho.png';     // Arquivo PNG, não use uma imagem muito grande - Tamanho recomendado é 144 x 73 que permite um bom ddesempenho e boa visibilidade
         //---------------------------------------------------------------------------
         //   Pagamento
         //---------------------------------------------------------------------------
         ConfigTEFMPL.Pagamento.FormaPgtoAplicacao := 'CANCELAMENTO'; // Forma de pagamento descritiva a ser apresentada na tela
         ConfigTEFMPL.Pagamento.ValorPgto          := dm.tbltef.FieldByName('ValorPgto').AsFloat; // Valor a ser transacionado
         ConfigTEFMPL.Pagamento.Documento          := dm.tbltefDocumento.Text; // Numero do cupom
         ConfigTEFMPL.Pagamento.TipoPgtoCartaoPIX  := TTpMPlCartaoOperacaoTEF(dm.tbltef.FieldByName('TipoPgto').AsInteger); // Informar qual tipo de cartão ou PIX vai transacionar, verifique quais os tipos disponíveis no arquivo uMultiplusTypes.pas
         ConfigTEFMPL.Pagamento.NSUCancelamento    := dm.tbltefNSU.Text;
         ConfigTEFMPL.Pagamento.QtdeParcelas       := 1;  // Informar quantas parcelas é a transação, para cartão de debito ou crédito a vista informar 1
         //---------------------------------------------------------------------------
         SA_MultiplusCancelarTEF(ConfigTEFMPL);


         //---------------------------------------------------------------------
      end
   else
      begin
         // O dataset está vazio, não foi realizada nenhuma operação de TEF ainda
         beep;
         ShowMessage('Não existe nenhuma transação para processar !');
      end;
end;

procedure Tfrmrelatorio.btcomprovanteClick(Sender: TObject);
begin
   if dm.tbltef.RecordCount>0 then   // Verificando se o dataset possui algum registro para processar
      begin
         //---------------------------------------------------------------------
         if fileexists(GetCurrentDir+'\comprovantes\comprovante_'+dm.tbltefNSU.Text+'.txt') then
            ShellExecute(GetDesktopWindow,'open',pchar(GetCurrentDir+'\comprovantes\comprovante_'+dm.tbltefNSU.Text+'.txt'),nil,nil,sw_ShowNormal)
         else
            begin
               beep;
               ShowMessage('O arquivo do comprovante não foi encontrado na pasta !');
            end;
         //---------------------------------------------------------------------
      end
   else
      begin
         // O dataset está vazio, não foi realizada nenhuma operação de TEF ainda
         beep;
         ShowMessage('Não existe nenhuma transação para processar !');
      end;
end;

procedure Tfrmrelatorio.FormActivate(Sender: TObject);
begin
   //---------------------------------------------------------------------------
   dm.tbltef.Close;
   dm.tbltef.Open;
   dm.tbltef.EmptyDataSet;
   if fileexists(GetCurrentDir+'\tef.xml') then
      dm.tbltef.LoadFromFile(GetCurrentDir+'\tef.xml');
   //---------------------------------------------------------------------------
   pntitulo.Align := alTop;
   pnrodape.Align := alBottom;
   //---------------------------------------------------------------------------
   DBGridtef.Align := alClient;
   //---------------------------------------------------------------------------
   frmrelatorio.WindowState := wsMaximized;

end;

end.
