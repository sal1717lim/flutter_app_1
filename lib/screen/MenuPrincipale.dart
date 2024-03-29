import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../script/Personne.dart';
import 'Profile.dart';
import 'package:pedometer/pedometer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../script/produit.dart';
import '../screen/ScreenAl.dart';
import '../screen/Entrainement.dart';

class MenuPrincipale extends StatefulWidget{

  _MenuPrincipale createState() => _MenuPrincipale();

}
class _MenuPrincipale extends State<MenuPrincipale>{
  @override
  final List<pointP> data=[];
  final List<barPas> bar=User.bar;
  ScrollController control=ScrollController();
  int position=1;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '/';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
    setState(() async{


      await User.database.execute("insert or replace into podometre (date,pas) values(\""+DateTime.now().toString().substring(0,10)+'",$_steps);');
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _drawerKey,
      body: body(),
      drawer :Drawer(

        child:Stack(
          children: [ListView(
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
                    height:  MediaQuery.of(context).size.height*0.3,
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
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
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
          ),Positioned(child:Container(
            child: Row(
              children: [
                Text("Suivez nous:",style: TextStyle(
                  fontSize: 18
                ),),
                Container(

                  child: FlatButton(
                    onPressed: (){},
                    child: Image.asset("assets/images/instagram.png",height: 50,width: 50,),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.symmetric(vertical:5,horizontal: 5),
          ),bottom: 0,right: 0,)],
        )


      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //shape: BoxShape.circle
        leading: Container(

          decoration: BoxDecoration(
              shape: BoxShape.circle,
                  color: Colors.deepOrangeAccent.withOpacity(0.8)
          ),
          child: IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: (){
            _drawerKey.currentState.openDrawer();
          }),
        ),
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
                        Text("${User.kcalT.toInt()} \nkcal",style: TextStyle(
                          fontSize: Size.height*0.4*0.07
                        ),),
                        SizedBox(height: Size.height*0.4*0.08,),
                        Text("$_steps\n pas",style: TextStyle(
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
                            child: Text(
                              User.morpho.index==0?"Petit\ndéjeuner\n${User.kcal1}/580":User.morpho.index==1?"Petit\ndéjeuner\n${User.kcal1}/360":"Petit\ndéjeuner\n${User.kcal1}/245"
                              ,style: TextStyle(
                              fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white
                            ),),
                          )
                        ],
                      ),
                      Row(
                        children: [Expanded(child: Column(
                          children: [Center(

                            child: Text( User.morpho.index==0?"Collation\nMatinale\n${User.kcal2}/145":User.morpho.index==1?"Collation\nMatinale\n${User.kcal2}/90":"Collation\nMatinale\n${User.kcal2}/75",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white
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
                            child: Text( User.morpho.index==0?"Déjeuner\n${User.kcal3}/1160":User.morpho.index==1?"Déjeuner\n${User.kcal3}/720":"Déjeuner\n${User.kcal3}/580",

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white
                            ),),
                          )],
                      ),
                      Row(
                        children: [Expanded(child: Column(children: [
                          Center(
                              child: Text( User.morpho.index==0?"Collation soir\n${User.kcal4}/145":User.morpho.index==1?"Collation soir\n${User.kcal4}/90":"Collation soir\n${User.kcal4}/75",

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white
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
                            child: Text( User.morpho.index==0?"Gouter\n${User.kcal5}/580":User.morpho.index==1?"Gouter\n${User.kcal5}/360":"Gouter\n${User.kcal5}/290",

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white
                            ),),
                          )],
                      ),
                      Row(
                        children: [Expanded(child: Column(
                          children: [Center(
                              child: Text( User.morpho.index==0?"Dinner\n${User.kcal6}/290":User.morpho.index==1?"Dinner\n6/180":"Dinner\n${User.kcal6}/145",

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white
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
           Container(
             height: 50,
             child: Row(
               children: [SizedBox(width: 25,),Text("vos statistiques:",style: TextStyle(
                 fontSize: 30,
                 fontWeight: FontWeight.w400
               ),),],
             )
           ),
           SizedBox(height: 5,),
           Container(
             height: 300,
             width: Size.width-30,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(30),
               boxShadow: [BoxShadow(
                 offset: Offset(0,10),
                 blurRadius: 50,
                 color: Colors.black.withOpacity(0.2)
               )]
             ),
             child: Row(
               children: [
                 Container(child: IconButton(onPressed:this.position!=1? (){
                   setState(() {
                     control.animateTo(control.offset-(MediaQuery.of(context).size.width-30)*0.8, duration: Duration(milliseconds: 200), curve: Curves.linear);
                     this.position--;
                     print(this.position);
                   }
                   );
                 }:null, icon: Icon(Icons.arrow_back_ios)),width:(Size.width-30)*0.1 ,),
                 Container(width:(Size.width-30)*0.8 ,
                 height: 270,

                 child: Center(
                   child: SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                            physics:NeverScrollableScrollPhysics(),
                            controller: this.control,
                            child: Container(
                              width: (Size.width-30)*2.5,
                                child: Row(

                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: (Size.width-30)*0.8,
                                          height: 240,
                                          child: charts.TimeSeriesChart(
                                            creerdata(),
                                            animate: true,

                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          child: FlatButton(
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
                                          }
                                          ,color:Colors.white,child: Row(
                                            children: [Icon(Icons.add_circle_rounded,color: Colors.deepOrange,),Text("Poids")],
                                          ),),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 41,),
                                    Container(
                                      height: 240,
                                      width: (Size.width-30)*0.65,
                                      child: Center(
                                        child: charts.BarChart(
                                          creerpas(),
                                          animate: true,
                                          domainAxis: new charts.OrdinalAxisSpec(

                                              showAxisLine: true,

                                              renderSpec: new charts.NoneRenderSpec()),
                                          layoutConfig: new charts.LayoutConfig(
                                              leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
                                              topMarginSpec: new charts.MarginSpec.fixedPixel(0),
                                              rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
                                              bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)),



                                        ),
                                      )
                                    )
                                  ],
                                )
                            ),
                       ),

                 ),),
                 Container(child: IconButton(
                     onPressed: this.position==1?(){
                   setState(() {
                     control.animateTo(control.offset+(MediaQuery.of(context).size.width-30)*0.8, duration: Duration(milliseconds: 200), curve: Curves.linear);
                     this.position++; print(this.position);
                   });
                 }:null, icon: Icon(Icons.arrow_forward_ios)),width:(Size.width-30)*0.1 ,),
               ],
             ),
           ),
            SizedBox(height: 20,),
           RaisedButton(onPressed: ()async{
             var x=await User.database.rawQuery("select * from podometre");
             print(x);
             print("\a");

           })




      ],
    ));
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
  creerpas(){

    return [
      new charts.Series<barPas,String>(id: 'nombre de pas', data: bar, domainFn:(barPas sales, _)=>sales.date, measureFn: (barPas sales, _)=>sales.pas)
    ];


  }

}
class pointP {
  final DateTime date;
  final double poid;

  pointP(this.date, this.poid);
}
class barPas {
  final String date;
  final int pas;
  barPas(this.date,this.pas);
}