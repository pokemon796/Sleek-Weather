import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loadingscreen extends StatefulWidget {
  @override
  _Loadingscreen createState() => _Loadingscreen();
}

class _Loadingscreen extends State<Loadingscreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 75,
            ),
          ),
        ],
      ),
    );
  }
}