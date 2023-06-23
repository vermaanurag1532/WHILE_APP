import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/repository/firebase_repository.dart';
import 'package:while_app/resources/colors.dart';
import 'package:while_app/view/create_screen.dart';
import 'package:while_app/view/feed_screen.dart';
import 'package:while_app/view/profile_screen.dart';
import 'package:while_app/view/reels_screen.dart';
import 'package:while_app/view/social/social_home_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.theme1Color,
            elevation: 0.0,
            // actions: [
            //   PopupMenuButton(
            //       icon: const Icon(
            //         Icons.more_vert,
            //         color: Colors.white,
            //       ),
            //       itemBuilder: (_) => _popupMenuList.map((menuItem) {
            //             return PopupMenuItem(
            //               child: Text(menuItem),
            //               onTap: () async {
            //                 FirebaseAuthMethods(FirebaseAuth.instance)
            //                     .signOut(context);
            //               },
            //             );
            //           }).toList())
            // ],
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
      ]),
    );
  }
}
