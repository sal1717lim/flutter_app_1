import 'package:flutter/material.dart';
import 'dart:io';
import '../script/Personne.dart';

import '../screen/MenuPrincipale.dart';
class morphologie extends StatelessWidget{

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("choisir sa morphologie ?"),

      ),

      body:morph(),

    );

  }

}
class morph extends StatelessWidget{
  Widget build(Context){
    return Container(
      margin: EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        childAspectRatio: 7/8,
        mainAxisSpacing: 30,
        children: [ectomorphe(Context),mesomorphe(Context),endomorphe(Context),aide()],
      ),

    );



  }
  Widget ectomorphe(Context){
    return  FlatButton(
        onPressed: () async{
          User.morpho=enummorphologie.ectomorphe;
          print(User.database);
          User.ouvrirBDD();
          print(User.database);
          Navigator.of(Context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MenuPrincipale()), (route) => false);
          //Navigator.push(Context,MaterialPageRoute(builder: (context)=>Principale()));
        },
        padding: EdgeInsets.all(0.0),
        child: Image.asset('assets/images/ectomorphe.png'));

  }
  Widget mesomorphe(Context){
    return  FlatButton(
        onPressed: (){
          User.morpho=enummorphologie.mesomorphe;
          print(User.database);
          User.ouvrirBDD();
          print(User.database);
          Navigator.of(Context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MenuPrincipale()), (route) => false);
        },
        padding: EdgeInsets.all(0.0),
        child: Image.asset('assets/images/mesomorphe.png',
        ));

  }
  Widget endomorphe(Context){
    return  FlatButton(
        onPressed: (){
          User.morpho=enummorphologie.endomorphe;
          print(User.database);
          User.ouvrirBDD();
          print(User.database);
          Navigator.of(Context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MenuPrincipale()), (route) => false);
        },
        padding: EdgeInsets.all(0.0),
        child: Image.asset('assets/images/endomorphe.png'));
  }
  Widget aide(){
    return  FlatButton(
        onPressed: (){
          print(User);

        },
        padding: EdgeInsets.all(0.0),
        child: Image.asset('assets/images/aide.png'));

  }



}