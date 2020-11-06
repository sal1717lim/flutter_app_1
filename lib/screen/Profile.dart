import 'package:flutter/material.dart';
import '../script/Personne.dart';
import '../src/Bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class Profile extends StatelessWidget{

  Widget build(BuildContext context) {
    bloc.upgrade();
    return Scaffold(


      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back),
        ),
          backgroundColor: Colors.deepOrangeAccent,
          title: Text("Profil")

      ),
      body: Container(
        child: StaggeredGridView.count(
          crossAxisCount: 6,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(4.0),
          staggeredTiles:[
            StaggeredTile.count(6,3),
            StaggeredTile.count(6,1),
            //StaggeredTile.count(6,1),
            StaggeredTile.count(3,1),
            StaggeredTile.count(3,1),
            StaggeredTile.count(4,1),
            StaggeredTile.count(2,1),
            StaggeredTile.count(2,1),
            StaggeredTile.count(2,1),
            StaggeredTile.count(2,1),

          ],
          children: [
            Center(

              child: Container(

                child: Stack(
                  children: [
                    Image.asset("assets/images/"+User.morpho.toString().substring(16)+".png")
                ],
              ),
            ),
            ),
            Text("Vous ete a ${pour100()}% de votre objectif!",

              style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
           //Text("Information utilisateur"),
            champNom(),
            champPrenom(),
            champDate(),
            Sexe(),
            taille(),
            Imc(),
            poid()
          ],

        ),
      ),


    );
  }
  Widget champNom() {
    return new StreamBuilder(

      stream: bloc.Nom,
      builder: (context, snapshot) {
        return TextFormField(
          enabled: false,
          initialValue: User.getNom(),
          onChanged: bloc.changeNom,
          //controller: TextEditingController(text:User.getNom()),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,//this has no effect
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),


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
          return TextFormField(
              enabled: false,
              initialValue: User.getPrenom(),
              onChanged: bloc.changePrenom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,//this has no effect
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //hintText: "votre prenom",
                //labelText:"Prenom",
                errorText: snapshot.error,
              )

          );}
    );
  }
  Widget taille() {

    return StreamBuilder(
        stream: bloc.Taille,
        builder: (context, snapshot) {
          return TextFormField(
            enabled: false,
            initialValue: User.getTaille().toString()+" cm",
            onChanged: bloc.changeTaille,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,//this has no effect
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              //hintText: "votre prenom",
              //labelText:"Prenom",
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
          return TextFormField(
            enabled: false,
            onChanged: bloc.changePoid,
            initialValue: User.getpoid().toString()+" kg",
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,//this has no effect
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              //hintText: "votre prenom",
              //labelText:"Prenom",
              errorText: snapshot.error,
            ),
          );
        }
    );
  }

  Widget champDate(){
    return StreamBuilder(
        stream: bloc.Naissance,
        builder: (context,snapshot)
        {
          return TextFormField(
              enabled:false,
              initialValue: User.getNaissance(),
              onChanged: bloc.changeNaissance,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
          border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,//this has no effect
          ),
          borderRadius: BorderRadius.circular(10.0),
          ),
        errorText: snapshot.error,
        ),


          );
        }
    );
  }
  Widget Sexe(){

          return TextFormField(
            enabled:false,
            initialValue: User.getSexe(),
            onChanged: bloc.changeNaissance,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,//this has no effect
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),

            ),


          );
        }
  Widget Imc(){

    return TextFormField(
      enabled:false,
      initialValue: "Imc:"+calculeImc().toString().substring(0,5),
      //onChanged: bloc.changeNaissance,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,//this has no effect
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),

      ),


    );
    //double calculeImc
  }
  double calculeImc(){
    return(User.getpoid()/((User.getTaille()/100)*(User.getTaille()/100)));
  }
  pour100(){
    var p100;
    if(User.getpoid()<User.getobj()){
      p100=-(User.getpoid()-User.getobj());

    }else{
      p100=User.getpoid()-User.getobj();

    }
    return p100;
  }
  }

