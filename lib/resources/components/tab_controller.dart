import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [Container(), ];
                },
                body: Column(
                  children: [
                    Material(
                      color: Colors.white,
                      child: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey[400],
                          indicatorWeight: 1,
                          indicatorColor: Colors.black,
                          tabs: const[
                            Tab(
                              icon: Icon(
                                Icons.photo,
                                color: Colors.black,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.filter_frames,
                                color: Colors.black,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.piano_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            );
  }
}