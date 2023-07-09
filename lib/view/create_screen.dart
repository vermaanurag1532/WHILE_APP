import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_app/resources/colors.dart';
import 'package:while_app/resources/components/create_container.dart';
import 'package:while_app/view_model/reel_controller.dart';


class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
   
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReelController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text("Create Screen",
                    style: TextStyle(
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sen",
                        fontSize: 25)),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(
              height: 30,
            ),
            CreateContainer(
                text: "Videos",
                function: () {
                  provider.selectVideo(context);
  
                }),
            CreateContainer(
                text: "Reels",
                function: () {
                  provider.selectVideo(context);
                }),
          ],
        ),
      ),
    );
  }
}
