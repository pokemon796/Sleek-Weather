import 'package:flutter/material.dart';
import 'package:sleek_weather/Backend/DataManager.dart';
import 'package:sleek_weather/Colors/ColorsManager.dart';

import 'package:sleek_weather/MainControllers/Homescreen.dart';
import 'package:sleek_weather/MainControllers/InternetError.dart';
import 'package:sleek_weather/MainControllers/AnimatedBackground/AnimatedBackground.dart';
import 'package:sleek_weather/Backend/ConnectionStatusSingleton.dart';
import 'package:sleek_weather/Location/BackendLocation.dart';
import 'package:sleek_weather/MainControllers/Loadingscreen.dart';
import 'package:sleek_weather/Weather/BackendWeather.dart';

ConnectionStatusSingleton connectivityProtocol = ConnectionStatusSingleton.getInstance();

void main() {
  runApp(
    MaterialApp(
      home: SleekWeather(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class SleekWeather extends StatefulWidget {
  @override
  _SleekWeather createState() => new _SleekWeather();
}

class _SleekWeather extends State<SleekWeather> {

  AppStructure APPSTRUCTURE;

  @override
  void initState() {
    super.initState();
    ColorsManager.setupColorValues();
    Location.setupLocations(() {
      Weather.setupWeatherData();
    });

    APPSTRUCTURE = AppStructure();
    APPSTRUCTURE.controllers[0] = Positioned(
      top: APPSTRUCTURE.switcher ? 30 : 0,
      child: Container(
          decoration: BoxDecoration(
          borderRadius: APPSTRUCTURE.switcher ? null : BorderRadius.all(
            Radius.circular(25),
          )
        ),
        child: Background(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    connectivityProtocol.connectionChange.listen((connection) {
      if (!connection) {
        APPSTRUCTURE.setMainController(InternetErrorController());
      } else {
        APPSTRUCTURE.setupData();
        APPSTRUCTURE.setMainController(Loadingscreen());
      }
    });

    if (!DataManager.verifiedData()) {
      APPSTRUCTURE.setMainController(Loadingscreen());
    } else {
      APPSTRUCTURE.setMainController(Homescreen(
        switcher: () {
          setState(() {
            APPSTRUCTURE.switcher = !APPSTRUCTURE.switcher;
          });
        }
      ));
    }

    return Scaffold(
      body: Stack(
        children: APPSTRUCTURE.controllers,
      ),
    );
  }
}

class AppStructure {
  bool switcher;

  List<Widget> controllers = List<Widget>(2);

  AppStructure() {
    connectivityProtocol.initialize();
    connectivityProtocol.checkConnection();
    switcher = false;
  }

  void setupData() {
    Weather.setupWeatherData();
  }

  void setMainController(StatefulWidget controller) {
    controllers[1] = controller;
  }
}