unit u_modele;

{$mode objfpc}{$H+}    // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

interface

uses Classes, SysUtils, u_loaddataset;

type
  Tmodele = class(TMySQL)

  private
  { private declarations }

  public
  { public declarations }
    procedure open;
    procedure close;

    function filtre_inscrit_tous : TLoadDataSet;
    function filtre_inscrit_etudiant(num_etud, nom_etud : string) : TLoadDataSet;
    function filtre_inscrit_filiere(code_filiere : string) : TLoadDataSet;

    // ----- TP8 Partie 1 Etape 3 ----- //
    function detail_etud(num: String):TLoadDataSet;
    function message_filiere(num: String):String;

    // ----- TP8 Partie 2 Etape 3 ----- //
    function note_liste_etud(num: String):TLoadDataSet;
    function code_fil_liste:TLoadDataSet;

    // ----- TP9 Etape 3 ----- //
    procedure inscrit_sup(id : String);
    procedure inscrit_modif(id, civ, nom, prenom,
                            adresse, postal, ville,
                            portable, tel, mail : String);
    procedure inscrit_ajout(id, civ, nom, prenom,
                            adresse, postal, ville,
                            portable, tel, mail,
                            code_fil : String);

    // ----- Calcul de la moyenne ----- //
    function clacul_moy_etud(id : String):String;
    function clacul_moy_fil(id : String):String;
end;

var modele: Tmodele;


implementation

// ouvre la base de donnée //
procedure Tmodele.open;
begin
  Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0,
           'orliange2u_projet_ihm', // nom de notre base
	   'orliange2u_appli', // mon identifiant ENT suivi de _appli
           '31900963', // MDP : numéro de carte étudiant
           'mysqld-5', 'libmysql64.dll');
end;

// ferme la base de donnée //
procedure Tmodele.close;
begin
  Bd_close;
end;


// filtre : toutes les inscrits //
function Tmodele.filtre_inscrit_tous:TLoadDataSet;
begin
  result := load('cp_filtre_inscrit_tous',[]);
end;

// filtre : num ou nom etudiant //
function Tmodele.filtre_inscrit_etudiant(num_etud, nom_etud : string) : TLoadDataSet;
begin
  result := load('cp_filtre_inscrit_etudiant',[num_etud, nom_etud]);
end;

// filtre : code fiiere //
function Tmodele.filtre_inscrit_filiere(code_filiere : string) : TLoadDataSet;
begin
  result := load('cp_filtre_inscrit_filiere',[code_filiere]);
end;



// ----- TP8 Partie 1 Etape 3 ----- //
function Tmodele.detail_etud(num : String):TLoadDataSet;
begin
  result := load('cp_detail_etud',[num]);
end;

function Tmodele.message_filiere(num : String):String;
begin
  load('cp_message_filiere',[num], result);
end;


// ----- TP8 Partie 2 Etape 3 ----- //
function Tmodele.note_liste_etud(num: String):TLoadDataSet;  // fait une liste des notes de l'etud
begin
  result := load('cp_note_liste_etud',[num]);
end;

function Tmodele.code_fil_liste:TLoadDataSet; // liste des codes fils
begin
  result := load('cp_code_fil_liste',[]);
end;

// ----- TP9 Etape 3 ----- //
procedure Tmodele.inscrit_sup(id : String);
begin
  exec('cp_sup_etud',[id]); // sup etudiant et note de etud
end;

procedure Tmodele.inscrit_modif(id, civ, nom, prenom,  adresse, postal, ville,
                        portable, tel, mail : String);
begin
  exec('cp_modif_etud',[id, civ, nom, prenom,  adresse, postal, ville,
                        portable, tel, mail]);
end;

procedure Tmodele.inscrit_ajout(id, civ, nom, prenom,  adresse, postal, ville,
                        portable, tel, mail,   code_fil : String);
begin
  exec('cp_ajout_etud',[id, civ, nom, prenom,  adresse, postal, ville,
                        portable, tel, mail,   code_fil]);
end;



// ----- Calcul de la moyenne ----- //
function Tmodele.clacul_moy_etud(id : String):String;
begin
  load('cp_moy_etu',[id]);
end;

function Tmodele.clacul_moy_fil(id : String):String;
begin
  load('cp_moy_fil',[id]);
end;

// TOUJOURS A LA FIN //
begin
  modele := TModele.Create;
end.

end.    // ORLIANGE Brice & GIANGRECO Vincent - Projet IHM //

