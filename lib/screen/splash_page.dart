import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../src/splash_nloc/splash_bloc.dart';
import 'MenuPrincipale.dart';
import 'UIForm.dart';
import '../script/Personne.dart';
import 'package:animator/animator.dart';

class SplashPage extends StatefulWidget {
  @override
  bool b;
  SplashPage(this.b);
  _SplashPageState createState() => _SplashPageState(this.b);
}

class _SplashPageState extends State<SplashPage> {
  final SplashBloc _splashBloc = SplashBloc();
  bool b;
  _SplashPageState(this.b);
  @override
  void initState() {
    _splashBloc.add(SetSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.deepOrange,
        child: BlocProvider(
          create: (_) => _splashBloc,
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoaded) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: User.notfirst?(BuildContext context) => MenuPrincipale():(BuildContext context) =>Myform(),
                  ),
                );
              }
            },
            child: _buildSplashWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashWidget() {
    return Animator<double>(
      tween: Tween<double>(begin: 0,end: 500),
      cycles: 0,
      duration: Duration(seconds: 4),
      builder: (context,animatorState, child) => Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: animatorState.value,
          width: animatorState.value,
          child: Image.asset("assets/images/icon.png"),
        ),
      ),

    );



  }
}