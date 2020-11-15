import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/main_Section.dart';
import 'authentication.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String textValue = 'Emergency !';
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) {
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, "Emergency", "There is a fire", platform);
  }

  update(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/${token}').set({"token": token});
    textValue = token;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [

              Colors.lightGreen,

              Colors.white
              ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 25,),
            Expanded(child: Center(child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.blue,Colors.red,Colors.blue,Colors.orange,Colors.deepPurple,Colors.black],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: Text("Final Year Project",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35,))))),
             SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(15),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(15),

                 child: Image.network(
                        'https://cdn2.vectorstock.com/i/1000x1000/81/01/smart-home-automation-isometric-infographic-poster-vector-13668101.jpg',
                      ),
               ),
             ),
            SizedBox(height:10),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: _signInButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(

      splashColor: Colors.green,

      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainSection();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      color: Colors.transparent,
      highlightColor: Colors.lightGreen,
      highlightElevation: 15,
      borderSide: BorderSide(color: Colors.black,width: 3),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: NetworkImage(
                    "https://www.pngkey.com/png/full/10-109089_google-logo-png-transparent-google-logo-round-png.png"),
                height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.purple,Colors.teal,Colors.blue,Colors.red],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
