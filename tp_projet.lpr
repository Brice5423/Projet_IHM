program tp_projet;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, u_grabarit, u_feuille_style, u_select_inscrit,
  u_list_inscrit, u_detail_inscrit, u_note_list, u_modele
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tf_gabarit, f_gabarit);
  Application.CreateForm(Tf_select_inscrit, f_select_inscrit);
  Application.CreateForm(Tf_list_inscrit, f_list_inscrit);
  Application.CreateForm(Tf_detail_inscrit, f_detail_inscrit);
  Application.CreateForm(Tf_note_list, f_note_list);
  Application.Run;
end.

