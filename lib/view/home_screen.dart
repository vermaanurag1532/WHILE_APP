// // import 'dart:html';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:while_app/repository/firebase_repository.dart';
// import 'package:while_app/resources/components/round_button.dart';
// import 'package:while_app/view/social/social_home_screen.dart';
// // import 'package:while_app/view/message_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Home screen',
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (ctx) => const TestScreen()));
//             },
//             icon: const Icon(Icons.message),
//           ),
//         ],
//       ),
//       body: SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//                 onTap: () {
//                   //To do
//                 },
//                 child: Text('Home screen: ${user?.email ?? 'User email'}')),
//             const SizedBox(
//               height: 10,
//             ),
//             RoundButton(
//                 title: 'SignOut',
//                 onPress: () async {
//                   FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:while_app/repository/firebase_repository.dart';
import 'package:while_app/resources/colors.dart';
import 'package:while_app/view/create_screen.dart';
import 'package:while_app/view/feed_screen.dart';
import 'package:while_app/view/profile_screen.dart';
import 'package:while_app/view/reels_screen.dart';
import 'package:while_app/view/social/social_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int CurrentIndex = 0;
  final List<String> _popupMenuList = [
    "Sign Out",
  ];

  void onTapChange(int index) {
    setState(() {
      CurrentIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    const SocialScreen(),
    ReelsScreen(),
    const CreateScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        Scaffold(
          appBar: AppBar(
            // title:
            // Center(child:Column(
            //   children: [
            //     SizedBox(height: 8,),
            //     Row(
            //       children: [
            //         SizedBox(width:w/4 ,),
            //         Image.asset('assets/mate4-removebg-preview.png', height:80,fit: BoxFit.cover),
            //       ],
            //     ),
            //   ],
            // ),),
            // const Center(child: Text('Heal+TheMate',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
            backgroundColor: AppColors.theme1Color,
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const SocialScreen()));
                },
                icon: const Icon(Icons.message),
              ),
              PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (_) => _popupMenuList.map((menuItem) {
                        return PopupMenuItem(
                          child: Text("$menuItem"),
                          onTap: () async {
                            FirebaseAuthMethods(FirebaseAuth.instance)
                                .signOut(context);
                          },
                        );
                      }).toList())
            ],
          ),
          extendBody: true,
          backgroundColor: AppColors.theme1Color,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GNav(
                  onTabChange: onTapChange,
                  backgroundColor: AppColors.buttonColor,
                  color: Colors.white,
                  activeColor: AppColors.buttonColor,
                  tabBackgroundColor: Colors.white,
                  padding: const EdgeInsets.all(5),
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(
                      icon: Icons.message,
                      text: 'Social',
                      iconSize: 25,
                    ),
                    GButton(
                      icon: Icons.abc,
                      text: 'Reels',
                      iconSize: 25,
                    ),
                    GButton(
                      icon: Icons.add,
                      text: 'Create',
                    ),
                    GButton(
                      icon: Icons.account_circle,
                      text: 'User Profile',
                    ),
                  ]),
            ),
          ),
          body: Center(
            child: _widgetOptions.elementAt(CurrentIndex),
          ),
        ),
        //   Positioned(
        //   top: 30,
        //   right: w/3.2,
        //   child: Image.asset('assets/mate4-removebg-preview.png',
        //       height: 80),
        // ),
      ]),
    );
  }
}
