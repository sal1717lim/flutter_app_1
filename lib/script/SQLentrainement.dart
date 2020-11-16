import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void creerbddEntrainement(Database db) async{


  await db.execute(
      "CREATE TABLE ENTRAINEMENT (id INTEGER PRIMARY KEY ,categorie TEXT,titre TEXT,diff INTEGER) "  );
  await db.execute(
      "CREATE TABLE EXERCICE (nom TEXT PRIMARY KEY,serie INTEGER,repetition INTEGER ,duree INTEGER,nbent INTEGER,FOREIGN KEY(nbent) REFERENCES ENTRAINEMENT(id)) "  );
  print('table d\'entrainement creer');
  await db.rawInsert("INSERT INTO ENTRAINEMENT (id,categorie,titre,diff) VALUES(1,'Musculation','Lundi',1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Mobilisations articulaires',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Traction à la poulie haute prise large devant',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Rowing avec haltères sur banc incliné',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Rowing assis à la poulie basse en prise neutre',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Oiseau avec haltères sur banc incliné',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('L-Fly assis à la poulie basse',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Dips prise serrée',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Magic tRYCeps',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Gainage abdominal – Planche',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Étirements',1,-1,5,1);");

 print("fin de SQLENTRAINEMENT");

}