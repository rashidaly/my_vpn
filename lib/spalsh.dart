import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_app/custom/utils.dart';

import 'Screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(

          splash: Lottie.asset('assets/images/97886-circle-animation.json'),
         backgroundColor: Color(0xFF623896),
          nextScreen: HomePage(),
        splashIconSize: 250,
        duration: 3000,
        //splashTransition: SplashTransition.fadeTransition,
       // pageTransitionType: pageTransitionType,
        animationDuration: Duration( seconds: 1),
      ),
    );

    /*Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        alignment: const Alignment(-0.06, -0.18),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.97, -1.0),
            end: Alignment(1.0, 0.98),
            colors: [
              Color(0xFF6E2C9F),
              Color(0xFF7337A0),
              Color(0xFF7B45A4),
              Color(0xFF7B45A4)
            ],
            stops: [0.0, 0.064, 0.778, 1.0],
          ),
        ),
        *//*    height: 100,
        width: 100,*//*

        child: Padding(
          padding: const EdgeInsets.all(150.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                child: Center(
                  child: Image.asset('assets/images/vpn.png'),
                ),
              ),

          const SpinKitWave(
            color: Colors.green,
            size: 50.0,
          ),
            ],
          ),
        ),
      ),
    );*/
  }
}
