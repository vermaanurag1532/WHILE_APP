import 'package:flutter/material.dart';


class Textbutton extends StatelessWidget {
  final String text;
  var ontap;
  Textbutton({super.key,required this.ontap,required this.text});


  @override
  Widget build(BuildContext context) {
    return  TextButton(
                      onPressed: ontap,
                      child: Text(text,
                          style:const TextStyle(fontSize: 20)));
  }
}