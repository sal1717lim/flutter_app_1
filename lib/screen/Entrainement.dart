import 'package:flutter/material.dart';

class MPEntraineent extends StatefulWidget{


  MPEntraineent({Key key}) :super(key:key);

  @override
  _MPEntrainement createState() => _MPEntrainement();
}
class _MPEntrainement extends State<MPEntraineent> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon:Icon(Icons.arrow_back),color: Colors.deepOrange,
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
          Categories()
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
  List<String> categories =["Musculation","Poid du corps",'cross-fit'];
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
          selectedIndex = index;
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
