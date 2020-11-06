import 'dart:async';
import 'Validators.dart';

class Bloc extends Object with Validators{
  var _nom =StreamController<String>();
  var _prenom =StreamController<String>();
  var _naissance =StreamController<String>();
  var _taille =StreamController<String>();
  var _poid =StreamController<String>();
  var _objectif =StreamController<String>();
  var _kcal =StreamController<String>();
  var _nomp =StreamController<String>();
  var _nbkcal =StreamController<String>();


  //Add
  Stream<String> get Nom => _nom.stream.transform(validateNom);
  Stream<String> get Prenom => _prenom.stream.transform(validatePrenom);
  Stream<String> get Naissance => _naissance.stream.transform(validateNaissance);
  Stream<String> get Taille => _taille.stream.transform(validateTaille);
  Stream<String> get Poid => _poid.stream.transform(validatePoid);
  Stream<String> get Objectif => _objectif.stream.transform(validateobjectif);
  Stream<String> get kcal => _kcal.stream.transform(validatekcal);
  Stream<String> get nomp => _nomp.stream.transform(validatenomp);
  Stream<String> get nbkcal => _nbkcal.stream.transform(validatenbkcal);




  //endAdd


  //change
  //Endchange

  Function(String) get changeNom => _nom.sink.add;
  Function(String) get changePrenom => _prenom.sink.add;
  Function(String) get changeNaissance => _naissance.sink.add;
  Function(String) get changeTaille => _taille.sink.add;
  Function(String) get changePoid => _poid.sink.add;
  Function(String) get changeObj => _objectif.sink.add;
  Function(String) get changekcal => _kcal.sink.add;
  Function(String) get changenomp => _nomp.sink.add;
  Function(String) get changenbkcal => _nbkcal.sink.add;


  dispose(){
    _nom.close();
    _prenom.close();
    _naissance.close();
    _taille.close();
    _poid.close();
    _kcal.close();
    _nomp.close();
    _nbkcal.close();
  }
void upgrade(){
   this._nom =new StreamController<String>();
   this._prenom =new StreamController<String>();
  this._naissance =new StreamController<String>();
  this._taille =new StreamController<String>();
  this._poid =new StreamController<String>();

   this._objectif =new StreamController<String>();
   this._kcal=new StreamController<String>();
   this._nomp =new StreamController<String>();
   this._nbkcal =new StreamController<String>();

}
}
final bloc =Bloc();