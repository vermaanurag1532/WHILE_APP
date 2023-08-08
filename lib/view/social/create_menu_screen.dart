import 'package:flutter/material.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:while_app/resources/components/container_button.dart';
import 'package:while_app/resources/components/menu_container.dart';

class CreateMenuScreen extends StatelessWidget {
  const CreateMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        },icon:const Icon(Icons.arrow_back, color: Colors.black)),
        title:
           const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image(image: AssetImage("assets/while.jpg"), height: 60),
            Text(
            "Studio",
            // colors: const [Colors.blue, Colors.green],
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30)
          )
          ],),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.menu, color: Colors.blue,))
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Dashboard", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),),
              Container(height: 400,color: const Color.fromARGB(255, 185, 216, 241), width: 400,child:const Text("Chart"),),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ContainerButton(function: (){}, text: "Week"),
                ContainerButton(function: (){}, text: "Month"),
                ContainerButton(function: (){}, text: "Year"),
                ContainerButton(function: (){}, text: "Custom"),
              ],),
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuContainer(data: "123456", text: "Subscriber"),
                  MenuContainer(data: "123456", text: "Likes"),
                ],
              ),
              const SizedBox(height: 20,),
              const BottomMenuContainer(text: "Total Revenue")
            ],
          ),
        ),
      ),
    );
  }
}
