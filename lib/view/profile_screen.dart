import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/bottom_options_sheet.dart';
import 'package:while_app/resources/components/bottom_sheet.dart';
import 'package:while_app/view/uploaded_screen.dart';

import '../resources/components/profile_data_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  var color = Colors.blue;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var nh = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
        body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverList(delegate: SliverChildListDelegate([ProfileDataWidget()]))
                  ];
                },
                body: const Column(
                  children: [
                    Material(
                      // color: Colors.white,
                      child: TabBar(tabs: [
                        Tab(
                          icon: Icon(CupertinoIcons.photo, color: Colors.black,),
                        ),
                        Tab(
                          icon: Icon(CupertinoIcons.sidebar_right, color: Colors.black,),
                        ),
                        Tab(
                          icon: Icon(CupertinoIcons.paintbrush, color: Colors.black,),
                        ),
                      ]),
                    ),
                    Expanded(
                        child: TabBarView(
                            children: [UploadedScreen(), Text("ok"), Text("ok")]))
                  ],
                ))));
  }
}
