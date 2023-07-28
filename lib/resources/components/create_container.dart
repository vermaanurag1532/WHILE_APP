import 'package:flutter/material.dart';

import '../colors.dart';

class CreateContainer extends StatelessWidget {
  final String text;
  final function;
  const CreateContainer(
      {super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          gradient: LinearGradient(
              colors: [AppColors.theme1Color, AppColors.buttonColor]),
        ),
        child: Container(
          width: w / 1.1,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            onTap: function,
            leading: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, border: Border.all(width: 1)),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
