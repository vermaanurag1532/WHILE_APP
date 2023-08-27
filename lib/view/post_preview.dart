import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:while_app/resources/components/round_button.dart';
import 'package:while_app/resources/components/text_container_widget.dart';
import 'package:while_app/utils/utils.dart';
import 'package:while_app/view_model/post_provider.dart';

import '../view_model/session_controller.dart';

class PostPreview extends StatefulWidget {
  final File file;

  const PostPreview({super.key, required this.file});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  TextEditingController caption = TextEditingController();
  bool isLoading = false;
  String? cateogry;
  List<String> cateogries=['App Development', 'Web Development', 'Space', 'Science', 'Maths', 'Physics'];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final provider = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: (w - w / 1.1) / 2),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: w / 1.1,
              width: w / 1.1,
              child: Image(image: FileImage(widget.file)),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      height: h / 3,
                      width: w,
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      decoration:const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white),
                      child: ListView.builder(itemBuilder: (context, index) {
                        return ListTile(onTap: () {
                          setState(() {
                            cateogry=cateogries[index];
                          });
                          Navigator.of(context).pop();
                        },title: Text(cateogries[index]),);
                        
                      },itemCount: cateogries.length,),
                    );
                  },
                );
              },
              child: Container(
                width: w,
                height: h / 14,
                decoration: BoxDecoration(
                    color:
                        const Color.fromRGBO(116, 116, 128, 1).withOpacity(.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.category,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      cateogry?? 'Select Cateogry',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 65, 63, 63)),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextContainerWidget(
              hintText: "Caption",
              prefixIcon: Icons.note,
              controller: caption,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
                loading: isLoading,
                title: "Post",
                onPress: () async {
                  if(cateogry==null){
                    Utils.flushBarErrorMessage('Please select a cateogry', context);
                  }
                  else if(caption.text.isEmpty){
                    Utils.flushBarErrorMessage('Please add a caption', context);
                  }
                  else{
                    try {
                    setState(() {
                      isLoading = true;
                    });
                    final datetime = DateTime.now();
                    firebase_storage.Reference storageRef =
                        firebase_storage.FirebaseStorage.instance.ref(
                            'content/${FirebaseSessionController().uid}/post/$datetime');
                    firebase_storage.UploadTask uploadTask =
                        storageRef.putFile(File(provider.post!.path).absolute);
                    await Future.value(uploadTask);
                    final newUrl = await storageRef.getDownloadURL();
                    FirebaseFirestore.instance
                        .collection('Posts')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection(FirebaseAuth.instance.currentUser!.email!)
                        .add({
                      "caption": caption.text.trim(),
                      "postUrl": newUrl
                    }).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Utils.toastMessage("Done...");
                      Navigator.pop(context);
                    });
                  } on FirebaseAuthException catch (e) {
                    Utils.snackBar(e.message!, context);
                  }
                  }
                })
          ],
        ),
      ),
    );
  }
}
