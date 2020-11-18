//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import '../script/Personne.dart';
class Entrainement{
  List<Exercice> exerice=[];
  String titre;
  String categorie;
  int difficult;
  Entrainement(this.titre,this.categorie,this.exerice,this.difficult);


}
class Exercice{
   String titre;
   int serie;
   int repetition;
   int duree;
   Exercice(this.titre,this.serie,this.repetition,this.duree);

}
void nomcateg(Database db)async{

  var x=await db.rawQuery("SELECT DISTINCT categorie FROM ENTRAINEMENT ;");
  print(x.runtimeType);
  for (int i=0;i<x.length;i++){
    //nom.add(x[i]["categorie"]);
    listecateg.add(x[i]["categorie"]);
    Ent[x[i]["categorie"]]=[];
  }

}

void listEnt(Database db)async{

  var x=await db.rawQuery("SELECT DISTINCT * FROM (ENTRAINEMENT,EXERCICE) WHERE ENTRAINEMENT.id=EXERCICE.nbent ORDER BY ENTRAINEMENT.titre");
  Entrainement a=new Entrainement(x[0]["titre"], x[0]["categorie"], [],x[0]["diff"]);
  a.exerice.add(new Exercice(x[0]["nom"], x[0]["serie"], x[0]["repetition"], x[0]["duree"]));
  for(int i=1;i<x.length;i++){
    print(x[i]);
    if(x[i]["titre"]==a.titre){
      a.exerice.add(new Exercice(x[i]["nom"], x[i]["serie"], x[i]["repetition"], x[i]["duree"]));
    }else{
      Ent[x[i]["categorie"]].add(a);
      a=new Entrainement(x[i]["titre"], x[i]["categorie"], [],x[i]["diff"]);
      a.exerice.add(new Exercice(x[i]["nom"], x[i]["serie"], x[i]["repetition"], x[i]["duree"]));
    }
   // Ent[x[i]["categorie"]].add(Entrainement(,x[i]["categorie"],[]));
  }
  Ent[a.categorie].add(a);
  print(Ent);
}
final List listecateg=[];
final Map Ent={};
