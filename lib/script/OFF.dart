import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:tes/script/produit.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../src/Bloc.dart';

Future<Product> getProduct(barcode1) async {
  var barcode = barcode1;

  ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode, language: OpenFoodFactsLanguage.FRENCH, fields: [ProductField.ALL]);
  ProductResult result =
  await OpenFoodAPIClient.getProduct(configuration);


  if (result.status == 1) {
    print(result.product);
    return result.product;
  } else {

  }
}
//test shearch product  by name

void recherche(context,x,db,test) async{
  User myUser = new User(userId: "sal-lim-17", password: "Sofisfgsf5g4s6f45");

  //await OpenFoodAPIClient.searchProducts(myUser, null);

  ProductSearchQueryConfiguration config= ProductSearchQueryConfiguration(language: OpenFoodFactsLanguage.FRENCH,fields: [ProductField.NAME,ProductField.IMAGES,ProductField.NUTRIMENTS],parametersList: [SearchTerms(terms:[x])]);
  SearchResult result = await OpenFoodAPIClient.searchProducts(myUser, config);
  if (result.page!=0) {
    print(result.products);
    cour.rc.clear();
    Size size=MediaQuery.of(context).size;
    for (int i=0;i<result.products.length;i++){
      cour.rc.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white
          ),
          margin: EdgeInsets.only(
            left: 20,top: 10,bottom: 80
          ),
          width: size.width*0.4,
height: 180,

           child: Column(children:[Container(
             decoration: BoxDecoration(
               color: Colors.white10
                   ,borderRadius: BorderRadius.circular(23)
             ),
height: 150,
             width: 150,
             child:FlatButton(
               onPressed: (){
                 cour.setnom(result.products[i].productName);
                 cour.kcal1g=result.products[i].nutriments.energyKcal100g/100;
                 try{
                   cour.seturl(result.products[i].imgSmallUrl);}

                 catch(e){
                   cour.seturl("https://i0.wp.com/www.triomphe-securite.fr/wp-content/uploads/2014/07/image-vide.png");
                 }
                 cour.setKcal("Energie(100g):"+result.products[i].nutriments.energyKcal100g.toString()+" kcal");
                 showCupertinoDialog(context: context,
                     builder: (BuildContext context) => CupertinoDialog(
                         child: Container(
                           height: 150,
                           width: 100,
                           child: ficheproduit(context, cour, db,test:test),

                         )));

           }, child: Image.network(result.products[i].imgSmallUrl)))
           , Container(
               decoration: BoxDecoration(

                 boxShadow: [
                   BoxShadow(
                     offset: Offset(0,10),
                     blurRadius: 50,
                     color: Colors.deepOrange.withOpacity(0.5)
                   )
                 ]
               ),child: SingleChildScrollView(
               scrollDirection:Axis.horizontal,child: Row(
               children: [RichText(text: TextSpan(
                 children: [
                   TextSpan(text: result.products[i].productName.toUpperCase(),style: TextStyle(
                     color: Colors.black
                   )
                   ),
                 ]
               ))],
             ),
             ))],
          ),
          
        )
      );
    }

  } else {

  }
}
ficheproduit(context,produit pr,db,{test,controlleur}){
  bloc.upgrade();
  double tet=0;
  TextEditingController _cont=TextEditingController();
  _cont.addListener(() {
    print(cour.nom);
    cour.setkcalt(double.parse(_cont.value.text)*cour.kcal1g);
    print(cour.kcalt);
  });

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
                fontSize: 14.0,
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
       CupertinoTextField(


              controller: _cont,

              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            )// HERE THE IMPORTANT PART

                ,
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
            if(cour.kcalt!=0){

              Map <String,dynamic> x={
                'date':DateTime.now().toString().substring(0,10),
                'aliment':cour.nom.toString(),
                'repas':cour.repas,
                'kcal': cour.kcalt


              };
              await db.insert("journee", x);
              test.add(Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30)
                ),
                child: ListTile(
                  leading: Icon(Icons.fastfood,
                    color: Colors.red,
                  ),
                  title: Text(cour.nom.toString()+"   "+cour.kcalt.toString()+" kcal"),
                ),
              )

              );
              print("produit ajoutée");
             // cour.f(cour.repas,cour.kcalt);
              cour.rc.clear();
              Navigator.pop(context);


            }
          },
          child:Center(child:Icon(Icons.add_circle_outline,color: Colors.green,)
          )
      ),
    ],

  );


}
/// add a new product to the OpenFoodFacts database
void addNewProduct(codebar,nomproduit,kcal) async {
  // define the product to be added.
  // more attributes available ...
  Product myProduct = new Product(
    barcode: codebar,
    productName: nomproduit,
    nutriments:new  Nutriments(
      energy: 0,

      energyKcal100g: kcal,
      fat: 0,
      proteins: 0,
      carbohydrates: 0,
    )
  );



  // a registered user login for https://world.openfoodfacts.org/ is required
  User myUser = new User(userId: "sal-lim-17", password: "Sofisfgsf5g4s6f45");

  // query the OpenFoodFacts API
  Status result = await OpenFoodAPIClient.saveProduct(myUser, myProduct);

  if (result.status != 1) {
    throw new Exception("product could not be added: " + result.error);
  }
}

/// add a new image for an existing product of the OpenFoodFacts database
void addProductImage(codecode,url) async {
  // define the product image
  // set the uri to the local image file
  // choose the "imageField" as location / description of the image content.
  SendImage image = new SendImage(
    lang: OpenFoodFactsLanguage.FRENCH,
    barcode: codecode,

    imageField: ImageField.INGREDIENTS,
    imageUrl: Uri.parse(url),
  );

  // a registered user login for https://world.openfoodfacts.org/ is required
  User myUser = new User(userId: "sal-lim-17", password: "Sofisfgsf5g4s6f45");


  // query the OpenFoodFacts API
  Status result = await OpenFoodAPIClient.addProductImage(myUser, image);

  if (result.status != "status ok") {
    throw new Exception("image could not be uploaded: " +
        result.error +
        " " +
        result.imageId.toString());
  }
}