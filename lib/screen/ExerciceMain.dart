import 'package:flutter/material.dart';
import 'package:tes/screen/Entrainement.dart';

import '../script/programme.dart';

class ExerciceMain extends StatefulWidget{
  List<Exercice> list=[];
  Color c;
  ExerciceMain(this.list,this.c);
  _ExerciceMain createState() =>_ExerciceMain(this.list,this.c);
}
class _ExerciceMain extends State<ExerciceMain>{
  @override
  List<Exercice> list=[];
  Color c;
  _ExerciceMain(this.list,this.c);
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
       appBar: AppBar(
         backgroundColor: c,
       ),
       bottomNavigationBar: Container(
         width: MediaQuery.of(context).size.width,
         height: 100,
         color: Colors.white,
         child: Center(
           child: Container(
             width: MediaQuery.of(context).size.width-25,
             height: 80,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(100),
               color: c

             ),
             child: FlatButton(
               onPressed: (){

               },
               child: Center(
                 child: Text("Commencer !",style: TextStyle(
                   color: Colors.white,
                   fontSize: 25
                 ),),
               ),
           ),
           ),
         ),
       ),
       body: body(list,c),
     );
  }
  body(x,c){
    List<Widget> list=[Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),bottomLeft: Radius.circular(100)),
        color: c
      ),
    ),SizedBox(height: 20)];
    for(int i=0;i<x.length;i++){
     /* list.add(Text("Exercice:${i+1}",
      style: TextStyle(
        fontSize:20
      ),));*/
     var str="";
     if(x[i].duree==-1){
       str=str+x[i].serie.toString()+" serie de "+x[i].repetition.toString()+" répétitions";
     }

     else{
       if (x[i].duree==1)
       str=str+x[i].serie.toString()+" serie de "+x[i].duree.toString()+" minute";
       else
         str=str+x[i].serie.toString()+" serie de "+x[i].duree.toString()+" minutes";
     }
      list.add(
        Container(
          width: MediaQuery.of(context).size.width-40,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(
                  offset: Offset(0,10),
                  blurRadius: 50,
                  color: c.withOpacity(0.1)
              )],
            color: Colors.white
          ),
          child: Stack(
            children: [

              Positioned(left: 8,top: 8,
                  child: Text(x[i].titre,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.045
                  ,
              )))
              ,Positioned(bottom: 8,right: 8,child: Text(str,
              style: TextStyle(
                fontSize: 18
              ),))

            ]

          ),
        )
      );
      list.add(SizedBox(height: 20));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Column(
          children: list,
      ) ,
    );
  }

}