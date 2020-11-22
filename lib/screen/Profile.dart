import 'package:flutter/cupertino.dart';
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



      ),
      body:body(context) ,


    );
  }
  body(context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
                children: [
                            Container(
                              height:  MediaQuery.of(context).size.height*0.28,
                              width:MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    width:MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height*0.15,
                                    decoration: BoxDecoration(

                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(1000),bottomRight: Radius.circular(1000)),
                                        color: Colors.deepOrangeAccent,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0,10),
                                            blurRadius: 50,
                                            color: Colors.grey.withOpacity(0.4)
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(left: MediaQuery.of(context).size.width/2-80,
                                      child: Container(
                                        width: 160,
                                        child: Center(
                                          child: Text("Profile",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30
                                          ),),
                                        ),

                                      ))
                                  ,
                                  Positioned(top: MediaQuery.of(context).size.height*0.05,
                                    left: MediaQuery.of(context).size.width/2-MediaQuery.of(context).size.height*0.1,
                                    child: Container(
                                      height:MediaQuery.of(context).size.height*0.2,
                                      width:MediaQuery.of(context).size.height*0.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0,10),
                                              blurRadius: 50,
                                              color: Colors.black.withOpacity(0.3)
                                          )
                                        ],
                                      ),
                                      child:Center(
                                        child:  Container(
                                          height: MediaQuery.of(context).size.height*0.15,
                                          width:MediaQuery.of(context).size.height*0.15,
                                          child:  Image.asset("assets/images/"+User.morpho.toString().substring(16)+".png"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          Text(User.nom+'  '+User.prenom,style: TextStyle(
                            fontSize: 30
                          ),),
                          SizedBox(height: 15,),
                          Container(
                            height:100 ,
                            width: MediaQuery.of(context).size.width-20,
                            color: Colors.transparent,
                            child: Row(

                              children: [

                                Container(
                                  height:100 ,
                                  width: (MediaQuery.of(context).size.width-20)/3,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox( height:15),
                                        Text(User.getpoid().toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color:Colors.blue
                                          ),
                                        ),SizedBox( height:15),
                                        Text("Poids",style: TextStyle(
                                          fontSize: 18,))

                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height:100 ,
                                  width: (MediaQuery.of(context).size.width-20)/3,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox( height:15),
                                        Text(calculeImc().toString().substring(0,5),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: calculeImc()<18.5?Colors.amber:calculeImc()<25?Colors.green:calculeImc()<30?Colors.orange:calculeImc()<35?Colors.deepOrangeAccent:calculeImc()<40?Colors.deepOrange:Colors.red
                                        ),
                                        ),SizedBox( height:15),
                                        Text("IMC",style: TextStyle(
                                          fontSize: 18,))

                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height:100 ,
                                  width: (MediaQuery.of(context).size.width-20)/3,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox( height:15),
                                        Text(User.getTaille().toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.blue
                                          ),
                                        ),SizedBox( height:15),
                                        Text("Taille",style: TextStyle(
                                          fontSize: 18,))

                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width-20,
                            height: MediaQuery.of(context).size.height*0.4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,10),
                                    blurRadius: 50,
                                    color: Colors.black.withOpacity(0.4)

                                )
                              ]

                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(

                                children: [
                                  SizedBox(height: 15,),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child:
                                 Row(
                                   children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                               Text("(IMC)",
                                                   style: TextStyle(
                                                       fontSize: 20
                                                   )),
                                               SizedBox(width:( MediaQuery.of(context).size.width-20)/6,),
                                               Text("Interprétation \n(d'après l'OMS)",
                                               style: TextStyle(
                                                 fontSize: 20
                                               ),),

                                   ],
                                 ),),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                      Text("moins de \n18,5",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                              color: Colors.amber
                                          )),
                                      SizedBox(width:( MediaQuery.of(context).size.width-20)/6,),
                                      Text("Insuffisance pondérale \n(maigreur)",
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                            color: Colors.amber
                                        ),),


                                    ],
                                  )
                                  ,
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                      Text("18,5 à 25",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                              color:Colors.green
                                          )),
                                      SizedBox(width:( MediaQuery.of(context).size.width-20)/6,),
                                      Text(" Corpulence normale",
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                            color:Colors.green
                                        ),),


                                    ],
                                  )
                                  ,
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                      Text("25 à 30",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                              color:Colors.orange
                                          )),
                                      SizedBox(width:( MediaQuery.of(context).size.width-20)/6,),
                                      Text("    Surpoids",
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                            color:Colors.orange
                                        ),),


                                    ],
                                  )
                                  ,
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                      Text("30 à 35",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                              color:Colors.deepOrangeAccent
                                          )),
                                      SizedBox(width:( MediaQuery.of(context).size.width-20)/6,),
                                      Text("    Obésité modérée",
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                            color:Colors.deepOrangeAccent
                                        ),),


                                    ],
                                  )
                                  ,
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                      Text("35 à 40",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                              color:Colors.deepOrange
                                          )),
                                      SizedBox(width:( MediaQuery.of(context).size.width-20)/6,),
                                      Text("    Obésité sévère",
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                            color:Colors.deepOrange
                                        ),),


                                    ],
                                  )
                                  ,
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [ SizedBox(width:( MediaQuery.of(context).size.width-20)/10,),
                                      Text("plus de 40",
                                          style: TextStyle(
                                              fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                              color:Colors.red
                                          )),
                                      SizedBox(width:( MediaQuery.of(context).size.width-20)/6.5,),
                                      Text("Obésité morbide",
                                        style: TextStyle(
                                            fontSize: (MediaQuery.of(context).size.width-20)*0.045,
                                            color:Colors.red
                                        ),),


                                    ],
                                  )
                                  ,


                                ],
                              ),
                            ),
                          )

                          ),
                          Container(
                            
                          )
                ],

                    ),
    );
  }
  double calculeImc(){
    return(User.getpoid()/((User.getTaille()/100)*(User.getTaille()/100)));
  }
  }

