import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:while_app/resources/components/post_widget.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final list=context.watch<List<Map<String, dynamic>>>();
    final List<Map<String,dynamic>> posts=context.watch<List<Map<String, dynamic>>>();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      body: SizedBox(width: w,height: h,child:ListView.builder(itemBuilder: (context, index) {
        return PostWidget(data: posts[index]);
      },itemCount: list.length,),)
    );
  }
}
