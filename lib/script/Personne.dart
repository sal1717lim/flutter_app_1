import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../script/produit.dart';
class personne {
  Database database;
  double kcal1=0;
  double kcal2=0;
  double kcal3=0;
  double kcal4=0;
  double kcal5=0;
  double kcal6=0;

  List <Widget> test=[];
  String nom;
  String prenom;
  String naissance;
  double poid;
  String sexe;
  enummorphologie morpho;
  double taille;
  double objectif;
  bool bNom, bPrenom, bPoid, bTaille, bSexe, bNaissance,bobj;
  List evolution;
  personne(
      {this.nom, this.prenom, this.naissance, this.poid, this.sexe, this.taille}) {
    this.initbool();
  }
  void creerlist() async{
    this.test=[];
    List<Map> list=await User.database.rawQuery('SELECT * FROM journee WHERE (date = \''+DateTime.now().toString().substring(0,10)+'\' AND repas = \''+cour.repas+'\')');
    print(list);
    int i;

    for (i=0;i<list.length;i++ ){
      switch(cour.repas){
        case 'ptit-dej':kcal1=kcal1+list[i]["kcal"];
        break;
        case 'dej':kcal2=kcal2+list[i]["kcal"];
          break;
        case 'collmat':kcal3=kcal3+list[i]["kcal"];
          break;
        case 'the':kcal4=kcal4+list[i]["kcal"];
          break;
        case 'dinner':kcal5=kcal5+list[i]["kcal"];
          break;
        case 'collsoir':kcal6=kcal6+list[i]["kcal"];
          break;
      }
      this.test.add(
          new Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue)
              ),
              child:ListTile(leading: Icon(Icons.fastfood,
                color: Colors.red,
              ),

            title: Text(list[i]["aliment"]+"   "+list[i]["kcal"].toString()+"kcal"),
          )

      ));



    }

  }
  void setevolution(List ev){
    this.evolution=ev;
  }
  void ouvrirBDD() async {
    WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
    this.database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'test.db'),
      version: 1,
    );
    await database.execute(
      "CREATE TABLE TABPOID(id INTEGER PRIMARY KEY AUTOINCREMENT,poid REAL,DATENR TEXT) "  );
    await database.execute(
    "CREATE TABLE personne(nom TEXT, prenom TEXT,sexe  TEXT,taille REAL,idp INTEGER,objectif REAL,morphologie TEXT,naissance TEXT ,PRIMARY KEY(nom, prenom ),FOREIGN KEY(idp) REFERENCES TABPOID(id));",
    );
    await database.execute(
      "CREATE TABLE journee(id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT ,repas TEXT,aliment TEXT,kcal REAL);",
    );
    print("database creer");
    this.insertPersonne();
  }

  void initbool() {
    this.bNom = false;
    this.bPrenom = false;
    this.bPoid = false;
    this.bTaille = false;
    this.bSexe = false;
    this.bNaissance = false;
    this.bobj=false;
  }

  void setNaissance(String Naissance){
    this.naissance=Naissance;
  }
  String getNaissance(){
     return this.naissance;
  }
  void setpoid(double poid) {
    this.poid = poid;
  }

  double getpoid() {
    return this.poid;
  }


  void setobj(double obj) {
    this.objectif = obj;
  }

  double getobj() {
    return this.objectif;
  }


  void setTaille(double taille) {
    this.taille = taille;
  }

  double getTaille() {
    return this.taille;
  }

  void setNom(String Nom) {
    this.nom = Nom;
  }

  String getNom() {
    return this.nom;
  }

  void setPrenom(String Prenom) {
    this.prenom = Prenom;
  }

  String getPrenom() {
    return this.prenom;
  }

  void setSexe(String Sexe) {
    this.sexe = Sexe;
  }

  String getSexe() {
    return this.sexe;
  }

  String toString() {
    return 'vous ete la personne \nnom:${this.getNom() } \nprenom:${this
        .getPrenom()}\nsexe:${this.getSexe()}\ntaille:${this.getTaille()
        .toString()}\npoid:${this.getpoid().toString()}\nmorphologie:${this
        .morpho.toString()}';
  }

  Map <String, dynamic> toMap() {
    return {
      'nom': this.nom,
      'prenom': this.prenom,
      'sexe': this.sexe,
      'taille': this.taille,
      'idp': 1,
      'morphologie': this.morpho.toString(),
      'naissance': this.naissance,
      'objectif':this.objectif,

    };
  }
  Map <String, dynamic> toMaptb() {
    return {

      'poid': this.poid,
      'DATENR': DateTime.now().toString(),


    };
  }
  Future<void> insertPersonne() async {
    final Database db = await this.database;
    await db.insert(
      'TABPOID',
      this.toMaptb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("personne ajouter a la BDD :50%");
    await db.insert(
      'personne',
      this.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("personne ajouter a la BDD :OK");
  }

  void setmorphologie(String Enum) {
    switch(Enum){
      case("enummorphologie.ectomorphe"):
        this.morpho=enummorphologie.ectomorphe;
        break;
      case("enummorphologie.mesomorphe"):
        this.morpho=enummorphologie.mesomorphe;
        break;
      case("enummorphologie.endomorphe"):
        this.morpho=enummorphologie.endomorphe;
        break;
    }


  }
}
 enum enummorphologie {
   ectomorphe,
   mesomorphe,
   endomorphe
 }
 final User= personne();



