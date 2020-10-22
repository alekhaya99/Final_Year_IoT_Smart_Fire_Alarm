import 'package:flutter/material.dart';
import 'package:fyp/Sensor/Camera_Webview.dart';
import 'package:fyp/Sensor/FireAlert.dart';
import 'package:fyp/SignInWithGoogle/First_Screen.dart';
import 'package:fyp/Sensor/Temperature.dart';
import 'package:fyp/CRUD_Ops/Test.dart';



class MainSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainSectionState();
  }
}
class MainSectionState extends State<MainSection> {
  int _selectedTab = 0;
  final _pageOptions = [
    FirstScreen(),
    SinglePageApp(),
CameraView(),

  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Final Year Project'),
          centerTitle: true,

        ),
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.priority_high),
              title: Text('Temperature'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Camera View'),
            ),
          ],
        ),
      ),
    );
  }}
