unit uMultiplusTypes;

interface

uses
   uescpos,
   ACBrPosPrinter,
   System.UITypes,
   system.Classes;

type
  //---------------------------------------------------------------------------
  //  Tipos de opera��o com ccart�es TEF
  //   0 - Cr�dito a vista / 1 - Credito / 2 - Cr�dito parcelado Loja / 3 - Cr�dito parcelado ADM / 4 - D�bito
  //   11 - Frota / 18 - Voucher
  //   20 - D�bito a vista
  //   51 - PIX PSP cliente / 52 - PIX Mercado Pago / 53 - PIX PicPay
  TTpMPlCartaoOperacaoTEF  = (tpMPlCreditoVista, tpMPlCredito , tpMPlCreditoaParceladoLoja , tpMPlCreditoParceladoADM , tpMPlDebito, tpMPlFrota, tpMPlDebitoVista , tpMPlVoucher , tpMPlPIX, tpMPlPIXMercadoPago,tpMPlPIXPicPay);
  //----------------------------------------------------------------------------
  TtpMPlImpressao          = (tpiMPlImprimir, tpiMPlPerguntar , tpiMPlNaoImprimir);
   //---------------------------------------------------------------------------
  TpOperacaoMPL            = (tpOpVenda , tpOpCancelamentoVenda);  // Para definir qual a opera��o para a impress�o de comprovante
  //----------------------------------------------------------------------------
  //   PINPAD
  //----------------------------------------------------------------------------
  TBaudPINPAD  = (b300,b600,b1200,b2400,b4800,b9600,b14400,b19200,b38400,b56000,b57600,b115200);
  TStopBit     = (ts1,ts1emeio,ts2);
  TParity      = (tpNone,tpOdd,tpEven,tpMark,tpSpace);
  THandShaking = (thsNenhum, thsXON_XOFF, thsRTS_CTS, thsDTR_DSR);
  //----------------------------------------------------------------------------
  TConfigPINPAD = record
    PINPAD_usar        : boolean;      // Usar PINPAD
    PINPAD_Porta       : string;       // Porta = COM1, COM2, etc
    PINPAD_Baud        : TBaudPINPAD;  // Velocidade da porta do PINPAD
    PINPAD_DataBits    : integer;      // 5,6,7 ou 8 = Normalmente 8
    PINPAD_StopBit     : TStopBit;     // Stop Bit  = Normalmente 1
    PINPAD_Parity      : TParity;      // Paridade - Normalmente sem PARIDADE
    PINPAD_HandShaking : THandShaking; // Normalmente NENHUM
    PINPAD_SoftFlow    : boolean;      // Normalmente FALSE
    PINPAD_HardFlow    : boolean;      // Normalmente FALSE
    PINPAD_Imagem      : string;       // Caminho completo para um PNG - 170x73 apr4oximadamente
  end;
  //----------------------------------------------------------------------------
  TPagamentoTEF = record   // Record para passar como par�metro na fun��o de pagamento
     FormaPgtoAplicacao : string; // Forma descritiva da aplica��o para ser mostrada na tela de transacionamento
     ValorPgto          : real;   // Valor a ser transacionado
     Documento          : string; // Numero do cupom / documento a ser enviado ao TEF
     NSUCancelamento    : string; // Utilizado somente para cancelamento
     TipoPgtoCartaoPIX  : TTpMPlCartaoOperacaoTEF;  // Qual a forma de transacionamento a ser realizado
     QtdeParcelas       : integer;  // Quantidade de parcelas - Para a vista, informar 1
  end;
  //----------------------------------------------------------------------------
  TConfigImpressora = record
    PortaImpressora             : string;    // Porta aonde a impressora est� conectada
    AvancoImpressora            : integer;   // Quantas linhas a impressora vai avan�ar
    ModeloImpressoraACBR        : TACBrPosPrinterModelo; // Usar os mesmos padr�es do ACBRPOSPrinter
  end;
  //----------------------------------------------------------------------------
  TConfigMultiplus = record   // Record para passar como par�metro da fun��o de transa��o
    IComprovanteCliente         : TtpMPlImpressao; // Comprovante do cliente
    IComprovanteLoja            : TtpMPlImpressao;
    ComprovanteLojaSimplificado : boolean;
    CNPJ                        : string;    // Credencial cadastrada no portal
    CodigoLoja                  : string;    // C�digo da loja recebido da MULTIPLUS
    Pdv                         : string;    // Nr. do PDV recebido da Multiplus
    SalvarLog                   : boolean;   // Habilitar ou desabilitar o armazenamento do LOG da automa��o
    TituloJanela                : string;
    Impressora                  : TConfigImpressora;    // Configura��es da impressora
    PINPAD                      : TConfigPINPAD; // Configura��es do PINPAD
    Pagamento                   : TPagamentoTEF;       // Pagamento a ser executado
  end;
  //----------------------------------------------------------------------------
   TPRetornoMultiPlus = (TPMultiplusMENU , TPMultiplusMSG , TPMultiplusPERGUNTA , TPMultiplusRETORNO , TPMultiplusERROABORTAR , TPMultiplusERRODISPLAY,TPMultiplusINDEFINIDO);
   //---------------------------------------------------------------------------
   TMultiplusMenu = record
      Titulo : string;
      Opcoes : TStringList;
   end;
   //---------------------------------------------------------------------------
   TMultiplusTTipoDado = (TtpINT, TtpSTRING, TtpDECIMAL, TtpDATE , TtpINDEFINIDO);
   //---------------------------------------------------------------------------
   TMultiplusPergunta = record
      Titulo         : string;
      Tipo           : TMultiplusTTipoDado;
      TamanhoMinimo  : integer;
      TamanhoMaximo  : integer;
      VlMinimo       : string;
      VlMaximo       : string;
      CasasDecimais  : integer;
      Mascara        : string;
      ValorColetado  : string;
   end;
   //---------------------------------------------------------------------------
   //   Tipo RECORD para armazenar os dados de uma solicita��o PIX
   //---------------------------------------------------------------------------
   TMultiplusDadosPix = record
      NSU    : string;
      ORIGEM : string;
      VALOR  : real;
      QRCODE : string;
   end;
   //---------------------------------------------------------------------------
   TMultiplusRetornoTransacao = record
      CUPOM              : string;  // Dado informado pela automa��o como documento
      VALOR              : real;    // Valor transacionado
      COD_BANDEIRA       : string;  // C�digo da Bandeira
      COD_REDE           : string;  // C�digo da REDE
      COD_AUTORIZACAO    : string;
      NSU                : string;
      QTDE_PARCELAS      : integer;
      TAXA_SERVICO       : real;
      BIN_CARTAO         : string;
      ULT_DIGITOS_CARTAO : string;
      CNPJ_AUTORIZADORA  : string;
      NOME_CLIENTE       : string;
      NSU_REDE           : string;
      VENCTO_CARTAO      : string;
      COMPROVANTE        : TStringList;
      VIAS_COMPROVANTE   : integer;
      NOME_BANDEIRA      : string;
      NOME_REDE          : string;
      CARTAO_PRE_PAGO    : boolean;
      COD_TIPO_TRANSACAO : string;
      DESC_TRANSACAO     : string;
      DadosPIX           : TMultiPlusDadosPix;
      E2E                : string;   // Retorno da transa��o PIX
      ComprovanteLoja    : TStringList;
      Data               : TDate;
      Hora               : TTime;
      OperacaoExecutada  : boolean;
   end;
   //---------------------------------------------------------------------------

implementation

end.
