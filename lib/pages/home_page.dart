import 'package:chatx/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex =0;
  final tabs=[
    Center(child: Text('Home')),
    Center(child: Text('Message')),
    Center(child: Text('While')),
    Center(child: Text('Add')),
    Center(child: Text('User')),

  ];
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items:[
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset('assets/home.png',width: 25),
              backgroundColor: Colors.white
        ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset('assets/message.png',width: 25),
              backgroundColor: Colors.white
      
        ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset('assets/whilelogo.png', width: 60),
              backgroundColor: Colors.white
      
        ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset('assets/add.png', width: 25),
              backgroundColor: Colors.white
              ),
      
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset('assets/user.png', width: 25),
              backgroundColor: Colors.white
      
        ),
          ],
        onTap: (index){
          setState((){
            _currentIndex = index;
          });
        }
      
        ),
      );
      //body: Center(
        //child: ElevatedButton(
         // child: Text("Logout"),
          //onPressed: () {
           // authService.signOut();
  }
}