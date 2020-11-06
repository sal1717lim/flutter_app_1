import 'dart:async';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
Future<Product> getProduct(barcode1) async {
  var barcode = barcode1;
  var name="candia";
  ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode, language: OpenFoodFactsLanguage.FRENCH, fields: [ProductField.ALL]);
  ProductResult result =
  await OpenFoodAPIClient.getProduct(configuration);

  if (result.status == 1) {
    return result.product;
  } else {

  }
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