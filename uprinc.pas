unit uprinc;

interface

uses
  acbrposprinter,
  umultiplustef,
  umultiplustypes,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.UITypes,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask, Vcl.Buttons,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.Grids,
  Vcl.DBGrids;

type
  //----------------------------------------------------------------------------
  //   Esse dado é utilizado para a rotina que salva o rewgistro no dataset utilizado pelo exemplo
  //----------------------------------------------------------------------------
  TPagamento = record  // Record para ser parametrizado entre as functions e procedures
     valor       : real;         // Valor da transação
     Nrcupom     : string;       // Número do cupom
     NSU         : string;       // NSU da operação
     TipoPgto    : integer;      // Tipo de pagamento
     Comprovante : TStringList;  // Comprovante
  end;
  //----------------------------------------------------------------------------
  Tfrmprinc = class(TForm)
    pntitulo: TPanel;
    pnrodape: TPanel;
    btreiniciarvenda: TSpeedButton;
    btpagar: TSpeedButton;
    edttotal: TMaskEdit;
    Label1: TLabel;
    tblvenda: TFDMemTable;
    dtsvenda: TDataSource;
    tblvendadescricao: TStringField;
    tblvendaqtde: TFloatField;
    tblvendapreco: TFloatField;
    tblvendatotal: TFloatField;
    DBGridprod: TDBGrid;
    edtdigitar: TMaskEdit;
    Label2: TLabel;
    edtqtde: TMaskEdit;
    Label3: TLabel;
    edtpreco: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    rbformas: TRadioGroup;
    btconfig: TSpeedButton;
    btrelatorio: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure edtdigitarKeyPress(Sender: TObject; var Key: Char);
    procedure btreiniciarvendaClick(Sender: TObject);
    procedure edtdigitarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btpagarClick(Sender: TObject);
    procedure btconfigClick(Sender: TObject);
    procedure btrelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmprinc: Tfrmprinc;

  function SA_MultiplusCancelarTEF(ConfigTEFMPL : TConfigMultiplus):TMultiplusRetornoTransacao;

implementation

{$R *.dfm}

uses uconfig, udm, urelatorio;


//------------------------------------------------------------------------------
procedure SA_SalvarRegistroTEF(dadosPgto : TPagamento);
begin
   //---------------------------------------------------------------------------
   //  Incluindo o registro no dataset
   dm.tbltef.Close;
   dm.tbltef.Open;
   dm.tbltef.EmptyDataSet;
   if fileexists(GetCurrentDir+'\tef.xml') then
      dm.tbltef.LoadFromFile(GetCurrentDir+'\tef.xml');
   //---------------------------------------------------------------------------
   dm.tbltef.Append;
   dm.tbltef.FieldByName('ValorPgto').AsFloat   := dadosPgto.valor;
   dm.tbltef.FieldByName('Documento').AsString  := dadosPgto.Nrcupom;
   dm.tbltef.FieldByName('NSU').AsString        := dadosPgto.NSU;
   dm.tbltef.FieldByName('TipoPgto').AsInteger  := dadosPgto.TipoPgto;
   dm.tbltef.Post;
   //---------------------------------------------------------------------------
   dm.tbltef.SaveToFile(GetCurrentDir+'\tef.xml');   // Salvando o arquivo XML
   //---------------------------------------------------------------------------
   //  Salvando o comprovante em TXT
   dadosPgto.Comprovante.SaveToFile(GetCurrentDir+'\comprovantes\comprovante_'+dadosPgto.NSU+'.txt');
   //---------------------------------------------------------------------------
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//   Limpar tabelas do PINPAD - TEF Multiplus
//------------------------------------------------------------------------------
function SA_MultiplusLimparTabelas(ConfigTEFMPL : TConfigMultiplus):boolean;
var
   TEF_Multiplus : TMultiplusTEF;
begin
   if not DirectoryExists(GetCurrentDir+'\TEFMPL_log') then
      CreateDir(GetCurrentDir+'\TEFMPL_log');
   //---------------------------------------------------------------------------
   TEF_Multiplus                             := TMultiPlusTEF.Create;
   //---------------------------------------------------------------------------
   TEF_Multiplus.IComprovanteCliente         := ConfigTEFMPL.IComprovanteCliente;
   TEF_Multiplus.IComprovanteLoja            := ConfigTEFMPL.IComprovanteLoja;
   TEF_Multiplus.ComprovanteLojaSimplificado := ConfigTEFMPL.ComprovanteLojaSimplificado;
   TEF_Multiplus.CNPJ                        := ConfigTEFMPL.CNPJ;
   TEF_Multiplus.CodigoLoja                  := ConfigTEFMPL.CodigoLoja;
   TEF_Multiplus.Pdv                         := ConfigTEFMPL.Pdv;
   TEF_Multiplus.SalvarLog                   := ConfigTEFMPL.SalvarLog;
   //---------------------------------------------------------------------------
   //   Configurações do PINPAD
   //---------------------------------------------------------------------------
   TEF_Multiplus.ConfigPINPAD := TEF_Multiplus.ConfigPINPAD;   // Atribuindo o type inteiro à instância da classe
   //---------------------------------------------------------------------------
   //  Configurações da impressora
   //---------------------------------------------------------------------------
   TEF_Multiplus.ImpressoraPorta  := ConfigTEFMPL.Impressora.PortaImpressora;
   TEF_Multiplus.ImpressoraAvanco := ConfigTEFMPL.Impressora.AvancoImpressora;
   TEF_Multiplus.ImpressoraModelo := ConfigTEFMPL.Impressora.ModeloImpressoraACBR;
   //---------------------------------------------------------------------------
   //   Atualizar tabelas
   //---------------------------------------------------------------------------
   TEF_Multiplus.SA_LimparTabelas;    // Processar o cancelamento
   //---------------------------------------------------------------------------
   while TEF_Multiplus.Executando do
      begin
         sleep(10);
         Application.ProcessMessages;
      end;

   //---------------------------------------------------------------------------
   Result := TEF_Multiplus.LimpouTabelas;
   TEF_Multiplus.Free;
   //---------------------------------------------------------------------------
end;
//------------------------------------------------------------------------------
//   Atualizar tabelas no PINPAD - TEF Multiplus
//------------------------------------------------------------------------------
function SA_MultiplusAtualizarTabelas(ConfigTEFMPL : TConfigMultiplus):boolean;
var
   TEF_Multiplus : TMultiplusTEF;
begin
   if not DirectoryExists(GetCurrentDir+'\TEFMPL_log') then
      CreateDir(GetCurrentDir+'\TEFMPL_log');
   //---------------------------------------------------------------------------
   TEF_Multiplus                             := TMultiPlusTEF.Create;
   //---------------------------------------------------------------------------
   TEF_Multiplus.IComprovanteCliente         := ConfigTEFMPL.IComprovanteCliente;
   TEF_Multiplus.IComprovanteLoja            := ConfigTEFMPL.IComprovanteLoja;
   TEF_Multiplus.ComprovanteLojaSimplificado := ConfigTEFMPL.ComprovanteLojaSimplificado;
   TEF_Multiplus.CNPJ                        := ConfigTEFMPL.CNPJ;
   TEF_Multiplus.CodigoLoja                  := ConfigTEFMPL.CodigoLoja;
   TEF_Multiplus.Pdv                         := ConfigTEFMPL.Pdv;
   TEF_Multiplus.SalvarLog                   := ConfigTEFMPL.SalvarLog;
   //---------------------------------------------------------------------------
   //   Configurações do PINPAD
   //---------------------------------------------------------------------------
   TEF_Multiplus.ConfigPINPAD := TEF_Multiplus.ConfigPINPAD;   // Atribuindo o type inteiro à instância da classe
   //---------------------------------------------------------------------------
   //  Configurações da impressora
   //---------------------------------------------------------------------------
   TEF_Multiplus.ImpressoraPorta  := ConfigTEFMPL.Impressora.PortaImpressora;
   TEF_Multiplus.ImpressoraAvanco := ConfigTEFMPL.Impressora.AvancoImpressora;
   TEF_Multiplus.ImpressoraModelo := ConfigTEFMPL.Impressora.ModeloImpressoraACBR;
   //---------------------------------------------------------------------------
   //   Atualizar tabelas
   //---------------------------------------------------------------------------
   //  O parâmetro desta função define a forma de como as tabelas serão atualizadas
   //    True - Para limpar as tabelas do PINPAD antes de atualizar
   //    False - Para atualizar sem limpar as tabelas, esse modo somente atualiza as tabelas que estejam desatualizadas
   //
   //  TEF_Multiplus.SA_AtualizarTabelas(true);    // Limpar tabelas do PINPAD e Atualizar tabelas
   //---------------------------------------------------------------------------
   TEF_Multiplus.SA_AtualizarTabelas(false);    // Atualizar tabelas sem limpar
   //---------------------------------------------------------------------------
   while TEF_Multiplus.Executando do
      begin
         sleep(10);
         Application.ProcessMessages;
      end;

   //---------------------------------------------------------------------------
   Result := TEF_Multiplus.AtualizouTabelas;
   TEF_Multiplus.Free;
   //---------------------------------------------------------------------------
end;
//------------------------------------------------------------------------------
//   Cancelamento Multiplus
//------------------------------------------------------------------------------
function SA_MultiplusCancelarTEF(ConfigTEFMPL : TConfigMultiplus):TMultiplusRetornoTransacao;
var
   TEF_Multiplus : TMultiplusTEF;
begin
   if not DirectoryExists(GetCurrentDir+'\TEFMPL_log') then
      CreateDir(GetCurrentDir+'\TEFMPL_log');
   //---------------------------------------------------------------------------
   TEF_Multiplus                             := TMultiPlusTEF.Create;
   //---------------------------------------------------------------------------
   TEF_Multiplus.IComprovanteCliente         := ConfigTEFMPL.IComprovanteCliente;
   TEF_Multiplus.IComprovanteLoja            := ConfigTEFMPL.IComprovanteLoja;
   TEF_Multiplus.ComprovanteLojaSimplificado := ConfigTEFMPL.ComprovanteLojaSimplificado;
   TEF_Multiplus.CNPJ                        := ConfigTEFMPL.CNPJ;
   TEF_Multiplus.CodigoLoja                  := ConfigTEFMPL.CodigoLoja;
   TEF_Multiplus.Pdv                         := ConfigTEFMPL.Pdv;
   TEF_Multiplus.SalvarLog                   := ConfigTEFMPL.SalvarLog;
   //---------------------------------------------------------------------------
   //   Configurações do PINPAD
   //---------------------------------------------------------------------------
   TEF_Multiplus.ConfigPINPAD := TEF_Multiplus.ConfigPINPAD;   // Atribuindo o type inteiro à instância da classe
   //---------------------------------------------------------------------------
   //  Configurações da impressora
   //---------------------------------------------------------------------------
   TEF_Multiplus.ImpressoraPorta  := ConfigTEFMPL.Impressora.PortaImpressora;
   TEF_Multiplus.ImpressoraAvanco := ConfigTEFMPL.Impressora.AvancoImpressora;
   TEF_Multiplus.ImpressoraModelo := ConfigTEFMPL.Impressora.ModeloImpressoraACBR;
   //---------------------------------------------------------------------------
   //   Pagamento
   //---------------------------------------------------------------------------
   TEF_Multiplus.Valor           := ConfigTEFMPL.Pagamento.ValorPgto;
   TEF_Multiplus.forma           := ConfigTEFMPL.Pagamento.FormaPgtoAplicacao;
   TEF_Multiplus.Cupom           := StrToIntDef(ConfigTEFMPL.Pagamento.Documento,0);
   TEF_Multiplus.NSU             := ConfigTEFMPL.Pagamento.NSUCancelamento;
   TEF_Multiplus.TpOperacaoTEF   := ConfigTEFMPL.Pagamento.TipoPgtoCartaoPIX;
   TEF_Multiplus.Parcela         := ConfigTEFMPL.Pagamento.QtdeParcelas;
   //---------------------------------------------------------------------------
   TEF_Multiplus.SA_Cancelamento;    // Processar o cancelamento
   //---------------------------------------------------------------------------
   while TEF_Multiplus.Executando do
      begin
         sleep(10);
         Application.ProcessMessages;
      end;
   //---------------------------------------------------------------------------
   Result := TEF_Multiplus.RetornoTransacao;
   //---------------------------------------------------------------------------
   TEF_Multiplus.Free;
   //---------------------------------------------------------------------------
end;
//------------------------------------------------------------------------------
//   Pagamento Multiplus
//------------------------------------------------------------------------------
function SA_MultiplusPagarTEF(ConfigTEFMPL : TConfigMultiplus):TMultiplusRetornoTransacao;
var
   TEF_Multiplus : TMultiplusTEF;
begin
   //---------------------------------------------------------------------------
   if not DirectoryExists(GetCurrentDir+'\TEFMPL_log') then
      CreateDir(GetCurrentDir+'\TEFMPL_log');
   //---------------------------------------------------------------------------
   TEF_Multiplus                             := TMultiplusTEF.Create;
   TEF_Multiplus.IComprovanteCliente         := ConfigTEFMPL.IComprovanteCliente;
   TEF_Multiplus.IComprovanteLoja            := ConfigTEFMPL.IComprovanteLoja;
   TEF_Multiplus.ComprovanteLojaSimplificado := ConfigTEFMPL.ComprovanteLojaSimplificado;
   TEF_Multiplus.CNPJ                        := ConfigTEFMPL.CNPJ;
   TEF_Multiplus.CodigoLoja                  := ConfigTEFMPL.CodigoLoja;
   TEF_Multiplus.Pdv                         := ConfigTEFMPL.Pdv;
   TEF_Multiplus.SalvarLog                   := ConfigTEFMPL.SalvarLog;
   TEF_Multiplus.TituloJanela                := ConfigTEFMPL.TituloJanela;
   //---------------------------------------------------------------------------
   TEF_Multiplus.ConfigPINPAD := ConfigTEFMPL.PINPAD; // Atribuindo o type inteiro à instância da classe
   //---------------------------------------------------------------------------
   //  Configurações da impressora
   //---------------------------------------------------------------------------
   TEF_Multiplus.ImpressoraPorta  := ConfigTEFMPL.Impressora.PortaImpressora;
   TEF_Multiplus.ImpressoraAvanco := ConfigTEFMPL.Impressora.AvancoImpressora;
   TEF_Multiplus.ImpressoraModelo := ConfigTEFMPL.Impressora.ModeloImpressoraACBR;
   //---------------------------------------------------------------------------
   TEF_Multiplus.Valor           := ConfigTEFMPL.Pagamento.ValorPgto;
   TEF_Multiplus.forma           := ConfigTEFMPL.Pagamento.FormaPgtoAplicacao;
   TEF_Multiplus.Cupom           := StrToIntDef(ConfigTEFMPL.Pagamento.Documento,0);
   TEF_Multiplus.NSU             := ConfigTEFMPL.Pagamento.Documento;
   TEF_Multiplus.TpOperacaoTEF   := ConfigTEFMPL.Pagamento.TipoPgtoCartaoPIX;
   TEF_Multiplus.Parcela         := ConfigTEFMPL.Pagamento.QtdeParcelas;
   //---------------------------------------------------------------------------
   TEF_Multiplus.SA_ProcessarPagamento;    // Efetuar o pagamento
   //---------------------------------------------------------------------------
   while TEF_Multiplus.Executando do
      begin
         sleep(10);
         Application.ProcessMessages;
      end;
   //---------------------------------------------------------------------------
   Result := TEF_Multiplus.RetornoTransacao;
   //---------------------------------------------------------------------------
   TEF_Multiplus.Free;
   //---------------------------------------------------------------------------
end;
//------------------------------------------------------------------------------


procedure SomarVenda;
var
   total : real;
begin
   total := 0;
   frmprinc.tblvenda.First;
   while not frmprinc.tblvenda.Eof do
      begin
         total := total + frmprinc.tblvenda.FieldByName('total').AsFloat;
         frmprinc.tblvenda.Next;
      end;
   frmprinc.edttotal.Text := formatfloat('###,##0.00',total);
end;

procedure Tfrmprinc.btconfigClick(Sender: TObject);
begin
   Application.CreateForm(Tfrmconfig, frmconfig);
   frmconfig.ShowModal;
end;

procedure Tfrmprinc.btpagarClick(Sender: TObject);
var
   //---------------------------------------------------------------------------
   ConfigTEFMPL : TConfigMultiplus;   // Configuração gerais do TEF
   RetornoTEF   : TMultiplusRetornoTransacao; // Contém o retorno da operação TEF
   //---------------------------------------------------------------------------
   Pagamento : TPagamento;
begin
   if rbformas.ItemIndex<0 then
      begin
         beep;
         ShowMessage('Selecione a forma de pagamento para encerrar a venda !');
         exit;
      end;
   if strtofloatdef(edttotal.Text,0)=0 then
      begin
         beep;
         ShowMessage('Venda sem valor. Operação impossível !');
         exit;
      end;
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
   ConfigTEFMPL.Pagamento.FormaPgtoAplicacao := frmprinc.rbformas.Items[frmprinc.rbformas.ItemIndex]; // Forma de pagamento descritiva a ser apresentada na tela
   ConfigTEFMPL.Pagamento.ValorPgto          := strtofloatdef(frmprinc.edttotal.Text,1); // Valor a ser transacionado
   ConfigTEFMPL.Pagamento.Documento          := formatdatetime('hhmmss',now); // Numero do cupom
   ConfigTEFMPL.Pagamento.TipoPgtoCartaoPIX  := TTpMPlCartaoOperacaoTEF(frmprinc.rbformas.ItemIndex); // Informar qual tipo de cartão ou PIX vai transacionar, verifique quais os tipos disponíveis no arquivo uMultiplusTypes.pas
   ConfigTEFMPL.Pagamento.QtdeParcelas       := 1;  // Informar quantas parcelas é a transação, para cartão de debito ou crédito a vista informar 1
   //---------------------------------------------------------------------------
   RetornoTEF := SA_MultiplusPagarTEF(ConfigTEFMPL);  // Chamar a função com a variável composta de entrada definida acima
   //---------------------------------------------------------------------------
   Pagamento.Comprovante := TStringList.Create;
   Pagamento.valor       := RetornoTEF.VALOR;
   Pagamento.Nrcupom     := RetornoTEF.CUPOM;
   Pagamento.NSU         := RetornoTEF.NSU;
   Pagamento.Comprovante := RetornoTEF.COMPROVANTE;
   //---------------------------------------------------------------------------
   SA_SalvarRegistroTEF(Pagamento);
   //---------------------------------------------------------------------------
   Pagamento.Comprovante.Free;
   //---------------------------------------------------------------------------
   btreiniciarvenda.Click;
end;

procedure Tfrmprinc.btreiniciarvendaClick(Sender: TObject);
begin
   if messagedlg('Deseja reiniciar a venda em andamento ?!',mtconfirmation,[mbyes,mbno],0)= mryes then
      begin
         tblvenda.EmptyDataSet;
         SomarVenda;

      end;

end;

procedure Tfrmprinc.btrelatorioClick(Sender: TObject);
begin
   Application.CreateForm(Tfrmrelatorio, frmrelatorio);
   frmrelatorio.ShowModal;
end;

procedure Tfrmprinc.edtdigitarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case key of
      vk_f2:btconfig.Click;
      vk_f5:btpagar.Click;
      vk_f7:btrelatorio.Click;
      vk_f9:btreiniciarvenda.Click;
   end;
end;

procedure Tfrmprinc.edtdigitarKeyPress(Sender: TObject; var Key: Char);
begin
   //---------------------------------------------------------------------------
   if key='*' then   // Vai efetuar a multiplicação, ou seja, definir a quantidade a ser vendida
      begin
         key := #0;
         try
            edtqtde.Text    := formatfloat('###,##0.000',strtofloatdef(edtdigitar.Text,1));
            edtdigitar.Text := '';
         except
            edtqtde.Text    := formatfloat('###,##0.000',1);
         end;
      end;
   //---------------------------------------------------------------------------
   if key='=' then  // Vai definir o valor unitário do produto a ser vendido
      begin
         key := #0;
         try
            edtpreco.Text   := formatfloat('###,##0.000',strtofloatdef(edtdigitar.Text,1));
            edtdigitar.Text := '';
         except
            edtqtde.Text    := formatfloat('###,##0.000',1);
         end;
      end;
   //---------------------------------------------------------------------------
   if key=#13 then   // Foi pressionado a tecla ENTER = vk_return
      begin
         //---------------------------------------------------------------------
         if edtdigitar.Text='' then
            edtdigitar.Text := 'PAO COM BANHA';
         if strtofloatdef(edtqtde.Text,0)=0 then
            edtqtde.Text := '1';
         if strtofloatdef(edtpreco.Text,0)=0 then
            edtpreco.Text := '1';
         //---------------------------------------------------------------------
         tblvenda.Append;
         tblvenda.FieldByName('descricao').AsString := edtdigitar.Text;
         tblvenda.FieldByName('qtde').AsFloat := strtofloatdef(edtqtde.Text,1);
         tblvenda.FieldByName('preco').AsFloat := strtofloatdef(edtpreco.Text,1);
         tblvenda.FieldByName('total').AsFloat := strtofloatdef(edtqtde.Text,1)*strtofloatdef(edtpreco.Text,1);
         tblvenda.Post;
         //---------------------------------------------------------------------
         SomarVenda;  // Calcular o valor total dos itens vendidos
         edtdigitar.Text := '';
         edtqtde.Text    := formatfloat('###,##0.000',1);
         edtpreco.Text   := formatfloat('###,##0.000',0);
         edtdigitar.SetFocus;
         //---------------------------------------------------------------------
      end;

end;

procedure Tfrmprinc.FormActivate(Sender: TObject);
begin
   frmprinc.WindowState := wsMaximized;
   tblvenda.Open;
   tblvenda.EmptyDataSet;
   edtdigitar.SetFocus;
end;

end.
