
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:while_app/resources/components/round_button.dart';
import 'package:while_app/resources/components/text_container_widget.dart';
import 'package:while_app/resources/components/video_player.dart';
import 'package:while_app/utils/utils.dart';
import '../../repository/firebase_repository.dart';

class AddReel extends StatefulWidget {
  final String video;
  const AddReel({Key? key, required this.video}) : super(key: key);

  @override
  State<AddReel> createState() => _AddReelState();
}

class _AddReelState extends State<AddReel> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final h = MediaQuery.of(context).size.height * 1;
    final w = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Reel"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Center(
          child: SizedBox(
            width: w,
            height: h/2,
            child: VideoPlayerWidget(videoPath: widget.video),
          ),
        ),
              const SizedBox(height: 15),
              TextContainerWidget(
                keyboardType: TextInputType.text,
                controller: _titleController,
                prefixIcon: Icons.title,
                hintText: 'Title',
              ),
              const SizedBox(height: 10),
              TextContainerWidget(
                keyboardType: TextInputType.text,
                controller: _descriptionController,
                prefixIcon: Icons.description,
                hintText: 'Description',
              ),
              const SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: 'Add Reel',
                  onPress: () async {
                    if (_titleController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter title', context);
                    } else if (_descriptionController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter description', context);
                    } else {
                      context
                          .read<FirebaseAuthMethods>()
                          .loginInWithEmailAndPassword(
                              _titleController.text.toString(),
                              _descriptionController.text.toString(),
                              context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
