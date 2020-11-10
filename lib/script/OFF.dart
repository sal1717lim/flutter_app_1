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

void recherche(context,x,db) async{
  User myUser = new User(userId: "sal-lim-17", password: "Sofisfgsf5g4s6f45");

  //await OpenFoodAPIClient.searchProducts(myUser, null);

  ProductSearchQueryConfiguration config= ProductSearchQueryConfiguration(language: OpenFoodFactsLanguage.FRENCH,fields: [ProductField.NAME,ProductField.IMAGES,ProductField.NUTRIMENTS],parametersList: [SearchTerms(terms:[x])]);
  SearchResult result = await OpenFoodAPIClient.searchProducts(myUser, config);
  if (result.page!=0) {
    print(result.products);
    cour.rc.clear();

    for (int i=0;i<result.products.length;i++){
      cour.rc.add(Container(
          decoration:BoxDecoration(
              border: Border.all(color: Colors.blue)
          ),
          child:FlatButton(onPressed: (){
        cour.setnom(result.products[i].productName);
        cour.seturl(result.products[i].imgSmallUrl);
        cour.setKcal("Energie(100g):"+result.products[i].nutriments.energyKcal100g.toString()+" kcal");
        showCupertinoDialog(context: context,
            builder: (BuildContext context) => CupertinoDialog(
              child: Container(
                  height: 150,
                  width: 100,
child: ficheproduit(context, cour, db),

            )));
      },
          child:
          ListTile(
            leading: Image.network(result.products[i].imgSmallUrl),
        title: Text(result.products[i].productName),
      ))));
    }

  } else {

  }
}
ficheproduit(context,produit pr,db){
  bloc.upgrade();
  double tet=0;
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
              onChanged:bloc.changekcal,

              onEditingComplete: (){

              },

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
            if(cour.kcalt!=0){

              Map <String,dynamic> x={
                'date':DateTime.now().toString().substring(0,10),
                'aliment':cour.nom.toString(),
                'repas':cour.repas,
                'kcal': cour.kcalt


              };
              await db.insert("journee", x);


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