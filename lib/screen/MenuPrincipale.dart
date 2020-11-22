import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../script/Personne.dart';
import 'Profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'ScreenAliment.dart';
import '../script/produit.dart';
import '../screen/ScreenAl.dart';
import '../screen/Entrainement.dart';

class MenuPrincipale extends StatefulWidget{

  _MenuPrincipale createState() => _MenuPrincipale();

}
class _MenuPrincipale extends State<MenuPrincipale>{
  @override
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _drawerKey,
      body: body(),
      drawer :Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                boxShadow: [BoxShadow(

                    offset: Offset(0,10),

                    blurRadius: 50,

                    color: Colors.deepOrange.withOpacity(0.2)
                )],

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
            SizedBox(height: 50,),
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
                try {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => (new MPEntraineent())));
                }catch(e){

                }

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.menu,color: Colors.black,), onPressed: (){
          _drawerKey.currentState.openDrawer();
        }),
      ),
      extendBodyBehindAppBar: true
    );
  }
  body(){
    var Size=MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
      children: [
           Row(
            children: [
              Expanded(child: Center(
                child: Container(
                  height:Size.height*0.4,
                  width:Size.width*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white,
                      boxShadow: [BoxShadow(
                          offset: Offset(0,10),
                          blurRadius: 50,
                          color: Colors.black.withOpacity(0.4)
                      )]
                  ),
                  child: Center(
                    child:Column(
                      children: [
                        SizedBox(height: Size.height*0.4*0.15,),
                        Text("9000 \n kcal",style: TextStyle(
                          fontSize: Size.height*0.4*0.07
                        ),),
                        SizedBox(height: Size.height*0.4*0.08,),
                        Text("10\nkm",style: TextStyle(
                            fontSize: Size.height*0.4*0.07)),
                        SizedBox(height: Size.height*0.4*0.08,),
                        Text("10\nkm",style: TextStyle(
                            fontSize: Size.height*0.4*0.07)),

                        ],
                    )
                  ),
                ),
              )
        ,
              ),
              Container(
                height: Size.height*0.7,
                width: Size.width*0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(60)),
                  color: Colors.deepOrangeAccent,
                  boxShadow: [BoxShadow(
                      offset: Offset(0,10),
                      blurRadius: 50,
                      color: Colors.deepOrange.withOpacity(0.5)
                  )],

                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: Size.height*0.7*0.1,),

                      Row(
                        children: [
                          Container(
                          height: Size.height*0.7*0.15,
                          width: Size.width*0.7*0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  offset: Offset(0,10),
                                  blurRadius: 50,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )],
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight:Radius.circular(20) )
                          ),
                          child:
                              FlatButton(
                                  onPressed: () async {
                                    cour.repas="ptit-dej";
                                    cour.msg="petit-déjeuner";
                                    User.creerlist();
                                    cour.rc.add(Container(height: 200,));
                                    cour.img="assets/images/ptitdej.png";
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screen())));
                                    setState(() {
                                      User.kcal1=User.kcal1+1-1;
                                    });
                                  }, child: Image.asset("assets/images/ptitdej.png"))

                        ),
                          SizedBox(width: 20,),
                          Center(
                            child: Text("petit dejeuner\n 1500/1500",style: TextStyle(
                              fontSize: 20
                            ),),
                          )
                        ],
                      ),
                      Row(
                        children: [Expanded(child: Column(
                          children: [Center(
                            child: Text("petit dejeuner\n 1500/1500",style: TextStyle(
                                fontSize: 20
                            ),),
                          )],
                        )),
                          Container(
                            height: Size.height*0.7*0.15,
                            width: Size.width*0.7*0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                    offset: Offset(0,10),
                                    blurRadius: 50,
                                    color: Colors.deepOrange.withOpacity(0.2)
                                )],
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft:Radius.circular(20) )
                            ),
                              child:
                              FlatButton(
                                  onPressed: () async {
                                    cour.repas="collmat";
                                    cour.msg="Collation \n  matinal";
                                    cour.img="assets/images/collmat.png";
                                    User.creerlist();
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screen())));
                                    setState(() {
                                      User.kcal3+1-1;
                                    });
                                  }, child: Image.asset("assets/images/collmat.png"))
                          )],
                      ),
                      Row(
                        children: [
                          Container(
                          height: Size.height*0.7*0.15,
                          width: Size.width*0.7*0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  offset: Offset(0,10),
                                  blurRadius: 50,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )],
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight:Radius.circular(20) )
                          ),
                            child:
                            FlatButton(
                                onPressed: () async {
                                  cour.repas="dej";
                                  cour.msg="Dejeuner";
                                  cour.img="assets/images/dejeuner.png";
                                  User.creerlist();
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screen())));
                                }, child: Image.asset("assets/images/dejeuner.png"))
                        ),
                          SizedBox(width: 20,),
                          Center(
                            child: Text("petit dejeuner\n 1500/1500",style: TextStyle(
                                fontSize: 20
                            ),),
                          )],
                      ),
                      Row(
                        children: [Expanded(child: Column(children: [
                          Center(
                            child: Text("petit dejeuner\n 1500/1500",style: TextStyle(
                                fontSize: 20
                            ),),
                          )
                        ],)),
                          Container(
                            height: Size.height*0.7*0.15,
                            width: Size.width*0.7*0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                    offset: Offset(0,10),
                                    blurRadius: 50,
                                    color: Colors.deepOrange.withOpacity(0.2)
                                )],
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft:Radius.circular(20) )
                            ),
                              child:
                              FlatButton(
                                  onPressed: () async {
                                    cour.repas="collsoir";
                                    cour.msg="collation soir";
                                    cour.img="assets/images/collsoir.png";
                                    User.creerlist();
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screen())));
                                  }, child: Image.asset("assets/images/collsoir.png"))
                          )],
                      ),
                      Row(
                        children: [
                          Container(
                          height: Size.height*0.7*0.15,
                          width: Size.width*0.7*0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  offset: Offset(0,10),
                                  blurRadius: 50,
                                  color: Colors.deepOrange.withOpacity(0.2)
                              )],
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight:Radius.circular(20) )
                          ),
                            child:
                            FlatButton(
                                onPressed: () async {
                                  cour.repas="the";
                                  cour.msg="Gouter";
                                  cour.img="assets/images/thé.png";
                                  User.creerlist();
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screen())));
                                }, child: Image.asset("assets/images/thé.png"))
                        ),
                          SizedBox(width: 20,),
                          Center(
                            child: Text("petit dejeuner\n 1500/1500",style: TextStyle(
                                fontSize: 20
                            ),),
                          )],
                      ),
                      Row(
                        children: [Expanded(child: Column(
                          children: [Center(
                            child: Text("petit dejeuner\n 1500/1500",style: TextStyle(
                                fontSize: 20
                            ),),
                          )],
                        )),
                          Container(
                            height: Size.height*0.7*0.15,
                            width: Size.width*0.7*0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                    offset: Offset(0,10),
                                    blurRadius: 50,
                                    color: Colors.deepOrange.withOpacity(0.2)
                                )],
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft:Radius.circular(20) )
                            ),
                              child:
                              FlatButton(
                                  onPressed: () async {
                                    cour.repas="dinner";
                                    cour.msg="Dinner";
                                    cour.img="assets/images/dinner.png";
                                    User.creerlist();
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>(new screen())));
                                    setState(() {
                                      User.kcal5+1-1;
                                    });
                                  }, child: Image.asset("assets/images/dinner.png"))
                          )],
                      ),

                    ],
                  ),
                ),
              )
            ],

          ),




      ],
    ));
}


}