import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tes/screen/Entrainement.dart';

class Exercicesuite extends StatefulWidget{
   List suite=[];
   int step;
   Exercicesuite(this.suite,this.step);
  _Exercicesuite createState()=>_Exercicesuite(this.suite,this.step);
}
class _Exercicesuite extends State<Exercicesuite> with TickerProviderStateMixin{

  List suite=[];
  List couleur=[Colors.grey,Colors.red];
  int nb;
  int step;
  int nbserie;
  bool test;
  _Exercicesuite(suite,step){
    this.suite=suite;
    this.step=step;

    nbserie=1;
    nb=0;
    this.test=false;
  }
  AnimationController controller;
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: this.suite[this.step].duree),
    );

    controller.reverse(from: this.suite[this.step].duree.toDouble());
    controller.addListener(() {

      if(controller.value<0.01){
        setState(() {
          this.test=true;
        });


      }



    });

  }
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: this.suite[this.step].duree==-1?bodyrepet():bodyduree(),
     bottomNavigationBar: Container(

       width: MediaQuery.of(context).size.width,
       height: 100,
       color: Colors.transparent,
       child: Center(child:Container(
         width:  MediaQuery.of(context).size.width-50,
         height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:this.test?Colors.red:Colors.grey,
        ),
         child: FlatButton(
             //this.suite[this.step].serie!=nbserie
           onPressed:this.test? this.suite.length-1!=this.step?
                    this.suite[this.step].serie!=nbserie ? (){
                     setState(() {
                       this.nbserie++;
                       this.test=false;
                       if(this.suite[this.step].duree>0) {
                         controller.duration = Duration(minutes: this.suite[this
                             .step].duree);
                         controller.reverse(from: this.suite[this.step].duree
                             .toDouble());
                       }
                     });
                    } : (){
                        setState(() {
                          this.nbserie=1;
                          this.step++;
                          this.test=false;
                          if(this.suite[this.step].duree>0) {
                            controller.duration = Duration(minutes: this.suite[this
                                .step].duree);
                            controller.reverse(from: this.suite[this.step].duree
                                .toDouble());
                          }
                          print(this.suite.length);
                          print(this.step);
                        });
                    }:(){print(this.suite.length);
           print(this.step);

                            print("dela3a");
           }:null
           ,
           child: Text(this.suite[this.step].serie!=nbserie ? "serie $nbserie/${this.suite[this.step].serie}" : "Prochain Exercice!",
             style: TextStyle(
               fontSize: 24,
               color: Colors.white
             ),
           ),
         ),
       ),
     ),
    ));
  }
  bodyduree(){


    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Stack(
            children: [

              Container(

                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width+100,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(360),
                          bottomRight: Radius.circular(360))
                  )),
              Positioned(
                  bottom:10,

                  left: MediaQuery.of(context).size.width/2-100,
                  right:MediaQuery.of(context).size.width/2-100 ,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 280,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(90)
                      ),
                      child: FlatButton(
                        onPressed: (){

                        },
                        child: Center(
                          child: Text(
                            "ARRETER ?",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                //fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold
                            ),
                          ) ,
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),
          SizedBox(height: 10),
          Center(child:Container(
            width:MediaQuery.of(context).size.width-100 ,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.3)
                )
              ],

            ),
            child:Center(child:
            Text(this.suite[this.step].titre,
            style: TextStyle(
              fontSize: 18
            ),),)

          )),
          AnimatedBuilder(animation: controller, builder: (context,child){
            return Stack(
              children: [
                Text(timerString,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width/3
                ),)
              ],
            );
          }),
          Container(
            width: MediaQuery.of(context).size.width-30,
            height:MediaQuery.of(context).size.height*0.42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: this.test?Colors.red.withOpacity(0.4):Colors.black.withOpacity(0.4)
                )
              ],

            ),

          )
        ],
      ),
    );
  }
  bodyrepet(){
    this.test=true;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        children: [
          Stack(
            children: [

        Container(

            height: MediaQuery.of(context).size.height*0.15,
            width: MediaQuery.of(context).size.width+100,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(360),
                    bottomRight: Radius.circular(360))
            )),
                Positioned(
                        bottom:10,

                      left: MediaQuery.of(context).size.width/2-100,
                         right:MediaQuery.of(context).size.width/2-100 ,
                         child: Center(
                               child: Container(
                                                  height: 50,
                                                  width: 280,
                                                  decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                    borderRadius: BorderRadius.circular(90)
                                                  ),
                                 child: FlatButton(
                                   onPressed: (){

                                   },
                                        child: Center(
                                                    child: Text(
                                                                  "ARRETER ?",
                                                                    style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.white,
                                                                                //fontStyle: FontStyle.italic,
                                                                                fontWeight: FontWeight.bold
                                                                                    ),
                                                                ) ,
                                                     ),
                                                  ),
                                                ),
                                      )
                         )
            ],
          ),
          SizedBox(height: 10,),
                   Center(child:Container(
      width:MediaQuery.of(context).size.width-80 ,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,

        boxShadow: [
          BoxShadow(
              offset: Offset(0,10),
              blurRadius: 50,
              color: Colors.green.withOpacity(0.4)
          )
        ],

      ),
      child:Center(child:
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(this.suite[this.step].titre,

            style: TextStyle(
                fontSize: 18
            ),),
        )
      ,)

  )),
          SizedBox(height: 30,),
          Center(child:Container(
            height: MediaQuery.of(context).size.height-330,
            width: MediaQuery.of(context).size.width-30,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: Colors.green.withOpacity(0.5)
                )
              ],

              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              children: [
                SizedBox(height: 15,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Positioned(
                        left: 10,
                        child: Text(
                          'nombre de repetitions:'+this.suite[this.step].repetition.toString(),
                          style: TextStyle(
                              fontSize: 25
                          ),

                        )
                    )
                  ],
                )
              ],

            ),
          ))

],
        )
    );
  }
}