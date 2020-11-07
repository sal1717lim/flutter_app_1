import 'package:flutter/material.dart';
class produit{
  List <Widget> rc=[];
  StringBuffer nom;
  StringBuffer url;
  StringBuffer kcal;
  String repas;
  double kcal1g;
  double kcalt;
  produit(this.nom,this.url,this.kcal,this.kcal1g,this.kcalt);
  void setnom(String nom){
    this.nom.clear();
    this.nom.write(nom);
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
    StringBuffer(""),0,0);