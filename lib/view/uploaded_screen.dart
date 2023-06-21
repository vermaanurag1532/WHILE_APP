import 'package:flutter/material.dart';

class UploadedScreen extends StatelessWidget {
  const UploadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3/2, crossAxisSpacing: 1, mainAxisSpacing: 1), itemBuilder: (context, index){
      return Container(color: Colors.blue,child: const Image(fit: BoxFit.cover, image: AssetImage("assets/while.jpg")),);
    }, itemCount: 10,);
  }
}