import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 79, 158, 223),width: 2)
  ),

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue,width: 2)
  ),

  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 211, 80, 70))
  )
);

void nextScreen(context,page){
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context,page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}


void showSnackBar(context,color,message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    )
  );
}