import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'principale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:tes/script/OFF.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tes/script/produit.dart';
import '../src/Bloc.dart';
import '../test.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import '../script/Personne.dart';

class screenAliment extends StatefulWidget{

  screenAliment({Key key}) :super(key:key);

  @override
  _screenAliment createState() => _screenAliment();
}
class _screenAliment extends State<screenAliment> {

  TextEditingController _controller;
  TextEditingController _controllerkcal;
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controllerkcal = TextEditingController();
    _controllerkcal.addListener(() {
      cour.setkcalt(double.parse(_controllerkcal.value.text)*cour.kcal1g);
      print(cour.kcalt);
    });
    _controller.addListener(() {
      setState(() {
        cour.rc.add(ListTile(title: Text(""),));
        print(cour.rc);
      });
    });
  }

  void dispose() {
    _controller.dispose();
    _controllerkcal.dispose();
    super.dispose();
  }

  Color couleur=Colors.black;
  void _showErrorSnackbar(BuildContext context, String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  Widget build(BuildContext context) {
    bloc.upgrade();

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            cour.setnom("");
            cour.setKcal("");
            User.lila();
            cour.seturl("https://i0.wp.com/www.triomphe-securite.fr/wp-content/uploads/2014/07/image-vide.png");
            Navigator.pop(context);
            cour.rc.clear();

          },



        ),
        backgroundColor: Colors.deepOrange,
        title: Container(
          height: 40,

        child :
             StreamBuilder(
            stream: bloc.recherchp,
            builder: (context,snapshot){
              cour.context=context;
              return TextFormField(
                controller: _controller,
          onChanged: bloc.changenrcherch,
          onEditingComplete: (){
            setState(() {
              cour.rc.add(ListTile());
            });
          },

          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white// This is not so important
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom:4,  // HERE THE IMPORTANT PART
              ),
            suffixIcon: IconButton(
                 onPressed: ()async {
                   var scanResult;
                   try {

                     scanResult = await BarcodeScanner.scan();
                     var x= scanResult.rawContent;
                     var y=await getProduct(x);
                     print(y.productName);

                     setState(() {
                      cour.seturl(y.images[0].url);
                      cour.setnom(y.productName);
                      if(y.nutriments.energyKcal100g==null){
                        cour.setKcal("Energie: / ");

    }else {
                        cour.setKcal("Energie:" +
                            y.nutriments.energyKcal100g.toString() +
                            " kcal(100g)");
                        cour.kcal1g=y.nutriments.energyKcal100g/100;
                      }

                      
                      showCupertinoDialog(context: context,
                          builder: (BuildContext context) => CupertinoDialog(
                            child: Container(
                              height: 150,
                                width: 100,
                                child:ficheproduit(context,cour)),

                      ));
                     });


                   }  catch (e) {
                     showCupertinoDialog(context: context,
                         builder: (BuildContext context) => CupertinoDialog(
                           child: Container(
                             height: 300,
                             width: 200,
                             child: ajoutprduit(context,scanResult.rawContent),
                           ),
                         ));


                   } catch (e) {
                     _showErrorSnackbar(context, 'Unknown error: $e');
                   }

                  // showSearch(context: context, delegate: ProductSearch());
                 },
                icon: Icon(Icons.camera_alt),
          ),
            fillColor: Colors.white38,
            filled: true,
            border: OutlineInputBorder(

            ),



          ),
        );
         }
        ),
        ),

      ),
      body: SingleChildScrollView(child:Container(
    child:displayPro(),

    )
    ));
  }
  displayPro(){
    return  Column(


    children: [
      Container(
        height:300,
          width: 1000,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
    child:SingleChildScrollView(child:Column(
      children: cour.rc,))


    ),Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),child: Column(
      children: User.test,
    ))
    ]

  );
  }
  ficheproduit(context,produit pr){
    bloc.upgrade();
    return StaggeredGridView.count(
      crossAxisCount: 8,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(4.0),
      staggeredTiles:[
        StaggeredTile.count(3,4),
        StaggeredTile.count(4,1),
        StaggeredTile.count(5,1),
        StaggeredTile.count(3,1),
        StaggeredTile.count(3,2),
        StaggeredTile.count(2,2),
        StaggeredTile.count(1,1),
        StaggeredTile.count(1,1),
        StaggeredTile.count(2,1),
      ],
      children: [Image.network("${cour.url}"),
    RichText(
    text:TextSpan(text:"${cour.nom}",
           style: TextStyle(
color: Colors.black,
           decoration: TextDecoration.none,
           fontSize: 16.0,
        ))
    ),
        RichText(
        text:TextSpan(text:"${cour.kcal}",
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
            fontSize: 10.0,
          )
    )
        ),
      StreamBuilder(
    stream: bloc.kcal,
    builder: (context, snapshot) {

      return CupertinoTextField(
        controller: _controllerkcal,

        onChanged:bloc.changekcal,



        keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    )// HERE THE IMPORTANT PART

      ;}),
      RichText(
        text:TextSpan(text:"",
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 12.0,
            )
        ),
      ),
       // Text(""),
       // Text(""),
       // Text(""),
      FlatButton(

        onPressed: ()async{
          print(DateTime.now().toString().substring(0,10));
          print(cour.kcal1g);
          print(cour.kcalt);
            if(cour.kcalt!=0){

              Map <String,dynamic> x={
                'date':DateTime.now().toString().substring(0,10),
                'aliment':cour.nom.toString(),
                'repas':cour.repas,
                'kcal': cour.kcalt


              };
              await User.database.insert("journee", x);
              setState(() {
                User.test.add(Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.fastfood,
                      color: Colors.red,
                    ),
                    title: Text(cour.nom.toString()+"   "+cour.kcalt.toString()+" kcal"),
                  ),
                )

                );
              });

              Navigator.pop(context);


            }
        },
        child:Center(child:Icon(Icons.add_circle_outline,color: Colors.green,)
        )
      ),
        ],

    );


}
  ajoutprduit(context,String barcode){
    bloc.upgrade();
    return StaggeredGridView.count(
        crossAxisCount: 5,
        staggeredTiles: [
          StaggeredTile.count(5, 1),
          StaggeredTile.count(2, 1),
          StaggeredTile.count(3, 1),
          StaggeredTile.count(2, 1),
          StaggeredTile.count(3, 1),
          StaggeredTile.count(2, 1),
          StaggeredTile.count(3, 1),
          StaggeredTile.count(5, 1),

        ],
      children: [
        Center(

      child:RichText(
      text:TextSpan(text:"votre produit est introuvable?\najoutez le!" ,
          style: TextStyle(
            color: Colors.redAccent,
            decoration: TextDecoration.none,
            fontSize: 18.0,
          )))
        )
        ,
        Center(
          child: FlatButton(
            onPressed: () async{

              cour.url=StringBuffer(join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              ));
              var cameras = await availableCameras();
              var firstCamera = cameras.first;
              Navigator.push(context,MaterialPageRoute(builder: (context)=>(new TakePictureScreen(camera: firstCamera))));
              setState(() {
                print(cour.url);
                couleur.withBlue(10);
              });
            },
            child: Icon(Icons.add_a_photo,
            color: couleur,),
          ),
        ),

        Container(

            child:CupertinoTextField(

            controller: TextEditingController(
              text: barcode

            ),
        )
        )
        ,Center(child:RichText(
            text:TextSpan(text:"Nom du produit:" ,
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                ))))
        ,StreamBuilder(
            stream: bloc.nomp,
            builder: (context,snapshot)
            {return
              CupertinoTextField(

                onChanged: bloc.changenomp,
              );
            }),
    Center(
    child:RichText(
            text:TextSpan(text:"Energy:\nkcal/100(g,ml)" ,
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                )))),
     StreamBuilder(
    stream: bloc.nbkcal,
    builder: (context,snapshot)
    {
      return CupertinoTextField(
         



      keyboardType: TextInputType.number,
      onChanged: bloc.changenbkcal,
    );
    }),

        RaisedButton(
          color: Colors.blue,
          onPressed: () {
            print(cour.kcal);
            print(cour.nom);
            if(cour.nom.length!=0 && cour.kcal.length!=0){
              cour.kcal1g=double.parse(cour.kcal.toString())/100;
              addNewProduct(barcode, cour.nom.toString(),cour.kcal1g*100 );
              addProductImage(barcode,cour.url.toString());
              cour.setnom("");
              cour.setKcal("");
              cour.seturl("https://i0.wp.com/www.triomphe-securite.fr/wp-content/uploads/2014/07/image-vide.png");
              Navigator.pop(context);

            }



          },
            child: Center(
              child: Text("sauvegarder",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),),
            ),
        )


      ],
    );

  }

}
