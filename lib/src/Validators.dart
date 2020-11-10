import 'dart:async';
import 'package:tes/script/produit.dart';

import '../script/Personne.dart';
import '../script/OFF.dart';

class Validators {
  final validateNom = StreamTransformer<String, String>.fromHandlers(

    handleData: (Nom,sink){
      RegExp exp = new RegExp(r"[a-z A-Z \s]+");
     if(exp.hasMatch(Nom)){
       sink.add(Nom);
       User.setNom(Nom);
       User.bNom=true;
     }else{
       sink.addError("donner un nom valide");
       User.bNom=false;
     }
    }
  );
  final validatePrenom = StreamTransformer<String, String>.fromHandlers(
      handleData: (Prenom,sink){
        RegExp exp = new RegExp(r"[a-z A-Z \s]+");
        if(exp.hasMatch(Prenom)){
          sink.add(Prenom);
          User.setPrenom(Prenom);
          User.bPrenom=true;

        }else{
          sink.addError("donner un prenom valide");
          User.bPrenom=false;
        }
      }
  );
  final validateNaissance = StreamTransformer<String, String>.fromHandlers(
      handleData: (Naissance,sink){
        RegExp exp = new RegExp(r"\d\d/\d\d/\d\d\d\d");
        if(exp.hasMatch(Naissance)){
          if(Naissance.length==2) {
            sink.add(Naissance+"/");
          }else if(Naissance.length==5){
            sink.add(Naissance+"/");
          }else{
            sink.add(Naissance);
          }
          User.setNaissance(Naissance);
          User.bNaissance=true;
        }else{
          sink.addError("donner une date de naissance valide");
          User.bNaissance=false;
        }
      }
  );
  final validateTaille = StreamTransformer<String, String>.fromHandlers(
      handleData: (Taille,sink){
        RegExp exp = new RegExp(r"\d\d\d");
        if(exp.hasMatch(Taille)){
          sink.add(Taille);
          User.setTaille(double.parse(Taille));
          User.bTaille=true;

        }else{
          sink.addError("error");
          User.bTaille=false;
        }
      }
  );
  final validatePoid = StreamTransformer<String, String>.fromHandlers(
      handleData: (Poid,sink){
        RegExp exp = new RegExp(r"\d\d+");
        if(exp.hasMatch(Poid)){
          sink.add(Poid);
          User.setpoid(double.parse(Poid));

          User.setevolution([{
            'id':1,
            'poid':double.parse(Poid),
            'DATENR':DateTime.now().toString()
          }]);
          User.bPoid=true;
        }else{
          sink.addError("error");
          User.bPoid=false;
        }
      }
  );
  final validateobjectif = StreamTransformer<String, String>.fromHandlers(
      handleData: (Objectif,sink){
        RegExp exp = new RegExp(r"\d\d+");
        if(exp.hasMatch(Objectif)){
          sink.add(Objectif);
          User.setobj(double.parse(Objectif));
          User.bobj=true;
        }else{
          sink.addError("error");
          User.bobj=false;
        }
      }
  );
  final validatekcal= StreamTransformer<String, String>.fromHandlers(
      handleData: (kcal,sink){

        cour.kcalt=double.parse(kcal)*cour.kcal1g;

        }

  );
  final validatenomp= StreamTransformer<String, String>.fromHandlers(
      handleData: (nomp,sink){
        if(nomp.length!=0){
          cour.setnom(nomp);
        }else{
          sink.add("donnez le nom du produit");
        }


      }

  );
  final validatenbkcal= StreamTransformer<String, String>.fromHandlers(
      handleData: (nbkcal,sink){
      if(nbkcal.length!=0){
        cour.setKcal(nbkcal);
      }else{
        sink.add("donnez le nombre de kcal/100g");
      }

      }

  );
  final rechercheproduit= StreamTransformer<String, String>.fromHandlers(
      handleData: (produit,sinkt){
        recherche(cour.context,produit,User.database);
        print("1");

      }

  );

}