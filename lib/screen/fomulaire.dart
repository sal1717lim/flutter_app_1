

import 'package:flutter/material.dart';
import '../src/Bloc.dart';
import '../script/Personne.dart';
import 'morphologieC.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class form extends StatelessWidget{

  Widget build(context){
    bloc.upgrade();
    return StaggeredGridView.count(
        crossAxisCount: 6,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: const EdgeInsets.all(4.0),
        staggeredTiles:[
          StaggeredTile.count(3,2),
          StaggeredTile.count(3,2),
          //StaggeredTile.count(6,1),
          StaggeredTile.count(4,2),
          StaggeredTile.count(2,2),
          StaggeredTile.count(2,2),
          StaggeredTile.count(2,2),
          StaggeredTile.count(2,2),


        ],
        children: [champNom(), champPrenom(),champDate(),MyStatefulWidget(),taille(),poid(),Objectif()
        ],

    );
  }

  Widget champNom(){
    return StreamBuilder(
      stream: bloc.Nom,
      builder: (context,snapshot){
        return TextField(
          onChanged:bloc.changeNom,

          decoration: InputDecoration(
            hintText: "votre nom",
            labelText:"Nom",
            errorText: snapshot.error,

          ),
        );
      },


    );
  }
  Widget champPrenom(){
    return StreamBuilder(
        stream: bloc.Prenom,
        builder: (context,snapshot){
          return TextField(
              onChanged: bloc.changePrenom,
              decoration: InputDecoration(
                hintText: "votre prenom",
                labelText:"Prenom",
                errorText: snapshot.error,
              )

          );}
    );
  }


  Widget champDate(){
    return StreamBuilder(
        stream: bloc.Naissance,
        builder: (context,snapshot)
        {
          return TextField(
              onChanged: bloc.changeNaissance,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "jj/mm/aaaa",
                labelText: "Date de naissance",
                errorText: snapshot.error,


              )


          );
        }
    );
  }
  Widget taille() {
    return StreamBuilder(
        stream: bloc.Taille,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeTaille,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "cm",
              labelText: "Taille",
              errorText: snapshot.error,

            ),
          );
        }
    );
  }
  Widget poid() {
    return StreamBuilder(
        stream: bloc.Poid,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changePoid,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "kg",
              labelText: "poid",
              errorText: snapshot.error,

            ),
          );
        }
    );
  }
  Widget Objectif() {
    return StreamBuilder(
        stream: bloc.Objectif,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeObj,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "kg",
              labelText: "Objectif",
              errorText: snapshot.error,

            ),
          );
        }
    );
  }


}

class Formulaire extends StatelessWidget{

  Widget  build(context){
      return Scaffold(
          appBar: AppBar(
            title: Text("formulaire"),

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(User.bTaille && User.bPoid && User.bNom && User.bPrenom &&User.bobj && User.bNaissance){
                print(User);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>morphologie()));

              }else{
                print("dala3a");

              }



            },
            child: const Icon(Icons.arrow_forward),
          ),
        body:form(),

      );
  }



}
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Homme';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(

      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      style: TextStyle(color: Colors.blue),

      onChanged: (String newValue)  {
        setState(() {
          dropdownValue = newValue;
          User.bSexe=true;
          User.setSexe(newValue);

        });
      },
      items: <String>['Homme', 'Femme']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

