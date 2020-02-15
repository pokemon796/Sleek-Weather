import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadingscreen extends StatefulWidget {
  @override
  _Loadingscreen createState() => _Loadingscreen();
}

class _Loadingscreen extends State<Loadingscreen> with TickerProviderStateMixin {
  double display = 0.0;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        display = 1.0;
      });
    });
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 75,
            ),
          ),
          Positioned(
            top: 35,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: display,
              child: Text(
                "If it hasn't loaded, try rerunning the app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}