import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  final String text;
  final dynamic function;
  const ContainerButton({super.key,required this.function,required this.text});

  @override
  Widget build(BuildContext context) {
    // var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: w/12,
        width: w/5,
        decoration: BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 1, color: Colors.blue)
        ),
        child: Text(
          text,
      )),
    );
  }
}