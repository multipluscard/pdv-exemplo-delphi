unit udm;

interface

uses
  midaslib,
  System.SysUtils,
  System.Classes,
  Data.DB,
  Datasnap.DBClient;

type
  Tdm = class(TDataModule)
    tblconf: TClientDataSet;
    tblconfCNPJ: TStringField;
    tblconfLoja: TStringField;
    tblconfPDV: TStringField;
    tblconfImpressaoComprovanteCliente: TIntegerField;
    tblconfImpressaoComprovanteLoja: TIntegerField;
    tblconfComprovanteLojaSimplificado: TBooleanField;
    tblconfSalvarLOG: TBooleanField;
    tblconfPINPADPorta: TStringField;
    tblconfPINPADBauRate: TIntegerField;
    tblconfPINPADDataBits: TIntegerField;
    tblconfPINPADParity: TIntegerField;
    tblconfPINPADStopBits: TIntegerField;
    tblconfPINPADHandshaking: TIntegerField;
    tblconfPINPADHardFlow: TBooleanField;
    tblconfPINPADSoftFlow: TBooleanField;
    tblconfPINPADUsar: TBooleanField;
    tblconfIMPRESSORAPortaNome: TStringField;
    tblconfIMPRESSORAModelo: TIntegerField;
    tblconfIMPRESSORAAvanco: TIntegerField;
    tbltef: TClientDataSet;
    dtstef: TDataSource;
    tbltefValorPgto: TFloatField;
    tbltefDocumento: TStringField;
    tbltefNSU: TStringField;
    tbltefTipoPgto: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
   //---------------------------------------------------------------------------
   if not DirectoryExists(GetCurrentDir+'\comprovantes') then  // Verificando a existência da pasta para salvar os comprovantes em TXT
      CreateDir(GetCurrentDir+'\comprovantes');  // Criando a pasta
   //---------------------------------------------------------------------------
   tbltef.CreateDataSet;  // Inicializando tabela para armazenar a transação TEF
   tblconf.CreateDataSet; // Inicializando a tabela de configurações
   //---------------------------------------------------------------------------
   tblconf.Open;
   tblconf.EmptyDataSet;
   if fileexists(GetCurrentDir+'\config.xml') then  // Verificando se o arquivo de configurações existe na pasta (diretório) corrente
      tblconf.LoadFromFile(GetCurrentDir+'\config.xml')  // Carregar o arquivo de configurações para o DataSet
   else
      begin
         //---------------------------------------------------------------------
         //   Se o arquivo de configurações não existir, criar com as configurações padrão
         //---------------------------------------------------------------------
         tblconf.Append;
         tblconf.FieldByName('CNPJ').AsString := '60177876000130';
         tblconf.FieldByName('Loja').AsString := '167';
         tblconf.FieldByName('PDV').AsString  := '001';
         tblconf.FieldByName('ImpressaoComprovanteCliente').AsInteger := 1;      // Via do cliente - 1 = Perguntar
         tblconf.FieldByName('ImpressaoComprovanteLoja').AsInteger    := 1;      // Via da Loja -    1 = Perguntar
         tblconf.FieldByName('ComprovanteLojaSimplificado').AsBoolean := true;   // Imprimir a via da loja simplificada
         tblconf.FieldByName('SalvarLOG').AsBoolean                   := true;   // Salvar LOG automaticamente
         tblconf.FieldByName('PINPADPorta').AsString                  := 'COM3'; // Porta do PINPAD - (AUTO_USB para multiplus)
         tblconf.FieldByName('PINPADBauRate').AsInteger               := 5;      // Padrão 9600
         tblconf.FieldByName('PINPADDataBits').AsInteger              := 3;      // Padsrão 8
         tblconf.FieldByName('PINPADParity').AsInteger                := 0;      // Padrão NONE
         tblconf.FieldByName('PINPADStopBits').AsInteger              := 0;      // Padrão 1
         tblconf.FieldByName('PINPADHandshaking').AsInteger           := 0;      // Padrão Nenhum
         tblconf.FieldByName('PINPADHardFlow').AsBoolean              := false;
         tblconf.FieldByName('PINPADSoftFlow').AsBoolean              := false;
         tblconf.FieldByName('PINPADUsar').AsBoolean                  := false;
         tblconf.FieldByName('IMPRESSORAPortaNome').AsString          := '';
         tblconf.FieldByName('IMPRESSORAModelo').AsInteger            := 4;  // Padrão EPSON
         tblconf.FieldByName('IMPRESSORAAvanco').AsInteger            := 5;  //  Padrão 5 linhas
         tblconf.Post;
         tblconf.SaveToFile('config.xml');
         //---------------------------------------------------------------------
      end;
end;

end.
