import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../script/Personne.dart';
import 'Profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'ScreenAliment.dart';
import '../script/produit.dart';

class Principale extends StatefulWidget{

  Principale({Key key}) :super(key:key);

  @override
  _Principale createState() => _Principale();
}


class _Principale extends State<Principale>{

  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: null,
      backgroundColor: Colors.white,
      drawer :Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              child:Container(
                child: Stack(
                  children: [
                Image.asset("assets/images/icon.png"),
                    Align(
                      alignment: Alignment(-1,0.9),
                        child: Text("Bienvenue "+User.getPrenom(),
                                    style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,

                      ),),
                  ),],
                )
              ),



                
            ),
            FlatButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>(new Profile())));

              },
              child: ListTile(
                leading: Icon(Icons.account_circle,
                color: Colors.blue,),
                title: Text('Profil'),
              ),
            ),
            FlatButton(
              onPressed: (){
                //Navigator.push(context,MaterialPageRoute(builder: (context)=>(new Profile())));

              },
              child: ListTile(
                leading: Icon(Icons.favorite,
                  color: Colors.red,
                ),
                title: Text('Entraînement'),
              ),
            ),
          ],
        ),
      ),


      body:NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
    SliverAppBar(
      backgroundColor:Colors.deepOrange,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,
    title: Text("",
    style: TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    )),
    //background: Image.network(
    //"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
    //fit: BoxFit.cover,
    ),
    ),
    ];
    },
    body:menu()
    ,
      )


    );

  }

}
class menu extends StatelessWidget {
  Widget build(Context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: StaggeredGridView.count(
        crossAxisCount: 11,
        //crossAxisSpacing: 30,
        //mainAxisSpacing: 30,
        //padding: const EdgeInsets.all(4.0),
        staggeredTiles:[
          StaggeredTile.count(11, 1),
          StaggeredTile.count(11, 8),
          StaggeredTile.count(11, 1),
          StaggeredTile.count(11, 6),


        ],
        children: [
          Center(
              child:Text("récapitulatif de votre journée",
                style: TextStyle(

                  fontSize: 24,

      ))),
          journee(),
      Text("récapitulatif de votre journée"),
          graph(),


        ],

      ),

    );
  }
}
class journee extends StatefulWidget{

  journee({Key key}) :super(key:key);

  @override
  _journee createState() => _journee();
}
class _journee extends State<journee> {
  Widget build(Context) {
    return Container(
      color: Colors.white,

      child: StaggeredGridView.count(
        crossAxisCount: 10,
        physics: new NeverScrollableScrollPhysics(),

        //crossAxisSpacing: 30,
        //mainAxisSpacing: 30,
        //padding: const EdgeInsets.all(4.0),
        staggeredTiles: [
          StaggeredTile.count(10, 1),
          StaggeredTile.count(3, 3),
          StaggeredTile.count(4, 3),
          StaggeredTile.count(3, 3),
          StaggeredTile.count(3, 3),
          StaggeredTile.count(4, 3),
          StaggeredTile.count(3, 3),


        ],
        children: [
          Center(
            child: Text("9000 / 9000 Kcal ",
                style: TextStyle(
                  fontSize: 20,

                )),
          ),
          ptit(Context,User.kcal1, 1500, Colors.black),
          dej(Context,User.kcal2, 1500, Colors.black),
          collmat(Context,User.kcal3, 1500, Colors.black),
          the(Context,User.kcal4, 1500, Colors.black),
          dinner(Context,User.kcal5, 1500, Colors.black),
          collsoir(Context,User.kcal6, 1500, Colors.black)

        ],

      ),

    );
  }

  Widget ptit(context,double courant, int limite, var couleur) {
    return Container(
      child: Stack(
        children: [
          Text(""),
          RaisedButton(

            onPressed: () async {
              cour.repas="ptit-dej";
              User.creerlist();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screenAliment())));
              setState(() {
                User.kcal1=User.kcal1+1-1;
              });
            },
            child: Image.asset("assets/images/ptitdej.png"),
            color: Colors.white,
          ),
          Align(
              alignment: Alignment(0, 0.7),
              child: Text("Petit déjeuner:\n" + courant.toString() + "/" +
                  limite.toString(),
                style: TextStyle(
                  color: couleur,
                  fontSize: 16,

                ),
              )
          )

        ],
      ),
    );
  }

  Widget dej(context,double courant, int limite, var couleur) {
    return Container(
      child: Stack(
        children: [
          RaisedButton(
            onPressed: () async {
              cour.repas="dej";
              User.creerlist();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screenAliment())));
            },
            child: Image.asset("assets/images/dejeuner.png"),
            color: Colors.white,
          ),
          Align(
              alignment: Alignment(-0.7, 0.75),
              child: Text(
                "Déjeuner:" + courant.toString() + "/" + limite.toString(),
                style: TextStyle(
                  color: couleur,
                  fontSize: 14,

                ),
              )
          )
        ],
      ),
    );
  }

  Widget collmat(context,double courant, int limite, var couleur) {
    return Container(
      child: Stack(
        children: [
          RaisedButton(
            onPressed: () async {
              cour.repas="collmat";
              User.creerlist();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screenAliment())));
              setState(() {
                User.kcal3+1-1;
              });
            },
            child: Image.asset("assets/images/collmat.png"),
            color: Colors.white,
          ),
          Align(
              alignment: Alignment(-0.7, 0.8),
              child: Text("Collation matinal:\n " + courant.toString() + "/" +
                  limite.toString(),
                style: TextStyle(
                  color: couleur,
                  fontSize: 14,

                ),
              )
          )
        ],
      ),
    );
  }

  Widget the(context,double courant, int limite, var couleur) {
    return Container(
      child: Stack(
        children: [
          RaisedButton(
            onPressed: () async {
              cour.repas="the";
              User.creerlist();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screenAliment())));
            },
            child: Image.asset("assets/images/thé.png"),
            color: Colors.white,
          ),
          Align(
              alignment: Alignment(-0.0, 0.85),
              child: Text(
                "    Goûter:\n" + courant.toString() + "/" + limite.toString(),
                style: TextStyle(
                  color: couleur,
                  fontSize: 16,

                ),
              )
          )
        ],
      ),
    );
  }

  Widget dinner(context,double courant, int limite, var couleur) {
    return Container(
      child: Stack(
        children: [
          RaisedButton(
            onPressed: () async {
              cour.repas="dinner";
              User.creerlist();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screenAliment())));
              setState(() {
                User.kcal5+1-1;
              });
            },
            child: Image.asset("assets/images/dinner.png"),
            color: Colors.white,
          ),
          Align(
              alignment: Alignment(0, 0.3),
              child: Text(
                "Dinner:" + courant.toString() + "/" + limite.toString(),
                style: TextStyle(
                  color: couleur,
                  fontSize: 16,

                ),
              )
          )
        ],
      ),
    );
  }

  Widget collsoir(context,double courant, int limite, var couleur) {
    return Container(
      child: Stack(
        children: [
          RaisedButton(
            onPressed: () async {
              cour.repas="collsoir";
              User.creerlist();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screenAliment())));
            },
            child: Image.asset("assets/images/collsoir.png"),
            color: Colors.white,
          ),
          Align(
              alignment: Alignment(-0.7, 0.6),
              child: Text("Collation soir:\n " + courant.toString() + "/" +
                  limite.toString(),
                style: TextStyle(
                  color: couleur,
                  fontSize: 14,

                ),
              )
          )
        ],
      ),
    );
  }
}
class graph extends StatelessWidget {
  Widget build(Context) {

    return Container(
      child: diagW(),


    );


  }

}
class diagW extends StatefulWidget{
  diagW({Key key}) : super(key : key);
  diag createState() => diag();
}

class diag extends State<diagW> {
  final List<pointP> data=[];
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 11,
        //crossAxisSpacing: 30,
        //mainAxisSpacing: 30,
        //padding: const EdgeInsets.all(4.0),
        staggeredTiles:[
          StaggeredTile.count(10, 6),
          StaggeredTile.count(1, 1),

        ],
        children: [//test
          new charts.TimeSeriesChart(
          creerdata(),
          animate: true,
              layoutConfig: new charts.LayoutConfig(
                  leftMarginSpec: new charts.MarginSpec.fixedPixel(60),
                  topMarginSpec: new charts.MarginSpec.fixedPixel(20),
                  rightMarginSpec: new charts.MarginSpec.fixedPixel(60),
                  bottomMarginSpec: new charts.MarginSpec.fixedPixel(20))
        ),
        FlatButton(
          onPressed: (){
            setState(() {
              TextEditingController _textController=TextEditingController(text: '');
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: const Text(
                      'Donner votre poid actuel',
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )
                  ),

                  actions: [

                    CupertinoTextField(controller: _textController
                    ,keyboardType: TextInputType.number),
                    CupertinoActionSheetAction(
                      child: const Text('Valider'),
                      onPressed: () async{

                        RegExp exp = new RegExp(r"\d\d+");
                        if(exp.hasMatch(_textController.text)) {
                          if (data.last.date.day == DateTime.now().day &&data.last.date.month == DateTime.now().month &&data.last.date.year == DateTime.now().year) {
                            data.removeLast();
                            data.add(new pointP(DateTime.now(), double.parse(_textController.text.toString())));
                            User.setpoid(
                                double.parse(_textController.text.toString()));
                            var x = {
                              'id':User.evolution.last['id'],
                              'poid': double.parse(
                                  _textController.text.toString()),
                              'DATENR': DateTime.now().toString()
                            };
                            await User.database.update('TABPOID', x,where: "id = ?",whereArgs:[User.evolution.last['id']]);
                            Navigator.pop(context);
                          } else {
                            data.add(new pointP(DateTime.now(),
                                double.parse(_textController.text.toString())));
                            var x = {
                              'poid': double.parse(
                                  _textController.text.toString()),
                              'DATENR': DateTime.now().toString()
                            };
                            User.setpoid(
                                double.parse(_textController.text.toString()));
                            await User.database.insert("TABPOID", x,
                            );
                            Navigator.pop(context);
                          }
                        }else{

                        }

                      },
                    ),

                  ],
                ),
              );

            });
          },
          child: Icon(Icons.add_circle,
          color: Colors.orange,),
        )],

    );

  }
   creerdata(){

    for (var j in User.evolution){
      int year=int.parse(j["DATENR"].toString().substring(0,4));
      int month=int.parse(j["DATENR"].toString().substring(5,7));
      int day=int.parse(j["DATENR"].toString().substring(8,10));
      data.add( pointP( new DateTime(year,month,day),j["poid"]));
    }
    return [
      new charts.Series<pointP, DateTime>(id: "graph",
          data: data,
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (pointP sales , _)=>sales.date,
          measureFn: (pointP sales , _)=>sales.poid)
    ];
  }
}
class pointP {
  final DateTime date;
  final double poid;

  pointP(this.date, this.poid);
}

class changepoid extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<changepoid> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => CupertinoActionSheet(
                title: const Text('Title'),
                message: const Text('Message'),
                actions: [

                ],
              ),
            );
          },
          child: Text('CupertinoActionSheet'),
        ),
      ),
    );
  }
}