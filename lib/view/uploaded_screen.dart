import 'package:flutter/material.dart';

class UploadedScreen extends StatelessWidget {
  const UploadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2/2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
