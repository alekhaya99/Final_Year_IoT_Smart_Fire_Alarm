import 'package:flutter/material.dart';
import 'package:fyp/Sensor/Camera_Webview.dart';
import 'package:fyp/Sensor/FireAlert.dart';
import 'package:fyp/Sensor/Smoke.dart';
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
    Smoke(),
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

          title: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.blue,Colors.red,Colors.blue,Colors.orange,Colors.deepPurple,Colors.black],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Text('Final Year Project')),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.lightGreen,
                      Colors.yellow
                    ])
            ),
          ),

        ),
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ Colors.yellow,Colors.lightGreen,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.8],
              tileMode: TileMode.clamp,
            ),
          ),
          child: BottomNavigationBar(

            backgroundColor: Colors.transparent,
            fixedColor: Colors.deepPurple,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
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
                title: Text('Temperature Sensor'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.smoking_rooms),
                title: Text('Smoke Sensor'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                title: Text('Camera View'),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
