import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../script/programme.dart';
import 'package:tes/script/Personne.dart';

ScrollController control=ScrollController();

class MPEntraineent extends StatefulWidget{
 
  MPEntraineent({Key key}) :super(key:key);

  @override
  _MPEntrainement createState() => _MPEntrainement();
}
class _MPEntrainement extends State<MPEntraineent> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: body() ,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
            icon:Icon(Icons.arrow_back),color: Colors.white,
          onPressed: (){
              Navigator.pop(context);

          },
        ),
      ),

    );
  }
  body(){
    return Container(
      color: Colors.white,
        child:SingleChildScrollView(


      child: Column(
        children: [
          Categories(),
         Rcateg([Ccateg(),Ccateg(),Ccateg()])

        ],

      ),
    ));
  }
}
class Categories extends StatefulWidget {
  @override
  _Categories createState() => _Categories();
}
class _Categories extends State<Categories>{
  List categories=[] ;
  _Categories(){
    categories=listecateg;
  }
  int selectedIndex =0;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child:SizedBox(
      height: 35,
     child: ListView.builder(
       scrollDirection: Axis.horizontal,
         itemCount: categories.length,
         itemBuilder: (context,index)=> buildCategoriItem(index)),
    ));

  }
  Widget buildCategoriItem(int index){
    return GestureDetector(
      onTap:(){
        setState(() {
          if(selectedIndex==index-1){
            control.animateTo(control.offset+MediaQuery.of(context).size.width, duration: Duration(milliseconds: 200), curve: Curves.linear);
            selectedIndex = index;
          }
          if(selectedIndex==index-2){
            control.animateTo(control.offset+MediaQuery.of(context).size.width*2, duration: Duration(milliseconds: 200), curve: Curves.linear);
            selectedIndex = index;
          }
          if(selectedIndex==index+1){
            control.animateTo(control.offset-MediaQuery.of(context).size.width, duration: Duration(milliseconds: 200), curve: Curves.linear);
            selectedIndex = index;
          }
          if(selectedIndex==index+2){
            control.animateTo(control.offset-MediaQuery.of(context).size.width*2, duration: Duration(milliseconds: 200), curve: Curves.linear);
            selectedIndex = index;
          }

        });
      },

     child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
        decoration: BoxDecoration(
          color: selectedIndex==index ? Color(0xFFEFF3EE) :Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child:Text(
      categories[index],
      style: TextStyle(
        fontWeight: FontWeight.bold,
          color:selectedIndex == index ? Colors.deepOrange : Color(0xFFC2C2B5)
      ),

    )));
  }
}
class Ccateg extends StatefulWidget{

  _Ccateg createState()=> _Ccateg();
}
class _Ccateg extends State <Ccateg>{
  @override
  List ent=[];
  _Ccateg();
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(

        scrollDirection: Axis.horizontal,
        child:
        Container(margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            child:
        Column(

      children: body(),
    )));

  }
  difficulte(int nb){
    

    List<Widget> x=[Positioned(bottom:10,child: Text("Difficulté:",
    style: TextStyle(
    color: Colors.white,
    fontSize: 25
    ),))];
    for (int i=0;i<nb;i++){
      x.add(
        Positioned(top: 100,
            child:Image.asset("assets/images/icon.png",height: 80,width: 60,))
      );
    }
    return Row(
      children: x,
    );
    
    
  }
  body(){
    List<Widget> list=[];

    List X =[Colors.red,Colors.lightGreen,Colors.blue,Colors.orange,Colors.purple,Colors.black,Colors.brown];
    for(int i=0;i<3;i++){
     list.add(
       Container(
         padding: EdgeInsets.symmetric(vertical: 13,horizontal: 13),

         height: MediaQuery.of(context).size.height*0.33,
         width: MediaQuery.of(context).size.width-25,
         decoration: BoxDecoration(
           color: X[Random().nextInt(6)]
              , borderRadius: BorderRadius.circular(50)
         ),
         child: FlatButton(
           onPressed: (){

           },
           child: Container(
             child: Stack(
               
               children: [
                 Positioned(child: Text("Entrainement",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 25
                 ),),left: 0,top:10 ,),
                 Positioned(child: Text("7x4",
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 25
                   ),),left: 5,top:45 ,),
                 Positioned(
                   bottom: -20,left: 0,
                     child: Container(

                       child: difficulte(1),
                     ))

               ],
             ),

           ),

         ),

       )
     );
    list.add(SizedBox(height: 20));
    }
    return list;
  }
}

class Rcateg extends StatefulWidget{
  List<Widget> elt=[];
  Rcateg(this.elt);
  _Rcateg createState() => _Rcateg(elt);
}
class _Rcateg extends State<Rcateg>{
  @override

  List<Widget> elt=[];
  _Rcateg(this.elt);
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: control,
        child: Container(
            //margin: EdgeInsets.symmetric(horizontal: 0,vertical: 0),

            child:Row(
      children: elt,

    )));
  }
}