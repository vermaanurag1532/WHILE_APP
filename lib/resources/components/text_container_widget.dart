import 'package:flutter/material.dart';


class TextContainerWidget extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? hintText; 
  final double? borderRadius;
  final Color? color;
  
  final iconClickEvent;
  const TextContainerWidget({Key? key,this.controller,this.prefixIcon,this.keyboardType,this.hintText,this.borderRadius=10,this.color,this.iconClickEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:color ?? const Color.fromRGBO(116 , 116 , 128, 1).withOpacity(.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                      keyboardType: keyboardType, 
                    
                      controller: controller,
                     
                      decoration: InputDecoration(
                        hintText: hintText,
                          border: InputBorder.none,
                          prefixIcon: InkWell(onTap:iconClickEvent,child: Icon(prefixIcon)))),
                );
  }
}