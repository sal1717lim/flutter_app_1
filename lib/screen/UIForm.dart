import 'package:flutter/material.dart';
import '../src/Bloc.dart';
import '../script/Personne.dart';
import 'morphologieC.dart';
class Myform extends StatefulWidget{

  _Myform createState() => _Myform();
}
class _Myform extends State<Myform>{
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() async {
      if (_controller.value.text.length == 2) {
        _controller.text =_controller.text+ "/";
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      } else if (_controller.value.text.length == 5) {
        _controller.text =_controller.text+ "/";
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      } else {
          print("dela3a");
      }
    }
      );
        }
  Widget build(BuildContext context) {

    return Scaffold(
        body: body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: (){
          if(User.bTaille && User.bPoid && User.bNom && User.bPrenom &&User.bobj && User.bNaissance&&User.bSexe ){
            print(User);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>morphologie()));

          }else{
            print("dala3a");

          }



        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  body(){
    String dropdownValue = 'Homme';
    bloc.upgrade();
    var size=MediaQuery.of(context).size;
    return Container(
      color: Colors.white,

      child: SingleChildScrollView(child: Column(

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [

              Container(
                height: 190,
                width: size.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft:Radius.circular(30) ),
                  color: Colors.deepOrange,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ Container(

                      child: Image.asset("assets/images/icon.png",height: 180,width: 180,),
                    ),

                  ],
                )
              ),




              Container(
                height: 150,
                width: size.width/2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(0),bottomLeft:Radius.circular(0) ),
                  color: Colors.deepOrange,
                ),
                child: Stack(
                  children: [Positioned(
                      bottom: 0
                      ,child: Container(
                    height: 70,
                    width: size.width/2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(60))
                    ),
                    child: Center(child: Text("Formulaire",style: TextStyle(
                      fontSize: 25
                    ),),),
                  ))],
                ),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
              child:
          Column(
            children: [
              SizedBox(height: 10,),
              Text("Bienvenue dans                   \n       ",style: TextStyle(
                  fontSize:size.width*0.065,
                  fontWeight: FontWeight.w400

              ),),
              SizedBox(height: 10,),
              Row(
                children: [
                  //nom
                  Container(
                    width: (size.width-20)/2,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(

                          offset: Offset(0,10),

                          blurRadius: 50,

                          color: Colors.black.withOpacity(0.5)
                      )],
                    ),

                    child: Center(
                      child: Container(
                        height: 60,
                        width: (size.width-20)/2-50,
                        child:  StreamBuilder(
                          stream: bloc.Nom,
                          builder: (context,snapshot){
                            return TextField(
                              onChanged:bloc.changeNom,

                              decoration: InputDecoration(
                                hintText: "votre nom",

                                errorText: snapshot.error,

                              ),
                            );
                          },


                        )
                      ),
                    ),
                  ),SizedBox(width: 20,),
                  Container(
                    width: (size.width-20)/2,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(

                          offset: Offset(0,10),

                          blurRadius: 50,

                          color: Colors.black.withOpacity(0.5)
                      )],
                    ),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: (size.width-20)/2-50,
                          child: StreamBuilder(
                              stream: bloc.Prenom,
                              builder: (context,snapshot){
                                return TextField(
                                    onChanged: bloc.changePrenom,
                                    decoration: InputDecoration(
                                      hintText: "votre prenom",

                                      errorText: snapshot.error,
                                    )

                                );}
                          ),
                      )
                  ))
                ],
              ),
              SizedBox(height: 50,),
              Row(
                children: [
                  Container(
                    width: (size.width-20)*2/3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(

                          offset: Offset(0,10),

                          blurRadius: 50,

                          color: Colors.black.withOpacity(0.5)
                      )],
                    ),
                  child: Center(child:Container(
                    width:(size.width-20)*2/3-20 ,
                    child: StreamBuilder(
                        stream: bloc.Naissance,
                        builder: (context,snapshot)
                        {
                          return TextField(
                              onChanged: bloc.changeNaissance,
                              keyboardType: TextInputType.datetime,
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: "Date de naissance:  jj/mm/aaaa",
                                errorText: snapshot.error,


                              )


                          );
                        }
                    ),
                  ),
                  )),
                  SizedBox(width: 20,),
                  Container(
                      width: (size.width-20)/3,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(

                            offset: Offset(0,10),

                            blurRadius: 50,

                            color: Colors.black.withOpacity(0.5)
                        )],
                      ),
                      child: Center(
                          child: Container(
                            height: 60,
                            width: (size.width-20)/3-50,
                            child: MyStatefulWidget()

                          )
                      ))
                ],
              ),
              SizedBox(height: 50,),
              Row(
                children: [
                  Container(
                      width: (size.width-20)/3-8,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(

                            offset: Offset(0,10),

                            blurRadius: 50,

                            color: Colors.black.withOpacity(0.4)
                        )],
                      ),
                      child: Center(
                          child: Container(
                            height: 60,
                            width: (size.width-20)/3-50,
                            child: StreamBuilder(
                                stream: bloc.Taille,
                                builder: (context, snapshot) {
                                  return TextField(
                                    onChanged: bloc.changeTaille,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Taille  cm",
                                      errorText: snapshot.error,

                                    ),
                                  );
                                }
                            ),

                          )
                      )),
                  SizedBox(width: 15,),
                  Container(
                      width: (size.width-20)/3-8,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(

                            offset: Offset(0,10),

                            blurRadius: 50,

                            color: Colors.black.withOpacity(0.3)
                        )],
                      ),
                      child: Center(
                          child: Container(
                            height: 60,
                            width: (size.width-20)/3-50,
                            child:  StreamBuilder(
                                stream: bloc.Poid,
                                builder: (context, snapshot) {
                                  return TextField(
                                    onChanged: bloc.changePoid,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Poid  kg",

                                      errorText: snapshot.error,

                                    ),
                                  );
                                }
                            ),

                          )
                      )),
                  SizedBox(width: 15,),
                  Container(
                      width: (size.width-20)/3,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(

                            offset: Offset(0,10),

                            blurRadius: 50,

                            color: Colors.black.withOpacity(0.3)
                        )],
                      ),
                      child: Center(
                          child: Container(
                            height: 60,
                            width: (size.width-20)/3-50,
                            child: StreamBuilder(
                                stream: bloc.Objectif,
                                builder: (context, snapshot) {
                                  return TextField(
                                    onChanged: bloc.changeObj,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Objectif kg",

                                      errorText: snapshot.error,

                                    ),
                                  );
                                }
                            ),

                          )
                      ))


                ],
              )
            ],
          ))
        ],
      ),
    ));
  }
}
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'sexe';

  @override
  Widget build(BuildContext context) {
    bool b =true;
    return DropdownButton<String>(

      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      style: TextStyle(color: Colors.blue),

      onChanged: (String newValue)  {

        setState(() {

          dropdownValue = newValue;
          dropdownValue=="sexe"?User.bSexe=false:User.bSexe=true;

          User.setSexe(newValue);

        });
      },
      items: <String>['sexe','Homme', 'Femme']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

