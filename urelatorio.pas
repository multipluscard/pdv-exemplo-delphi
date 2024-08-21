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
   ConfigTEFMPL : TConfigMultiplus;   // Configura��o gerais do TEF
   RetornoTEF   : TMultiplusRetornoTransacao; // Cont�m o retorno da opera��o TEF
   //---------------------------------------------------------------------------
begin
   if dm.tbltef.RecordCount>0 then   // Verificando se o dataset possui algum registro para processar
      begin
         //---------------------------------------------------------------------
         // Processando o cancelamento
         //---------------------------------------------------------------------


         //---------------------------------------------------------------------------
         //   Configura��es b�sicas do TEF - Pode usar uma vari�vel p�blica global
         //---------------------------------------------------------------------------
         ConfigTEFMPL.IComprovanteCliente         := TtpMPlImpressao(dm.tblconf.FieldByName('ImpressaoComprovanteCliente').AsInteger);  // Podemos configurar a impress�o do comprovante do cliente sempre, perguntar ou n�o imprimir
         ConfigTEFMPL.IComprovanteLoja            := TtpMPlImpressao(dm.tblconf.FieldByName('ImpressaoComprovanteLoja').AsInteger);  // Podemos configurar a impress�o do comprovante do cliente sempre, perguntar ou n�o imprimir
         ConfigTEFMPL.ComprovanteLojaSimplificado := dm.tblconf.FieldByName('ComprovanteLojaSimplificado').AsBoolean;             // Esta configura��o permite a impres�o do comprovante da loja ser reduzido, apenas para confer�ncia de caixa
         ConfigTEFMPL.CNPJ                        := dm.tblconfCNPJ.Text; // Atribua o CNPJ da empresa cadastrada no portal da MULTIPLUS
         ConfigTEFMPL.CodigoLoja                  := dm.tblconfLoja.Text; // Atribuir a este par�metro o c�digo da loja informado pela MULTPLUS
         ConfigTEFMPL.Pdv                         := dm.tblconfPDV.Text; // Atribua a esta vari�vel o c�digo do PDV fornecido pela MULTIPLUS
         ConfigTEFMPL.SalvarLog                   := dm.tblconf.FieldByName('SalvarLOG').AsBoolean;  // Este par�metro habilita que o LOG da automa��o seja guardado na pasta GetCurrentDir+'\TEFMPL_log' criada automaticamente
         ConfigTEFMPL.TituloJanela                := 'TEF Multiplus Card'; // T�tulo da janela a ser apresentado
         //---------------------------------------------------------------------------
         ConfigTEFMPL.Impressora.PortaImpressora      := dm.tblconfIMPRESSORAPortaNome.Text;  // Nome da impressora a ser utilizada pora imprimir os comprovantes - Usar o padr�o ACBRPosPrinte
         ConfigTEFMPL.Impressora.AvancoImpressora     := dm.tblconf.FieldByName('IMPRESSORAAvanco').AsInteger; // Deina quantas linhas � o avan�o da impressora
         ConfigTEFMPL.Impressora.ModeloImpressoraACBR := TACBrPosPrinterModelo(dm.tblconf.FieldByName('IMPRESSORAModelo').AsInteger);  // Utilize este par�metro para definir o modelo de impressora, a grande maioria � EPSON, use o padr�o ACBRPosPrinter
         //---------------------------------------------------------------------------
         //   Configura��es do PINPAD
         //---------------------------------------------------------------------------
         ConfigTEFMPL.PINPAD.PINPAD_usar         := dm.tblconf.FieldByName('PINPADUsar').AsBoolean;    // Habilitar o uso do PINPAD para apresentar o logo definido na imagem
         ConfigTEFMPL.PINPAD.PINPAD_Porta        := dm.tblconfPINPADPorta.Text;  // Porta em que o PINPAD est� conectado
         ConfigTEFMPL.PINPAD.PINPAD_Baud         := TBaudPINPAD(dm.tblconf.FieldByName('PINPADBauRate').AsInteger);   // Velocidade da porta - Pode ser 19200
         ConfigTEFMPL.PINPAD.PINPAD_DataBits     := dm.tblconf.FieldByName('PINPADDataBits').AsInteger;
         ConfigTEFMPL.PINPAD.PINPAD_StopBit      := TStopBit(dm.tblconf.FieldByName('PINPADStopBits').AsInteger);
         ConfigTEFMPL.PINPAD.PINPAD_Parity       := TParity(dm.tblconf.FieldByName('PINPADParity').AsInteger);
         ConfigTEFMPL.PINPAD.PINPAD_HandShaking  := THandShaking(dm.tblconf.FieldByName('PINPADHandshaking').AsInteger);
         ConfigTEFMPL.PINPAD.PINPAD_SoftFlow     := dm.tblconf.FieldByName('PINPADSoftFlow').AsBoolean;
         ConfigTEFMPL.PINPAD.PINPAD_HardFlow     := dm.tblconf.FieldByName('PINPADHardFlow').AsBoolean;
         ConfigTEFMPL.PINPAD.PINPAD_Imagem       := GetCurrentDir+'\icones\logo_cabecalho.png';     // Arquivo PNG, n�o use uma imagem muito grande - Tamanho recomendado � 144 x 73 que permite um bom ddesempenho e boa visibilidade
         //---------------------------------------------------------------------------
         //   Pagamento
         //---------------------------------------------------------------------------
         ConfigTEFMPL.Pagamento.FormaPgtoAplicacao := 'CANCELAMENTO'; // Forma de pagamento descritiva a ser apresentada na tela
         ConfigTEFMPL.Pagamento.ValorPgto          := dm.tbltef.FieldByName('ValorPgto').AsFloat; // Valor a ser transacionado
         ConfigTEFMPL.Pagamento.Documento          := dm.tbltefDocumento.Text; // Numero do cupom
         ConfigTEFMPL.Pagamento.TipoPgtoCartaoPIX  := TTpMPlCartaoOperacaoTEF(dm.tbltef.FieldByName('TipoPgto').AsInteger); // Informar qual tipo de cart�o ou PIX vai transacionar, verifique quais os tipos dispon�veis no arquivo uMultiplusTypes.pas
         ConfigTEFMPL.Pagamento.NSUCancelamento    := dm.tbltefNSU.Text;
         ConfigTEFMPL.Pagamento.QtdeParcelas       := 1;  // Informar quantas parcelas � a transa��o, para cart�o de debito ou cr�dito a vista informar 1
         //---------------------------------------------------------------------------
         SA_MultiplusCancelarTEF(ConfigTEFMPL);


         //---------------------------------------------------------------------
      end
   else
      begin
         // O dataset est� vazio, n�o foi realizada nenhuma opera��o de TEF ainda
         beep;
         ShowMessage('N�o existe nenhuma transa��o para processar !');
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
               ShowMessage('O arquivo do comprovante n�o foi encontrado na pasta !');
            end;
         //---------------------------------------------------------------------
      end
   else
      begin
         // O dataset est� vazio, n�o foi realizada nenhuma opera��o de TEF ainda
         beep;
         ShowMessage('N�o existe nenhuma transa��o para processar !');
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
