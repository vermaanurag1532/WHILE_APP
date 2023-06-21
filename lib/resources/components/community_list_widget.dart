import 'package:flutter/material.dart';
import 'package:while_app/data/model/community.dart';
import 'package:while_app/view/social/community_detail.dart';

class CommunityList extends StatelessWidget {
  const CommunityList({super.key, required this.message});
  final List<CommunityDetail> message;
  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) {
      return Center(
        child: Text(
          'No Message is added yet',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          ListView.builder(
              itemCount: message.length,
              itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 56,
                      backgroundImage: NetworkImage(message[index].image),
                    ),
                    title: Text(
                      message[index].title,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CommunityDetailScreen(
                          userName: message[index].title,
                          userImage: message[index].image,
                        ),
                      ));
                    },
                    contentPadding: const EdgeInsets.only(top: 15, left: 2),
                  )),
          Container(
            margin: const EdgeInsets.only(right: 20, bottom: 40),
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: const Icon(
                Icons.group_add,
                size: 30,
              ),
              // extendedPadding: EdgeInsets.o(30),
              elevation: 10,
              splashColor: Colors.purple,
              extendedPadding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              backgroundColor: Colors.deepPurpleAccent,
            ),
          )
        ],
      ),
    );
  }
}
