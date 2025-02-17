unit u_select_inscrit;

{$mode objfpc}{$H+}     // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tf_select_inscrit }

  Tf_select_inscrit = class(TForm)
    btn_ok: TButton;
    edt_numero: TEdit;
    edt_nom: TEdit;
    edt_code: TEdit;
    lbl_numero: TLabel;
    lbl_nom: TLabel;
    lbl_code: TLabel;
    pnl_filiere_edit: TPanel;
    pnl_filiere_btn: TPanel;
    pnl_etudiant_edit: TPanel;
    pnl_etudiant_btn: TPanel;
    pnl_tous_edit: TPanel;
    pnl_tous_btn: TPanel;
    pnl_ok: TPanel;
    pnl_filiere: TPanel;
    pnl_etudiant: TPanel;
    pnl_tous: TPanel;
    pnl_choix: TPanel;
    pnl_titre: TPanel;

    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Init;
    procedure NonSelectionPanel (pnl : TPanel);
    procedure AucuneSelection;
    procedure pnl_choix_btnClick (Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_select_inscrit: Tf_select_inscrit;

implementation


{$R *.lfm}


uses u_feuille_style,
     u_list_inscrit,
     u_modele;


var pnl_actif : TPanel;


{ Tf_select_inscrit }


procedure Tf_select_inscrit.Init;
begin
  style.panel_defaut(pnl_choix);
  style.panel_selection(pnl_titre);
  style.panel_defaut(pnl_ok);
  pnl_choix_btnClick (pnl_tous_btn);
end;

procedure Tf_select_inscrit.FormShow(Sender: TObject);
begin
  btn_ok.visible := false;
end;



procedure Tf_select_inscrit.pnl_choix_btnClick (Sender : TObject);
 var pnl : TPanel;
begin
  AucuneSelection; // retirer la sélection en cours

  pnl := TPanel(Sender) ;
  style.panel_selection (pnl);
  pnl := TPanel(pnl.Parent); // récupération du panel parent "pnl_xxx"
  style.panel_selection (pnl);
  pnl := TPanel(f_select_inscrit.FindComponent(pnl.name +'_edit'));
  style.panel_selection (pnl);
  pnl.show;
  pnl_actif := pnl; pnl_actif.enabled := true;
  btn_ok.visible := true;

  // vide zone edit //
  edt_numero.Clear;
  edt_nom.Clear;
  edt_code.Clear
end;


procedure Tf_select_inscrit.NonSelectionPanel(pnl : TPanel);
var pnl_enfant : TPanel;
begin
  // affectation des paramètres Fonte et Couleur du panel pnl_choix
  style.panel_defaut(pnl);

  // récupération du panel '_btn'
  pnl_enfant := TPanel(f_select_inscrit.FindComponent(pnl.name +'_btn'));
  style.panel_bouton(pnl_enfant);

  // récupération du panel '_edit'
  pnl_enfant := TPanel(f_select_inscrit.FindComponent(pnl.name +'_edit'));
  pnl_enfant.Hide;
end;

procedure Tf_select_inscrit.AucuneSelection;
begin
  NonSelectionPanel(pnl_tous);
  NonSelectionPanel(pnl_etudiant);
  NonSelectionPanel(pnl_filiere);
end;



procedure Tf_select_inscrit.btn_okClick(Sender: TObject);
begin
  btn_ok.Visible := false;
  pnl_actif.Enabled := false;

  // TP7 Etape 4 : fait appel à la base de donnée //
  if  pnl_tous_edit.Visible then
    f_list_inscrit.affi_data(modele.filtre_inscrit_tous)

  else if  pnl_etudiant_edit.Visible then
    f_list_inscrit.affi_data(modele.filtre_inscrit_etudiant(edt_numero.text,edt_nom.text))

  else if  pnl_filiere_edit.Visible then
    f_list_inscrit.affi_data(modele.filtre_inscrit_filiere(edt_code.text))
end;

end.   // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

