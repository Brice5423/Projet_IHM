unit u_detail_inscrit;

{$mode objfpc}{$H+} // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, CheckLst, ColorBox, ValEdit;

type

  { Tf_detail_inscrit }

  Tf_detail_inscrit = class(TForm)

    // ----- ----- ----- --------- ----- ----- ----- //
    // ----- ----- ----- Interface ----- ----- ----- //

    btn_retour: TButton;
    btn_valider: TButton;
    btn_annuler: TButton;
    cbb_civilite: TComboBox; // Sexe de l'étdiant
    cbb_filiere: TComboBox;
    edt_filiere: TEdit;
    edt_civilite: TEdit;
    edt_mail: TEdit;
    edt_portable: TEdit;
    edt_tel: TEdit;
    edt_ville: TEdit;
    edt_postal: TEdit;
    edt_adresse: TEdit;
    edt_prenom: TEdit;
    edt_nom: TEdit;
    edt_num: TEdit;
    lbl_filiere_erreur: TLabel;
    lbl_mail_erreur: TLabel;
    lbl_mail: TLabel;
    lbl_portable: TLabel;
    lbl_tel_porta_erreur: TLabel;
    lbl_tel: TLabel;
    lbl_ville_erreur: TLabel;
    lbl_postal_erreur: TLabel;
    lbl_adresse_erreur: TLabel;
    lbl_filiere: TLabel;
    lbl_contact: TLabel;
    lbl_adresse: TLabel;
    lbl_prenom_erreur: TLabel;
    lbl_prenom: TLabel;
    lbl_nom_erreur: TLabel;
    lbl_nom: TLabel;
    lbl_num: TLabel;
    lbl_ident: TLabel;
    lbl_num_erreur: TLabel;
    mmo_filiere: TMemo;
    pnl_note_liste: TPanel;
    pnl_note: TPanel;
    pnl_filiere: TPanel;
    pnl_contact: TPanel;
    pnl_adresse: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_btn: TPanel;
    pnl_titre: TPanel;


    // ----- ----- ----- ---------- ----- ----- ----- //
    // ----- ----- ----- TP5 Code 1 ----- ----- ----- //

    procedure btn_retourClick(Sender: TObject); // -> btn_retour & btn_annuler

    procedure init(idinf: string; affi: boolean);
    procedure detail(idinf: string);
    procedure edit(idinf: string);
    procedure add;
    procedure Delete(idinf: string); // pour le bouton sup


    // ----- ----- ----- ---------- ----- ----- ----- //
    // ----- ----- ----- TP5 Code 2 ----- ----- ----- //

    procedure edt_Enter(Sender: TObject);
    procedure cbb_Enter(Sender: TObject);

    procedure edt_numExit(Sender: TObject);
    procedure edt_nomExit(Sender: TObject);
    procedure edt_prenomExit(Sender: TObject);
    procedure edt_adresseExit(Sender: TObject);
    procedure edt_postalExit(Sender: TObject);
    procedure edt_villeExit(Sender: TObject);
    procedure edt_telExit(Sender: TObject);
    procedure edt_portableExit(Sender: TObject);
    procedure edt_mailExit(Sender: TObject);
    procedure cbb_filiereExit(Sender: TObject);

    // ----- TP9 Etape 4 ----- //
    procedure btn_validerClick(Sender: TObject);
  private
    { private declarations }
    procedure affi_page;

    procedure affi_filiere(num: string);
    function affi_erreur_saisie(erreur: string; lbl: TLabel; edt: TEdit): boolean;

  public
    { public declarations }

  end;


var
  f_detail_inscrit: Tf_detail_inscrit;


implementation

{$R *.lfm}
                                   // note_liste_etud
uses u_feuille_style,
     u_list_inscrit,
     u_note_list,
     u_modele,
     u_loaddataset;

{ Tf_detail_inscrit }


// ----- ----- ----- ---------- ----- ----- ----- //
// ----- ----- ----- TP5 Code 1 ----- ----- ----- //

var
  oldvaleur: string;
  // utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
  id: string; // variable active dans toute l'unité, contenant l'id inscrit affichée

  // ----- pour cbb_filiere <- liste des codes fil ----- //
  liste_code_fil:TLoadDataSet;




procedure Tf_detail_inscrit.btn_retourClick(Sender: TObject);
begin
  Close;
end;



procedure Tf_detail_inscrit.Init(idinf: string; affi: boolean);
// ajout nouvelle inscrit : id est vide
// affichage détail d'une inscrit : affi est vrai sinon affi est faux
begin
  // Style général //
  style.panel_travail(pnl_titre);
  style.panel_travail(pnl_btn);
  style.panel_travail(pnl_detail);

  // Style identification //
  style.panel_travail(pnl_ident); // caractère inconu
  style.label_titre(lbl_ident);  //       ’
  style.label_erreur(lbl_num_erreur);
  lbl_num_erreur.Caption := ' ';
  style.label_erreur(lbl_nom_erreur);
  lbl_nom_erreur.Caption := ' ';
  style.label_erreur(lbl_prenom_erreur);
  lbl_prenom_erreur.Caption := ' ';

  // Style adresse //
  style.panel_travail(pnl_adresse);
  style.label_titre(lbl_adresse);
  style.label_erreur(lbl_adresse_erreur);
  lbl_adresse_erreur.Caption := ' ';
  style.label_erreur(lbl_postal_erreur);
  lbl_postal_erreur.Caption := ' ';
  style.label_erreur(lbl_ville_erreur);
  lbl_ville_erreur.Caption := ' ';

  // Style contact //
  style.panel_travail(pnl_contact);
  style.label_titre(lbl_contact);
  style.label_erreur(lbl_tel_porta_erreur);
  lbl_tel_porta_erreur.Caption := ' ';
  style.label_erreur(lbl_mail_erreur);
  lbl_mail_erreur.Caption := ' ';

  // Style filiere //
  style.panel_travail(pnl_filiere);
  style.label_titre(lbl_filiere);
  style.label_erreur(lbl_filiere_erreur);
  lbl_filiere_erreur.Caption := ' ';
  style.memo_info(mmo_filiere);

  // Style note //
  style.panel_travail(pnl_note);
  style.panel_travail(pnl_note_liste);


  // initialisation identification //
  edt_num.Clear;
  edt_num.ReadOnly := affi;
  lbl_num_erreur.Caption := '';

  cbb_civilite.ItemIndex := 0;
  edt_civilite.Clear;

  edt_nom.Clear;
  edt_nom.ReadOnly := affi;
  lbl_nom_erreur.Caption := '';

  edt_prenom.Clear;
  edt_prenom.ReadOnly := affi;
  lbl_prenom_erreur.Caption := '';

  // initialisation adresse //
  edt_adresse.Clear;
  edt_adresse.ReadOnly := affi;
  lbl_adresse_erreur.Caption := '';

  edt_postal.Clear;
  edt_postal.ReadOnly := affi;
  lbl_postal_erreur.Caption := '';

  edt_ville.Clear;
  edt_ville.ReadOnly := affi;
  lbl_ville_erreur.Caption := '';

  // initialisation contact //
  edt_tel.Clear;
  edt_tel.ReadOnly := affi;
  edt_portable.Clear;
  edt_portable.ReadOnly := affi;
  lbl_tel_porta_erreur.Caption := '';

  edt_mail.Clear;
  edt_mail.ReadOnly := affi;
  lbl_mail_erreur.Caption := '';

  // initialisation filiere //
  cbb_filiere.ItemIndex := -1;
  cbb_filiere.Clear;
  edt_filiere.Clear;
  lbl_filiere_erreur.Caption := '';

  mmo_filiere.Clear;
  mmo_filiere.ReadOnly := True;

  // initialisation bouton //
  btn_retour.Visible := affi; // visible quand affichage détail
  btn_valider.Visible := not affi; // visible quand ajout/modification inscrit
  btn_annuler.Visible := not affi; // visible quand ajout/modification inscrit

  // initialisation note //
  Show;
  id := idinf;
  if not (id = '') then // affichage/modification inscrit
    affi_page;

  // ----- TP6 Code 2 ----- //
  f_note_list.borderstyle := bsNone;
  f_note_list.parent := pnl_note_liste;
  f_note_list.align := alClient;
  f_note_list.init(affi);
  f_note_list.show;

  // ----- TP8 Partie 2 Etape 4 ----- //
  f_note_list.affi_data(modele.note_liste_etud(id));

  // ----- Remplie cbb_filiere des codes fil de la bdd ----- //
  liste_code_fil := modele.code_fil_liste;
  cbb_filiere.items := liste_code_fil.Column('code_fil');

  // ----- Donne la moyenne etud et fil ----- //            // modele.clacul_moy_etud(edt_num.text)
  f_note_list.lbl_note_moy.Caption := '  -  Moyenne étudiant : ' + FloatToStr(17.50)
                                    + '  -  Moyenne filière : ' + FloatToStr(17.50) + '  ';
end;                                                       // modele.clacul_moy_fil(edt_num.text)
                                                           // FloatToStr(11.37)

// ----- TP8 Partie 1 Etape 4 ----- //
procedure Tf_detail_inscrit.affi_page;
var
  flux:TLoadDataSet;
begin
  flux := modele.detail_etud(id);
  flux.read;

  // complete les Edit dans identification //
  edt_num.Text := flux.Get('num_etud');
  cbb_civilite.Text := flux.Get('civilite');
  edt_civilite.Text := flux.Get('civilite');
  edt_nom.Text := flux.Get('nom_etud');
  edt_prenom.Text := flux.Get('prenom_etud');
  // complete les Edit dans adresse //

  edt_adresse.Text := flux.Get('adresse');
  edt_postal.Text := flux.Get('cp');
  edt_ville.Text := flux.Get('ville');

  // complete les Edit dans contact //
  edt_tel.Text := flux.Get('tel');
  edt_portable.Text := flux.Get('portable');
  edt_mail.Text := flux.Get('mail');

  // complete les Edit dans filiere //
  cbb_filiere.Text := flux.Get('code_fil');
  edt_filiere.Text := flux.Get('code_fil');
  affi_filiere(cbb_filiere.Text);

  flux.Destroy;
end;


// détail indcrit //
procedure Tf_detail_inscrit.detail(idinf: string);
begin
  init(idinf, True); // mode affichage
  pnl_titre.Caption := 'Détail d''une inscritption';
//  cbb_civilite.Style := csSimple; // retire la liste déroulante
//  cbb_civilite.ReadOnly := True;
  cbb_civilite.Visible := False;
  edt_civilite.Visible := True;
//  cbb_filiere.Style := csSimple; // retire la liste déroulante
//  cbb_filiere.ReadOnly := True;
  cbb_filiere.Visible := False;
  edt_filiere.Visible := True;
  btn_retour.SetFocus;

  // ----- TP6 Code 3 ----- //
  f_note_list.lbl_note_moy.visible := True;
  f_note_list.pnl_affi.Visible := True;
end;


// modif inscrit //
procedure Tf_detail_inscrit.edit(idinf: string);
begin
  init(idinf, False);
  pnl_titre.Caption := 'Modification d''une inscritption';
  edt_num.ReadOnly := True;
  cbb_civilite.Visible := True;
  edt_civilite.Visible := False;
//  cbb_filiere.ReadOnly := True;
//  cbb_civilite.Style := csDropDownList; // affiche la liste déroulante
//  cbb_filiere.Style := csSimple; // retire la liste déroulante
  cbb_filiere.Visible := False;
  edt_filiere.Visible := True;

  // ----- TP6 Code 3 ----- //
  f_note_list.lbl_note_moy.visible := True;
  f_note_list.pnl_affi.Visible := True;
end;


// nouveau inscrit //
procedure Tf_detail_inscrit.add;
begin
  init('', False); // pas de numéro d'inscrit
  pnl_titre.Caption := 'Nouvelle inscritption';
  cbb_civilite.ItemIndex := 0;
  cbb_civilite.Visible := True;
  edt_civilite.Visible := False;
  edt_num.SetFocus;
  cbb_filiere.Visible := True;
  edt_filiere.Visible := False;
  cbb_civilite.Style := csDropDownList; // affiche la liste déroulante
  cbb_filiere.Style := csDropDownList; // affiche la liste déroulante

  // ----- TP6 Code 3 ----- //
  f_note_list.lbl_note_moy.visible := False;
  f_note_list.sg_liste.Visible := False;
end;


// sup inscrit //
procedure Tf_detail_inscrit.Delete(idinf: string); // idinf => id_etud
begin
  if messagedlg( 'Confirmez-vous la suppression de l''inscrit n°' + idinf,
                 mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      // ----- TP9 Etape 4 ----- //
      modele.inscrit_sup(idinf);

      f_list_inscrit.line_delete;
    end;
end;



// ----- ----- ----- ---------- ----- ----- ----- //
// ----- ----- ----- TP5 Code 2 ----- ----- ----- //
// ----- -----    quite zone text     ----- ----- //

procedure Tf_detail_inscrit.edt_Enter(Sender: TObject);
begin
  oldvaleur := TEdit(Sender).Text;
end;

procedure Tf_detail_inscrit.cbb_Enter(Sender: TObject);
begin
  oldvaleur := TComboBox(Sender).Text;
end;


// Edit Identifiation //
procedure Tf_detail_inscrit.edt_numExit(Sender: TObject);
begin
  edt_num.Text := TRIM(edt_num.Text);
end;

procedure Tf_detail_inscrit.edt_nomExit(Sender: TObject);
begin
  edt_nom.Text := TRIM(edt_nom.Text);
end;

procedure Tf_detail_inscrit.edt_prenomExit(Sender: TObject);
begin
  edt_prenom.Text := TRIM(edt_prenom.Text);
end;


// Edit Adresse //
procedure Tf_detail_inscrit.edt_adresseExit(Sender: TObject);
begin
  edt_adresse.Text := TRIM(edt_adresse.Text);
end;

procedure Tf_detail_inscrit.edt_postalExit(Sender: TObject);
begin
  edt_postal.Text := TRIM(edt_postal.Text);
end;

procedure Tf_detail_inscrit.edt_villeExit(Sender: TObject);
begin
  edt_ville.Text := TRIM(edt_ville.Text);
end;


// Edit Contact //
procedure Tf_detail_inscrit.edt_telExit(Sender: TObject);
begin
  edt_tel.Text := TRIM(edt_tel.Text);
end;

procedure Tf_detail_inscrit.edt_portableExit(Sender: TObject);
begin
  edt_portable.Text := TRIM(edt_portable.Text);
end;

procedure Tf_detail_inscrit.edt_mailExit(Sender: TObject);
begin
  edt_mail.Text := TRIM(edt_mail.Text);
end;


// "Edit" ComboBox Filiere //
procedure Tf_detail_inscrit.cbb_filiereExit(Sender: TObject);
begin
  cbb_filiere.Text := TRIM(cbb_filiere.Text);
  if not (cbb_filiere.Text = oldvaleur) then
    affi_filiere(cbb_filiere.Text);
end;

// Gère message Memo dans  filiere //
procedure Tf_detail_inscrit.affi_filiere(num: string);
var
  ch: string;
begin
  mmo_filiere.Clear;
  if num = '' then
    mmo_filiere.Lines.add('')
  else
    begin
      // ----- TP8 Partie 1 Etape 4 ----- //
      ch := modele.message_filiere(num);
      if ch = '' then
        mmo_filiere.Lines.add('filière non identifiée')
      else
        mmo_filiere.Lines.Text := ch;
    end;
end;


// verifie si il y a une saisie vide //
function Tf_detail_inscrit.affi_erreur_saisie(erreur: string; lbl: TLabel; edt: TEdit): boolean;
begin
  lbl.Caption := erreur;
  if not (erreur = '') then
    begin
      edt.SetFocus;
      Result := False;
    end
  else
    Result := True;
end;


// ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- //
// ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- //


// ----- TP9 Etape 4 ----- //
procedure Tf_detail_inscrit.btn_validerClick(Sender: TObject);
var
  flux : TLoadDataSet;
  saisie, saisie2, erreur, ch : string;
  i : integer;
  valide : boolean;
begin
  valide := true;

  // ----- vérification FILIERE ----- //
  erreur := '';
  saisie := cbb_filiere.text;
  if  saisie = '' then
    begin
      erreur := 'La filiere doit être renseignée.';
      valide := False;
    end;
//  else
//    begin
//      ch := modele.infraction_commune(saisie);  // !!!!!!!!!!
//      if  ch = ''  then
//        begin
//          lbl_filiere_erreur := 'numéro inexistant.'; // il faut qu'il n'existe pas plus tot
//          valide := False;
//        end;
//    end;
  lbl_filiere_erreur.Caption := erreur;

  // ----- vérification CONTACT ----- //
  // vérifit mail //
  erreur := '';
  saisie := edt_mail.text;
  if  saisie = '' then
    erreur := 'L''adresse mel doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_mail_erreur, edt_mail) AND valide;

  // vérifit tel & portable //
  erreur := '';
  saisie := edt_portable.text;
  saisie2 := edt_tel.text;
  if  ((saisie = '') AND (saisie2 = '')) then
    erreur := 'Le téléphone ou le portable doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_tel_porta_erreur, edt_portable) AND valide;
    valide := affi_erreur_saisie(erreur, lbl_tel_porta_erreur, edt_tel) AND valide;


  // ----- vérification ADRESSE ----- //
  // vérifit ville //
  erreur := '';
  saisie := edt_ville.text;
  if  saisie = '' then
    erreur := 'La commune doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_ville_erreur, edt_ville) AND valide;

  // vérifit code postal //
  erreur := '';
  saisie := edt_postal.text;
  if  saisie = '' then
    erreur := 'Le code postal doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_postal_erreur, edt_postal) AND valide;

  // vérifit adresse //
  erreur := '';
  saisie := edt_adresse.text;
  if  saisie = '' then
    erreur := 'L''adresse doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_adresse_erreur, edt_adresse) AND valide;


  // ----- vérification IDENTIFICATION ----- //
  // vérifit prenom //
  erreur := '';
  saisie := edt_prenom.text;
  if  saisie = '' then
    erreur := 'Le prenom doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_prenom_erreur, edt_prenom) AND valide;

  // vérifit nom //
  erreur := '';
  saisie := edt_nom.text;
  if  saisie = '' then
    erreur := 'Le nom doit être rempli.';
    valide := affi_erreur_saisie(erreur, lbl_nom_erreur, edt_nom) AND valide;

  // vérifit numero (id_etud) // OK
  erreur := '';
  saisie := edt_num.text;
  if id = '' then
    begin
      if  saisie = '' then
        erreur := 'Le numéro doit être rempli.'
      else
        begin
	    flux := modele.filtre_inscrit_etudiant(saisie,'');
	    if  NOT  flux.endOf then
            erreur := 'Le numéro est déjà existant.';
        end;
      valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num)  AND  valide;
    end;


  // exécute le protocole SQL si valide est vrai //
  if  NOT  valide then
    messagedlg('Erreur enregistrement Inscrit', 'La saisie est incorrecte.' + #13 +
               'Corrigez la saisie et validez à nouveau.', mtWarning, [mbOk], 0)
  else
    begin
      if  id ='' then
        modele.inscrit_ajout(edt_num.Text, cbb_civilite.Text, edt_nom.Text, edt_prenom.Text,
                             edt_adresse.Text, edt_postal.Text, edt_ville.Text,
                             edt_tel.Text, edt_portable.Text, edt_mail.Text,
                             cbb_filiere.Text)
      else
        begin
	  modele.inscrit_modif(edt_num.Text, cbb_civilite.Text, edt_nom.Text, edt_prenom.Text,
                               edt_adresse.Text, edt_postal.Text, edt_ville.Text,
                               edt_tel.Text, edt_portable.Text, edt_mail.Text);

          // suppression de la composition de l'amende -> sup les notes
//	  modele.infraction_amende_delete (edt_num.text);
	end;

      // ----- il faut surment suprimé cette partie --------------------------------------------- //
//      i := 1;   // commence à 1 pour passer la ligne de titres des colonnes en ligne 0
//      while  ( i  <  f_note_list.sg_liste.RowCount ) do
//        begin
//          modele.infraction_amende_insert (edt_num.text, f_amende_list.sg_liste.Cells[0,i]); // !!!!!!!!!!
//          i := i +1;
//        end;
      // ---------------------------------------------------------------------------------------- //

      if id='' then
        f_list_inscrit.line_add(modele.filtre_inscrit_etudiant(edt_num.Text, ''))
      else
        f_list_inscrit.line_edit(modele.filtre_inscrit_etudiant(id, ''));
      close;
    end;
end;

end.     // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //
