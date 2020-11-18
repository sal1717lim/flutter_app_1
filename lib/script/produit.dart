import 'package:flutter/material.dart';
import 'Personne.dart';
class produit{
  var context;
  String img;
  String msg;
  List <Widget> rc=[];
  StringBuffer nom;
  StringBuffer url;
  StringBuffer kcal;
  String hero;
  String repas;
  double kcal1g;
  double kcalt;
  void f(r,a){
    User.majlila(r, a);
  }
  produit(this.nom,this.url,this.kcal,this.kcal1g,this.kcalt,this.hero);
  void setnom(String nom){
    this.nom.clear();
    this.nom.write(nom);
  }
  void setkcalt(double t){
    this.kcalt=t;

  }
  void seturl(String url){
    this.url.clear();
    this.url.write(url);
  }
  void setKcal(String kcal){
    this.kcal.clear();
    this.kcal.write(kcal);
  }
}
final cour=produit(StringBuffer(""),
    StringBuffer("https://i0.wp.com/www.triomphe-securite.fr/wp-content/uploads/2014/07/image-vide.png"),
    StringBuffer(""),0,0,"");