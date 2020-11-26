import 'package:flutter/material.dart';
import 'screen/fomulaire.dart';
import 'screen/principale.dart';
import 'screen/morphologieC.dart';
import 'script/Personne.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'script/programme.dart';
import 'package:flutter/services.dart';
import 'screen/MenuPrincipale.dart';
import 'screen/splash_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool notfirst=true;
  User.notfirst=true;
  runApp(Myapp(notfirst));
  Database db=await openDatabase(join(await getDatabasesPath(),'test.db'));
  User.database=db;


  try {
    List<Map> list=await db.rawQuery('SELECT * FROM personne');
    User.setNom(list[0]["nom"]);
    User.setPrenom(list[0]["prenom"]);
    User.setmorphologie(list[0]["morphologie"]);
    User.setTaille(list[0]["taille"]);
    User.setNaissance(list[0]["naissance"]);
    User.setSexe(list[0]["sexe"]);
    User.setobj(list[0]["objectif"]);
    List<Map> list2=await db.rawQuery('SELECT * FROM TABPOID WHERE id=(SELECT MAX(id) FROM TABPOID)');
    User.setpoid(list2[0]["poid"]);
    List<Map> listpoid=await db.rawQuery('SELECT * FROM TABPOID ORDER BY id ASC;');
    User.setevolution(listpoid);
    nomcateg(User.database);
    User.initbar();
    listEnt(User.database);
    User.lila();


  }catch(e){
    User.database=db;
    print(db);
    //runApp(newApp());
   User.notfirst=false;

  }
  if(notfirst){
    runApp(Myapp(notfirst));
  }

}

class newApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //
      home: Formulaire() ,
    );
  }
}
class Myapp extends StatelessWidget {
  // This widget is the root of your application.
  bool b;
   Myapp(this.b);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        backgroundColor: Colors.white,

        appBarTheme: AppBarTheme(color: Colors.white,elevation: 0),

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(this.b) ,
    );
  }
}


