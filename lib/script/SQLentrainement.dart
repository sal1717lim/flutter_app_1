//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../script/programme.dart';
void creerbddEntrainement(Database db) async{


  await db.execute(
      "CREATE TABLE ENTRAINEMENT (id INTEGER PRIMARY KEY ,categorie TEXT,titre TEXT,diff INTEGER) "  );
  await db.execute(
      "CREATE TABLE EXERCICE (nom TEXT,serie INTEGER,repetition INTEGER ,duree INTEGER,nbent INTEGER,PRIMARY KEY(nom,nbent),FOREIGN KEY(nbent) REFERENCES ENTRAINEMENT(id)) "  );
  print('table d\'entrainement creer');
  await db.rawInsert("INSERT INTO ENTRAINEMENT (id,categorie,titre,diff) VALUES(1,'Musculation','Lundi',1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Mobilisations articulaires',1,-1,5,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Traction à la poulie haute prise large devant',4,10,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Rowing avec haltères sur banc incliné',4,10,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Rowing assis à la poulie basse en prise neutre',3,15,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Oiseau avec haltères sur banc incliné',4,12,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('L-Fly assis à la poulie basse',4,18,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Dips prise serrée',4,12,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Magic tRYCeps',4,10,-1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Gainage abdominal – Planche',4,-1,1,1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Étirements',1,-1,5,1);");
  //**************************************************************************************
  await db.rawInsert("INSERT INTO ENTRAINEMENT (id,categorie,titre,diff) VALUES(2,'Musculation','Mercredi',1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Mobilisations articulaires',1,-1,5,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Squat avant',4,10,-1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Fentes avec haltères',4,15,-1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Leg curl allongé',4,8,-1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Extension au banc à lombaires à 45°',4,12,-1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES(' Mollets à la presse à cuisses',4,12,-1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES(' Crunch',4,-1,1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Enroulement de bassin',4,10,-1,2);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Étirements',1,-1,5,2);");
  //**************************************************************************************
  await db.rawInsert("INSERT INTO ENTRAINEMENT (id,categorie,titre,diff) VALUES(3,'Musculation','Vendredi',1);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Mobilisations articulaires',1,-1,5,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Développé décliné',4,10,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Écarté couché',3,12,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Pull over en travers d’un banc',3,18,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Élévation latérale avec haltères',4,12,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Rowing RYC',4,13,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Curl au pupitre avec barre EZ',3,12,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Curl allongé à la poulie haute',4,10,-1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Gainage obliques',4,-1,1,3);");
  await db.rawInsert("INSERT INTO EXERCICE (nom,serie,repetition,duree,nbent) VALUES('Étirements',1,-1,5,3);");


 print("fin de SQLENTRAINEMENT");
  nomcateg(db);
  listEnt(db);
}