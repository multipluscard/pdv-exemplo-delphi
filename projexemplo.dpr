program projexemplo;

uses
  Vcl.Forms,
  uprinc in 'uprinc.pas' {frmprinc},
  uconfig in 'uconfig.pas' {frmconfig},
  udm in 'udm.pas' {dm: TDataModule},
  urelatorio in 'urelatorio.pas' {frmrelatorio},
  tbotao in 'classes\tbotao.pas',
  uescpos in 'classes\uescpos.pas',
  uMultiplusTEF in 'classes\uMultiplusTEF.pas',
  uMultiplusTypes in 'classes\uMultiplusTypes.pas',
  uwebtefmp in 'classes\uwebtefmp.pas' {frmwebtef};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrmprinc, frmprinc);
  Application.CreateForm(Tdm, dm);
//  Application.CreateForm(Tfrmrelatorio, frmrelatorio);
//  Application.CreateForm(Tfrmwebtef, frmwebtef);
  Application.Run;
end.
