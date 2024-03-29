import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'OFF.dart';
class ProductSearch extends SearchDelegate<String> {

  Future _scanBarcode(BuildContext context) async {
    try {
      ScanResult scanResult = await BarcodeScanner.scan();
      query = "test";
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        _showErrorSnackbar(context, 'The user did not grant the camera permission!');
      } else {
        _showErrorSnackbar(context, 'Unknown error: $e');
      }
    } catch (e) {
      _showErrorSnackbar(context, 'Unknown error: $e');
    }
  }

  void _showErrorSnackbar(BuildContext context, String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search (using scan)';

  @override
  List<Widget> buildActions(BuildContext context) {
    //Widgets to display after the search query in the AppBar.
    return [
      IconButton(
        icon: Icon(Icons.scanner),
        color: Theme.of(context).primaryColor,
        onPressed: () => {_scanBarcode(context)},
      ),
      IconButton(
        icon: Icon(Icons.clear),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //A widget to display before the current query in the AppBar.
    return IconButton(
      icon: BackButtonIcon(),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //The results shown after the user submits a search from the search page.
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Create suggestions, to be shown in the body of the search page while the user types a query into the search field.
    final productNames = [

    ];
    final products = query.isEmpty
        ? productNames
        : productNames.where((p) =>
    p.barcode.toLowerCase().startsWith(query.toLowerCase()) ||
        p.name.toLowerCase().startsWith(query.toLowerCase())
    );

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          //You can navigate to product details page from here
        },
        title: Text(
          products.elementAt(index).toString(),
        ),
      ),
      itemCount: products.length,
    );
  }
}