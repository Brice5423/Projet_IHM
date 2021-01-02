unit u_grabarit;

{$mode objfpc}{$H+}    // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls;

type

  { Tf_gabarit }

  Tf_gabarit = class(TForm)
    item_archiveN1: TMenuItem;
    item_archiveN2: TMenuItem;
    item_liste_filiere: TMenuItem;
    item_statistiques: TMenuItem;
    lbl_bienvenu: TLabel;
    mnu_main: TMainMenu;
    item_accueil: TMenuItem;
    item_inscrit: TMenuItem;
    item_liste_inscrit: TMenuItem;
    item_archive: TMenuItem;
    item_filiere: TMenuItem;
    item_quitter: TMenuItem;

    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_ariane: TPanel;
    pnl_info: TPanel;

    procedure FormShow(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);

    procedure choix_item_liste;
    procedure choix_item_accueil;


  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_gabarit: Tf_gabarit;

implementation

{$R *.lfm}

{ Tf_gabarit }

USES u_feuille_style,
     u_select_inscrit,
     u_list_inscrit,
     u_detail_inscrit,
     u_modele;


procedure Tf_gabarit.FormShow(Sender: TObject);
begin
  style.panel_selection (pnl_ariane);
  style.panel_defaut (pnl_selection);
  style.panel_travail (pnl_travail);
  style.panel_defaut (pnl_info);
  f_gabarit.Width := 1200;
  f_gabarit.Height := 800;

  pnl_travail.Caption := '';

  lbl_bienvenu.Caption := 'Bienvenue' + chr(13) + ' dans l''application de gestion ' + chr(13) +'de la vie scolaire';
  lbl_bienvenu.Font.Color := clMenuHighlight;
  lbl_bienvenu.Font.Size := 50;
  lbl_bienvenu.Visible := True;

  pnl_ariane.Caption := '>Accueil';

  // TP7 Etape 4 : ouvre la base de donnée //
  modele.open;
end;

// Quand on click sur quitter //
procedure Tf_gabarit.item_quitterClick(Sender: TObject);
begin
  // TP7 Etape 4 : ferme la base de donnée //
  modele.open;

  Close;
end;


// gestion de menu (mmu_main) //
procedure Tf_gabarit.mnu_item_Click(Sender: TObject);
var
  item : TMenuItem;
begin
  pnl_selection.show;

  pnl_ariane.Caption := '';
  item := TmenuItem(Sender);
  repeat
    pnl_ariane.Caption := ' >' +item.caption +pnl_ariane.caption;
    item := item.parent;
  until item.parent = nil;
  item := TmenuItem(Sender);

  if item = item_liste_inscrit
    then choix_item_liste;

  if item = item_accueil
    then choix_item_accueil
end;


// Quand on click sur liste //
procedure Tf_gabarit.choix_item_liste;
begin
  f_list_inscrit.borderstyle := bsNone;
  f_list_inscrit.parent := pnl_travail;
  f_list_inscrit.align := alClient;
  f_list_inscrit.init;
  f_list_inscrit.show ;

  f_select_inscrit.borderstyle := bsNone;
  f_select_inscrit.parent := pnl_selection;
  f_select_inscrit.align := alClient;
  f_select_inscrit.init;
  f_select_inscrit.show;

  f_detail_inscrit.borderstyle := bsNone;
  f_detail_inscrit.parent := pnl_travail;
  f_detail_inscrit.align := alClient;
end;

// Quand on click sur accuiel //
procedure Tf_gabarit.choix_item_accueil;
begin
  f_list_inscrit.Close;
  f_select_inscrit.Close;
  f_detail_inscrit.Close;
end;

end.    // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //
