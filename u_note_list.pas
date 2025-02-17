unit u_note_list;

{$mode objfpc}{$H+}    // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Grids, StdCtrls, u_liste;

type

{ Tf_note_list }

Tf_note_list = class(TF_liste)
  lbl_note_moy: TLabel;
  lbl_titre: TLabel;

  procedure Init (affi : boolean);

private
  { private declarations }

public
  { public declarations }

end;

var
  f_note_list: Tf_note_list;

implementation

{$R *.lfm}

uses u_feuille_style,
     u_detail_inscrit,
     u_modele,
     u_loaddataset;


procedure Tf_note_list.Init (affi : boolean);
begin
  style.panel_travail(pnl_titre);
    style.label_titre(lbl_titre);
    style.label_titre(lbl_note_moy);
  style.panel_travail(pnl_affi);
    style.grille(sg_liste);

  pnl_btn.Hide;
end;

end.     // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

