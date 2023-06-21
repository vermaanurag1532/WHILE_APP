import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double coverHeight = 160;
  final double profileHeight = 144;
  String name = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        name = ds.data()!['name'];
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: bottom),
                        child: buildCoverImage()),
                    Positioned(top: top, child: buildProfileImage())
                  ]),
              Column(
                children: [
                  const SizedBox(height: 8),
                  FutureBuilder(
                    future: _fetch(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Text('Loading data...Please Wait');
                      } else {
                        
                        return Text(
                          '$name',
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        );
                      }
                    }),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Flutter Software Engineer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton(text: 'Projects', value: 39),
                      buildDivider(),
                      buildButton(text: 'Following', value: 529),
                      buildDivider(),
                      buildButton(text: 'Followers', value: 5934),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2.5,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const NetworkImage(
          'https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=2000',
        ),
      );
}

Widget buildButton({required String text, required int value}) =>
    MaterialButton(
        onPressed: () {},
        padding: const EdgeInsets.symmetric(vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              '$text',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ));

Widget buildDivider() {
  return Container(
    height: 24,
    child: const VerticalDivider(
      color: Colors.black,
    ),
  );
}
