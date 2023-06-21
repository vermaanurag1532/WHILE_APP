import 'package:flutter/material.dart';
import 'package:while_app/utils/routes/routes_name.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ListTile(
              leading:const Icon(Icons.settings, color: Colors.black, size: 30,),
              title:const  Text("Settings"),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.settings);
              },
            ),
            const ListTile(
              leading: Icon(Icons.download_outlined, color: Colors.black, size: 30,),
              title: Text("Saved"),
            ),
            const ListTile(
              leading: Icon(Icons.share_outlined, color: Colors.black, size: 30,),
              title: Text("Share"),
            ),
            const ListTile(
              leading: Icon(Icons.watch, color: Colors.black, size: 30,),
              title: Text("Activity"),
            ),
            const ListTile(
              leading: Icon(Icons.report, color: Colors.black, size: 30,),
              title: Text("Report an issue"),
            ),
            const ListTile(
              leading: Icon(Icons.mobile_friendly, color: Colors.black, size: 30,),
              title: Text("Refer"),
            ),
            const ListTile(
              leading: Icon(Icons.money, color: Colors.black, size: 30,),
              title: Text("change a plan"),
            )
          ],
        ),
      ),
    );
  }
}
