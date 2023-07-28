import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  final String text;
  final String data;
   const MenuContainer({super.key,required this.data,required this.text});

  @override
  Widget build(BuildContext context) {
    // var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/2.2,
      height: w/4.5,
      decoration: BoxDecoration(
        borderRadius:const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color:const Color.fromARGB(255, 165, 207, 242))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:const EdgeInsets.only(left: 10, top: 10),
            child: Text(text,)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Text(data, style:const TextStyle(color: Color.fromARGB(255, 165, 207, 242,), fontSize: 30, fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}

class BottomMenuContainer extends StatelessWidget {
  final String text;
  const BottomMenuContainer({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    //  var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Container(
      width: w/1.1,
      height: w/2.25,
      decoration: BoxDecoration(
        borderRadius:const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color:const Color.fromARGB(255, 165, 207, 242))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:const EdgeInsets.only(left: 10, top: 10),
            child: Text(text,)),
          const Spacer(),
        ],
      ),
    );
  }
}