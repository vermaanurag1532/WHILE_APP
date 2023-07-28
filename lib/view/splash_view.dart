import 'dart:async';

import 'package:flutter/material.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pop();
     Navigator.pushNamed(context, RoutesName.wrapper);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 1;
    final w = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Center(
        child:  SizedBox(
          height:h/5.8,
          width:w/1.5,
          child: Image.asset('assets/WhatsApp_Image_2023-06-02_at_12.43.29_AM-removebg-preview.png',fit: BoxFit.fill,))
      ),
    );
  }
}