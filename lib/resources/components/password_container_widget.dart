import 'package:flutter/material.dart';

class TextPasswordContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? hintText;
  const TextPasswordContainerWidget(
      {Key? key,
      this.controller,
      this.prefixIcon,
      this.keyboardType,
      this.hintText})
      : super(key: key);

  @override
  State<TextPasswordContainerWidget> createState() =>
      _TextPasswordContainerWidgetState();
}

class _TextPasswordContainerWidgetState
    extends State<TextPasswordContainerWidget> {
  bool isobscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(116, 116, 128, 1).withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
          obscureText: isobscureText,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isobscureText = !isobscureText;
                    });
                  },
                  child: Icon(isobscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined)),
              prefixIcon: Icon(widget.prefixIcon))),
    );
  }
}
