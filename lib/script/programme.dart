import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../script/Personne.dart';
class Entrainement{
  List<Exercice> exerice=[];
  String titre;
  String categorie;


}
class Exercice{


}
void nomcateg(Database db)async{
  List nom=[];
  var x=await db.rawQuery("SELECT DISTINCT categorie FROM ENTRAINEMENT ;");
  print(x.runtimeType);
  for (int i=0;i<x.length;i++){
    //nom.add(x[i]["categorie"]);
    listecateg.add(x[i]["categorie"]);
  }

}
final List listecateg=[];
