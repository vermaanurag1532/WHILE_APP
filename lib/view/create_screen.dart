import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:while_app/resources/components/create_container.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ImagePickerPlus _picker = ImagePickerPlus(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(RoutesName.createMenu);
          }, icon:const Icon(Icons.menu, color: Colors.blue,))
        ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Image(image: AssetImage("assets/while.jpg")),
          title: GradientText(
            "Studio",
            colors: const [Colors.blue, Colors.green],
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
          ),),
      body: Column(
        children: [
          const Text("Hey there, "),
          const Text("Channel Analytics"),
          CreateContainer(
              text: "Videos",
              function: () async {
              }),
          CreateContainer(text: "Loops", function: () {}),
          CreateContainer(text: "Blog/Post", function: () {})
        ],
      ),
    );
  }
}
