// import 'package:chatx/firebase_options.dart';
import 'package:chatx/pages/auth/login_page.dart';
import 'package:chatx/pages/home_page.dart';
import 'package:chatx/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'helper/helper_function.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb){
    await Firebase.initializeApp(

      options: FirebaseOptions(
        apiKey: Constants.apiKey, 
        appId: Constants.appId, 
        messagingSenderId: Constants.messagingSenderId, 
        projectId: Constants.projectId
      )
    );
  } else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if(value != null){
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // initialRoute: AppPages.INITIAL,
      home: _isSignedIn ? HomePage() : LoginPage(),
    );
  }
}
