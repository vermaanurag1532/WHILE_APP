import 'package:flutter/material.dart';
import 'package:while_app/resources/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {Key? key,
      required this.title,
      required this.loading,
      required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(height: 44, width:MediaQuery.of(context).size.width,
      decoration:BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: loading?const CircularProgressIndicator(color: Colors.white,):Text(title,style: const TextStyle(color: AppColors.whiteColor),))));
  }
}
